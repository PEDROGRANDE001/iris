const https = require('https');

const TOKEN = 'eyJhbGciOiJIUzI1NiJ9.eyJ0aWQiOjYyMTgzMzYxMywiYWFpIjoxMSwidWlkIjo0MzMxMjA0NywiaWFkIjoiMjAyNi0wMi0xNlQxNTozODowMy4xMTZaIiwicGVyIjoibWU6d3JpdGUiLCJhY3RpZCI6MTY5MzE4NDcsInJnbiI6InVzZTEifQ.6sTFd82zVfwqBeD-C5W-x6s0TMpMBQMHiJy1qI1_E90';
const BOARD_ID = 18356765710;

function mondayAPI(query, variables = {}) {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify({ query, variables });
    const req = https.request({
      hostname: 'api.monday.com',
      path: '/v2',
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': TOKEN,
      }
    }, res => {
      let body = '';
      res.on('data', c => body += c);
      res.on('end', () => {
        try { resolve(JSON.parse(body)); } catch(e) { reject(e); }
      });
    });
    req.on('error', reject);
    req.write(data);
    req.end();
  });
}

// All targets organized by category
const targets = [
  // Section 1: Architects
  { name: "Nichols Architects", category: "Architect", contact: "Senior hospitality principals", location: "Coral Gables", notes: "Top-tier hotel architect in S. FL. Marriott Marquis Miami Worldcenter, Westin Diplomat, JW Marriott Tampa. Specifies FF&E for Marriott/Rosewood globally.", priority: true },
  { name: "Kobi Karp Architecture", category: "Architect", contact: "Kobi Karp", location: "Miami", notes: "Full architecture + interiors, influences FF&E directly. Active on conference circuit. PROFILE Summit March 4.", priority: true },
  { name: "Arquitectonica", category: "Architect", contact: "Hospitality studio leads", location: "Miami", notes: "One of Miami's most influential firms. Global hotel portfolio, active S. FL pipeline." },
  { name: "Choeff Levy Fischman", category: "Architect", contact: "Ralph Choeff", location: "Miami", notes: "Tropical modern luxury. Featured at PROFILE Design Summit 2026 (March 4, Wynwood)." },
  { name: "Nunzio Marc DeSantis Architects", category: "Architect", contact: "Nunzio DeSantis", location: "Fort Lauderdale", notes: "Omni Fort Lauderdale Hotel (801 rooms), Broward Convention Center expansion. Interior design by EoA Group." },
  { name: "Peacock + Lewis", category: "Architect", contact: "Kenneth Hart, Managing Director", location: "North Palm Beach & Naples", notes: "Club/resort renovation specialists since 1961. Steady FF&E needs for refreshes." },
  { name: "Touzet Studio", category: "Architect", contact: "Carlos Prio-Touzet & Jacqueline Touzet", location: "Miami", notes: "Designing Silver Sands Key Biscayne ($600M+ redevelopment, construction late 2026). FF&E not yet specified." },
  { name: "Stiles Architectural Group", category: "Architect", contact: "Via Stiles Corp leadership", location: "Fort Lauderdale", notes: "Part of Stiles development ecosystem. Gateway to their hotel pipeline." },
  
  // Section 2: General Contractors
  { name: "Moss Construction — The Dunes", category: "General Contractor", contact: "Moss Construction", location: "Fort Lauderdale Beach", notes: "The Dunes Fort Lauderdale (Autograph Collection) — 205 rooms, 16-story, $175M+. Broke ground Aug 2025. FF&E procurement window is NOW.", priority: true },
  { name: "Moss Construction — Nora Hotel", category: "General Contractor", contact: "Moss Construction", location: "West Palm Beach", notes: "Nora Hotel — 201-room luxury boutique, $200M. Opening Fall 2026. FF&E procurement likely underway or imminent.", priority: true },
  { name: "Suffolk Construction — Aman Miami Beach", category: "General Contractor", contact: "Suffolk Construction", location: "Miami Beach", notes: "Aman Residences Miami Beach — 22 residences + 56-room restored Versailles Hotel. Top-off early 2026, delivery 2027. Ultra-luxury FF&E." },
  { name: "Suffolk Construction — Edition Tampa", category: "General Contractor", contact: "Suffolk Construction", location: "Tampa", notes: "Edition Hotel & Residences — 172 rooms + 38 residences. Marriott Edition brand = high-end FF&E spec." },
  { name: "PCL Construction — Ritz-Carlton Key Biscayne", category: "General Contractor", contact: "PCL Construction", location: "Key Biscayne", notes: "Ritz-Carlton Key Biscayne — $44M repositioning. Phase 1 completing Jan 2026; Phase 2 follows.", priority: true },
  { name: "PCL Construction — Diplomat (Signia)", category: "General Contractor", contact: "PCL Construction", location: "Hollywood", notes: "Diplomat Beach Resort → Signia by Hilton — $18M+ renovation. Brand conversion = full FF&E refresh. Completing Jan 2026.", priority: true },
  { name: "KAST Construction — Westin Cocoa Beach", category: "General Contractor", contact: "KAST Construction", location: "Cocoa Beach", notes: "Westin Cocoa Beach Resort & Spa — 502 rooms, $420M. 45% complete, targeting Q3 2027. FF&E specification phase approaching." },

  // Section 3: Early-Stage Projects
  { name: "Grand Hyatt Miami Beach Convention Center", category: "Development Project", contact: "Convention Center authority / Hyatt", location: "Miami Beach", notes: "800 rooms + 90K SF meeting space + 5 F&B outlets. $92.5M agency debt secured. Construction ~2025-2027. Massive FF&E — likely going to RFP soon.", priority: true },
  { name: "Shore Club Resort (Auberge Collection)", category: "Development Project", contact: "Witkoff Group", location: "Miami Beach", notes: "Historic hotel restoration + 49-condo tower; beach club, spa, restaurant. Completion 2027." },
  { name: "Raleigh Rosewood Residences", category: "Development Project", contact: "SHVO", location: "Miami Beach", notes: "60-suite hotel + 40 residences. Rosewood brand = ultra-luxury FF&E. Completion 2026." },
  { name: "Waldorf Astoria Hotel & Residences", category: "Development Project", contact: "Related Group", location: "Downtown Miami", notes: "205 hotel rooms + 387 residences. Architect: Carlos Ott. Top-off late 2026, completion 2028." },
  { name: "Okan Tower — Hilton Miami Bayfront", category: "Development Project", contact: "Okan Group", location: "Downtown Miami", notes: "316 hotel keys + 236 condo-hotel units. Master permit Aug 2025, topping off 2026, opening 2027." },
  { name: "Silver Sands Key Biscayne", category: "Development Project", contact: "Terra + Fortune International", location: "Key Biscayne", notes: "$600M+ ultra-luxury condo with fine dining + resort amenities. Pre-construction, breaking ground late 2026. Early enough for FF&E influence." },

  // Section 4: Recently Acquired Hotels
  { name: "EAST Miami (Blackstone)", category: "Acquisition — Renovation", contact: "Blackstone asset management", location: "Brickell, Miami", notes: "Acquired Sept 2025 for $148M ($420K/key). 352 rooms + rooftop bar Sugar. Blackstone typically renovates post-acquisition.", priority: true },
  { name: "PGA National Resort", category: "Acquisition — Renovation", contact: "Henderson Park / Salamander / South Street Partners", location: "Palm Beach Gardens", notes: "Acquired 2025 for $171.4M ($475K/key). Already received $100M reno; new owners plan pool addition + golf enhancements." },
  { name: "Kimpton Angler's Hotel", category: "Acquisition — Renovation", contact: "Philippe Le Guennec", location: "Miami Beach", notes: "Acquired 2025 for $43.5M ($330K/key). 132-key boutique; new ownership likely to refresh." },
  { name: "Plunge Beach Resort", category: "Acquisition — Renovation", contact: "Mike Patel, T2 Hospitality", location: "Lauderdale-by-the-Sea", notes: "Acquired 2025 for $36.6M ($224K/key). 163 rooms; value-buy pricing suggests renovation planned.", priority: true },
  { name: "MOXY Miami Wynwood", category: "Acquisition — Renovation", contact: "Süzer Group", location: "Wynwood", notes: "Majority stake acquired 2025 for $99M ($825K/key). 120 keys; opened 2024 so less likely to renovate." },
  { name: "Hyatt House + Hyatt Place FLL Airport", category: "Acquisition — Renovation", contact: "Kolter Hospitality", location: "Dania Beach", notes: "292 rooms combined; acquired from Blackstone. Kolter is operator-owner — likely to upgrade." },
  { name: "Holiday Inn / Staybridge Suites Doral", category: "Acquisition — Renovation", contact: "CN Hotels", location: "Doral", notes: "216 rooms; new ownership typically triggers PIP (Property Improvement Plan)." },
  { name: "Doral Inn & Suites", category: "Acquisition — Renovation", contact: "Ratia Real Estate", location: "Doral", notes: "112 keys at $23M ($205K/key) = deep value renovation play." },

  // Section 5: Management Companies
  { name: "Aimbridge Hospitality", category: "Management Company", contact: "Aimbridge Hospitality", location: "South Florida", notes: "Added Voco Sandpiper All-Inclusive Resort. Phase 1 renovation completing early 2026. All-inclusive conversion = total FF&E overhaul." },
  { name: "Evolution Hospitality", category: "Management Company", contact: "Evolution Hospitality", location: "Miami Beach", notes: "Took over Balfour Miami Beach (82-room Art Deco, Ocean Drive). New management often triggers refresh." },
  { name: "MIA Hospitality Management", category: "Management Company", contact: "MIA Hospitality Management", location: "South Florida", notes: "Portfolio of 5 hotels / 939 rooms across S. FL. Growing local operator — relationship target." },
  { name: "Salamander Collection", category: "Management Company", contact: "Salamander Collection", location: "Palm Beach Gardens", notes: "Managing PGA National Resort post-acquisition. Luxury brand with high FF&E standards." },
  { name: "Driftwood Capital", category: "Management Company", contact: "Driftwood Capital", location: "Cocoa Beach / S. FL", notes: "Building Westin Cocoa Beach ($420M, 502 rooms). Vertically integrated = single point of contact for FF&E." },
  { name: "Rebel Hotel Company", category: "Management Company", contact: "Rebel Hotel Company", location: "Florida-wide", notes: "Expanding FL portfolio (Sheraton Orlando + seeking S. FL assets). Actively acquiring — each acquisition = FF&E opportunity." },
];

async function createItem(target) {
  const columnValues = {
    "text_mkxp6g3w": target.name,  // Company Name
    "text_mkxppqqa": target.location || "",  // Location
    "text_mkxpk034": target.contact ? target.contact.split(' ')[0] : "",  // First Name
    "text_mkxp6z19": target.contact ? target.contact.split(' ').slice(1).join(' ') : "",  // Last Name  
    "text_mkxp9nmd": target.notes || "",  // Summary
    "text_mkxpyjep": target.category || "",  // Headline (using for category)
  };
  
  // Add priority status
  if (target.priority) {
    columnValues["lead_status"] = { label: "Hot" };
  }

  const mutation = `mutation ($boardId: ID!, $itemName: String!, $columnValues: JSON!) {
    create_item(board_id: $boardId, item_name: $itemName, column_values: $columnValues) {
      id
      name
    }
  }`;

  const result = await mondayAPI(mutation, {
    boardId: String(BOARD_ID),
    itemName: target.name,
    columnValues: JSON.stringify(columnValues)
  });
  
  return result;
}

async function main() {
  // First check what status labels are available
  const statusCheck = await mondayAPI(`{ boards(ids: ${BOARD_ID}) { columns(ids: "lead_status") { settings_str } } }`);
  console.log("Status settings:", statusCheck.data?.boards?.[0]?.columns?.[0]?.settings_str?.substring(0, 500));
  
  let success = 0, failed = 0, errors = [];
  
  for (let i = 0; i < targets.length; i++) {
    const t = targets[i];
    try {
      const result = await createItem(t);
      if (result.errors || result.error_message) {
        console.log(`FAIL [${i+1}/${targets.length}] ${t.name}: ${JSON.stringify(result.errors || result.error_message)}`);
        failed++;
        errors.push({ name: t.name, error: result.errors || result.error_message });
        // If status label issue, retry without it
        if (JSON.stringify(result.errors).includes('status') && t.priority) {
          console.log(`  Retrying without status...`);
          t.priority = false;
          const retry = await createItem(t);
          if (retry.data?.create_item?.id) {
            console.log(`  Retry OK: ${retry.data.create_item.id}`);
            failed--; success++;
          }
        }
      } else if (result.data?.create_item?.id) {
        console.log(`OK [${i+1}/${targets.length}] ${t.name} → ID: ${result.data.create_item.id}${t.priority ? ' ⭐ PRIORITY' : ''}`);
        success++;
      } else {
        console.log(`UNKNOWN [${i+1}/${targets.length}] ${t.name}: ${JSON.stringify(result)}`);
        failed++;
      }
      // Rate limit: 100ms between calls
      await new Promise(r => setTimeout(r, 150));
    } catch(e) {
      console.log(`ERROR [${i+1}/${targets.length}] ${t.name}: ${e.message}`);
      failed++;
    }
  }
  
  console.log(`\n=== DONE ===`);
  console.log(`Success: ${success}/${targets.length}`);
  console.log(`Failed: ${failed}`);
  if (errors.length) console.log(`Errors:`, JSON.stringify(errors, null, 2));
}

main().catch(console.error);
