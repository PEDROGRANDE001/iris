# Bob's Your Uncle — Online Vehicle Auction Platform
## Business Research Report

**Prepared for:** Peter Higney, CEO, Higney International  
**Date:** March 25, 2026  
**Status:** Research Complete

---

## Executive Summary

The online enthusiast vehicle auction space is a $1.7B+ annual market dominated by Bring a Trailer (BaT), with Cars & Bids as a growing #2. Both platforms have real, exploitable weaknesses — particularly BaT's aggressive no-reserve policy that alienates sellers, and the industry-wide failure to deeply integrate vehicle history data into the auction experience. A Florida-first, reserve-friendly, VIN-data-rich auction platform could carve out a niche — but the domain bobsyouruncle.com is taken, the competitive moat of BaT's community is formidable, and this is fundamentally a marketplace cold-start problem.

**Bottom line:** The idea has genuine merit in its differentiators. The execution risk is high but not insurmountable. The VIN integration angle is the stronger of the two differentiators. The reserve-friendly angle is the better marketing hook.

---

## 1. Bring a Trailer Deep Dive

### The Numbers (2025)
- **$1.7 billion** in total sales — 4th consecutive year over $1B
- **49,486 total auctions** (cars, trucks, motorcycles, memorabilia)
- **81% sell-through rate**
- **951 auctions per week** average, peaked at 1,200+
- **1.65 million registered users** (11% YoY growth)
- **48 cars** sold for $1M+ in 2025
- **Average sale price:** ~$58,000
- Owned by **Hearst Autos** (publisher of Road & Track, Car and Driver)

### Fee Structure
| Fee | Amount |
|-----|--------|
| Seller listing fee | $99 (basic), $250 (pro photos), variable (White Glove) |
| Buyer premium | 5% of final sale price |
| Buyer minimum fee | $250 |
| Buyer maximum fee | $7,500 (raised from $5,000 in 2024) |

### Revenue Estimate
At $1.7B in sales with an 81% sell-through rate and a 5% buyer premium (capped at $7,500), plus ~$99 per listing from sellers, BaT is likely generating **$80-100M+ in annual revenue**. Hearst isn't disclosing, but the math works.

### The No-Reserve Policy — The Achilles' Heel

**This is the single biggest vulnerability in the market.** BaT doesn't technically require no-reserve, but they push it *hard*:

- BaT's curation team sets acceptable reserve prices. If your reserve is "too high," they reject your listing or refuse to list it at all.
- For vehicles under ~$20K, they often refuse reserves entirely.
- Sellers who insist on a reasonable reserve get told "we'd simply be too far apart on reserve expectations."
- BaT's stated logic: no-reserve drives engagement, ensures cars sell, and generates higher final bids.

**Seller complaints are loud and consistent:**
- "I wanted a $17K reserve. BaT said no. Car sold for $15K. I lost $14K total (paid $17K, put $12K in)."
- "They rejected listing my Porsche 911 because I wanted an $80K reserve. They suggested $66K. The car is worth $90K."
- "BaT pressed me HARD for no reserve, and it was quite a battle to get a reserve at all."
- Multiple reports of sellers backing out after low bids, getting banned, but suffering no real financial penalty.
- BBB reviews are scathing — sellers feel trapped, buyers feel unprotected when sellers bail.

**The asymmetry is real:** Buyers who back out lose their 5% premium and get banned. Sellers who back out lose a $99 listing fee and get banned. That's a lopsided system.

**Why BaT does this:** No-reserve creates urgency. It drives more bidding. It guarantees BaT gets paid. It's great for BaT's revenue and bad for risk-averse sellers.

### Other BaT Weaknesses
- **No seller reputation system** — buyers can't see past seller reviews
- **Shill bidding reported** — same IP addresses bidding on their own cars, BaT confirmed it but didn't act
- **Title/ownership verification is weak** — dealers listing as "private party," consignment cars with murky title chains
- **Shipping service is terrible** — repeatedly cited in BBB complaints
- **Comment section can torpedo listings** — sellers get attacked with no recourse
- **Vehicle condition misrepresentation** — no structured inspection or verification beyond photos

---

## 2. Competitor Landscape

### Cars & Bids (Doug DeMuro)
- Founded 2020, focused on 1981+ modern enthusiast cars
- **$400M+ total sales**, 30,000+ cars sold through 2025
- **$37M investment** from The Chernin Group (2023)
- **Average sale price:** ~$32,000 (lower than BaT)
- **Sell-through:** ~70%
- **Fees:** Free seller listing, 4.5% buyer premium ($225 min, $4,500 max)
- **Strength:** Doug's massive YouTube following (4M+ subs), faster listings, better customer service
- **Weakness:** Smaller audience = lower final prices on high-end cars, still pushes no-reserve

### Other Players
| Platform | Niche | Online? | Notes |
|----------|-------|---------|-------|
| RM Sotheby's | Ultra-high-end ($500K+) | Yes + live | 10-12% seller + 12% buyer fees. Massive. |
| Gooding & Co | Ultra-high-end | Yes + live | Now partnered with Christie's |
| Barrett-Jackson | Spectacle/entertainment auctions | Primarily live | ~$300M/year, very brand-driven |
| Mecum | Volume classics, muscle cars | Live + online | Physical auction houses, huge events |
| Hemmings | Classifieds + auctions | Yes | Smaller, more pleasant seller experience per reports |
| Collecting Cars | UK-based, expanding to US | Yes | Newer entrant, growing |
| Hagerty | Valuation/insurance, marketplace | Yes | Insurance-first, auctions secondary |
| AutoTrader/eBay Motors | General marketplace | Yes | Not curated, not auction-focused for enthusiasts |

### Market Saturation Analysis

**Is there room for another player?** Yes, but barely — and only with clear differentiation.

The market is consolidating around BaT at the top. Cars & Bids carved space by targeting a younger demographic and modern cars. The remaining gap is:

1. **Sellers who want price protection** (reserves) — this is an underserved emotional need
2. **Buyers who want deep vehicle transparency** — VIN data, structured inspections, seller verification
3. **Regional markets** — Florida has a massive car culture and no dominant online-only auction platform
4. **Mid-market cars ($15K-$75K)** — too "normal" for BaT's curation, too nice for Copart, too specific for Facebook Marketplace

---

## 3. VIN History as Differentiator

### Current VIN Data Landscape

| Provider | Data Sources | Strengths | Weaknesses | Consumer Price |
|----------|-------------|-----------|------------|---------------|
| **Carfax** | Proprietary dealer/service/insurance networks | Best service history, most recognized brand | No NMVTIS data, expensive, dealer-focused | $45/report |
| **AutoCheck** (Experian) | Auction data, insurance, Experian credit data | Best auction history tracking, proprietary score | Limited service records | $30/report |
| **NMVTIS** (Gov) | All state DMVs, insurance, salvage yards, junkyards | Only legally mandated database, title/brand history | Bare-bones data, no service records | $2-10/report via providers |
| **VinAudit** | NMVTIS-backed + aggregated sources | Cheapest API ($1/report at volume), NMVTIS-approved | Less brand recognition, limited service data | $5-10/report |

### What's NOT Being Done Well

This is where Bob's Your Uncle could genuinely differentiate:

1. **Nobody integrates VIN data INTO the auction listing itself.** BaT and C&B provide a free Carfax link. That's it. The data just sits in a PDF. Nobody surfaces it in a structured, visual, trust-building way within the listing.

2. **Service history is fragmented.** Carfax has the best data, but it's locked behind their ecosystem. Independent shops often don't report. Dealers report inconsistently.

3. **Ownership timeline visualization doesn't exist.** Imagine a clean timeline showing: manufactured → dealer → owner 1 (3 years, 30K miles, 8 service records) → owner 2 (5 years, 45K miles, 1 accident) → current seller.

4. **No cross-referencing of claims.** Sellers say "no accidents" but VIN data shows otherwise. Nobody automatically flags this discrepancy.

5. **No predictive maintenance alerts.** Based on VIN data + make/model, you could flag "this BMW N54 engine is at 85K miles — known timing chain guide issue typically occurs at 80-100K."

### The Opportunity

**Build VIN data into the listing DNA, not as an afterthought.** Every listing should automatically show:
- Ownership count and duration with state history
- Accident timeline with severity
- Service record summary (where available)
- Title brand history (clean, salvage, rebuilt, flood, lemon)
- Odometer verification against historical readings
- Open recalls (NHTSA is free)
- Market value context (what similar VINs have sold for)
- **Trust Score** — an aggregated score based on VIN data completeness, title cleanliness, seller verification

This isn't just "we include a Carfax." This is making vehicle transparency the *product*.

### API Access & Costs

| Provider | API Available? | Cost | Notes |
|----------|---------------|------|-------|
| **VinAudit** | Yes | ~$1/report (dealer), $0.25-$1 at NMVTIS volume | Best value. NMVTIS-approved. Free demo. Starts $100/mo for API. |
| **Carfax** | Dealer only | $800-$2,000/mo subscription | No consumer/startup API. Must be established dealer. |
| **AutoCheck** (Experian) | Dealer only | Similar to Carfax | Enterprise sales process |
| **NMVTIS Direct** | Yes (become approved provider) | $30,000 setup fee + per-query | You get raw NMVTIS data, can build your own reports. Serious commitment. |
| **NHTSA Recalls** | Yes | Free | Open API, no cost |
| **VIN Decoding** (NHTSA) | Yes | Free | Specs, build data |
| **ClearVin/EpicVin** | Yes | $3-5/report | Reseller APIs available |

**Recommended approach:** Start with VinAudit API ($100/mo + $1/report) for NMVTIS data, NHTSA free APIs for recalls and VIN decoding, and negotiate a Carfax dealer partnership once you have volume. Budget ~$3-5 per listing for VIN data costs initially.

---

## 4. Florida Auction Licensing

### What You Need

To sell vehicles at auction to the general public in Florida, you need **both**:
1. **Vehicle Auction Dealer License (VA)** — sell at auction to other licensed dealers
2. **Vehicle Independent Dealer License (VI)** — sell to the general public at retail

The VA alone only lets you sell to other dealers. For a consumer-facing auction platform, you need the VI.

### Requirements & Process

| Step | Detail | Cost | Time |
|------|--------|------|------|
| Pre-licensing course | 16 hours, online or in-person, FLHSMV-approved school | $100-$300 | 2 days |
| FEIN + Sales Tax Number | IRS + FL Dept of Revenue | Free | 1-2 weeks |
| Business location | Must be permanent, non-residential, separate from other businesses | Variable (lease) | Ongoing |
| Fingerprinting | LiveScan via FDLE-approved provider | $54.25/person | Same day |
| Surety bond | $25,000 auto dealer bond | $250-$1,250/year (1-5% of bond amount w/ good credit) | 1-2 days |
| Liability insurance | Garage liability OR general liability + business auto. Min $25K combined single-limit + $10K PIP | $1,500-$5,000/year | 1 week |
| Application | Form HSMV 86056, submitted to regional office | $300 | ~30 days to process |
| Compliance inspection | Regional office examiner visits your business location | Included | Scheduled after application |

**Total startup licensing cost: ~$2,000-$7,000**  
**Timeline: 2-3 months**  
**Annual renewal: $75 + 8 hours continuing education**

### The "Online-Only" Question

Here's the tricky part: **Florida requires a permanent business location that is not a residence.** This is designed for physical dealerships. For a purely online auction platform, you'd still need to maintain a compliant physical office — a small commercial space in Hollywood/Fort Lauderdale would work. You're not storing inventory, so you just need a proper office for records and inspections.

### Multi-State Expansion

This is where it gets complicated and expensive. Every state has its own dealer licensing:

| Expansion Difficulty | States | Notes |
|---------------------|--------|-------|
| **Easy** (minimal requirements) | Arizona, Arkansas, Idaho, Iowa, Louisiana, Minnesota, Mississippi, Montana, Nebraska, Oklahoma, Oregon, Pennsylvania, Vermont, Wyoming | Low bonds, simple process |
| **Moderate** | Texas ($50K bond), Georgia ($35K bond), North Carolina, Colorado | Higher bonds, more paperwork |
| **Hard** | California (strict DMV), New York (complex), Connecticut ($50K bond + high fees), Ohio ($75K net worth req) | Significant regulatory burden |

**Key insight for an online platform:** You may not need to be licensed in every state to operate. BaT is based in San Francisco and operates nationally. The question is whether the platform is "conducting business" in each state or simply facilitating a transaction between private parties. This is a legal gray area that needs attorney review.

**Recommendation:** Start with Florida. Get legal counsel on whether your platform model (facilitating auctions between private parties) requires multi-state licensing, or if you can operate similarly to BaT with a single state license.

---

## 5. Revenue Model Options

### Fee Comparison

| Revenue Stream | BaT | Cars & Bids | Bob's Your Uncle (Proposed) |
|---------------|-----|------------|---------------------------|
| Seller listing fee | $99 | Free | $49 (no-reserve) / $99 (with reserve) |
| Buyer premium | 5% ($250 min, $7,500 max) | 4.5% ($225 min, $4,500 max) | 4% ($200 min, $5,000 max) |
| VIN report upsell | N/A (free Carfax link) | N/A (free Carfax link) | Free basic w/ listing; Premium Deep VIN Report $29 for buyers |
| Featured listing | Not explicit | Not explicit | $149-$499 (homepage feature, social promotion) |
| Professional photos | $250 (BaT) / $149-$249 (C&B) | $149-$249 | $149 (partner with local photographers) |
| Shipping | Variable (via partner) | Variable | Commission from shipping partner |
| Escrow service | Not offered | Not offered | 1% escrow fee (optional but recommended) |

### Revenue Projections — Florida-Focused Launch

**Conservative (Year 1):**
| Metric | Assumption | Revenue |
|--------|-----------|---------|
| Listings/month | 50 (building to 100) | — |
| Average sale price | $35,000 | — |
| Sell-through rate | 65% | — |
| Cars sold/month (avg) | ~50 | — |
| Buyer premium (4% avg, ~$1,400) | 50 × $1,400 | $70,000/mo |
| Seller listing fees | 75 × $75 avg | $5,625/mo |
| VIN report upsells | 30 × $29 | $870/mo |
| Featured listings | 10 × $249 | $2,490/mo |
| **Monthly revenue** | | **~$79,000** |
| **Annual revenue** | | **~$950,000** |

**Moderate (Year 2, expanding beyond FL):**
| Metric | Assumption | Revenue |
|--------|-----------|---------|
| Listings/month | 200-400 | — |
| Cars sold/month | 200 | — |
| **Monthly revenue** | | **~$350,000** |
| **Annual revenue** | | **~$4.2M** |

**Reality check:** These numbers assume you can attract 50+ quality listings per month in Florida within the first year. BaT started as a blog in 2007 and didn't launch auctions until 2014 after building a massive community. Cars & Bids leveraged Doug DeMuro's 3.7M YouTube subscribers. **The cold-start problem is the #1 risk.**

---

## 6. Tech Stack & Build Plan

### Core Platform Features (MVP)

1. **User Management** — Registration, verification (ID + credit card hold), profiles, bid history
2. **Listing Creation** — Photo upload (drag-and-drop, reorder), description editor, VIN auto-populate, reserve price setting
3. **VIN Integration** — Auto-pull vehicle specs, history data, recalls; display as structured visual timeline
4. **Real-Time Bidding** — WebSocket-based live bid updates, anti-sniping extension (bids in final 2 min extend by 2 min), proxy/auto-bidding
5. **Auction Management** — 7-day auctions, countdown timers, reserve met/not met indicators, comment system
6. **Payment Processing** — Credit card holds, buyer premium collection, optional escrow via Stripe Connect
7. **Seller Dashboard** — Listing analytics, bid tracking, post-auction buyer communication
8. **Admin Panel** — Listing curation/approval, user management, dispute resolution, analytics
9. **Search & Discovery** — Make/model/year filters, saved searches, email alerts, homepage featured carousel
10. **Notifications** — Email + push for outbid, auction ending, new comments, reserve met

### Recommended Tech Stack

| Layer | Technology | Why |
|-------|-----------|-----|
| **Frontend** | Next.js (React) + Tailwind CSS | SEO-critical (auction listings need to rank), fast, modern |
| **Mobile** | React Native or responsive web-first | Start web-only for MVP; mobile app in Year 2 |
| **Backend** | Node.js with NestJS | TypeScript end-to-end, great WebSocket support, modular |
| **Real-time** | WebSockets via Socket.IO + Redis Pub/Sub | Essential for live bidding |
| **Database** | PostgreSQL | Transactional integrity for bids and payments |
| **Search** | Elasticsearch or Algolia | Fast filtered search across listings |
| **File Storage** | AWS S3 + CloudFront CDN | High-res photos need fast delivery |
| **Payments** | Stripe Connect | Marketplace payments, escrow, split payouts |
| **VIN APIs** | VinAudit + NHTSA | Cost-effective vehicle data |
| **Auth** | Auth0 or Clerk | KYC-ready, secure, handles ID verification |
| **Hosting** | AWS (ECS/Fargate) or Vercel + AWS | Auto-scaling, reliable |
| **CI/CD** | GitHub Actions | Standard, works great with Vercel/AWS |
| **Monitoring** | Datadog or Sentry | Error tracking, performance monitoring |

### MVP Scope & Timeline

**With AI-assisted development (Cursor/Claude + experienced developer):**

| Phase | Scope | Timeline |
|-------|-------|----------|
| **Phase 1: Foundation** | Auth, user profiles, basic listing CRUD, admin panel | 3-4 weeks |
| **Phase 2: Auction Engine** | Real-time bidding, WebSockets, countdown/extension logic, reserve handling | 4-5 weeks |
| **Phase 3: VIN Integration** | API integrations, visual timeline, auto-populate, trust score | 2-3 weeks |
| **Phase 4: Payments** | Stripe Connect, buyer premium, seller payouts, credit card holds | 2-3 weeks |
| **Phase 5: Polish** | Search/filters, email notifications, SEO, responsive design, photo upload | 3-4 weeks |
| **Phase 6: Testing & Launch** | QA, load testing, security audit, soft launch | 2-3 weeks |
| **Total MVP** | | **16-22 weeks (~4-5 months)** |

### Cost Estimate

**Option A: Peter + AI (solo build with Cursor/Claude)**
| Item | Cost |
|------|------|
| Development tools (Cursor, hosting, APIs) | $500/mo |
| VIN data APIs | $200/mo |
| AWS/Vercel hosting | $200-500/mo |
| Stripe fees | 2.9% + $0.30 per transaction |
| Domain (see below) | $500-$10,000 |
| Legal (licensing, terms of service, privacy) | $3,000-$5,000 |
| Design (logo, brand, templates) | $2,000-$5,000 |
| **Total to MVP launch** | **~$15,000-$25,000** |

**Option B: Hire a small dev team (2-3 developers)**
| Item | Cost |
|------|------|
| Development (4-5 months × $15-25K/mo) | $60,000-$125,000 |
| Everything else from Option A | ~$10,000-$15,000 |
| **Total to MVP launch** | **~$70,000-$140,000** |

**Option C: Offshore dev shop**
| Item | Cost |
|------|------|
| Development (quoted range for auction platforms) | $25,000-$50,000 |
| Quality risk | HIGH — real-time bidding is hard to get right |

**My recommendation:** Option A if you or someone technical can lead the build. The AI-assisted development angle is real — a competent developer with Cursor/Claude can build this 3-4x faster than traditional development. Budget $25K and 5 months.

---

## 7. Domain Check

### bobsyouruncle.com — ❌ TAKEN

| Field | Detail |
|-------|--------|
| **Status** | Registered |
| **Created** | April 12, 1998 |
| **Expires** | April 11, 2034 |
| **Owner** | Robert Froese, Toronto, Ontario, Canada |
| **Email** | bob@byuagency.com |
| **Nameservers** | Vercel (ns1.vercel-dns.com) — site is actively hosted |
| **Transfer status** | clientTransferProhibited |

This domain has been registered for **28 years** and is locked until 2034. The owner runs "BYU Agency" — a branding/creative agency. He's literally a guy named Bob. The domain is likely sentimental/brand-relevant to him.

### Options

1. **Make an offer.** Given the owner is a creative agency guy named Bob, this could be a $5,000-$50,000 conversation. The domain isn't running a high-traffic business. Use DomainAgents or Afternic to broker.

2. **Alternative domains:**
   - `bobsyouruncle.co` — check availability
   - `bobsyouruncleauctions.com`
   - `byuauctions.com`
   - `unclebobsauction.com`
   - Something completely different that's more descriptive: `reserveauction.com`, `vinauction.com`, `deepvinauction.com`

3. **Honestly?** The name is fun and memorable but it doesn't tell anyone what you do. BaT works because "Bring a Trailer" is car-coded. "Bob's Your Uncle" needs explanation. Consider whether the name is worth the acquisition hassle vs. finding something that screams "car auction + transparency."

---

## 8. Market Opportunity Summary

### TAM / SAM / SOM

| Level | Scope | Size |
|-------|-------|------|
| **TAM** (Total Addressable Market) | US vehicle auction market | $3.47B (2024), growing to $4.48B by 2030 |
| **TAM** (Used car market, broader) | All US used car transactions | ~$1.05 trillion (2025) |
| **SAM** (Serviceable) | Online enthusiast vehicle auctions (BaT + C&B + similar) | ~$2.5-3B annually |
| **SAM** (Florida-specific) | Florida used car market (strong state, tax-friendly, year-round car culture) | ~$80-120B in used car transactions; auction segment ~$300-500M |
| **SOM** (Obtainable Year 1) | 50 cars/month × $35K avg × 12 months | ~$21M in GMV, ~$1M in revenue |

### Why This Could Work

1. **The reserve-friendly angle is a real, emotional, underserved need.** Thousands of sellers have been burned by BaT's no-reserve pressure. A platform that says "set your reserve, sell with confidence" is a genuinely differentiated marketing message.

2. **VIN data as product, not afterthought.** Nobody is doing this. Every auction site treats vehicle history as a checkbox. Making it the centerpiece builds trust and creates a defensible feature.

3. **Florida is a phenomenal launch market.** Year-round car culture, massive population, no state income tax (attracts wealth), collector car density, snowbird buyers, proximity to massive car events (Amelia Island, Miami, Palm Beach). And licensing is cheap.

4. **BaT has BBB problems and community trust erosion.** They're big enough that quality is slipping. Seller verification, shill bidding, buyer flaking — these are unsolved problems that a smaller, more careful platform could address.

5. **AI-assisted development makes the build feasible.** Five years ago, building a custom auction platform was a $500K+ endeavor. Today, a technical founder with AI tools can build an MVP for $25K in 5 months. The tech barrier is lower than ever.

6. **The enthusiast car market keeps growing.** Online overtaking physical. Younger buyers trust digital. The shift is permanent.

### Biggest Risks

1. **🔴 Cold Start / Chicken-and-Egg Problem** — This is the #1 killer. You need sellers to attract buyers and buyers to attract sellers. BaT had 7 years of community building before launching auctions. Cars & Bids had Doug's 3.7M YouTube audience. What's your unfair distribution advantage? **This needs a real answer before building anything.**

2. **🔴 BaT's network effects are massive.** 1.65M registered users. A known brand. Sellers go where the buyers are. You're not competing on features — you're competing on audience size and trust.

3. **🟡 Legal complexity.** Is your platform "conducting" auctions (requiring licensing in every state a car is located)? Or facilitating private party sales? This distinction matters enormously and needs legal clarity before launch.

4. **🟡 Fraud and disputes.** Auction platforms become arbiters of messy situations — seller misrepresentation, buyer flaking, title issues, shipping damage. This is operationally intensive and costly.

5. **🟡 Curation quality.** BaT's curators write the listing descriptions. This is labor-intensive but creates consistency. If you let sellers write everything, quality drops. If you curate, you need staff.

6. **🟢 VIN data costs are manageable.** At $1-5 per listing, VIN data is cheap. The cost isn't the risk — the integration quality and UX presentation are.

---

## 9. Strategic Recommendations

### If You Build This:

1. **Solve the cold-start problem FIRST.** Before writing a line of code:
   - Build a content presence (YouTube, Instagram, TikTok) around Florida car culture, VIN deep-dives, auction commentary
   - Partner with 5-10 Florida car dealerships and collectors who are frustrated with BaT
   - Run a "founding seller" program with zero fees for the first 100 auctions
   - Target the BMW/Porsche/JDM communities you already know

2. **Lead with VIN transparency as the brand.** Not "another auction site" — position as "the auction platform that tells you everything about the car before you bid." Trust is the brand.

3. **Embrace reserves as a feature, not a compromise.** Marketing: "Your car, your price. Set a reserve with confidence." This directly attacks BaT's biggest pain point.

4. **Start with Florida, but build for national from day one.** The tech should be state-agnostic. Florida is for licensing simplicity and initial community building.

5. **Consider a phased approach:**
   - **Phase 0 (now-3 months):** Content, community building, legal setup, domain acquisition
   - **Phase 1 (months 3-8):** Build MVP, soft launch with founding sellers
   - **Phase 2 (months 8-14):** Iterate based on feedback, grow Florida volume
   - **Phase 3 (months 14-24):** Expand to Southeast states, raise capital if needed

6. **Don't compete on fees.** Compete on trust, transparency, and seller experience. The fee difference between 4% and 5% doesn't move needles. The difference between "we respect your reserve" and "we'll force no-reserve" does.

### If You Don't Build This:

The VIN data integration concept could be a standalone SaaS product for *existing* auction platforms — a white-label "Deep VIN" widget that any marketplace could embed. Lower risk, faster revenue, no cold-start problem.

---

## Appendix: Quick Reference

### Key Contacts / Resources
- **FL DHSMV Dealer Licensing:** flhsmv.gov
- **VinAudit API:** vinaudit.com/vehicle-history-api-comparison
- **NHTSA VIN API:** vpic.nhtsa.dot.gov/api (free)
- **NMVTIS Provider Program:** aamva.org/vehicles/nmvtis
- **bobsyouruncle.com owner:** bob@byuagency.com (Robert Froese, Toronto)

### Competitive Fee Quick-Reference
| Platform | Seller Fee | Buyer Fee | Max Buyer Fee |
|----------|-----------|-----------|---------------|
| Bring a Trailer | $99 | 5% | $7,500 |
| Cars & Bids | Free | 4.5% | $4,500 |
| RM Sotheby's | ~10% | ~12% | None |
| Barrett-Jackson | Variable | ~10% | None |

### Florida Licensing Checklist
- [ ] 16-hour pre-licensing course ($100-300)
- [ ] FEIN from IRS
- [ ] FL Sales Tax Number
- [ ] Business location (commercial lease)
- [ ] LiveScan fingerprinting ($54.25)
- [ ] $25,000 surety bond ($250-1,250/yr)
- [ ] Liability insurance ($1,500-5,000/yr)
- [ ] Form HSMV 86056 + $300 application fee
- [ ] Compliance inspection
- [ ] Wait ~30 days for approval

---

*This report reflects research conducted March 25, 2026. Market data, fees, and regulations may change. Legal counsel recommended before proceeding with licensing or platform development.*
