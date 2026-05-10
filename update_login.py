import re

filepath = 'src/pages/Login.jsx'
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Replace profileImage with profileImageFile
content = content.replace("profile_image: profileImage,", "profile_image: profileImageUrl,")

upload_logic = """
    let profileImageUrl = '';
    if (profileImageFile) {
      const fileExt = profileImageFile.name.split('.').pop();
      const fileName = ${data.user.id}-.;
      const { error: uploadError } = await supabase.storage.from('profiles').upload(fileName, profileImageFile);
      if (!uploadError) {
        const { data: publicUrlData } = supabase.storage.from('profiles').getPublicUrl(fileName);
        profileImageUrl = publicUrlData.publicUrl;
      }
    }
"""

# Insert upload logic in handleRegisterAthlete
content = content.replace(
    "if (data.user) {",
    "if (data.user) {" + upload_logic,
    1 # First occurrence in athlete
)

# Insert upload logic in handleRegisterOwner
# It will be the second occurrence of "if (data.user) {"
parts = content.split("if (data.user) {")
content = parts[0] + "if (data.user) {" + parts[1] + "if (data.user) {" + upload_logic + parts[2]


# Replace inputs
content = re.sub(
    r'<input value={profileImage}[^>]*type="url"/>',
    r'<input onChange={e=>setProfileImageFile(e.target.files[0])} accept="image/*" required className="w-full bg-surface-container-lowest border-none rounded-lg py-2 px-4 text-on-surface ring-1 ring-white/10 focus:ring-2 focus:ring-primary outline-none" type="file"/>',
    content
)

with open(filepath, 'w', encoding='utf-8') as f:
    f.write(content)

print("Updated Login.jsx")
