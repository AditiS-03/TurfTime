import os
import re

pages_dir = 'src/pages'

for file in os.listdir(pages_dir):
    if not file.endswith('.jsx'): continue
    filepath = os.path.join(pages_dir, file)
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    if "from 'react-router-dom'" not in content:
        content = content.replace("import React from 'react';", "import React from 'react';\nimport { Link, useNavigate } from 'react-router-dom';")

    # Replace Top Nav links
    content = re.sub(r'<a([^>]+)href="#"([^>]*)>Facilities</a>', r'<Link\1to="/facilities"\2>Facilities</Link>', content)
    content = re.sub(r'<a([^>]+)href="#"([^>]*)>My Bookings</a>', r'<Link\1to="/bookings"\2>My Bookings</Link>', content)
    content = re.sub(r'<a([^>]+)href="#"([^>]*)>Dashboard</a>', r'<Link\1to="/owner-dashboard"\2>Dashboard</Link>', content)
    
    content = re.sub(r'<a([^>]+)href="#"([^>]*)>View all facilities', r'<Link\1to="/facilities"\2>View all facilities</Link>', content)
    
    # Replace buttons
    if 'LandingPage.jsx' in file:
        content = re.sub(r'(<button[^>]*>Sign In</button>)', r'<Link to="/login">\1</Link>', content)
        content = re.sub(r'(<button[^>]*>Get Started Now</button>)', r'<Link to="/login">\1</Link>', content)
        content = re.sub(r'(<button[^>]*>[^<]*Find Arena[^<]*</button>)', r'<Link to="/facilities">\1</Link>', content)
        content = re.sub(r'(<button[^>]*>Book Now</button>)', r'<Link to="/facility/1">\1</Link>', content)
    
    if 'Login.jsx' in file:
        content = re.sub(r'(<button[^>]*>\\s*Secure Sign In\\s*</button>)', r'<Link to="/facilities" className="w-full block">\1</Link>', content)
        content = content.replace('type="submit"', 'type="button"')

    if 'FindFacilities.jsx' in file:
        content = re.sub(r'(<button[^>]*>Book Now</button>)', r'<Link to="/facility/1">\1</Link>', content)

    if 'FacilityDetails.jsx' in file:
        content = re.sub(r'(<button[^>]*>Confirm Booking</button>)', r'<Link to="/booking-confirmed" className="w-full block">\1</Link>', content)
        content = re.sub(r'(<button[^>]*>\\s*Confirm Booking\\s*</button>)', r'<Link to="/booking-confirmed" className="w-full block">\1</Link>', content)

    if 'BookingConfirmed.jsx' in file:
        content = re.sub(r'(<button[^>]*>View My Bookings</button>)', r'<Link to="/bookings">\1</Link>', content)
        content = re.sub(r'(<button[^>]*>Return Home</button>)', r'<Link to="/">\1</Link>', content)

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

print("Routing injected.")
