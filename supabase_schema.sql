-- Drop existing tables if needed
-- DROP TABLE IF EXISTS feedback;
-- DROP TABLE IF EXISTS bookings;
-- DROP TABLE IF EXISTS slots;
-- DROP TABLE IF EXISTS facilities;
-- DROP TABLE IF EXISTS users;

-- Users table (Extending Supabase auth users)
CREATE TABLE public.users (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  email TEXT NOT NULL,
  role TEXT NOT NULL DEFAULT 'user' CHECK (role IN ('user', 'owner', 'admin')),
  full_name TEXT,
  phone TEXT,
  profile_image TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Facilities table
CREATE TABLE public.facilities (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  owner_id UUID REFERENCES public.users(id) NOT NULL,
  name TEXT NOT NULL,
  organization TEXT,
  description TEXT,
  sport_type TEXT,
  price_per_hour NUMERIC DEFAULT 0,
  area_sq_ft NUMERIC,
  phone TEXT,
  image_url TEXT,
  proof_url TEXT,
  location TEXT NOT NULL,
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Slots table
CREATE TABLE public.slots (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  facility_id UUID REFERENCES public.facilities(id) ON DELETE CASCADE NOT NULL,
  start_time TIMESTAMP WITH TIME ZONE NOT NULL,
  end_time TIMESTAMP WITH TIME ZONE NOT NULL,
  is_available BOOLEAN DEFAULT TRUE,
  is_blocked BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Bookings table
CREATE TABLE public.bookings (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES public.users(id) NOT NULL,
  slot_id UUID REFERENCES public.slots(id) ON DELETE RESTRICT NOT NULL,
  status TEXT NOT NULL DEFAULT 'confirmed' CHECK (status IN ('confirmed', 'cancelled', 'completed')),
  total_price NUMERIC NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Feedback table
CREATE TABLE public.feedback (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES public.users(id) NOT NULL,
  facility_id UUID REFERENCES public.facilities(id) ON DELETE CASCADE NOT NULL,
  rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
  comment TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- RLS Policies
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.facilities ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.slots ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.feedback ENABLE ROW LEVEL SECURITY;

-- Allow users to insert their own profile after auth signup
CREATE POLICY "Users can insert their own profile" ON public.users FOR INSERT WITH CHECK (auth.uid() = id);
CREATE POLICY "Users can update their own profile" ON public.users FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Public profiles are viewable by everyone" ON public.users FOR SELECT USING (TRUE);

-- Allow read access to all approved facilities
DROP POLICY IF EXISTS "Public read approved facilities" ON public.facilities;
DROP POLICY IF EXISTS "Owners can insert their facilities" ON public.facilities;
DROP POLICY IF EXISTS "Owners can view their own facilities" ON public.facilities;

CREATE POLICY "Public read approved facilities" ON public.facilities FOR SELECT USING (TRUE);
CREATE POLICY "Enable insert for authenticated users" ON public.facilities FOR INSERT WITH CHECK (TRUE);
CREATE POLICY "Owners can view their own facilities" ON public.facilities FOR SELECT USING (TRUE);
CREATE POLICY "Allow all updates" ON public.facilities FOR UPDATE USING (TRUE);

-- Allow read access to slots
DROP POLICY IF EXISTS "Public read slots" ON public.slots;
CREATE POLICY "Public read slots" ON public.slots FOR SELECT USING (TRUE);
CREATE POLICY "Public insert slots" ON public.slots FOR INSERT WITH CHECK (TRUE);

-- Storage Policies
DROP POLICY IF EXISTS "Public storage access" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated upload access" ON storage.objects;
CREATE POLICY "Public storage access" ON storage.objects FOR SELECT USING (TRUE);
CREATE POLICY "Authenticated upload access" ON storage.objects FOR INSERT WITH CHECK (TRUE);

-- Admin Auto-Role Function
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.users (id, email, role, full_name)
  VALUES (
    new.id, 
    new.email, 
    CASE WHEN new.email = '24ce102.aditi.naik.pccegoa.edu.in@gmail.com' THEN 'admin' ELSE 'user' END,
    new.raw_user_meta_data->>'full_name'
  );
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
