# 🛒 Flutter E-Commerce App


A modern, production-ready E-commerce mobile application built with **Flutter**, using **BLoC State Management**, **REST API Integration**, and **Hive Local Storage**.

---

## 🚀 Overview

This project demonstrates a complete mobile E-commerce workflow including:

- User Authentication
- Product Browsing
- Cart & Wishlist Management
- Order Placement
- SSL Payment Gateway Integration
- Profile Management
- API Driven Architecture

Built with scalable architecture and clean code principles.

---

## 📱 Features

### 🔐 Authentication
- Login
- Signup
- Token-based authentication
- Secure Hive storage

### 🏠 Home
- Banner Slider
- Category List
- Popular Products

### 🛍 Products
- Product List by Category
- Product Details Screen
- Add to Cart
- Add to Wishlist

### 🛒 Cart
- Cart List
- Quantity Control
- Remove Item
- Dynamic Total Calculation

### ❤️ Wishlist
- Add to Wishlist
- Remove from Wishlist
- Persistent API sync

### 💳 Order & Payment
- Shipping Address Submission
- Order Creation API
- SSL Payment Integration (WebView)
- Payment Redirect Handling
- Backend Verification

### 👤 Profile
- Fetch Profile from API
- Update Profile
- Instant UI Refresh using BLoC

---

### Architecture Principles

- Feature-first folder structure
- BLoC state management
- Repository-style API service layer
- Model-based JSON parsing
- Separation of UI & Business Logic

---

## 🛠 Technologies Used

- Flutter
- Dart
- flutter_bloc
- Hive
- http
- go_router
- webview_flutter

---

## ⚙️ Installation

```bash
git clone https://github.com/bappyguria/ecommerce.git
cd ecommerce
flutter pub get
flutter run
```

---

## 💳 Payment Flow

```
Checkout
   ↓
Create Order API
   ↓
Receive Payment URL
   ↓
Open WebView
   ↓
Redirect Success
   ↓
Verify Payment
   ↓
Order Confirmed
```

Supports SSL Payment Gateway integration.

---

## 📸 Screenshots

| E-commerce App Screen |
|-------------|
| ![E-commerce](assets/images/app_prevwe.png) |

---

## 🔐 Security

- Token-based API authentication
- Secure storage using Hive
- Payment verification handled by backend

---


## 👨‍💻 Developer

**Bappy Guria**

GitHub: https://github.com/bappyguria

---

## ⭐ Support

If you like this project, give it a ⭐ on GitHub!

---

## 📄 License

This project is for learning and demonstration purposes.
