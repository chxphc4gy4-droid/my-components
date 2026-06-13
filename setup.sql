-- ================================================================
-- 元器件仓库 — Supabase 建表脚本
-- 复制下面全部内容，粘贴到 Supabase SQL Editor 运行
-- ================================================================

-- 1. 创建分类表
CREATE TABLE IF NOT EXISTS categories (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  color TEXT DEFAULT '#adb5bd',
  icon TEXT DEFAULT '其他',
  icon_type TEXT DEFAULT 'svg',
  icon_svg TEXT,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. 创建封装表
CREATE TABLE IF NOT EXISTS packages (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. 创建设置表
CREATE TABLE IF NOT EXISTS settings (
  key TEXT PRIMARY KEY,
  value TEXT
);

-- 4. 创建元器件表
CREATE TABLE IF NOT EXISTS components (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT,
  package_type TEXT,
  quantity INTEGER DEFAULT 1,
  location TEXT,
  usage TEXT,
  description TEXT,
  purchase_date TEXT,
  purchase_link TEXT,
  photo_url TEXT,
  tags TEXT[] DEFAULT '{}',
  files JSONB DEFAULT '[]',
  is_deleted BOOLEAN DEFAULT FALSE,
  deleted_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. 创建索引
CREATE INDEX IF NOT EXISTS idx_components_category ON components(category);
CREATE INDEX IF NOT EXISTS idx_components_is_deleted ON components(is_deleted);
CREATE INDEX IF NOT EXISTS idx_components_created_at ON components(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_categories_name ON categories(name);

-- 6. 启用 Row Level Security
ALTER TABLE components ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE packages ENABLE ROW LEVEL SECURITY;
ALTER TABLE settings ENABLE ROW LEVEL SECURITY;

-- 7. 为 anon key 开放全部权限（个人应用，允许所有操作）
CREATE POLICY "Allow all" ON components FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all" ON categories FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all" ON packages FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all" ON settings FOR ALL USING (true) WITH CHECK (true);

-- 8. 现在去 Supabase 左侧 Storage → 创建两个公开 bucket：
--    bucket 名称: photos  → 勾选 "Public bucket"
--    bucket 名称: files   → 勾选 "Public bucket"
-- 然后为每个 bucket 创建策略: New Policy → For all operations → Allow all

-- 或者运行下面这两条（需要配置 Storage 策略）:
-- INSERT INTO storage.buckets (id, name, public) VALUES ('photos', 'photos', true) ON CONFLICT (id) DO NOTHING;
-- INSERT INTO storage.buckets (id, name, public) VALUES ('files', 'files', true) ON CONFLICT (id) DO NOTHING;
