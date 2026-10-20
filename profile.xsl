<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes" doctype-system="about:blank" />

  <xsl:template match="/profile">
    <html lang="en">
      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title><xsl:value-of select="developer/name" /> — Interactive XML Profile</title>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous" />
        <link href="https://fonts.googleapis.com/css2?family=Fira+Code:wght@400;600&amp;family=Inter:wght@400;500;600;700;800&amp;display=swap" rel="stylesheet" />
        <style>
          :root {
            --bg-base: #090d16;
            --bg-surface: #0f172a;
            --bg-card: rgba(15, 23, 42, 0.75);
            --border-subtle: #1e293b;
            --border-glow: rgba(56, 189, 248, 0.4);
            --accent-cyan: #38bdf8;
            --accent-blue: #2563eb;
            --accent-purple: #a855f7;
            --accent-green: #10b981;
            --accent-amber: #f59e0b;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --text-faint: #64748b;
          }

          * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
          }

          body {
            background-color: var(--bg-base);
            background-image: 
              radial-gradient(at 50% 0%, rgba(37, 99, 235, 0.15) 0px, transparent 60%),
              radial-gradient(at 100% 100%, rgba(168, 85, 247, 0.1) 0px, transparent 50%),
              radial-gradient(at 0% 100%, rgba(16, 185, 129, 0.08) 0px, transparent 50%);
            color: var(--text-main);
            font-family: 'Inter', -apple-system, sans-serif;
            min-height: 100vh;
            padding: 40px 20px;
            line-height: 1.6;
          }

          .container {
            max-width: 1080px;
            margin: 0 auto;
          }

          /* Header Nav */
          .hud-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 24px;
            background: var(--bg-card);
            backdrop-filter: blur(12px);
            border: 1px solid var(--border-subtle);
            border-radius: 14px;
            margin-bottom: 28px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4);
          }

          .brand-badge {
            display: flex;
            align-items: center;
            gap: 12px;
          }

          .brand-logo {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            background: linear-gradient(135deg, #2563eb, #38bdf8);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Fira Code', monospace;
            font-weight: 700;
            font-size: 18px;
            color: white;
            box-shadow: 0 0 14px rgba(56, 189, 248, 0.4);
          }

          .brand-title h1 {
            font-size: 17px;
            font-weight: 700;
            letter-spacing: -0.2px;
          }

          .brand-title p {
            font-size: 12px;
            color: var(--text-muted);
            font-family: 'Fira Code', monospace;
          }

          .status-pill {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 6px 14px;
            background: rgba(16, 185, 129, 0.12);
            border: 1px solid rgba(16, 185, 129, 0.35);
            border-radius: 20px;
            font-family: 'Fira Code', monospace;
            font-size: 11px;
            color: var(--accent-green);
          }

          .status-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: var(--accent-green);
            box-shadow: 0 0 8px var(--accent-green);
            animation: pulse 1.8s infinite;
          }

          @keyframes pulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.4; transform: scale(0.85); }
          }

          /* Hero SVG Embed Card */
          .svg-hero-wrapper {
            margin-bottom: 32px;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.5);
            border: 1px solid var(--border-subtle);
            background: #060911;
          }

          .svg-hero-wrapper object {
            width: 100%;
            display: block;
          }

          /* Grid Layout */
          .main-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
            margin-bottom: 32px;
          }

          @media (max-width: 820px) {
            .main-grid {
              grid-template-columns: 1fr;
            }
          }

          .glass-card {
            background: var(--bg-card);
            backdrop-filter: blur(12px);
            border: 1px solid var(--border-subtle);
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.35);
            transition: border-color 0.2s, box-shadow 0.2s;
          }

          .glass-card:hover {
            border-color: rgba(56, 189, 248, 0.3);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.45);
          }

          .card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 18px;
            padding-bottom: 12px;
            border-bottom: 1px solid var(--border-subtle);
          }

          .card-title {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 15px;
            font-weight: 700;
            color: var(--accent-cyan);
            font-family: 'Fira Code', monospace;
          }

          .tag-badge {
            font-size: 11px;
            padding: 3px 8px;
            border-radius: 6px;
            background: rgba(56, 189, 248, 0.1);
            color: var(--accent-cyan);
            border: 1px solid rgba(56, 189, 248, 0.2);
            font-family: 'Fira Code', monospace;
          }

          /* Skills Filter & Chips */
          .search-box {
            width: 100%;
            background: rgba(15, 23, 42, 0.8);
            border: 1px solid var(--border-subtle);
            color: var(--text-main);
            padding: 10px 14px;
            border-radius: 8px;
            font-family: 'Fira Code', monospace;
            font-size: 12px;
            margin-bottom: 16px;
            outline: none;
            transition: border-color 0.2s;
          }

          .search-box:focus {
            border-color: var(--accent-cyan);
            box-shadow: 0 0 10px rgba(56, 189, 248, 0.25);
          }

          .skills-wrap {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
          }

          .skill-item {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 8px;
            background: rgba(30, 41, 59, 0.5);
            border: 1px solid var(--border-subtle);
            font-size: 12px;
            font-family: 'Fira Code', monospace;
            transition: all 0.2s;
          }

          .skill-item:hover {
            background: rgba(56, 189, 248, 0.15);
            border-color: var(--accent-cyan);
            color: #ffffff;
            transform: translateY(-1px);
          }

          .skill-item span.level {
            font-size: 10px;
            padding: 2px 5px;
            border-radius: 4px;
            background: rgba(16, 185, 129, 0.15);
            color: var(--accent-green);
          }

          /* Architecture Highlights Table */
          .arch-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
          }

          .arch-table th {
            text-align: left;
            padding: 8px 12px;
            color: var(--text-muted);
            border-bottom: 1px solid var(--border-subtle);
            font-family: 'Fira Code', monospace;
            font-size: 11px;
          }

          .arch-table td {
            padding: 10px 12px;
            border-bottom: 1px solid rgba(30, 41, 59, 0.5);
            vertical-align: top;
          }

          .arch-table tr:hover td {
            background: rgba(56, 189, 248, 0.04);
          }

          .pillar-name {
            font-weight: 600;
            color: var(--accent-cyan);
            font-family: 'Fira Code', monospace;
            white-space: nowrap;
          }

          /* Buttons / Contact Strip */
          .contact-bar {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
          }

          .btn-action {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            font-family: 'Fira Code', monospace;
            transition: transform 0.2s, box-shadow 0.2s;
          }

          .btn-action:hover {
            transform: translateY(-2px);
          }

          .btn-blue {
            background: linear-gradient(135deg, #1d4ed8, #2563eb);
            color: white;
            box-shadow: 0 4px 14px rgba(37, 99, 235, 0.3);
          }

          .btn-purple {
            background: linear-gradient(135deg, #7e22ce, #9333ea);
            color: white;
            box-shadow: 0 4px 14px rgba(147, 51, 234, 0.3);
          }

          .btn-green {
            background: linear-gradient(135deg, #047857, #059669);
            color: white;
            box-shadow: 0 4px 14px rgba(5, 150, 105, 0.3);
          }

          /* Footer */
          footer {
            text-align: center;
            font-size: 12px;
            color: var(--text-faint);
            font-family: 'Fira Code', monospace;
            margin-top: 40px;
            padding-top: 20px;
            border-top: 1px solid var(--border-subtle);
          }
        </style>
      </head>
      <body>
        <div class="container">
          <!-- Header Bar -->
          <header class="hud-header">
            <div class="brand-badge">
              <div class="brand-logo">A</div>
              <div class="brand-title">
                <h1><xsl:value-of select="developer/name" /></h1>
                <p><xsl:value-of select="developer/title" /></p>
              </div>
            </div>
            <div class="status-pill">
              <div class="status-dot"></div>
              <span><xsl:value-of select="developer/status" /></span>
            </div>
          </header>

          <!-- Interactive SVG Hero Component -->
          <div class="svg-hero-wrapper">
            <object id="profileHud" type="image/svg+xml" data="assets/interactive-card.svg" width="100%"></object>
          </div>

          <!-- Main Two-Column Grid -->
          <div class="main-grid">
            <!-- Left: Featured System Project (Vaultly) -->
            <div class="glass-card">
              <div class="card-header">
                <div class="card-title">
                  <span>🚀</span>
                  <span><xsl:value-of select="featuredProject/name" /></span>
                </div>
                <span class="tag-badge"><xsl:value-of select="featuredProject/badge" /></span>
              </div>
              <p style="font-size: 13.5px; color: var(--text-muted); margin-bottom: 16px;">
                <xsl:value-of select="featuredProject/description" />
              </p>

              <table class="arch-table">
                <thead>
                  <tr>
                    <th>AREA</th>
                    <th>IMPLEMENTATION &amp; GUARANTEES</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="featuredProject/features/feature">
                    <tr>
                      <td class="pillar-name"><xsl:value-of select="area" /></td>
                      <td style="color: var(--text-muted);"><xsl:value-of select="details" /></td>
                    </tr>
                  </xsl:for-each>
                </tbody>
              </table>

              <div style="margin-top: 20px;">
                <a href="https://github.com/im-abhyuday/Vaultly" target="_blank" class="btn-action btn-blue">
                  <span>⚡ View Repository on GitHub</span>
                </a>
              </div>
            </div>

            <!-- Right: Skills Matrix with Live Search -->
            <div class="glass-card">
              <div class="card-header">
                <div class="card-title">
                  <span>🛠️</span>
                  <span>SKILLS &amp; PROFICIENCIES</span>
                </div>
                <span class="tag-badge">XML Data-Driven</span>
              </div>

              <input type="text" id="skillSearch" class="search-box" placeholder="Filter technologies (e.g. FastAPI, Kafka, RLS)..." oninput="filterSkills()" />

              <div class="skills-wrap" id="skillsContainer">
                <xsl:for-each select="skills/skill">
                  <div class="skill-item" data-name="{name}">
                    <span style="font-weight: 600; color: #f8fafc;"><xsl:value-of select="name" /></span>
                    <span class="level"><xsl:value-of select="level" /></span>
                  </div>
                </xsl:for-each>
              </div>

              <!-- Contact & Dispatch Channels -->
              <div style="margin-top: 28px; padding-top: 18px; border-top: 1px solid var(--border-subtle);">
                <div class="card-title" style="margin-bottom: 14px; font-size: 13px;">
                  <span>🤝</span>
                  <span>GET IN TOUCH</span>
                </div>
                <div class="contact-bar">
                  <a href="https://www.linkedin.com/in/abhyudayyy/" target="_blank" class="btn-action btn-blue">
                    <span>💼 LinkedIn</span>
                  </a>
                  <a href="mailto:abhyudaymishra2004@gmail.com" class="btn-action btn-green">
                    <span>✉️ Email</span>
                  </a>
                  <a href="https://github.com/im-abhyuday/Resume" target="_blank" class="btn-action btn-purple">
                    <span>📄 Resume</span>
                  </a>
                </div>
              </div>
            </div>
          </div>

          <!-- Footer -->
          <footer>
            <p>Generated via XML + XSLT Transformation • Designed for <xsl:value-of select="developer/name" />'s GitHub Profile</p>
          </footer>
        </div>

        <script><![CDATA[
          function filterSkills() {
            const query = document.getElementById('skillSearch').value.toLowerCase();
            const items = document.querySelectorAll('.skill-item');
            items.forEach(item => {
              const name = item.getAttribute('data-name').toLowerCase();
              if (name.includes(query)) {
                item.style.display = 'inline-flex';
              } else {
                item.style.display = 'none';
              }
            });
          }
        ]]></script>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
