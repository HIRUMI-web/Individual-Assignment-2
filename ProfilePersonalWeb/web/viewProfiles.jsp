<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.ProfileBean"%>
<%
    List<ProfileBean> listProfiles = (List<ProfileBean>) request.getAttribute("listProfiles");
    String currentSearch = (String) request.getAttribute("currentSearch");
    String currentFilter = (String) request.getAttribute("currentFilter");
    if(currentSearch == null) currentSearch = "";
    if(currentFilter == null) currentFilter = "";
%>
<!DOCTYPE html>
<html lang="ms">
<head>
    <meta charset="UTF-8">
    <title>All Student Profiles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap');

    body {
        font-family: 'Inter', sans-serif;
        background: #0d0e12;
        min-height: 100vh;
        color: #f3f4f6;
        overflow-x: hidden;
        position: relative;
        padding: 30px 0;
    }

    #splatter-canvas {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: 1;
        pointer-events: none; 
    }

    .container {
        position: relative;
        z-index: 2;
        max-width: 1200px;
    }

    .page-header {
        text-align: center;
        color: #ffffff;
        font-weight: 600;
        margin-bottom: 30px;
        letter-spacing: 0.5px;
        text-shadow: 0 0 20px rgba(56, 189, 248, 0.2);
    }

    /* --- CONTAINERS: SOLID BLACK WITH RAINBOW BORDERS --- */
    .top-bar, .profile-card {
        position: relative;
        border: none !important; 
        border-radius: 20px;
        background: #000000 !important; 
        box-shadow: 0 20px 50px rgba(0, 0, 0, 0.7);
        overflow: visible; 
        transition: transform 0.4s cubic-bezier(0.16, 1, 0.3, 1);
    }

    .top-bar::before, .profile-card::before {
        content: '';
        position: absolute;
        top: -2px;
        left: -2px;
        right: -2px;
        bottom: -2px;
        background: linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f);
        background-size: 400% 400%;
        border-radius: 22px;
        z-index: -1;
        opacity: 0.5; 
        animation: rainbowAnimation 8s ease infinite;
    }

    .top-bar:hover, .profile-card:hover {
        transform: translateY(-8px);
    }

    .top-bar:hover::before, .profile-card:hover::before {
        opacity: 0.5;
        filter: none;
    }

    .top-bar {
        padding: 25px;
        margin-bottom: 35px;
    }

    .profile-card {
        padding: 25px;
        height: 100%;
        display: flex;
        flex-direction: column;
    }

    .top-bar .form-control {
        background: rgba(255, 255, 255, 0.04);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 12px;
        color: #ffffff;
        padding: 12px 16px;
        transition: all 0.3s ease;
    }

    .top-bar .form-control:focus {
        background: rgba(255, 255, 255, 0.08);
        border-color: #38bdf8;
        box-shadow: 0 0 15px rgba(56, 189, 248, 0.2);
        color: #ffffff;
        outline: none;
    }

    .top-bar .form-control::placeholder {
        color: #6b7280;
    }

    .profile-name {
        font-size: 1.25rem;
        font-weight: 600;
        color: #ffffff;
        margin-bottom: 2px;
    }

    .profile-id {
        font-size: 0.8rem;
        color: #9ca3af;
        font-weight: 500;
        margin-bottom: 15px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .profile-info {
        font-size: 0.9rem;
        margin-bottom: 8px;
        color: #e5e7eb;
    }

    .profile-info b {
        color: #9ca3af;
        font-weight: 500;
    }

    .profile-bio {
        background: rgba(255, 255, 255, 0.03);
        border: 1px solid rgba(255, 255, 255, 0.06);
        padding: 12px;
        border-radius: 12px;
        font-size: 0.85rem;
        margin-top: 15px;
        color: #d1d5db;
        white-space: pre-line;
        flex-grow: 1;
    }

    .profile-bio b {
        color: #ffffff;
    }

    .btn {
        border-radius: 12px;
        font-size: 0.9rem;
        font-weight: 600;
        padding: 10px 20px;
        transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
    }

    .btn-rainbow-apply {
        background: linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f) !important;
        background-size: 400% 400% !important;
        color: #ffffff !important;
        border: 2px solid transparent !important;
        animation: rainbowAnimation 6s linear infinite;
    }

    .btn-rainbow-apply:hover {
        transform: translateY(-2px);
        background: #000000 !important;
        box-shadow: 0 0 15px rgba(56, 189, 248, 0.3);
        
        background-image: linear-gradient(#000, #000), linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f) !important;
        background-origin: border-box !important;
        background-clip: padding-box, border-box !important;
    }

    .btn-rainbow-apply:hover .btn-text-content,
    .btn-rainbow-apply:hover i {
        background: linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f);
        background-size: 400% 400%;
        -webkit-background-clip: text;
        background-clip: text;
        -webkit-text-fill-color: transparent;
        animation: rainbowAnimation 6s linear infinite;
    }

    /* RESET BUTTON */
    .btn-rainbow-reset {
        background: #000000 !important;
        color: #ffffff !important;
        border: 2px solid transparent !important;
        background-image: linear-gradient(#000, #000), linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f) !important;
        background-origin: border-box !important;
        background-clip: padding-box, border-box !important;
        animation: rainbowAnimation 6s linear infinite;
    }

    /* Hover state: changes background to rainbow, text stays readable white */
    .btn-rainbow-reset:hover {
        transform: translateY(-2px);
        background: linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f) !important;
        background-size: 400% 400% !important;
        background-image: none !important; /* Clears out the masking gradient */
        color: #ffffff !important;
        box-shadow: 0 0 15px rgba(255, 0, 127, 0.4);
    }

    .btn-edit {
        background: rgba(56, 189, 248, 0.1);
        color: #38bdf8;
        border: 1px solid rgba(56, 189, 248, 0.3);
    }
    .btn-edit:hover {
        background: #38bdf8;
        color: #000000;
        box-shadow: 0 0 15px rgba(56, 189, 248, 0.4);
    }

    .btn-delete {
        background: rgba(244, 63, 94, 0.1);
        color: #f43f5e;
        border: 1px solid rgba(244, 63, 94, 0.3);
    }
    .btn-delete:hover {
        background: #f43f5e;
        color: #ffffff;
        box-shadow: 0 0 15px rgba(244, 63, 94, 0.4);
    }

    .btn-back {
        background: transparent;
        color: #9ca3af;
        border: 1px solid rgba(255, 255, 255, 0.1);
    }
    .btn-back:hover {
        background: rgba(255, 255, 255, 0.05);
        color: #ffffff;
    }

    @keyframes rainbowAnimation {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }
    </style>
</head>

<body>

    <canvas id="splatter-canvas"></canvas>

    <div class="container">

        <h2 class="page-header"><i class="fas fa-users me-2"></i>Registered Student Profiles</h2>
        
        <div class="top-bar">
            <form action="ProfileServlet" method="GET" class="row g-3 align-items-center">
                <input type="hidden" name="action" value="view">

                <div class="col-md-5">
                    <input type="text" name="searchQuery" class="form-control"
                           placeholder="Search by Student ID or Name..."
                           value="<%= currentSearch %>">
                </div>

                <div class="col-md-4">
                    <input type="text" name="filterProgramme" class="form-control"
                           placeholder="Filter by Programme..."
                           value="<%= currentFilter %>">
                </div>

                <div class="col-md-3 d-flex gap-2">
                    <button class="btn btn-rainbow-apply w-100">
                        <i class="fas fa-filter me-2"></i><span class="btn-text-content">Apply</span>
                    </button>
                    
                    <a href="ProfileServlet?action=view" class="btn btn-rainbow-reset w-100 text-center text-decoration-none">
                        <i class="fas fa-undo me-2"></i>Reset
                    </a>
                </div>
            </form>
        </div>

        <div class="row g-4">
            <%
                if(listProfiles != null && !listProfiles.isEmpty()) {
                    for(ProfileBean p : listProfiles) {
            %>

            <div class="col-md-4">
                <div class="profile-card">

                    <div class="profile-name"><%= p.getName() %></div>
                    <div class="profile-id">ID: <%= p.getStudentID() %></div>

                    <div class="profile-info"><b>Programme:</b> <%= p.getProgramme() %></div>
                    <div class="profile-info"><b>Email:</b> <%= p.getEmail() %></div>
                    <div class="profile-info"><b>Hobbies:</b> <%= p.getHobbies() != null && !p.getHobbies().trim().isEmpty() ? p.getHobbies() : "-" %></div>

                    <div class="profile-bio">
                        <b>Bio:</b><br>
                        <%= p.getIntroduction() != null && !p.getIntroduction().trim().isEmpty() ? p.getIntroduction() : "-" %>
                    </div>

                    <div class="d-flex gap-2 mt-4">
                        <a href="ProfileServlet?action=editForm&studentId=<%= p.getStudentID() %>"
                           class="btn btn-edit w-50 text-center text-decoration-none">
                           <i class="fas fa-edit me-1"></i>Edit
                        </a>

                        <a href="ProfileServlet?action=delete&studentId=<%= p.getStudentID() %>"
                           class="btn btn-delete w-50 text-center text-decoration-none"
                           onclick="return confirm('Delete <%= p.getName() %>?');">
                           <i class="fas fa-trash-alt me-1"></i>Delete
                        </a>
                    </div>

                </div>
            </div>

            <%
                    }
                } else {
            %>

            <div class="col-12">
                <p class="text-center text-muted py-5"><i class="fas fa-folder-open fa-2x d-block mb-2"></i>No registered student profiles found.</p>
            </div>

            <%
                }
            %>
        </div>

        <div class="text-center mt-5">
            <a href="menu.html" class="btn btn-back"><i class="fas fa-arrow-left me-2"></i>Back to Menu</a>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
    const canvas = document.getElementById('splatter-canvas');
    const ctx = canvas.getContext('2d');

    let splatters = [];
    const colors = [
        'rgba(255, 0, 127, 0.15)',  
        'rgba(59, 130, 246, 0.12)',  
        'rgba(168, 85, 247, 0.15)',  
        'rgba(56, 189, 248, 0.12)'   
    ];

    function resizeCanvas() {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
    }
    window.addEventListener('resize', resizeCanvas);
    resizeCanvas();

    class SplatterBlot {
        constructor() {
            this.x = Math.random() * canvas.width;
            this.y = Math.random() * canvas.height;
            this.baseRadius = Math.random() * 60 + 40;
            this.radius = this.baseRadius;
            this.color = colors[Math.floor(Math.random() * colors.length)];
            this.pulseSpeed = Math.random() * 0.02 + 0.005;
            this.angle = Math.random() * Math.PI * 2;
            this.nodes = [];
            
            const nodeCount = Math.random() * 8 + 6;
            for(let i=0; i<nodeCount; i++) {
                this.nodes.push({
                    angle: (i / nodeCount) * Math.PI * 2 + (Math.random() * 0.4 - 0.2),
                    length: Math.random() * 40 + 10,
                    size: Math.random() * 12 + 4
                });
            }
        }

        update() {
            this.angle += this.pulseSpeed;
            this.radius = this.baseRadius + Math.sin(this.angle) * 8;
        }

        draw() {
            ctx.save();
            ctx.fillStyle = this.color;
            ctx.filter = "blur(18px)"; 
            
            ctx.beginPath();
            ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2);
            ctx.fill();

            this.nodes.forEach(node => {
                const nx = this.x + Math.cos(node.angle) * (this.radius + node.length);
                const ny = this.y + Math.sin(node.angle) * (this.radius + node.length);
                ctx.beginPath();
                ctx.arc(nx, ny, node.size, 0, Math.PI * 2);
                ctx.fill();
            });
            
            ctx.restore();
        }
    }

    for(let i = 0; i < 9; i++) {
        splatters.push(new SplatterBlot());
    }

    function animate() {
        ctx.fillStyle = '#0d0e12';
        ctx.fillRect(0, 0, canvas.width, canvas.height);

        splatters.forEach(s => {
            s.update();
            s.draw();
        });

        requestAnimationFrame(animate);
    }
    animate();
    </script>
</body>
</html>