# osilic: OSI License CLI & Python Package

osilic is a Python package and command-line tool for listing, searching, and viewing details of OSI Approved Licenses® using the [official OSI API](https://opensource.org/blog/introducing-the-new-api-for-osi-approved-licenses).

## Features
- List all OSI Approved Licenses®
- View details for a specific license by SPDX ID
- Search licenses by name
- Automatic suggestions for similar licenses if a license is not found
- Usable as a standalone CLI or as a Python package
- Filter licenses by keywords
- Auto suggest available keywords upon entering wrong keyword filters
- Filter licenses by stewards
- Auto suggest available licenses upon entering wrong stewards filters

## Installation

### From Pypi index
```bash
pip install osilic
```

### Using pip (editable mode for development)
```bash
pip install -e .
```
Or with [uv](https://github.com/astral-sh/uv):
```bash
uv pip install -e .
```

### Requirements
- Python 3.8+
- `requests` and `tabulate` Python packages

## Usage

### CLI
After installation, use the `osilic` command:

- List all licenses:
  ```bash
  osilic
  ```
  ![osilic](https://raw.githubusercontent.com/dineshr93/osilic/refs/heads/main/screenshot/osilic_all_licenses.png)

- Show details for a license by SPDX ID:
  ```bash
  osilic gpl-2-0
  ```
  ![osilic gpl-3-0](https://raw.githubusercontent.com/dineshr93/osilic/refs/heads/main/screenshot/osilic_lic_details.png)

- Search licenses by name (-s):
  ```bash
  osilic -s mit
  ```
  ![osilic -s gpl](https://raw.githubusercontent.com/dineshr93/osilic/refs/heads/main/screenshot/osilic_lic_search.png)
  
- If a license is not found, the CLI will suggest similar licenses automatically.
  ![osilic mi](https://raw.githubusercontent.com/dineshr93/osilic/refs/heads/main/screenshot/osilic_missing_lic.png)

- Filter licenses by steward (-w):
  ```bash
  osilic -w zope-foundation
  ```
  ![osilic -w zope-foundationl](https://raw.githubusercontent.com/dineshr93/osilic/refs/heads/main/screenshot/osilic%20steward.png)
  
- If a license is not found, the CLI will suggest list of stewards to use automatically.
  ![osilic -w dummy](https://raw.githubusercontent.com/dineshr93/osilic/refs/heads/main/screenshot/osilic%20steward%20suggest.png)

- Filter licenses by keyword (-k):
  ```bash
  osilic -k other-miscellaneous
  ```
  ![osilic -k other-miscellaneous](https://raw.githubusercontent.com/dineshr93/osilic/refs/heads/main/screenshot/osilic%20keyword.png)
  
- If a license is not found, the CLI will suggest list of keywords to use automatically.
  ![osilic -k test](https://raw.githubusercontent.com/dineshr93/osilic/refs/heads/main/screenshot/osilic%20keyword%20suggest.png)

### As a Python Package
You can also use OLC in your own Python code:
```python
from olc.model import license_from_dict, print_licenses_table, print_license_details_table
import requests

resp = requests.get("https://opensource.org/api/license")
licenses = license_from_dict(resp.json())
print_licenses_table(licenses)
```

## API Reference
- List all licenses: `https://opensource.org/api/license`
- License details: `https://opensource.org/api/license/{spdx-id}`
- Search licenses: `https://opensource.org/api/license?name={search_key}`
- Filter licenses by keywords: `https://opensource.org/api/license?keyword={filter_keyword}`
- Filter licenses by stewards: `https://opensource.org/api/license?steward={filter_steward_key}`

## Reference & Further Reading
- Official OSI API Blog Post: [Introducing the New API for OSI Approved Licenses](https://opensource.org/blog/introducing-the-new-api-for-osi-approved-licenses)
- For more information on OSI licenses, visit [opensource.org](https://opensource.org/licenses).

## Development
- Source code: [GitHub](https://github.com/dineshr93/osilic)
- Discusstion: [OSI discussion](https://discuss.opensource.org/t/introducing-the-new-api-for-osi-approved-licenses/1169/1)
- Issues and contributions welcome!

## License
This project is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) License.

Copyright © 2025 Dinesh R

See [LICENSE](https://github.com/dineshr93/osilic/blob/main/LICENSE) for details.

## Author
- Dinesh R

## Changelog
See [CHANGELOG.md](https://github.com/dineshr93/osilic/blob/main/CHANGELOG.md) for a list of all commits and changes.

---
For more information on OSI licenses, visit [opensource.org](https://opensource.org/licenses).
