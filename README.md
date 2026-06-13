# 🔌 元器件仓库 — 设置指南

## 🗂️ 文件位置
```
A:\File\元器件网站存储\
├── index.html   ← 主程序（浏览器打开这个）
├── setup.sql    ← Supabase 建表脚本
└── README.md    ← 本说明文件
```

---

## 📝 第一步：注册 Supabase（2分钟）

1. 打开 https://supabase.com
2. 点右上角 **Sign In** → 用 GitHub 登录
3. 点 **New project**
4. 填写：
   - **Name**: `components-db`
   - **Database Password**: 设一个密码，**记下来！**
   - **Region**: 选 `Asia Pacific` 或 `Northeast Asia`
5. 点 **Create project**，等待1-2分钟

---

## 📝 第二步：获取 API 密钥

1. 在 Supabase 项目里，左边菜单点 **Settings（齿轮图标）→ API**
2. 复制两个值：
   - **Project URL**（类似 `https://xxxxx.supabase.co`）
   - **anon public key**（一长串字符）
3. 用记事本打开 `A:\File\元器件网站存储\index.html`
4. 找到最前面的这两行，替换：
```javascript
const SUPABASE_URL = 'https://xxxxx.supabase.co';  // 替换为你的 URL
const SUPABASE_KEY = 'eyJhbGciOi...';               // 替换为你的 key
```

---

## 📝 第三步：建数据库表

1. 在 Supabase 左边菜单点 **SQL Editor**
2. 点 **New query**
3. 用记事本打开 `A:\File\元器件网站存储\setup.sql`
4. **复制全部内容**，粘贴到 SQL Editor
5. 点右下角绿色 **Run** 按钮
6. 看到 "Success" 即可

---

## 📝 第四步：创建存储桶（存照片用）

1. 在 Supabase 左边菜单点 **Storage**
2. 点 **New bucket**：
   - 名称: `photos` → **☑ Public bucket** → Create
   - 名称: `files` → **☑ Public bucket** → Create
3. 点进 `photos` → **Policies** 标签
4. 点 **New Policy** → 选 `For all operations` → 点 `Use this template` → Review → Save
5. 对 `files` 桶重复步骤 3-4

---

## 📱 第五步：打开使用

### 电脑
双击 `index.html`，或用本地服务器：
```powershell
cd "A:\File\元器件网站存储"
python -m http.server 8080
```
然后浏览器打开 `http://localhost:8080`

### 手机
1. 确认手机和电脑**连的是同一个 WiFi**
2. 电脑上查 IP：
   ```powershell
   ipconfig
   ```
   找 `IPv4 地址`，类似 `192.168.x.x`
3. 手机浏览器打开 `http://192.168.x.x:8080`
4. ✅ 手机拍照上传 → 电脑刷新就能看到！

> 🌐 手机用流量也行 — 因为数据在 Supabase 云端，手机只要有网就能同步！

---

## 💾 本地备份

点侧边栏的 **💾 本地备份** 按钮：
- 第一次会弹出文件夹选择窗口
- 选择 `A:\File\元器件网站存储` 目录
- 之后每次点击都会保存 `backup.json` 到该目录

---

## 💰 费用

Supabase 免费额度：
- 数据库 500MB — 够存 5000+ 个元器件
- 文件存储 1GB — 够存几千张照片
- **你一个人用完全免费，永远不需要付费**
