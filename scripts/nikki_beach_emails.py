#!/usr/bin/env python3
import json, base64, re
from google.oauth2.credentials import Credentials
from googleapiclient.discovery import build

with open('/Users/peterhigney/.openclaw/workspace/credentials/google_token.json') as f:
    creds_info = json.load(f)
creds = Credentials.from_authorized_user_info(creds_info)
service = build('gmail', 'v1', credentials=creds)

# Search for Nikki Beach emails
queries = [
    'from:nikkibeach.com OR to:nikkibeach.com',
    'nikki beach hotel',
    'nikki beach resort',
    'subject:nikki beach',
]

all_ids = set()
for q in queries:
    page_token = None
    while True:
        resp = service.users().messages().list(userId='me', q=q, maxResults=100, pageToken=page_token).execute()
        msgs = resp.get('messages', [])
        for m in msgs:
            all_ids.add(m['id'])
        page_token = resp.get('nextPageToken')
        if not page_token or len(all_ids) >= 300:
            break

print(f"Found {len(all_ids)} unique messages")

results = []
for i, mid in enumerate(list(all_ids)[:200]):
    msg = service.users().messages().get(userId='me', id=mid, format='metadata',
        metadataHeaders=['From','To','Subject','Date','Cc']).execute()
    headers = {h['name']: h['value'] for h in msg.get('payload', {}).get('headers', [])}
    results.append({
        'id': mid,
        'snippet': msg.get('snippet', ''),
        'from': headers.get('From', ''),
        'to': headers.get('To', ''),
        'cc': headers.get('Cc', ''),
        'subject': headers.get('Subject', ''),
        'date': headers.get('Date', ''),
    })
    if (i+1) % 50 == 0:
        print(f"  processed {i+1}...")

# Sort by date
from email.utils import parsedate_to_datetime
def parse_date(d):
    try:
        return parsedate_to_datetime(d)
    except:
        return None

results.sort(key=lambda x: parse_date(x['date']) or __import__('datetime').datetime.min.replace(tzinfo=__import__('datetime').timezone.utc))

with open('/Users/peterhigney/.openclaw/workspace/scripts/nikki_beach_raw.json', 'w') as f:
    json.dump(results, f, indent=2, default=str)

print(f"\nSaved {len(results)} emails to nikki_beach_raw.json")

# Print summary
print("\n=== EMAIL SUMMARY ===\n")
for r in results:
    print(f"Date: {r['date']}")
    print(f"From: {r['from']}")
    print(f"To: {r['to']}")
    if r['cc']:
        print(f"Cc: {r['cc']}")
    print(f"Subject: {r['subject']}")
    print(f"Snippet: {r['snippet'][:200]}")
    print("---")
