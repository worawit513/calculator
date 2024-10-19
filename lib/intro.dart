import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worawit/calculatorscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // ตั้งเวลาให้ Splash Screen แสดงผล 3 วินาที ก่อนเข้าสู่หน้าหลัก
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const CalculatorApp()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // กำหนดพื้นหลังเป็นสีขาว
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // แสดงโลโก้
            Image.asset(
              'assets/images/logo.png', // ใส่ path ของโลโก้ที่เตรียมไว้
              height: 150.0, // กำหนดขนาดของโลโก้
            ),
            const SizedBox(height: 20.0),

            // แสดงชื่อแอป
            Text(
              'เครื่องคิดเลข',
              style: GoogleFonts.itim(
                textStyle: const TextStyle(
                  fontSize: 40.0, // ขนาดฟอนต์
                  fontWeight: FontWeight.bold, // ตัวหนา
                  color: Colors.black, // สีข้อความ
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
