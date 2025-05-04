# 🍔 FastFood App – Ứng dụng bán đồ ăn nhanh

Ứng dụng **FastFood App** là sản phẩm di động đa nền tảng được xây dựng bằng Flutter, hỗ trợ người dùng **đặt món, thanh toán, quản lý tài khoản, trò chuyện hỗ trợ** và nhiều tính năng tiện ích khác. Dự án được phát triển với mục tiêu mô phỏng một hệ thống bán hàng thực tế, phục vụ mục đích học tập và nghiên cứu.

## 📱 Tính năng nổi bật
- Màn hình chờ
- 🔐 Đăng ký, đăng nhập và xác thực người dùng qua Firebase Authentication
- ❓ Quên mật khẩu, đổi mật khẩu
- 📍 Quản lý địa chỉ giao hàng
- 💬 Chat với AI 
- 🛒 Đặt món, quản lý giỏ hàng (nâng cấp trong các phiên bản sau)
- 💳 Thanh toán đơn hàng 
- 📦 Lưu lịch sử đặt hàng (nâng cấp trong các phiên bản sau)

## 🛠️ Công nghệ sử dụng

- **Flutter 3.x** – Framework phát triển ứng dụng đa nền tảng
- **Dart** – Ngôn ngữ lập trình chính
- **Firebase** (Authentication, Firestore, Storage)
- **Firebase Authenticationt** - Xác thực người dùng 
- **Cloud Firestore** – Lưu trữ dữ liệu realtime
- **Firebase Storage** – Quản lý hình ảnh sản phẩm, avatar,...

## 🧩 Cấu trúc dự án (ví dụ)
_lib_

- models/  Định nghĩa các lớp dữ liệu (User, Product, Order...)
- components/ Dùng cho toàn app
- services/  Tầng kết nối Firebase (AuthService, FirestoreService...)
- pages (Home, Login, Register...)
- widgets/ Các widget tái sử dụng
- main.dart/  Điểm khởi chạy ứng dụng
- resources/ Bổ sung thêm về màu sắc và phong cách 
- utils/ tiện ích 
- gen/ truy cập đến icon và images

## 📦 Cài đặt và chạy ứng dụng

```bash
# 1. Clone dự án về máy
git clone https://github.com/DSTAN03/DSTAN.git
cd DSTAN

# 2. Cài đặt dependencies
flutter pub get

# 3. Chạy ứng dụng
flutter run

# 4.  Chạy test 
flutter test
