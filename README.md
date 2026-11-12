# 🎵 Nhóm 11 — Ứng dụng Nghe Nhạc Di Động

Ứng dụng nghe nhạc trên thiết bị di động lấy cảm hứng từ **SoundCloud**, được phát triển bằng **Flutter**. Dự án tập trung vào trải nghiệm tương tác âm nhạc trực quan thông qua thanh sóng âm và hệ thống bình luận theo mốc thời gian thực của bài hát.

---

## 📋 Thông tin môn học & Nhóm thực hiện

- **Môn học:** Lập trình cho thiết bị di động
- **Lớp:** N02 — **Nhóm:** 11
- **Giảng viên hướng dẫn:** Nguyễn Xuân Quế

| Vai trò | Họ và tên | Mã sinh viên |
| :---: | :--- | :---: |
| **Nhóm trưởng** | Đỗ Trọng Thắng | `24100316` |
| **Thành viên** | Nguyễn Anh Tuấn | `24100400` |
| **Thành viên** | Nguyễn Thế Tuấn | `24100315` |

---

## ✨ Tính năng nổi bật

### 🔥 Điểm nhấn đặc trưng (SoundCloud-inspired)
- **Thanh sóng âm (Waveform):** Hiển thị biên độ âm thanh trực quan, hỗ trợ chạm/vuốt trực tiếp trên sóng âm để tua nhanh.
- **Bình luận theo thời điểm (Timed Comments):** Cho phép người dùng để lại bình luận gắn với từng giây cụ thể của bài hát và hiển thị đồng bộ khi nhạc phát tới mốc đó.

### 🎧 Trình phát nhạc & Tiện ích
- Phát nhạc cục bộ (`assets`) mượt mà với đầy đủ điều khiển: Phát / Tạm dừng, Bài trước / Bài sau và **Mini Player** xuyên suốt ứng dụng.
- Tùy chỉnh tốc độ phát (`0.5x` – `2.0x`) và điều chỉnh âm lượng.
- Hẹn giờ tắt nhạc tự động với các mốc: `1`, `15`, `30`, `45`, `60` phút.

### 🔍 Khám phá & Cá nhân hóa
- **Trang chủ & Feed:** Gợi ý bài hát, duyệt theo thể loại và trang chi tiết nghệ sĩ (sắp xếp theo *Phổ biến / Mới nhất / A-Z*).
- **Bảng xếp hạng:** Thống kê top bài hát theo 3 tiêu chí: *Nghe nhiều nhất / Yêu thích nhất / Nhiều bình luận nhất*.
- **Quản lý thư viện:** Thích bài hát, theo dõi nghệ sĩ, tạo/đổi tên/xóa Playlist và tính năng tải lên bài hát (giả lập).
- **Tìm kiếm thông minh:** Tìm kiếm bài hát/nghệ sĩ kèm lưu trữ lịch sử tìm kiếm cục bộ.

### ⚙️ Hệ thống
- Chuyển đổi linh hoạt **Giao diện Sáng / Tối** (Light / Dark Mode).
- Hỗ trợ **Đa ngôn ngữ**: Tiếng Việt / English.
- Tích hợp trang thông tin nhóm ngay trong ứng dụng.

---

## 🛠️ Công nghệ & Thư viện chính

- **Framework:** Flutter & Dart
- **Xử lý âm thanh:** `just_audio`
- **Lưu trữ cục bộ:** `shared_preferences` (lưu lịch sử tìm kiếm, cấu hình giao diện, ngôn ngữ)

---
