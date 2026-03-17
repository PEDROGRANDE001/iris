#!/bin/bash
cd "$(dirname "$0")"
PHOTOS="../brochure_photos"

# Build HTML with embedded base64 images
python3 << 'PYEOF'
import base64, os

photos_dir = "../brochure_photos"

def img_b64(filename):
    path = os.path.join(photos_dir, filename)
    with open(path, "rb") as f:
        data = base64.b64encode(f.read()).decode()
    ext = filename.rsplit(".", 1)[-1].lower()
    mime = "image/png" if ext == "png" else "image/jpeg"
    return f"data:{mime};base64,{data}"

hero = img_b64("marbella_overview.jpg")
workshop1 = img_b64("chair_workshop.jpeg")
workshop2 = img_b64("stools_finishing.jpeg")
factory = img_b64("stools_factory.jpg")
loungers = img_b64("beach_loungers.jpg")
dining = img_b64("dining_table.jpg")
poolside = img_b64("marbella_poolside.jpg")
restaurant = img_b64("marbella_restaurant.jpg")
tropez = img_b64("st_tropez_dining.jpg")
miami = img_b64("miami_daybeds.jpg")
daybeds = img_b64("beach_daybeds.jpg")

html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Higney International — Custom Manufacturing</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300;1,400&family=Inter:wght@300;400;500&display=swap');

  * {{ margin: 0; padding: 0; box-sizing: border-box; }}

  body {{
    font-family: 'Inter', sans-serif;
    font-weight: 300;
    color: #2a2a2a;
    background: #fff;
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
  }}

  .page {{
    width: 8.5in;
    min-height: 11in;
    margin: 0 auto;
    position: relative;
    overflow: hidden;
    page-break-after: always;
  }}

  /* PAGE 1 - COVER */
  .cover {{
    height: 11in;
    background: linear-gradient(180deg, rgba(0,0,0,0) 0%, rgba(0,0,0,0.6) 100%),
                url('{hero}') center/cover no-repeat;
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    padding: 0.8in;
    color: white;
  }}
  .cover h1 {{
    font-family: 'Cormorant Garamond', serif;
    font-weight: 300;
    font-size: 48pt;
    line-height: 1.1;
    letter-spacing: 2px;
    margin-bottom: 12px;
  }}
  .cover .subtitle {{
    font-family: 'Inter', sans-serif;
    font-weight: 300;
    font-size: 11pt;
    letter-spacing: 4px;
    text-transform: uppercase;
    opacity: 0.9;
    margin-bottom: 30px;
  }}
  .cover .tagline {{
    font-family: 'Cormorant Garamond', serif;
    font-style: italic;
    font-weight: 300;
    font-size: 14pt;
    opacity: 0.85;
  }}

  /* PAGE 2 - INTRO */
  .intro-page {{
    padding: 0.8in;
    height: 11in;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }}
  .intro-page .section-label {{
    font-family: 'Inter', sans-serif;
    font-weight: 500;
    font-size: 8pt;
    letter-spacing: 4px;
    text-transform: uppercase;
    color: #999;
    margin-bottom: 24px;
  }}
  .intro-page h2 {{
    font-family: 'Cormorant Garamond', serif;
    font-weight: 300;
    font-size: 32pt;
    line-height: 1.2;
    margin-bottom: 30px;
    color: #1a1a1a;
  }}
  .intro-page p {{
    font-size: 10.5pt;
    line-height: 1.8;
    color: #444;
    max-width: 5.5in;
    margin-bottom: 16px;
  }}
  .intro-page .stat-row {{
    display: flex;
    gap: 48px;
    margin-top: 40px;
    padding-top: 30px;
    border-top: 1px solid #e0e0e0;
  }}
  .stat {{
    text-align: left;
  }}
  .stat .number {{
    font-family: 'Cormorant Garamond', serif;
    font-weight: 600;
    font-size: 36pt;
    color: #1a1a1a;
    line-height: 1;
  }}
  .stat .label {{
    font-size: 8pt;
    letter-spacing: 2px;
    text-transform: uppercase;
    color: #999;
    margin-top: 6px;
  }}

  /* PAGE 3 - MANUFACTURING */
  .manufacturing-page {{
    height: 11in;
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-template-rows: 1fr 1fr;
    gap: 3px;
  }}
  .manufacturing-page .photo {{
    background-size: cover;
    background-position: center;
    position: relative;
  }}
  .manufacturing-page .photo-overlay {{
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    padding: 20px 24px;
    background: linear-gradient(transparent, rgba(0,0,0,0.7));
    color: white;
  }}
  .manufacturing-page .photo-overlay .caption {{
    font-size: 8pt;
    letter-spacing: 2px;
    text-transform: uppercase;
    opacity: 0.9;
  }}

  /* PAGE 4 - CAPABILITIES */
  .capabilities-page {{
    height: 11in;
    padding: 0.8in;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }}
  .capabilities-page h2 {{
    font-family: 'Cormorant Garamond', serif;
    font-weight: 300;
    font-size: 28pt;
    margin-bottom: 40px;
    color: #1a1a1a;
  }}
  .cap-grid {{
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 32px 48px;
  }}
  .cap-item h3 {{
    font-family: 'Inter', sans-serif;
    font-weight: 500;
    font-size: 10pt;
    margin-bottom: 8px;
    color: #1a1a1a;
  }}
  .cap-item p {{
    font-size: 9.5pt;
    line-height: 1.7;
    color: #555;
  }}
  .cap-item .divider {{
    width: 30px;
    height: 1px;
    background: #ccc;
    margin-bottom: 14px;
  }}

  /* PAGE 5 - PORTFOLIO */
  .portfolio-page {{
    height: 11in;
  }}
  .portfolio-page .top-image {{
    height: 55%;
    background-size: cover;
    background-position: center;
    position: relative;
  }}
  .portfolio-page .bottom {{
    height: 45%;
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 3px;
  }}
  .portfolio-page .bottom .photo {{
    background-size: cover;
    background-position: center;
    position: relative;
  }}
  .portfolio-page .photo-label {{
    position: absolute;
    bottom: 16px;
    left: 20px;
    color: white;
    font-size: 8pt;
    letter-spacing: 2px;
    text-transform: uppercase;
    text-shadow: 0 1px 3px rgba(0,0,0,0.5);
  }}

  /* PAGE 6 - CONTACT */
  .contact-page {{
    height: 11in;
    background: #1a1a1a;
    color: white;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    padding: 0.8in;
  }}
  .contact-page h2 {{
    font-family: 'Cormorant Garamond', serif;
    font-weight: 300;
    font-size: 36pt;
    margin-bottom: 12px;
    letter-spacing: 1px;
  }}
  .contact-page .line {{
    width: 40px;
    height: 1px;
    background: #666;
    margin: 24px auto;
  }}
  .contact-page .subtitle2 {{
    font-family: 'Cormorant Garamond', serif;
    font-style: italic;
    font-weight: 300;
    font-size: 14pt;
    color: #aaa;
    margin-bottom: 40px;
  }}
  .contact-page .info {{
    font-size: 9.5pt;
    line-height: 2.2;
    color: #ccc;
    letter-spacing: 1px;
  }}
  .contact-page .info strong {{
    color: white;
    font-weight: 400;
  }}
  .contact-page .closing {{
    margin-top: 50px;
    font-family: 'Cormorant Garamond', serif;
    font-style: italic;
    font-size: 12pt;
    color: #777;
  }}

  @media print {{
    .page {{ page-break-after: always; margin: 0; }}
    body {{ margin: 0; }}
  }}
</style>
</head>
<body>

<!-- PAGE 1: COVER -->
<div class="page cover">
  <h1>Custom<br>Manufacturing</h1>
  <div class="subtitle">Higney International</div>
  <div class="tagline">Designed by operators. Built by artisans.</div>
</div>

<!-- PAGE 2: INTRO / WHO WE ARE -->
<div class="page intro-page">
  <div class="section-label">Who We Are</div>
  <h2>We don't just design<br>hospitality spaces.<br>We've run them.</h2>
  <p>
    Higney International brings 25 years of hands-on venue operations to every piece we create.
    Our custom manufacturing division works directly with master craftsmen in Vietnam and Indonesia
    to produce furniture, fixtures, and equipment that doesn't just look beautiful — it survives
    the realities of commercial hospitality.
  </p>
  <p>
    Every design decision is informed by decades of operating beach clubs, restaurants, and luxury
    hotels across four continents. We know what breaks, what fades, what guests actually use —
    and we build accordingly.
  </p>
  <div class="stat-row">
    <div class="stat">
      <div class="number">25+</div>
      <div class="label">Years in Hospitality</div>
    </div>
    <div class="stat">
      <div class="number">12</div>
      <div class="label">Venues Operated</div>
    </div>
    <div class="stat">
      <div class="number">4</div>
      <div class="label">Continents</div>
    </div>
    <div class="stat">
      <div class="number">3</div>
      <div class="label">Manufacturing Partners</div>
    </div>
  </div>
</div>

<!-- PAGE 3: MANUFACTURING / CRAFT -->
<div class="page manufacturing-page">
  <div class="photo" style="background-image: url('{workshop1}');">
    <div class="photo-overlay">
      <div class="caption">Hand-built frames — Indonesia</div>
    </div>
  </div>
  <div class="photo" style="background-image: url('{workshop2}');">
    <div class="photo-overlay">
      <div class="caption">Finishing & staining — artisan workshop</div>
    </div>
  </div>
  <div class="photo" style="background-image: url('{factory}');">
    <div class="photo-overlay">
      <div class="caption">Production line — quality at scale</div>
    </div>
  </div>
  <div class="photo" style="background-image: url('{restaurant}');">
    <div class="photo-overlay">
      <div class="caption">Installed — Nikki Beach Marbella</div>
    </div>
  </div>
</div>

<!-- PAGE 4: CAPABILITIES -->
<div class="page capabilities-page">
  <h2>Capabilities</h2>
  <div class="cap-grid">
    <div class="cap-item">
      <div class="divider"></div>
      <h3>Seating & Lounging</h3>
      <p>Dining chairs, barstools, lounge chairs, daybeds, and custom banquettes.
         Hardwood frames, marine-grade upholstery, UV-resistant finishes built
         for outdoor commercial use.</p>
    </div>
    <div class="cap-item">
      <div class="divider"></div>
      <h3>Tables & Surfaces</h3>
      <p>Dining tables, cocktail tables, side tables, and bar tops. Solid hardwood,
         stone, composite, and marine-grade materials. Custom dimensions for any layout.</p>
    </div>
    <div class="cap-item">
      <div class="divider"></div>
      <h3>Cabanas & Structures</h3>
      <p>Daybed cabanas, pergola furnishings, and poolside structures designed to
         withstand coastal weather while maintaining luxury aesthetics.</p>
    </div>
    <div class="cap-item">
      <div class="divider"></div>
      <h3>Bars & Millwork</h3>
      <p>Custom bar facades, reception desks, host stands, and built-in millwork.
         Full shop drawings provided. Designed for efficient service flow.</p>
    </div>
    <div class="cap-item">
      <div class="divider"></div>
      <h3>COM & Custom Finishes</h3>
      <p>Customer's Own Material program. We work with your specified fabrics,
         leathers, and finishes — or source from our curated library of
         commercial-grade textiles.</p>
    </div>
    <div class="cap-item">
      <div class="divider"></div>
      <h3>End-to-End Delivery</h3>
      <p>From concept sketches to containerized shipping. We manage manufacturing
         QC, export documentation, ocean freight, and last-mile delivery
         to your project site.</p>
    </div>
  </div>
</div>

<!-- PAGE 5: PORTFOLIO -->
<div class="page portfolio-page">
  <div class="top-image" style="background-image: url('{poolside}');">
    <div class="photo-label">Nikki Beach Marbella — Poolside Lounge</div>
  </div>
  <div class="bottom">
    <div class="photo" style="background-image: url('{tropez}');">
      <div class="photo-label">Nikki Beach Saint-Tropez</div>
    </div>
    <div class="photo" style="background-image: url('{miami}');">
      <div class="photo-label">Nikki Beach Miami</div>
    </div>
  </div>
</div>

<!-- PAGE 6: CONTACT -->
<div class="page contact-page">
  <h2>Higney International</h2>
  <div class="line"></div>
  <div class="subtitle2">Custom Manufacturing Division</div>
  <div class="info">
    <strong>Peter Higney</strong> — CEO & Creative Director<br>
    peter@higneyintl.com &nbsp;|&nbsp; 954-444-8754<br><br>
    1720 Harrison St, Suite 16A<br>
    Hollywood, Florida 33020<br><br>
    www.higney-international.com
  </div>
  <div class="closing">"The gap between design intent and operational reality — that's where we live."</div>
</div>

</body>
</html>"""

with open("brochure.html", "w") as f:
    f.write(html)
print("HTML written")
PYEOF
