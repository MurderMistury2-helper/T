<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title>Anti-Cheat Processing — Loading</title>
<style>
  :root{
    --bg1:#0f1724;
    --bg2:#081029;
    --accent:#7c5cff;
    --accent2:#00e6ff;
    --glass: rgba(255,255,255,0.05);
    --text:#e9eef8;
  }
  html,body{height:100%;margin:0;font-family:Inter,ui-sans-serif,system-ui,-apple-system,Segoe UI,Roboto,"Helvetica Neue",Arial;}
  body{
    background: radial-gradient(1200px 600px at 10% 20%, rgba(124,92,255,0.12), transparent),
                radial-gradient(1000px 500px at 90% 80%, rgba(0,230,255,0.06), transparent),
                linear-gradient(180deg,var(--bg1),var(--bg2));
    color:var(--text);
    overflow:hidden;
    display:flex;
    align-items:center;
    justify-content:center;
  }

  /* Floating particle layer */
  .particles{
    position:fixed; inset:0; pointer-events:none; z-index:0;
  }
  .particle{
    position:absolute;
    width:6px;height:6px;border-radius:50%;
    background:linear-gradient(45deg,var(--accent),var(--accent2));
    opacity:0.12;
    filter: blur(6px);
    animation: drift 18s linear infinite;
  }
  @keyframes drift {
    from { transform: translateY(0) translateX(0) scale(1); opacity:0.12; }
    50% { transform: translateY(-120vh) translateX(20vw) scale(1.6); opacity:0.22; }
    to { transform: translateY(0) translateX(-10vw) scale(1); opacity:0.12; }
  }

  /* Panel */
  .panel{
    position:relative;
    z-index:2;
    width:92%;
    max-width:1100px;
    border-radius:18px;
    padding:28px;
    background: linear-gradient(180deg, rgba(255,255,255,0.03), rgba(255,255,255,0.015));
    box-shadow: 0 10px 40px rgba(2,6,23,0.6), inset 0 1px 0 rgba(255,255,255,0.02);
    display:flex;
    gap:28px;
    align-items:center;
    backdrop-filter: blur(8px) saturate(140%);
    border: 1px solid rgba(255,255,255,0.04);
  }

  /* Left — info */
  .info{
    flex:1 1 520px;
    min-width:300px;
  }
  .title{
    font-size:20px;
    letter-spacing:0.6px;
    color:var(--accent);
    display:flex;
    gap:10px;
    align-items:center;
  }
  .title .dot{
    width:12px;height:12px;border-radius:50%;
    background:linear-gradient(180deg,var(--accent),var(--accent2));
    box-shadow:0 0 20px rgba(124,92,255,0.35), 0 0 40px rgba(0,230,255,0.07);
  }
  h1{
    margin:8px 0 12px;
    font-size:28px;
    line-height:1.05;
    color:#f6f8ff;
  }
  .status{
    font-size:16px;
    color:rgba(233,238,248,0.85);
    margin-bottom:20px;
  }

  /* Progress visuals */
  .loader-wrap{
    background: linear-gradient(90deg, rgba(255,255,255,0.02), rgba(255,255,255,0.01));
    border-radius:14px;
    padding:14px;
    border:1px solid rgba(255,255,255,0.03);
  }
  .progress-bar{
    position:relative;
    height:28px;
    background:linear-gradient(90deg, rgba(255,255,255,0.02), rgba(0,0,0,0));
    border-radius:10px;
    overflow:hidden;
  }
  .progress-fill{
    position:absolute; left:0; top:0; bottom:0;
    width:0%;
    background: linear-gradient(90deg, rgba(124,92,255,0.9), rgba(0,230,255,0.8));
    box-shadow: 0 6px 18px rgba(124,92,255,0.18), 0 0 40px rgba(0,230,255,0.05);
    transform-origin:left center;
    transition: width 0.2s linear;
  }
  .progress-glow{
    content:"";
    position:absolute; right:-40px; top:-20px; width:140px; height:80px;
    background: radial-gradient(circle at 30% 30%, rgba(255,255,255,0.15), transparent 40%),
                linear-gradient(90deg, rgba(124,92,255,0.25), rgba(0,230,255,0.18));
    filter: blur(18px);
    transform: rotate(12deg);
    pointer-events:none;
    opacity:0.9;
  }
  .progress-meta{
    display:flex; justify-content:space-between; align-items:center;
    margin-top:10px; font-size:13px; color:rgba(233,238,248,0.7);
  }
  .eta{ font-variant-numeric: tabular-nums; }

  /* Right — anime girl */
  .character{
    width:320px; max-width:38%;
    display:flex; align-items:center; justify-content:center;
    pointer-events:none;
  }
  .avatar{
    width:260px;height:320px;border-radius:18px;
    background: linear-gradient(180deg,#0b1320 0%, rgba(124,92,255,0.06) 50%);
    display:flex; align-items:center; justify-content:center;
    box-shadow: 0 20px 60px rgba(2,6,23,0.6), 0 8px 30px rgba(124,92,255,0.06);
    border:1px solid rgba(255,255,255,0.03);
    position:relative;
    overflow:visible;
  }
  /* bobbing anime */
  .anime{
    width:220px; height:300px;
    transform-origin:center;
    animation: bob 6s ease-in-out infinite, floatGlow 3.5s ease-in-out infinite;
    will-change: transform;
  }
  @keyframes bob {
    0% { transform: translateY(0); }
    50% { transform: translateY(-12px); }
    100% { transform: translateY(0); }
  }
  @keyframes floatGlow {
    0% { filter: drop-shadow(0 6px 16px rgba(124,92,255,0.12)); }
    50% { filter: drop-shadow(0 18px 40px rgba(0,230,255,0.12)); }
    100% { filter: drop-shadow(0 6px 16px rgba(124,92,255,0.12)); }
  }

  /* anime SVG minor styling */
  .anime svg { width:100%; height:100%; display:block; }

  /* Bottom reminder */
  .reminder{
    position:fixed;
    left:50%;
    transform:translateX(-50%);
    bottom:18px;
    z-index:3;
    background: linear-gradient(90deg, rgba(124,92,255,0.12), rgba(0,230,255,0.06));
    padding:10px 18px;
    border-radius:999px;
    font-size:13px;
    color:#ffffff;
    border:1px solid rgba(255,255,255,0.04);
    box-shadow: 0 6px 30px rgba(2,6,23,0.6);
    display:flex; gap:10px; align-items:center;
  }
  .reminder .warn{
    background:linear-gradient(90deg,#ff9f5c,#ff6b6b);
    width:8px;height:8px;border-radius:50%;
    box-shadow:0 4px 16px rgba(255,107,107,0.22);
  }

  /* small responsive */
  @media (max-width:880px){
    .panel{flex-direction:column; padding:18px;}
    .character{max-width:100%;}
    .avatar{width:220px;height:260px;}
  }

  /* subtle scanlines overlay */
  .scanlines{
    position:fixed; inset:0; z-index:1; pointer-events:none;
    background-image: linear-gradient(rgba(255,255,255,0.01) 1px, transparent 1px);
    background-size: 100% 6px;
    mix-blend-mode: overlay;
    opacity:0.6;
  }

  /* animated glitch for header text */
  .glitch{
    position:relative;
    color:#fff;
  }
  .glitch::before, .glitch::after{
    content:attr(data-text);
    position:absolute; left:0; top:0;
    width:100%;
    overflow:hidden;
    clip-path: inset(0 0 0 0);
    opacity:0.85;
  }
  .glitch::before{ color:var(--accent); transform:translate(2px,-2px); mix-blend-mode: screen; animation: g1 2.4s infinite linear; }
  .glitch::after{ color:var(--accent2); transform:translate(-2px,2px); mix-blend-mode: screen; animation: g2 3s infinite linear; }
  @keyframes g1 { 0%{clip-path: inset(0 0 90% 0)} 40%{clip-path: inset(10% 0 60% 0)} 70%{clip-path: inset(40% 0 10% 0)} 100%{clip-path: inset(0 0 90% 0)} }
  @keyframes g2 { 0%{clip-path: inset(90% 0 0 0)} 30%{clip-path: inset(60% 0 10% 0)} 60%{clip-path: inset(10% 0 40% 0)} 100%{clip-path: inset(90% 0 0 0)} }

</style>
</head>
<body>
  <div class="particles" aria-hidden="true"></div>
  <div class="scanlines" aria-hidden="true"></div>

  <div class="panel" role="status" aria-live="polite">
    <div class="info">
      <div class="title"><span class="dot" aria-hidden="true"></span><span>SECURE PROCESS</span></div>
      <h1 class="glitch" data-text="Processing anti-cheat...">Processing anti-cheat...</h1>
      <div class="status">Deep verification of game integrity, session tokens, and behavior analytics is currently running. This can take a long time depending on system checks.</div>

      <div class="loader-wrap" aria-hidden="false">
        <div class="progress-bar" aria-hidden="false" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
          <div class="progress-fill" id="progressFill"></div>
          <div class="progress-glow" aria-hidden="true"></div>
        </div>
        <div class="progress-meta">
          <div><strong id="percent">0%</strong> complete</div>
          <div class="eta"><span id="eta">ETA: calculating...</span></div>
        </div>
      </div>

      <p style="margin-top:14px;color:rgba(233,238,248,0.68);font-size:13px;">
        Tip: Keep this window open. Do not refresh or close while verification is in progress.
      </p>
    </div>

    <div class="character" aria-hidden="true">
      <div class="avatar" title="Anime assistant">
        <!-- Stylized anime girl SVG (replace or customize as you like) -->
        <div class="anime" aria-hidden="true">
          <svg viewBox="0 0 240 320" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="cute anime girl illustration">
            <!-- hair shadow -->
            <defs>
              <linearGradient id="hair" x1="0" x2="1">
                <stop offset="0" stop-color="#7c5cff" />
                <stop offset="1" stop-color="#1f2b6b" />
              </linearGradient>
              <radialGradient id="glow" cx="30%" cy="20%">
                <stop offset="0" stop-color="#fff" stop-opacity="0.7"/>
                <stop offset="1" stop-color="#fff" stop-opacity="0"/>
              </radialGradient>
            </defs>

            <!-- background aura -->
            <circle cx="120" cy="100" r="70" fill="url(#glow)" opacity="0.12"/>

            <!-- hair -->
            <path d="M40,80 C20,40 40,20 80,36 C100,44 120,36 150,20 C170,12 200,30 190,72 C188,86 186,120 160,140 C120,170 100,170 70,150 C46,136 42,108 40,80 Z" fill="url(#hair)"/>

            <!-- face -->
            <ellipse cx="120" cy="140" rx="54" ry="62" fill="#ffe6f0"/>
            <ellipse cx="102" cy="134" rx="6" ry="8" fill="#27223e" opacity="0.9"/>
            <ellipse cx="138" cy="134" rx="6" ry="8" fill="#27223e" opacity="0.9"/>
            <circle cx="102" cy="132" r="2" fill="#fff" />
            <circle cx="138" cy="132" r="2" fill="#fff" />

            <!-- mouth -->
            <path d="M110 158 Q120 168 130 158" stroke="#b2536f" stroke-width="2" fill="none" stroke-linecap="round"/>

            <!-- blush -->
            <ellipse cx="92" cy="152" rx="7" ry="4" fill="#ffd6e8" opacity="0.9"/>
            <ellipse cx="148" cy="152" rx="7" ry="4" fill="#ffd6e8" opacity="0.9"/>

            <!-- outfit -->
            <path d="M72,194 C92,184 148,184 168,196 L168,230 C130,248 110,248 72,230 Z" fill="#13203a" opacity="0.95"/>

            <!-- little sparkles -->
            <g fill="#fff" opacity="0.9">
              <circle cx="40" cy="40" r="1.4" opacity="0.9"/>
              <circle cx="190" cy="30" r="1.8" opacity="0.85"/>
              <circle cx="200" cy="100" r="1.6" opacity="0.75"/>
            </g>
          </svg>
        </div>
      </div>
    </div>
  </div>

  <div class="reminder" role="note" aria-live="polite">
    <span class="warn" aria-hidden="true"></span>
    <span style="font-weight:600">Reminder:</span>&nbsp;<span>Make sure to use your main account while verification completes.</span>
  </div>

<script>
/*
  This script simulates a very long loading process (almost 2 hours).
  durationMs controls the total simulated loading time in milliseconds.
  Adjust durationMs if you want faster/slower behavior.
*/
(function(){
  // Duration: ~1 hour 55 minutes (6900 seconds) = 6,900,000 ms — almost two hours as requested.
  const durationMs = 6900 * 1000;

  const start = Date.now();
  const progressFill = document.getElementById('progressFill');
  const percentEl = document.getElementById('percent');
  const etaEl = document.getElementById('eta');

  function formatTimeRemaining(ms){
    if(ms <= 0) return "ETA: 0s";
    const totalSeconds = Math.ceil(ms/1000);
    const hours = Math.floor(totalSeconds / 3600);
    const mins = Math.floor((totalSeconds % 3600) / 60);
    const secs = totalSeconds % 60;
    if(hours > 0) return `ETA: ${hours}h ${mins}m ${secs}s`;
    if(mins > 0) return `ETA: ${mins}m ${secs}s`;
    return `ETA: ${secs}s`;
  }

  function step(){
    const now = Date.now();
    const elapsed = now - start;
    const raw = Math.min(1, elapsed / durationMs);
    const percent = (raw * 100);
    progressFill.style.width = percent.toFixed(3) + '%';
    percentEl.textContent = percent < 100 ? percent.toFixed(2) + '%' : '100%';
    const remaining = Math.max(0, durationMs - elapsed);
    etaEl.textContent = formatTimeRemaining(remaining);

    // micro animations: subtle width pulse on the fill to feel alive
    progressFill.style.transform = `scaleX(1)`;

    if(elapsed < durationMs){
      requestAnimationFrame(step);
    } else {
      // finished
      progressFill.style.width = '100%';
      percentEl.textContent = 'Complete';
      etaEl.textContent = 'Verification complete';
      // small finish glow
      progressFill.style.boxShadow = '0 10px 40px rgba(0,230,255,0.16), 0 6px 18px rgba(124,92,255,0.12)';
      // optional final message (can be customized)
      document.querySelector('.status').textContent = 'Verification finished. You may now continue.';
    }
  }

  // create a scattering of particles for background (visual only)
  const particleContainer = document.querySelector('.particles');
  const pCount = 24;
  for(let i=0;i<pCount;i++){
    const el = document.createElement('div');
    el.className = 'particle';
    el.style.left = Math.random() * 100 + '%';
    el.style.top = Math.random() * 100 + '%';
    const s = 2 + Math.random()*10;
    el.style.width = s + 'px';
    el.style.height = s + 'px';
    el.style.opacity = (0.06 + Math.random()*0.18).toFixed(2);
    el.style.animationDuration = (14 + Math.random()*20) + 's';
    el.style.animationDelay = (Math.random()*-20) + 's';
    particleContainer.appendChild(el);
  }

  // start animation loop
  requestAnimationFrame(step);
})();
</script>
</body>
</html>
