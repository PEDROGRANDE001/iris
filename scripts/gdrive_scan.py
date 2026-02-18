import json, requests, sys, csv, io

with open('/tmp/gdrive_token.txt') as f:
    TOKEN = f.read().strip()
H = {'Authorization': f'Bearer {TOKEN}'}

def lf(folder_id, drive_id):
    files = []
    pt = None
    while True:
        p = {'q': f"'{folder_id}' in parents and trashed=false", 'driveId': drive_id,
             'includeItemsFromAllDrives': True, 'supportsAllDrives': True, 'corpora': 'drive',
             'fields': 'files(id,name,mimeType,modifiedTime,size),nextPageToken', 'pageSize': 100}
        if pt: p['pageToken'] = pt
        r = requests.get('https://www.googleapis.com/drive/v3/files', headers=H, params=p, timeout=15)
        d = r.json()
        files.extend(d.get('files', []))
        pt = d.get('nextPageToken')
        if not pt: break
    return sorted(files, key=lambda x: x['name'])

def download_sheet_csv(file_id):
    """Download Google Sheet as CSV"""
    url = f'https://www.googleapis.com/drive/v3/files/{file_id}/export'
    r = requests.get(url, headers=H, params={'mimeType': 'text/csv'}, timeout=15)
    if r.status_code == 200:
        return r.text[:5000]
    return f"Error {r.status_code}"

def download_doc_text(file_id):
    """Download Google Doc as plain text"""
    url = f'https://www.googleapis.com/drive/v3/files/{file_id}/export'
    r = requests.get(url, headers=H, params={'mimeType': 'text/plain'}, timeout=15)
    if r.status_code == 200:
        return r.text[:5000]
    return f"Error {r.status_code}"

def scan_folder(folder_id, drive_id, depth=0, max_depth=2, prefix=""):
    files = lf(folder_id, drive_id)
    results = []
    for f in files:
        is_folder = 'folder' in f.get('mimeType','')
        indent = "  " * depth
        mime_short = f.get('mimeType','').split('.')[-1][:20]
        mod = f.get('modifiedTime','')[:10]
        print(f"{indent}{mime_short:20s} | {mod} | {f['name'][:60]}")
        results.append({**f, 'path': prefix + '/' + f['name'], 'depth': depth})
        if is_folder and depth < max_depth:
            sub = scan_folder(f['id'], drive_id, depth+1, max_depth, prefix + '/' + f['name'])
            results.extend(sub)
    return results

# Phase 1: Scan all 3 drives
drives = [
    ('4.0 FINANCE + ACCOUNTING', '0AFP7PVQS6wkyUk9PVA'),
    ('6.0 LOGISTICS', '0AOzbCKQznVTFUk9PVA'),
    ('1.0 MARKETING', '0ABZvW98jt1tAUk9PVA'),
]

all_results = {}
for name, did in drives:
    print(f"\n{'='*70}")
    print(f"DRIVE: {name}")
    print('='*70)
    all_results[name] = scan_folder(did, did, max_depth=2)

# Save structure
with open('/tmp/gdrive_structure.json', 'w') as f:
    json.dump(all_results, f, indent=2, default=str)

print("\n\nStructure saved. Total files per drive:")
for k,v in all_results.items():
    print(f"  {k}: {len(v)} items")
