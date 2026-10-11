# 维克软件官网

使用单页静态 HTML 构建的维克软件企业官网，基于 `weike-software-i18n-v7.html`，已接入 Formspree 项目咨询表单，支持中英文切换、移动端响应式与项目分类筛选。

## 自研项目链接

- **Kedo 智能知识库客服平台**：https://chat.usekedo.com/
- **Kedo 商单管理平台**：https://www.usekedo.com/

两个是**不同的自研产品**，不要互换产品定位。

## 项目结构

```text
├── public/
│   ├── index.html      # 官网主页面
│   ├── favicon.svg     # 网站图标
│   └── robots.txt      # 搜索引擎爬取规则
├── vercel.json         # Vercel 静态部署配置
├── publish.ps1         # Windows 一键创建 GitHub 仓库并推送
├── publish.sh          # macOS/Linux 版本
└── README.md
```

## 发布到 GitHub

GitHub 仓库建议使用 `vicuncle/weike-software-website`，与原有 `vicuncle/intellik` **完全独立**。

### 方法 A：Windows 一键创建仓库并上传（推荐）

1. 安装 [Git](https://git-scm.com/downloads) 与 [GitHub CLI（命令行工具）](https://cli.github.com/)。
2. 在本文件夹打开 PowerShell（命令行窗口）。
3. 首次使用执行 `gh auth login`，使用浏览器登录 `vicuncle`。
4. 执行 `./publish.ps1`（如果出现执行策略拦截，请在命令行执行 `powershell -ExecutionPolicy Bypass -File .\publish.ps1`）。

这会尝试自动创建一个 **public（公开）** GitHub 仓库并推送代码。如果仓库已存在，则只推送代码，不会创建重复仓库。

### 方法 B：通过 GitHub 网页创建空仓库

1. 打开 https://github.com/new ，账号选择 `vicuncle`。
2. 仓库名填写 `weike-software-website`，可选公开仓库；**不要勾选自动添加 README**。
3. 新建仓库后，在本文件夹执行：

```bash
git init -b main
git add .
git commit -m "feat: initialize Weike Software website"
git remote add origin https://github.com/vicuncle/weike-software-website.git
git push -u origin main
```

## 部署到 Vercel

1. 打开 https://vercel.com/new 并使用 Vercel 账号登录。
2. 选择 **Import Git Repository（导入 Git 仓库）**，选择 `vicuncle/weike-software-website`；如果找不到仓库，请在 Vercel 的 GitHub 授权中允许访问新仓库。
3. 配置：
   - **Framework Preset（框架预设）**：`Other`（其他/静态站点）
   - **Root Directory（根目录）**：`./`
   - **Build Command（构建命令）**：不填
   - **Output Directory（输出目录）**：`public`（已通过 `vercel.json` 设置）
4. 点击 **Deploy（部署）**。部署成功后得到一个 `*.vercel.app` 域名。
5. 以后把代码更新推送到 `main`，Vercel 的 GitHub 集成会自动重新部署。

## 本地预览

使用 VS Code 的 Live Server 插件打开 `public/index.html`，或者直接双击 `public/index.html`。

## 官网咨询表单（已接入）

- **表单接收地址**：`https://formspree.io/f/xrpekrzq`
- **表单字段**：`name`（称呼）、`contact`（微信/手机号/邮箱）、`project_type`（项目类型）、`message`（需求描述）、`subject`（邮件标题）和 `source`（来源）。当客户在联系方式中填写有效电子邮箱时，还会发送 `email` 字段，方便直接回复客户。
- **提交方式**：使用浏览器 `fetch` 异步提交，`Accept: application/json`；提交期间禁用按钮，成功后清空表单并显示成功消息。失败和提交频率限制有对应提示；中英文均已适配。
- **表单通知**：请在 Formspree 后台确认已经验证收件邮箱，并开启邮件通知。咨询内容在 Formspree 管理后台也可查看（取决于服务套餐及保留政策）。
- **上线自测**：部署到 Vercel 后，亲自提交一条明确标注为测试的咨询，再检查 Formspree 后台和绑定邮箱（包括垃圾邮件文件夹）。这个项目包没有自动向真实邮箱发送测试消息。
- **反垃圾设置**：如果收到了大量垃圾咨询，可在 Formspree 后台开启适当的反垃圾验证。

## 上线前注意
- 部分字体通过 Google Fonts 加载，无法访问时会回退到系统字体。
- 项目示意界面与数字为演示内容，不代表真实业务统计或客户案例。
- 如需绑定正式域名，可在 Vercel 项目的 **Settings → Domains（设置 → 域名）** 中添加域名，并按提示配置 DNS（域名解析）。

## 搜索引擎优化（SEO）

当前首页已设置面向软件定制开发与 AI 应用开发业务的中文标题、描述、社交分享文案、搜索引擎抓取指令及 `schema.org`（结构化数据）。页面也保留了英文切换，但**中文和英文暂时共用同一个地址**，不能视作两套独立可收录语言页面。

### 正式上线后补充

1. 确认官网最终可公开访问的生产环境地址（例如 `https://weike.usekedo.com/`；这是此前讨论的候选域名，只有绑定生效后才使用）。
2. 再为该正式地址添加 `<link rel="canonical">`、`og:url` 和网站首页 `sitemap.xml`，并在 `robots.txt` 中引用站点地图。**切勿把未绑定、重定向错误或测试域名写成规范网址**。
3. 在 [Google Search Console（谷歌搜索管理平台）](https://search.google.com/search-console) 和 [Bing Webmaster Tools（必应站长工具）](https://www.bing.com/webmasters/) 验证网站、提交正式域名的站点地图，使用 URL 检查工具申请抓取。面向中国内地用户，还可考虑百度搜索资源平台。
4. 通过实际网址确认网站返回 HTTP 200、页面可以公开访问，没有 `noindex` 或访问密码，且表单不会被任何结构化数据或部署修改影响。
5. SEO 不是一次配置就能保证排名。后续应根据客户搜索需求增加有真实案例、交付过程、常见问题、服务说明等原创内容；勿伪造客户案例、公司地址、评价或运营数据。

### 当前页面的 SEO 关键词重点

企业软件定制开发、软件定制开发、AI 应用开发、智能客服开发、企业系统开发、微信小程序开发、系统集成、系统二次开发、技术合作。

当前未写入 `canonical` 与 `sitemap.xml`，是因为 GitHub 代码尚不能证明最终公网域名已经绑定成功。待确认真实正式地址后再补齐。
