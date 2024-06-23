# Bus Seat Booking App

## Overview

The Bus Seat Booking App is a mobile application developed using Flutter and Firebase. The app provides an intuitive interface for users to book bus seats, view their bookings, and validate tickets using QR codes. It includes features for different user roles, including regular users, admins, and super admins, to manage and oversee bookings.

## Features

- *User Authentication:* Secure login and registration using Firebase Authentication.
- *Seat Booking:* Users can select and book seats for different bus routes.
- *Admin and Super Admin Roles:* Special roles for managing bookings and users.
- *QR Code Generation:* QR codes are generated using JWT for ticket validation.
- *Real-time Updates:* Utilizes Firebase Streams for real-time data updates.
- *User-friendly Interface:* Intuitive UI built with Flutter.

## Installation

1. *Clone the repository:*

    bash
    git clone https://github.com/yourusername/bus-seat-booking-app.git
    cd bus-seat-booking-app
    

2. *Install dependencies:*

    bash
    flutter pub get
    

3. *Set up Firebase:*

    - Create a Firebase project and configure it for Android and iOS.
    - Enable Firebase Authentication, Firestore, and any other required services.
    - Download the google-services.json (for Android) and GoogleService-Info.plist (for iOS) and place them in the respective directories.

4. *Run the app:*

    bash
    flutter run
    

## Usage

### User Roles

- *Regular Users:* Can register, log in, view available bus routes, select and book seats, and view their bookings.
- *Admin:* Can manage bus routes, view all bookings, and manage users.
- *Super Admin:* Has all the privileges of an admin plus the ability to add or remove admin accounts.

### QR Code Generation

QR codes are generated using JWT (JSON Web Tokens) to ensure secure and tamper-proof ticket validation. The QR codes can be scanned by bus conductors or admin staff to validate bookings.

### Real-time Updates

The app uses Firebase Streams to provide real-time updates to users. This ensures that any changes in seat availability, booking status, or user data are immediately reflected in the app.

## Directory Structure

```plaintext
lib/
├── main.dart
├── screens/
│   ├── login_screen.dart
│   ├── registration_screen.dart
│   ├── home_screen.dart
│   ├── booking_screen.dart
│   ├── admin_dashboard.dart
│   └── super_admin_dashboard.dart
├── services/
│   ├── authentication_service.dart
│   ├── booking_service.dart
│   ├── qr_code_service.dart
│   └── firebase_stream_service.dart
├── models/
│   ├── user_model.dart
│   └── booking_model.dart
├── widgets/
│   ├── custom_button.dart
│   └── seat_selector.dart
└── utils/
    └── constants.dart
