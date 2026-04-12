<p align="center">
  <a href="./README.md">🇬🇧 English</a> &nbsp;·&nbsp;
  🇻🇳 <strong>Tiếng Việt</strong> &nbsp;·&nbsp;
  <a href="./README_CN.md">🇨🇳 简体中文</a> &nbsp;·&nbsp;
  <a href="./README_KR.md">🇰🇷 한국어</a> &nbsp;·&nbsp;
  <a href="./README_JP.md">🇯🇵 日本語</a> &nbsp;·&nbsp;
  <a href="./README_DE.md">🇩🇪 Deutsch</a> &nbsp;·&nbsp;
  <a href="./README_FR.md">🇫🇷 Français</a> &nbsp;·&nbsp;
  <a href="./README_RU.md">🇷🇺 Русский</a>
</p>

<h1 align="center">Wiki Knowledge Compiler</h1>

<p align="center">
  <em>Biến tài liệu của bạn thành kho kiến thức cá nhân — được hỗ trợ bởi AI, lưu trữ dưới dạng file đơn giản.</em>
</p>

<p align="center">
  <a href="https://github.com/bradduy/wiki-knowledge-compiler/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License" /></a>
  <a href="https://github.com/bradduy/wiki-knowledge-compiler"><img src="https://img.shields.io/badge/platform-Claude%20Code-blueviolet.svg" alt="Claude Code" /></a>
  <a href="https://obsidian.md"><img src="https://img.shields.io/badge/works%20with-Obsidian-7C3AED.svg" alt="Works with Obsidian" /></a>
  <img src="https://img.shields.io/badge/offline-100%25-brightgreen.svg" alt="100% Offline" />
</p>

<p align="center">
  <img src="./assets/demo.gif" alt="Wiki Knowledge Compiler Demo" width="100%" />
</p>

<p align="center">
  <img src="./assets/logo.png" alt="Wiki Knowledge Compiler Logo" width="100%" />
</p>

---

# 🇻🇳 Tiếng Việt

## 📖 Đây là gì?

Một plugin cho [Claude Code](https://docs.anthropic.com/en/docs/claude-code) giúp biến tài liệu của bạn thành một kho kiến thức có tổ chức, dễ tìm kiếm.

Đưa cho nó bất cứ thứ gì — bài viết, ghi chú, PDF, cả một thư mục — và nó sẽ:

1. **Lưu trữ** bản gốc của bạn (không bao giờ bị thay đổi)
2. **Tóm tắt** từng nguồn tài liệu
3. **Trích xuất** các ý tưởng chính thành từng trang riêng
4. **Kết nối** các ý tưởng liên quan xuyên suốt mọi thứ bạn đã thêm
5. **Trả lời** câu hỏi của bạn kèm liên kết về nguồn gốc

Mọi thứ nằm trên máy tính của bạn dưới dạng file văn bản thuần. Không cloud. Không database. Không bị phụ thuộc.

---

## 🚀 Bắt đầu nhanh

Ba bước. Mọi thứ được cài đặt tự động — bạn không cần tự thiết lập gì cả.

**Bước 1 — Cài plugin:**
```
/plugin marketplace add bradduy/wiki-knowledge-compiler
```
Sau khi thêm, cấu hình trong marketplace:
1. Chạy `/plugin` → chọn tab **Marketplace**
2. Tìm **wiki-knowledge-compiler** và mở ra
3. Nhấn **Enable** và chọn scope — chọn thư mục dự án bạn muốn đặt wiki
4. Xác nhận — bước này cấp quyền cho plugin tạo file và chạy lệnh trong thư mục đó

<p align="center">
  <img src="./assets/user_scope_setting.png" alt="Cài đặt scope" width="100%" />
</p>

**Bước 2 — Chạy thiết lập:**
```
/wiki-setup
```
Chọn quy mô dự án (nhỏ, vừa, hoặc lớn). Plugin lo phần còn lại — cài các công cụ cần thiết, tạo thư mục wiki, và còn đề nghị cài [Obsidian](https://obsidian.md) để bạn duyệt wiki trực quan.

<p align="center">
  <img src="./assets/obisidian.gif" alt="Duyệt wiki bằng Obsidian" width="100%" />
</p>

**Bước 3 — Thêm tài liệu đầu tiên:**
```
/wiki-ingest ~/Documents/my-article.md
```

Xong. Wiki của bạn đã sẵn sàng.

---

## 🎯 Bạn có thể làm gì

Mỗi lệnh sẽ gợi ý bước tiếp theo, nên bạn luôn biết phải làm gì.

| Lệnh | Chức năng |
|---------|-------------|
| `/wiki-setup` | Thiết lập một lần (tự cài đặt mọi thứ cho bạn) |
| `/wiki-ingest` | Thêm tài liệu — một file, cả thư mục, hoặc một URL |
| `/wiki` | Đặt câu hỏi, nhận câu trả lời kèm nguồn |
| `/wiki-insights` | Tìm các mẫu hình và mối liên hệ giữa các nguồn |
| `/wiki-update` | Cập nhật mục lục |

**Thứ tự khuyên dùng:** `/wiki-setup` → `/wiki-ingest` → `/wiki` → `/wiki-insights` → `/wiki-update`

---

## 📥 Thêm tài liệu

Bạn có thể thêm tài liệu bằng nhiều cách:

```bash
# Một file
/wiki-ingest ~/Documents/article.md

# Cả một thư mục (quét toàn bộ bên trong)
/wiki-ingest ~/Documents/research/

# Nhiều file cùng lúc
/wiki-ingest ~/notes/meeting1.md ~/notes/meeting2.md

# Tất cả PDF trong một thư mục
/wiki-ingest ~/papers/*.pdf

# Một URL
/wiki-ingest https://example.com/interesting-article

# Hoặc dán trực tiếp nội dung sau lệnh
```

Với thư mục và nhiều file, plugin sẽ hiển thị tiến trình khi xử lý từng file.

---

## 🧪 Ví dụ: Từ tài liệu đến kiến thức

Giả sử bạn thêm một bài viết về biến đổi khí hậu:

```
/wiki-ingest ~/Articles/ipcc-summary-2023.md
```

Plugin sẽ tạo ra:

| Nội dung | Mô tả |
|------|------------|
| **Tóm tắt** | Tổng quan một trang về bài viết |
| **Khái niệm** | Các trang cho ý tưởng chính như "ngân sách carbon" và "điểm tới hạn" |
| **Trang chủ đề** | Trang "khoa học khí hậu" liên kết mọi thứ lại với nhau |

Bây giờ thêm một bài viết thứ hai về chính sách năng lượng. Plugin nhận ra cả hai nguồn đều đề cập đến ngân sách carbon và tự động liên kết chúng.

Khi bạn hỏi:
```
/wiki How do carbon budgets affect energy policy?
```

Bạn nhận được câu trả lời rút ra từ **cả hai** nguồn, kèm liên kết đến chính xác nơi mỗi thông tin được lấy ra.

---

## 🔮 Duyệt wiki bằng Obsidian

Trong quá trình thiết lập, bạn sẽ được hỏi có muốn dùng [Obsidian](https://obsidian.md) không — một ứng dụng miễn phí để duyệt wiki trực quan. Nó được cài tự động nếu bạn đồng ý.

Mở thư mục `knowledge-base/` trong Obsidian và bạn có:

- **Graph View** — bản đồ trực quan tất cả các trang và cách chúng kết nối
- **Backlinks** — nhấn vào bất kỳ trang nào để xem mọi thứ liên kết đến nó
- **Search** — tìm bất cứ thứ gì trong toàn bộ wiki
- **Đồng bộ trực tiếp** — các trang mới từ `/wiki-ingest` hiện ngay trong Obsidian

Đây là tùy chọn. Wiki của bạn hoạt động hoàn toàn tốt chỉ với các lệnh.

---

## 📁 Những gì được tạo ra

```
knowledge-base/
  raw/           Tài liệu gốc của bạn (không bao giờ bị sửa đổi)
  summaries/     Tóm tắt một trang cho mỗi nguồn
  concepts/      Ý tưởng chính, mỗi ý một trang
  topics/        Các trang tổng quan nhóm các ý tưởng liên quan
  insights/      Mối liên hệ phát hiện được giữa các nguồn
  references/    Liên kết đến tài nguyên bên ngoài
  .data/         Dữ liệu nội bộ (ẩn)
```

Tất cả file đều là Markdown thuần. Mở bằng bất kỳ trình soạn thảo nào, Obsidian, hoặc VS Code.

---

## 💡 Mẹo hay

- **Bắt đầu nhỏ.** Thêm 2–3 nguồn và thử `/wiki` trước khi thêm nhiều hơn.
- **Hỏi cụ thể.** "Nguồn X nói gì về Y?" hiệu quả hơn câu hỏi chung chung.
- **Thử `/wiki-insights`** sau khi thêm nhiều nguồn về cùng một chủ đề — nó tìm ra các mẫu hình bạn có thể bỏ lỡ.
- **Nguồn của bạn luôn an toàn.** Plugin không bao giờ thay đổi file gốc của bạn.

---

## ⚙️ Cách thiết lập hoạt động

`/wiki-setup` tự động xử lý mọi thứ dựa trên quy mô dự án của bạn:

| Quy mô | Tìm kiếm | Những gì được cài đặt |
|------|--------|-------------------|
| **Nhỏ** | Tích hợp sẵn | Không cần thêm gì |
| **Vừa** | Tìm kiếm thông minh ([qmd](https://github.com/tobi/qmd)) | Node.js + qmd (tự động cài) |
| **Lớn** | Tìm kiếm nhanh nhất | Node.js + qmd + MCP server (tự động cài và cấu hình) |

Plugin nhận diện hệ điều hành của bạn (macOS, Linux, Windows) và cài đặt mọi thứ bằng phương pháp phù hợp. Nếu có lỗi xảy ra, nó tự chuyển về tìm kiếm tích hợp sẵn — bạn không bao giờ bị kẹt.

---

## 📦 Các cách cài đặt khác

### Từ Claude Code Marketplace (dễ nhất)

```
/plugin marketplace add bradduy/wiki-knowledge-compiler
```
Sau khi thêm, cấu hình trong marketplace:
1. Chạy `/plugin` → chọn tab **Marketplace**
2. Tìm **wiki-knowledge-compiler** và mở ra
3. Nhấn **Enable** và chọn scope — chọn thư mục dự án bạn muốn đặt wiki
4. Xác nhận — bước này cấp quyền cho plugin tạo file và chạy lệnh trong thư mục đó

<p align="center">
  <img src="./assets/user_scope_setting.png" alt="Cài đặt scope" width="100%" />
</p>

### Clone như một dự án độc lập

```bash
git clone https://github.com/bradduy/wiki-knowledge-compiler.git
cd wiki-knowledge-compiler
```

Mở trong Claude Code và chạy `/wiki-setup`.

### Thêm vào dự án hiện có

```bash
git clone https://github.com/bradduy/wiki-knowledge-compiler.git /tmp/wkc
cp -r /tmp/wkc/.claude/ your-project/.claude/
cp -r /tmp/wkc/.claude-plugin/ your-project/.claude-plugin/
cp -r /tmp/wkc/{agents,skills,templates} your-project/
cp /tmp/wkc/CLAUDE.md your-project/CLAUDE.md
cp /tmp/wkc/.data/wiki.config.md your-project/.data/wiki.config.md
bash /tmp/wkc/scripts/init-kb.sh your-project/knowledge-base
rm -rf /tmp/wkc
```

Sau đó chạy `/wiki-setup`.

---

## 📌 Lưu ý thêm

- **Hoạt động offline.** Mọi thứ nằm trên máy tính của bạn.
- **File văn bản thuần.** Không cần database hay phần mềm đặc biệt để đọc wiki.
- **Hỗ trợ PDF.** Bố cục phức tạp (bảng, nhiều cột) có thể không trích xuất hoàn hảo.
- **Thiết kế cho cá nhân.** Một người dùng.
- **Muốn lưu lịch sử phiên bản?** Chạy `git init` trong thư mục knowledge base.

---

## 🤝 Đóng góp

Muốn cải thiện plugin? Xem [hướng dẫn đóng góp](.github/CONTRIBUTING.md) hoặc tạo issue.

## 📄 Giấy phép

MIT

---
