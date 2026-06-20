package com.assignment.servlet;

import model.ProfileBean;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    
    // Konfigurasi pangkalan data standard APP/APP
    private final String dbURL = "jdbc:derby://localhost:1527/StudentProfilesDB;create=true";
    private final String dbUser = "APP"; 
    private final String dbPass = "APP"; 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "view";

        try {
            switch (action) {
                case "delete":
                    String deleteID = request.getParameter("studentId");
                    deleteProfile(deleteID);
                    response.sendRedirect("ProfileServlet?action=view");
                    break;
                    
                case "editForm":
                    String editID = request.getParameter("studentId");
                    ProfileBean existingProfile = getProfileByID(editID);
                    request.setAttribute("profile", existingProfile);
                    request.getRequestDispatcher("editProfile.jsp").forward(request, response);
                    break;
                    
                case "view":
                default:
                    String searchQuery = request.getParameter("searchQuery");
                    String filterProgramme = request.getParameter("filterProgramme");
                    
                    List<ProfileBean> listProfiles = getProfiles(searchQuery, filterProgramme);
                    
                    request.setAttribute("listProfiles", listProfiles);
                    request.setAttribute("currentSearch", searchQuery);
                    request.setAttribute("currentFilter", filterProgramme);
                    
                    request.getRequestDispatcher("viewProfiles.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        String studentId = request.getParameter("studentId");
        String name = request.getParameter("name");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String hobbies = request.getParameter("hobbies");
        String bio = request.getParameter("bio");

        if (name == null || name.trim().isEmpty()) {
            name = "Anonymous Student";
        }

        ProfileBean profile = new ProfileBean();
        profile.setStudentID(studentId);
        profile.setName(name);
        profile.setProgramme(program);
        profile.setEmail(email);
        profile.setHobbies(hobbies);
        profile.setIntroduction(bio);

        try {
            if ("update".equals(action)) {
                updateProfile(profile);
                response.sendRedirect("ProfileServlet?action=view");
            } else {
                saveProfile(profile);
                request.setAttribute("savedProfile", profile);
                request.getRequestDispatcher("profile.jsp").forward(request, response);
            }
        } catch (java.sql.SQLIntegrityConstraintViolationException e) {
            // BERJAYA FIX: Jika Student ID bertindih, sistem keluarkan popup mesej amaran mesra pengguna
            response.setContentType("text/html;charset=UTF-8");
            java.io.PrintWriter out = response.getWriter();
            out.println("<script type='text/javascript'>");
            out.println("alert('Ralat: Student ID \"" + studentId + "\" sudah wujud di dalam pangkalan data! Sila gunakan ID yang berbeza.');");
            out.println("window.history.back();");
            out.println("</script>");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    // --- FUNGSI OPERASI DATABASE (CRUD) ---

    private void saveProfile(ProfileBean profile) throws Exception {
        String sql = "INSERT INTO APP.Profile (studentID, name, programme, email, hobbies, introduction) VALUES (?, ?, ?, ?, ?, ?)";
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, profile.getStudentID());
            ps.setString(2, profile.getName());
            ps.setString(3, profile.getProgramme());
            ps.setString(4, profile.getEmail());
            ps.setString(5, profile.getHobbies());
            ps.setString(6, profile.getIntroduction());
            ps.executeUpdate();
        }
    }

    private List<ProfileBean> getProfiles(String search, String filter) throws Exception {
        List<ProfileBean> list = new ArrayList<>();
        String sql = "SELECT * FROM APP.Profile WHERE 1=1";
        
        if (search != null && !search.trim().isEmpty()) {
            sql += " AND (LOWER(studentID) LIKE ? OR LOWER(name) LIKE ?)";
        }
        if (filter != null && !filter.trim().isEmpty()) {
            sql += " AND LOWER(programme) = ?";
        }

        Class.forName("org.apache.derby.jdbc.ClientDriver");
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            int paramIndex = 1;
            if (search != null && !search.trim().isEmpty()) {
                String searchPattern = "%" + search.toLowerCase() + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }
            if (filter != null && !filter.trim().isEmpty()) {
                ps.setString(paramIndex, filter.toLowerCase());
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProfileBean p = new ProfileBean();
                    p.setStudentID(rs.getString("studentID"));
                    p.setName(rs.getString("name"));
                    p.setProgramme(rs.getString("programme"));
                    p.setEmail(rs.getString("email"));
                    p.setHobbies(rs.getString("hobbies"));
                    p.setIntroduction(rs.getString("introduction"));
                    list.add(p);
                }
            }
        }
        return list;
    }

    private ProfileBean getProfileByID(String studentID) throws Exception {
        ProfileBean p = null;
        String sql = "SELECT * FROM APP.Profile WHERE studentID = ?";
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, studentID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = new ProfileBean();
                    p.setStudentID(rs.getString("studentID"));
                    p.setName(rs.getString("name"));
                    p.setProgramme(rs.getString("programme"));
                    p.setEmail(rs.getString("email"));
                    p.setHobbies(rs.getString("hobbies"));
                    p.setIntroduction(rs.getString("introduction"));
                }
            }
        }
        return p;
    }

    private void updateProfile(ProfileBean profile) throws Exception {
        String sql = "UPDATE APP.Profile SET name=?, programme=?, email=?, hobbies=?, introduction=? WHERE studentID=?";
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, profile.getName());
            ps.setString(2, profile.getProgramme());
            ps.setString(3, profile.getEmail());
            ps.setString(4, profile.getHobbies());
            ps.setString(5, profile.getIntroduction());
            ps.setString(6, profile.getStudentID());
            ps.executeUpdate();
        }
    }

    private void deleteProfile(String studentID) throws Exception {
        String sql = "DELETE FROM APP.Profile WHERE studentID = ?";
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, studentID);
            ps.executeUpdate();
        }
    }
}