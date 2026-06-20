<!DOCTYPE html>
<html lang="ms">
<head>
    <meta charset="UTF-8">
    <title>Student Registration</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap');

    body {
        font-family: 'Inter', sans-serif;
        background: #090a0f;
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        overflow-x: hidden;
        position: relative;
        padding: 40px 0;
        color: #f3f4f6;
    }

    /* --- MOVING NEON BACKGROUND CANVAS --- */
    #neon-canvas {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: 1;
        pointer-events: none; 
    }

    /* --- FORM CARD: SOLID BLACK + BRIGHT RAINBOW BORDER --- */
    .form-card {
        position: relative;
        z-index: 2;
        background: #000000 !important; 
        border: none !important;
        border-radius: 24px;
        padding: 35px;
        width: 100%;
        max-width: 600px;
        box-shadow: 0 0 30px rgba(56, 189, 248, 0.15); 
        overflow: visible;
        transition: transform 0.4s cubic-bezier(0.16, 1, 0.3, 1);
    }

    .form-card::before {
        content: '';
        position: absolute;
        top: -3px;       
        left: -3px;
        right: -3px;
        bottom: -3px;
        background: #000000;
        background-size: 400% 400%;
        border-radius: 27px; 
        border-color: linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f);
        z-index: -1;
        opacity: 1 !important; 
        animation: rainbowAnimation 6s linear infinite; 
    }

    .form-card:hover {
        transform: translateY(-8px);
    }

    .form-title {
        text-align: center;
        color: #ffffff;
        font-weight: 600;
        margin-bottom: 30px;
        letter-spacing: 0.5px;
        text-shadow: 0 0 15px rgba(56, 189, 248, 0.2);
    }

    .form-label {
        font-size: 0.8rem;
        color: #9ca3af;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 8px;
    }

    .form-control {
        background: rgba(255, 255, 255, 0.06); 
        border: 1px solid rgba(255, 255, 255, 0.12);
        border-radius: 12px;
        padding: 12px;
        font-size: 0.95rem;
        color: #ffffff;
        transition: all 0.3s ease;
    }

    .form-control:focus {
        background: rgba(255, 255, 255, 0.1);
        border-color: #38bdf8;
        box-shadow: 0 0 15px rgba(56, 189, 248, 0.25);
        color: #ffffff;
        outline: none;
    }

    .form-control::placeholder {
        background: linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f);
        background-size: 400% 400%;
        -webkit-background-clip: text;
        background-clip: text;
        -webkit-text-fill-color: transparent;
        opacity: 0.75; 
        animation: rainbowAnimation 8s ease infinite;
    }

    .form-control::-webkit-input-placeholder {
        background: linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f);
        background-size: 400% 400%;
        -webkit-background-clip: text;
        background-clip: text;
        -webkit-text-fill-color: transparent;
        animation: rainbowAnimation 8s ease infinite;
    }

    .btn {
        border-radius: 12px;
        padding: 12px;
        font-size: 0.95rem;
        font-weight: 600;
        transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
    }

    .btn-submit {
        background: linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f) !important;
        background-size: 400% 400% !important;
        color: #ffffff !important;
        border: 2px solid transparent !important;
        animation: rainbowAnimation 6s linear infinite;
    }

    .btn-submit:hover {
        transform: translateY(-2px);
        background: #000000 !important;
        border: 2px solid transparent !important;
        box-shadow: 0 0 20px rgba(168, 85, 247, 0.3);
        
        background-image: linear-gradient(#000, #000), linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f) !important;
        background-origin: border-box !important;
        background-clip: padding-box, border-box !important;
    }

    .btn-submit:hover .btn-text-content,
    .btn-submit:hover i {
        background: linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f);
        background-size: 400% 400%;
        -webkit-background-clip: text;
        background-clip: text;
        -webkit-text-fill-color: transparent;
        animation: rainbowAnimation 6s linear infinite;
    }

    .btn-menu {
        background: #000000 !important;
        border: 2px solid rgba(255, 255, 255, 0.2);
        color: #ffffff;
        position: relative;
        overflow: hidden;
        z-index: 1;
    }

    .btn-menu::before {
        content: '';
        position: absolute;
        top: 0; left: 0; right: 0; bottom: 0;
        border-radius: 10px;
        padding: 2px; 
        background: linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f);
        background-size: 400% 400%;
        -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
        -webkit-mask-composite: xor;
        mask-composite: exclude;
        opacity: 0;
        transition: opacity 0.3s ease;
        animation: rainbowAnimation 6s linear infinite;
        z-index: -1;
    }

    .btn-menu:hover {
        transform: translateY(-2px);
        background: #000000 !important;
        border-color: transparent; 
        box-shadow: 0 0 15px rgba(56, 189, 248, 0.2);
    }

    .btn-menu:hover::before {
        opacity: 1;
    }

    .btn-menu:hover .btn-text-content,
    .btn-menu:hover i {
        background: linear-gradient(45deg, #ff007f, #3b82f6, #a855f7, #38bdf8, #ff007f);
        background-size: 400% 400%;
        -webkit-background-clip: text;
        background-clip: text;
        -webkit-text-fill-color: transparent;
        animation: rainbowAnimation 6s linear infinite;
    }

    @keyframes rainbowAnimation {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }
    </style>
</head>

<body>

    <canvas id="neon-canvas"></canvas>

    <div class="form-card">

        <h3 class="form-title"><i class="fas fa-user-plus me-2"></i>Student Registration</h3>

        <form action="ProfileServlet" method="POST">
            <input type="hidden" name="action" value="create">

            <div class="mb-3">
                <label class="form-label">Student ID</label>
                <input type="text" name="studentId" class="form-control" placeholder="e.g., 2026123456" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" name="name" class="form-control" placeholder="Enter full name here..." required>
            </div>

            <div class="mb-3">
                <label class="form-label">Programme</label>
                <input type="text" name="program" class="form-control" placeholder="e.g., Bachelor of Computer Science" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Hobbies</label>
                <input type="text" name="hobbies" class="form-control" placeholder="e.g., Reading, Coding, Gaming">
            </div>

            <div class="mb-3">
                <label class="form-label">Biography / Introduction</label>
                <textarea name="bio" class="form-control" rows="3" placeholder="Tell us a little bit about yourself..."></textarea>
            </div>

            <div class="d-flex flex-column gap-2 mt-4">
                <button type="submit" class="btn btn-submit">
                    <i class="fas fa-paper-plane me-2"></i><span class="btn-text-content">Register Student</span>
                </button>
                
                <a href="menu.html" class="btn btn-menu text-center text-decoration-none">
                    <i class="fas fa-home me-2"></i><span class="btn-text-content">Back to Menu</span>
                </a>
            </div>
        </form>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
    const canvas = document.getElementById('neon-canvas');
    const ctx = canvas.getContext('2d');

    function resizeCanvas() {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
    }
    window.addEventListener('resize', resizeCanvas);
    resizeCanvas();

    const streams = [];
    const colorThemes = ['#ff007f', '#3b82f6', '#a855f7', '#38bdf8'];

    class NeonStream {
        constructor() {
            this.reset();
            this.y = Math.random() * canvas.height;
        }

        reset() {
            this.x = Math.random() * canvas.width;
            this.y = -50;
            this.length = Math.random() * 80 + 40;
            this.speed = Math.random() * 2 + 1.5;
            this.color = colorThemes[Math.floor(Math.random() * colorThemes.length)];
            this.weight = Math.random() * 2 + 1;
            this.alpha = Math.random() * 0.25 + 0.05;
        }

        update() {
            this.y += this.speed;
            this.x += Math.sin(this.y / 30) * 0.3;

            if (this.y - this.length > canvas.height) {
                this.reset();
            }
        }

        draw() {
            ctx.save();
            ctx.globalAlpha = this.alpha;
            ctx.lineWidth = this.weight;
            ctx.strokeStyle = this.color;
            ctx.shadowBlur = 8;
            ctx.shadowColor = this.color;

            ctx.beginPath();
            ctx.moveTo(this.x, this.y - this.length);
            ctx.lineTo(this.x, this.y);
            ctx.stroke();
            ctx.restore();
        }
    }

    for (let i = 0; i < 25; i++) {
        streams.push(new NeonStream());
    }

    function animateNeonSystem() {
        ctx.fillStyle = '#090a0f';
        ctx.fillRect(0, 0, canvas.width, canvas.height);

        streams.forEach(stream => {
            stream.update();
            stream.draw();
        });

        requestAnimationFrame(animateNeonSystem);
    }

    animateNeonSystem();
    </script>
</body>
</html>