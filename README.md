# 學生學習進度追蹤網站 (支援雲端同步與 PIN 碼保護)

一個輕量、無需複雜登入流程、支援跨裝置即時同步的學生學習與複習進度追蹤系統（MVP）。

## 核心功能
- **PIN 碼鎖定防護**：初次開啟或重新整理時需輸入 PIN 碼解鎖（預設：`1234`）。
- **免登入學生切換**：頂端選單切換「王小明」、「李大華」。
- **總體進度儀表板**：動態計算完成率、進度條動畫、已完成與待完成統計。
- **任務管理**：新增科目與章節/任務名稱、勾選完成（觸發彩帶動畫）、刪除任務。
- **Realtime 雲端同步**：透過 Supabase Realtime 讓手機、平板與電腦多端無縫同步。

## 快速開始說明
1. **設定 Supabase 資料庫**：
   - 註冊並建立 [Supabase](https://supabase.com/) 專案。
   - 至 `SQL Editor` 執行本專案提供的 `schema.sql` 建立 `tasks` 資料表與開啟 Realtime。
2. **填入 API 金鑰與 PIN 碼**：
   - 開啟 `index.html`，修改以下變數：
     ```javascript
     const SUPABASE_URL = "您的 Supabase 專案 URL";
     const SUPABASE_ANON_KEY = "您的 Supabase anon key";
     const SECURITY_PIN = "您自訂的 4 位數 PIN 碼 (預設: 1234)";
     ```
3. **部署與存取**：
   - 直接用瀏覽器開啟 `index.html` 即可使用，或將資料夾部署至 GitHub Pages / Vercel / Netlify 供跨裝置訪問。
