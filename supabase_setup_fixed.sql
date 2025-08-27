-- Fixed Supabase Database Setup for Modern Login App
-- Run this in your Supabase SQL Editor to fix the database issues

-- Step 1: Clean up existing tables and functions
DROP TABLE IF EXISTS public.profiles CASCADE;
DROP FUNCTION IF EXISTS public.handle_new_user() CASCADE;

-- Step 2: Create the profiles table with correct structure
CREATE TABLE public.profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  full_name TEXT,
  avatar_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Step 3: Enable Row Level Security
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Step 4: Create security policies
CREATE POLICY "Users can view own profile" ON public.profiles
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON public.profiles
  FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile" ON public.profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

-- Step 5: Create function to handle new user registration
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', 'User')
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Step 6: Create trigger for new user registration
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

-- Step 7: Create indexes for performance
CREATE INDEX IF NOT EXISTS profiles_full_name_idx ON public.profiles(full_name);
CREATE INDEX IF NOT EXISTS profiles_created_at_idx ON public.profiles(created_at);

-- Step 8: Grant permissions
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT ALL ON public.profiles TO anon, authenticated;

-- Success message
SELECT 'Database setup completed successfully!' as status;
