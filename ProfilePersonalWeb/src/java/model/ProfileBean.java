package model;

import java.io.Serializable;

// Wajib implement Serializable untuk standard JavaBean
public class ProfileBean implements Serializable {
    
    // 1. Atribut Private (Sistem Encapsulation)
    private String studentID;
    private String name;
    private String programme;
    private String email;
    private String hobbies;
    private String introduction;

    // 2. No-argument Constructor (Wajib untuk JavaBean)
    public ProfileBean() {
    }

    // 3. Public Getter & Setter Methods
    // Digunakan oleh Servlet dan JSP untuk baca & tulis data
    
    public String getStudentID() {
        return studentID;
    }

    public void setStudentID(String studentID) {
        this.studentID = studentID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getProgramme() {
        return programme;
    }

    public void setProgramme(String programme) {
        this.programme = programme;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getHobbies() {
        return hobbies;
    }

    public void setHobbies(String hobbies) {
        this.hobbies = hobbies;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }
}