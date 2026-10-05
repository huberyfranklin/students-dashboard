-- ==========================================
-- 學生學習進度追蹤系統 Supabase 資料庫建置指令
-- 請至 Supabase Dashboard -> SQL Editor 執行此段 SQL
-- ==========================================

-- 1. 建立 tasks 資料表 (支援 科目、章節、任務 欄位)
CREATE TABLE IF NOT EXISTS public.tasks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_name VARCHAR(50) NOT NULL,
    subject VARCHAR(50) NOT NULL,
    chapter VARCHAR(100) NOT NULL DEFAULT '',
    title VARCHAR(50) NOT NULL,
    completed BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 2. 若舊資料表已存在，補上 chapter (章節) 欄位
ALTER TABLE public.tasks ADD COLUMN IF NOT EXISTS chapter VARCHAR(100) NOT NULL DEFAULT '';

-- 3. 設定 index
CREATE INDEX IF NOT EXISTS idx_tasks_student_name ON public.tasks(student_name);

-- 4. 開啟 Row Level Security (RLS) 政策
ALTER TABLE public.tasks ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public select on tasks" ON public.tasks;
DROP POLICY IF EXISTS "Allow public insert on tasks" ON public.tasks;
DROP POLICY IF EXISTS "Allow public update on tasks" ON public.tasks;
DROP POLICY IF EXISTS "Allow public delete on tasks" ON public.tasks;

CREATE POLICY "Allow public select on tasks" ON public.tasks FOR SELECT TO anon USING (true);
CREATE POLICY "Allow public insert on tasks" ON public.tasks FOR INSERT TO anon WITH CHECK (true);
CREATE POLICY "Allow public update on tasks" ON public.tasks FOR UPDATE TO anon USING (true) WITH CHECK (true);
CREATE POLICY "Allow public delete on tasks" ON public.tasks FOR DELETE TO anon USING (true);

-- 5. 啟用 Realtime 即時推播
BEGIN;
  DROP PUBLICATION IF EXISTS supabase_realtime;
  CREATE PUBLICATION supabase_realtime FOR TABLE public.tasks;
COMMIT;

-- 強制刷新 Schema 快取
NOTIFY pgrst, 'reload schema';

-- 6. 插入測試預設資料
INSERT INTO public.tasks (student_name, subject, chapter, title, completed) VALUES
('Rex', '國語', '第一課 雅量', '自修', true),
('Rex', '數學', '第一章 一元二次方程式', '評量', false),
('Rex', '自然', '第二單元 植物的生長', '小卷', false),
('Doris', '社會', '第三章 臺灣地理', '大卷', true),
('Doris', '英文', 'Unit 1 Grammar', '複習卷', false);
