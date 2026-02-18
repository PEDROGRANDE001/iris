import json, csv, urllib.request, urllib.parse, time

API_KEY = "eE0ZMtEErRZDJv0msz3QEf_HF4pUadhOqzHuqzI8-ZMU"
USER = "phigney@gmail.com"
BASE = "https://api.cloze.com/v1/people/find"

SEGMENTS = [
    "Customers", "Supplier Vietnam", "Development", "Supplier",
    "Architect & Design", "Operator", "Supplier Mexico", "Shipping",
    "Consultant", "Supplier Europe", "Capital Group", "Supplier Indonesia",
    "Supplier China", "Connection"
]

def fetch_segment(segment):
    all_people = []
    page = 1
    while True:
        params = urllib.parse.urlencode({
            "api_key": API_KEY, "user": USER,
            "segment": segment, "limit": 100, "pagenumber": page
        })
        url = f"{BASE}?{params}"
        with urllib.request.urlopen(url) as r:
            data = json.loads(r.read())
        people = data.get("people", [])
        if not people:
            break
        all_people.extend(people)
        avail = data.get("availablecount", 0)
        print(f"  {segment} page {page}: got {len(people)}, total so far {len(all_people)}/{avail}")
        if len(all_people) >= avail:
            break
        page += 1
        time.sleep(0.3)
    return all_people

def extract_fields(person, segment_name):
    emails = [e.get("value","") for e in person.get("emails",[])]
    phones = [p.get("value","") for p in person.get("phones",[])]
    companies = [c.get("name","") for c in person.get("companies",[])]
    return {
        "name": person.get("name",""),
        "first": person.get("first",""),
        "last": person.get("last",""),
        "email": emails[0] if emails else "",
        "email_other": "; ".join(emails[1:]) if len(emails)>1 else "",
        "phone": phones[0] if phones else "",
        "phone_other": "; ".join(phones[1:]) if len(phones)>1 else "",
        "company": companies[0] if companies else "",
        "company_other": "; ".join(companies[1:]) if len(companies)>1 else "",
        "segment_label": segment_name,
        "segment_raw": person.get("segment",""),
        "stage": person.get("stage",""),
        "step": person.get("step",""),
    }

# Extract categorized
all_rows = []
segment_counts = {}
for seg in SEGMENTS:
    print(f"Fetching: {seg}")
    people = fetch_segment(seg)
    segment_counts[seg] = len(people)
    for p in people:
        all_rows.append(extract_fields(p, seg))

# Write CSV
fields = ["name","first","last","email","email_other","phone","phone_other","company","company_other","segment_label","segment_raw","stage","step"]
with open("/Users/peterhigney/.openclaw/workspace/downloads/cloze_contacts_categorized.csv", "w", newline="") as f:
    w = csv.DictWriter(f, fieldnames=fields)
    w.writeheader()
    w.writerows(all_rows)

print(f"\nTotal categorized: {len(all_rows)}")
for seg, cnt in segment_counts.items():
    print(f"  {seg}: {cnt}")

# Sample uncategorized (4 pages of 50)
print("\nFetching uncategorized sample...")
uncat = []
for page in range(1, 5):
    params = urllib.parse.urlencode({
        "api_key": API_KEY, "user": USER, "limit": 50, "pagenumber": page
    })
    url = f"{BASE}?{params}"
    with urllib.request.urlopen(url) as r:
        data = json.loads(r.read())
    people = data.get("people", [])
    uncat.extend(people)
    avail = data.get("availablecount", 0)
    print(f"  Uncategorized page {page}: got {len(people)}, available: {avail}")
    time.sleep(0.3)

# Analyze uncategorized
from collections import Counter
uncat_segments = Counter(p.get("segment","none") for p in uncat)
uncat_stages = Counter(p.get("stage","none") for p in uncat)
has_email = sum(1 for p in uncat if p.get("emails"))
has_phone = sum(1 for p in uncat if p.get("phones"))
has_company = sum(1 for p in uncat if p.get("companies"))

# Build summary
summary = f"""# Cloze CRM Contacts Export Summary
**Date:** 2026-02-17
**Total categorized contacts exported:** {len(all_rows)}

## Segment Breakdown
| Segment | Count |
|---------|-------|
"""
for seg in SEGMENTS:
    summary += f"| {seg} | {segment_counts[seg]} |\n"

summary += f"""
## Notable Contacts by Segment
"""
for seg in SEGMENTS:
    seg_rows = [r for r in all_rows if r["segment_label"] == seg]
    names = [r["name"] for r in seg_rows[:5]]
    summary += f"\n### {seg} ({segment_counts[seg]})\n"
    summary += ", ".join(names)
    if segment_counts[seg] > 5:
        summary += f" ... and {segment_counts[seg]-5} more"
    summary += "\n"

summary += f"""
## Uncategorized Contacts Sample
**Sampled:** {len(uncat)} contacts (first 4 pages)
**Total available (uncategorized):** {avail}

### Data Quality
- Has email: {has_email}/{len(uncat)}
- Has phone: {has_phone}/{len(uncat)}
- Has company: {has_company}/{len(uncat)}

### Segment distribution in uncategorized
"""
for seg, cnt in uncat_segments.most_common():
    summary += f"- {seg}: {cnt}\n"

summary += f"""
### Stage distribution
"""
for stg, cnt in uncat_stages.most_common():
    summary += f"- {stg}: {cnt}\n"

summary += f"""
### Sample names (first 20)
"""
for p in uncat[:20]:
    summary += f"- {p.get('name','')} ({', '.join(e.get('value','') for e in p.get('emails',[])[:1])})\n"

with open("/Users/peterhigney/.openclaw/workspace/memory/cloze-contacts-summary.md", "w") as f:
    f.write(summary)

print("\nDone! CSV and summary written.")
