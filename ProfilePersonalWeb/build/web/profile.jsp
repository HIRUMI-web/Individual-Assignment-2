<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ProfileBean"%>
<%
    ProfileBean profile = (ProfileBean) request.getAttribute("savedProfile");
%>
<!DOCTYPE html>
<html lang="ms">
<head>
    <meta charset="UTF-8">
    <title>Registration Success</title>
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
    }

    #firework-canvas {
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
    }

    .success-box, .profile-card {
        position: relative;
        border: none; 
        border-radius: 24px;
        background: #000000; 
        box-shadow: 0 20px 50px rgba(0, 0, 0, 0.8);
        overflow: visible; 
        transition: transform 0.4s cubic-bezier(0.16, 1, 0.3, 1);
    }

    .success-box::before, .profile-card::before {
        content: '';
        position: absolute;
        top: -2px;
        left: -2px;
        right: -2px;
        bottom: -2px;
        background: linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f);
        background-size: 400% 400%;
        border-radius: 26px;
        z-index: -1;
        opacity: 0.5; 
        transition: none; 
        animation: rainbowAnimation 8s ease infinite;
    }

    .success-box:hover, .profile-card:hover {
        transform: translateY(-8px);
    }

    .success-box:hover::before, .profile-card:hover::before {
        opacity: 0.5;
        filter: none;
    }

    .success-box {
        padding: 25px;
        text-align: center;
    }

    .profile-card {
        padding: 25px;
    }

    .success-icon {
        font-size: 40px;
        color: #38bdf8;
        margin-bottom: 10px;
    }

    .section-title {
        font-weight: 600;
        color: #ffffff;
        margin-bottom: 20px;
        letter-spacing: 0.5px;
    }

    .info-item {
        margin-bottom: 15px;
    }

    .info-label {
        font-size: 0.8rem;
        color: #9ca3af;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .info-value {
        font-size: 0.95rem;
        font-weight: 500;
        color: #ffffff;
    }

    .bio-box {
        background: rgba(255, 255, 255, 0.03);
        border: 1px solid rgba(255, 255, 255, 0.08);
        padding: 15px;
        border-radius: 12px;
        font-size: 0.9rem;
        color: #e5e7eb;
        white-space: pre-line;
    }

    .uiverse-btn {
        position: relative;
        background-color: transparent;
        border: none;
        border-radius: 12px;
        width: 100%;
        height: 55px;
        cursor: pointer;
        overflow: hidden;
        font-size: 1rem;
        font-weight: 600;
        display: block;
        transition: all 0.3s cubic-bezier(0.23, 1, 0.320, 1);
    }

    .uiverse-btn:focus { outline: none; }
    .uiverse-btn:active { transform: scale(0.98); }

    .btn-add-rainbow::before {
        content: "\f067  Add New Record";
        font-family: 'Inter', 'Font Awesome 6 Free';
        font-weight: 600;
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
        height: 100%;
        position: absolute;
        top: 0; left: 0;
        pointer-events: none;
        background: linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f);
        background-size: 300% 300%;
        color: #ffffff;
        z-index: 2;
        transform: translate(0%, 0%);
        animation: rainbowAnimation 6s ease infinite;
        transition: all 0.6s cubic-bezier(0.23, 1, 0.320, 1);
    }

    .btn-add-rainbow::after {
        content: "\f067  Add New Record";
        font-family: 'Inter', 'Font Awesome 6 Free';
        font-weight: 600;
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
        height: 100%;
        position: absolute;
        top: 0; left: 0;
        pointer-events: none;
        background-color: #000000;
        border: 2px solid transparent;
        background-image: linear-gradient(#000000, #000000), linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f);
        background-origin: border-box;
        background-clip: padding-box, border-box;
        
        background: linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f);
        background-size: 300% 300%;
        -webkit-background-clip: text;
        background-clip: text;
        -webkit-text-fill-color: transparent;
        
        z-index: 1;
        transform: translate(0%, 100%);
        animation: rainbowAnimation 6s ease infinite;
        transition: all 0.6s cubic-bezier(0.23, 1, 0.320, 1);
    }

    .btn-add-rainbow:hover::before { transform: translate(0%, -100%); }
    .btn-add-rainbow:hover::after { transform: translate(0%, 0%); }

    .btn-view-rainbow::before {
        content: "\f03a  View All Records";
        font-family: 'Inter', 'Font Awesome 6 Free';
        font-weight: 600;
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
        height: 100%;
        position: absolute;
        top: 0; left: 0;
        pointer-events: none;
        
        background: #000000;
        border: 2px solid transparent;
        background-image: linear-gradient(#000000, #000000), linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f);
        background-origin: border-box;
        background-clip: padding-box, border-box;
        background-size: 100%, 300% 300%;
        
        background-color: transparent;
        background-image: linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f);
        -webkit-background-clip: text;
        background-clip: text;
        -webkit-text-fill-color: transparent;
        
        z-index: 2;
        transform: translate(0%, 0%);
        animation: rainbowAnimation 6s ease infinite;
        transition: all 0.6s cubic-bezier(0.23, 1, 0.320, 1);
    }

    .btn-view-rainbow::after {
        content: "\f03a  View All Records";
        font-family: 'Inter', 'Font Awesome 6 Free';
        font-weight: 600;
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
        height: 100%;
        position: absolute;
        top: 0; left: 0;
        pointer-events: none;
        
        background-color: rgba(255, 255, 255, 0.05);
        border: 2px solid transparent;
        background-image: linear-gradient(rgba(255, 255, 255, 0.05), rgba(255, 255, 255, 0.05)), linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f);
        background-origin: border-box;
        background-clip: padding-box, border-box;
        background-size: 100%, 300% 300%;
        
        background-image: linear-gradient(45deg, #ff3399, #5c9aff, #b975ff, #62d1ff, #ff3399);
        -webkit-background-clip: text;
        background-clip: text;
        -webkit-text-fill-color: transparent;
        
        z-index: 1;
        transform: translate(0%, 100%);
        animation: rainbowAnimation 6s ease infinite;
        transition: all 0.6s cubic-bezier(0.23, 1, 0.320, 1);
    }

    .btn-view-rainbow:hover::before { transform: translate(0%, -100%); }
    .btn-view-rainbow:hover::after { transform: translate(0%, 0%); }

    .btn-menu-sliding::before {
        content: "\f015  Main Menu";
        font-family: 'Inter', 'Font Awesome 6 Free';
        font-weight: 600;
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
        height: 100%;
        position: absolute;
        top: 0; left: 0;
        pointer-events: none;
        background-color: rgba(255, 255, 255, 0.02);
        border: 1px solid rgba(255, 255, 255, 0.15);
        border-radius: 12px;
        color: #ffffff;
        z-index: 2;
        transform: translate(0%, 0%);
        transition: all 0.6s cubic-bezier(0.23, 1, 0.320, 1);
    }

    .btn-menu-sliding::after {
        content: "\f015  Main Menu";
        font-family: 'Inter', 'Font Awesome 6 Free';
        font-weight: 600;
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
        height: 100%;
        position: absolute;
        top: 0; left: 0;
        pointer-events: none;
        background-color: rgba(255, 255, 255, 0.08);
        border: 1px solid rgba(255, 255, 255, 0.3);
        border-radius: 12px;
        color: #9ca3af;
        z-index: 1;
        transform: translate(0%, 100%);
        transition: all 0.6s cubic-bezier(0.23, 1, 0.320, 1);
    }

    .btn-menu-sliding:hover::before { transform: translate(0%, -100%); }
    .btn-menu-sliding:hover::after { transform: translate(0%, 0%); }

    @keyframes rainbowAnimation {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }
    </style>
</head>

<body>

    <canvas id="firework-canvas"></canvas>

    <div class="container mt-5 mb-5">

        <div class="success-box mx-auto mb-4" style="max-width: 600px;">
            <div class="success-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <h4 class="fw-bold text-white">Profile Successfully Created!</h4>
            <p class="text-muted mb-0">The record has been saved into the database.</p>
        </div>

        <% if (profile != null) { %>

        <div class="profile-card mx-auto" style="max-width: 600px;">

            <h5 class="section-title text-center">Submitted Student Information</h5>

            <div class="row">

                <div class="col-md-6 info-item">
                    <div class="info-label">Student ID</div>
                    <div class="info-value"><%= profile.getStudentID() %></div>
                </div>

                <div class="col-md-6 info-item">
                    <div class="info-label">Full Name</div>
                    <div class="info-value"><%= profile.getName() %></div>
                </div>

                <div class="col-md-6 info-item">
                    <div class="info-label">Programme</div>
                    <div class="info-value"><%= profile.getProgramme() %></div>
                </div>

                <div class="col-md-6 info-item">
                    <div class="info-label">Email</div>
                    <div class="info-value"><%= profile.getEmail() %></div>
                </div>

                <div class="col-12 info-item">
                    <div class="info-label">Hobbies</div>
                    <div class="info-value">
                        <%= (profile.getHobbies() != null && !profile.getHobbies().trim().isEmpty()) ? profile.getHobbies() : "-" %>
                    </div>
                </div>

                <div class="col-12 info-item">
                    <div class="info-label">Biography</div>
                    <div class="bio-box">
                        <%= (profile.getIntroduction() != null && !profile.getIntroduction().trim().isEmpty()) ? profile.getIntroduction() : "-" %>
                    </div>
                </div>

            </div>

            <div class="d-flex flex-column gap-3 mt-4">
                <a href="index.html" class="text-decoration-none">
                    <button type="button" class="uiverse-btn btn-add-rainbow"></button>
                </a>

                <a href="ProfileServlet?action=view" class="text-decoration-none">
                    <button type="button" class="uiverse-btn btn-view-rainbow"></button>
                </a>

                <a href="menu.html" class="text-decoration-none">
                    <button type="button" class="uiverse-btn btn-menu-sliding"></button>
                </a>
            </div>

        </div>

        <% } else { %>

        <div class="alert alert-warning text-center mx-auto mt-4" style="max-width: 600px; border-radius: 16px;">
            <i class="fas fa-exclamation-triangle me-2"></i>Tiada objek profil ditemui.
        </div>

        <% } %>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
    const canvas = document.getElementById('firework-canvas');
    const ctx = canvas.getContext('2d');

    let fireworks = [];
    let particles = [];
    const colors = ['#ff007f', '#3b82f6', '#a855f7', '#38bdf8', '#00ffcc', '#ffcc00', '#ff5500'];

    function resizeCanvas() {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
    }
    window.addEventListener('resize', resizeCanvas);
    resizeCanvas();

    class Firework {
        constructor() {
            this.x = Math.random() * canvas.width;
            this.y = canvas.height;
            this.targetY = Math.random() * (canvas.height * 0.5) + canvas.height * 0.1;
            this.speed = Math.random() * 4 + 4;
            this.color = colors[Math.floor(Math.random() * colors.length)];
            this.radius = 2.5;
        }

        update() {
            this.y -= this.speed;
            if (this.y <= this.targetY) {
                this.explode();
                return false;
            }
            return true;
        }

        draw() {
            ctx.save();
            ctx.beginPath();
            ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2);
            ctx.fillStyle = this.color;
            ctx.shadowBlur = 10;
            ctx.shadowColor = this.color;
            ctx.fill();
            ctx.restore();
        }

        explode() {
            const count = Math.random() * 40 + 60;
            for (let i = 0; i < count; i++) {
                particles.push(new Particle(this.x, this.y, this.color));
            }
        }
    }

    class Particle {
        constructor(x, y, color) {
            this.x = x;
            this.y = y;
            this.color = color;
            this.radius = Math.random() * 2 + 1;
            
            const angle = Math.random() * Math.PI * 2;
            const speed = Math.random() * 5 + 2;
            this.vx = Math.cos(angle) * speed;
            this.vy = Math.sin(angle) * speed;
            
            this.gravity = 0.06;
            this.alpha = 1;
            this.decay = Math.random() * 0.015 + 0.01;
        }

        update() {
            this.x += this.vx;
            this.y += this.vy;
            this.vy += this.gravity;
            this.alpha -= this.decay;
            return this.alpha > 0;
        }

        draw() {
            ctx.save();
            ctx.globalAlpha = this.alpha;
            ctx.beginPath();
            ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2);
            ctx.fillStyle = this.color;
            ctx.shadowBlur = 8;
            ctx.shadowColor = this.color;
            ctx.fill();
            ctx.restore();
        }
    }

    function animate() {
        ctx.fillStyle = 'rgba(13, 14, 18, 0.2)';
        ctx.fillRect(0, 0, canvas.width, canvas.height);

        if (Math.random() < 0.04 && fireworks.length < 5) {
            fireworks.push(new Firework());
        }

        fireworks = fireworks.filter(firework => {
            const alive = firework.update();
            if (alive) firework.draw();
            return alive;
        });

        particles = particles.filter(particle => {
            const alive = particle.update();
            if (alive) particle.draw();
            return alive;
        });

        requestAnimationFrame(animate);
    }

    animate();
    </script>
</body>
</html>