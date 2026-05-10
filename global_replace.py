import os
import re

pages_dir = 'src/pages'

for file in os.listdir(pages_dir):
    if not file.endswith('.jsx'): continue
    filepath = os.path.join(pages_dir, file)
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 1 & 2. Change StadiaFlow to TurfTime and 2024 to 2026
    content = content.replace('StadiaFlow', 'TurfTime')
    content = content.replace('2024', '2026')
    
    # 10. Landing Page My Bookings and Dashboard redirect to login
    if 'LandingPage.jsx' in file:
        content = re.sub(r'<Link([^>]+)to="/bookings"([^>]*)>My Bookings</Link>', r'<Link\1to="/login"\2>My Bookings</Link>', content)
        content = re.sub(r'<Link([^>]+)to="/owner-dashboard"([^>]*)>Dashboard</Link>', r'<Link\1to="/login"\2>Dashboard</Link>', content)

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

print("Global text replaced.")
