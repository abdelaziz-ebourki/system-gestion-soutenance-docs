with open('spec_endpoints.txt', 'r') as f:
    spec = set(line.strip() for line in f if line.strip())

with open('annex_endpoints.txt', 'r') as f:
    annex = set(line.strip() for line in f if line.strip())

missing = spec - annex
for endpoint in sorted(missing):
    print(endpoint)
