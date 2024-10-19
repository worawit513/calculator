import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  // โหลดและแสดงประวัติการคำนวณ
  Future<Map<String, dynamic>> loadHistory() async {
    return await readHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "ประวัติ",
          style: GoogleFonts.itim(
            textStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: loadHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading history"));
          } else if (!snapshot.hasData || snapshot.data!['history'] == null) {
            return const Center(child: Text("No history available"));
          } else {
            List<String> history =
                (snapshot.data!['history'] as List<dynamic>).cast<String>();
            return ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(history[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}

// ฟังก์ชันที่ใช้จัดการกับไฟล์ JSON
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/history.json');
}

Future<File> writeHistory(Map<String, dynamic> historyData) async {
  final file = await _localFile;
  return file.writeAsString(json.encode(historyData));
}

Future<Map<String, dynamic>> readHistory() async {
  try {
    final file = await _localFile;
    String contents = await file.readAsString();
    return json.decode(contents);
  } catch (e) {
    return {};
  }
}
