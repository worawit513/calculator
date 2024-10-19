import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worawit/HistoryScreen.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  @override
  void initState() {
    super.initState();
    _loadHistory(); // โหลดประวัติการคำนวณเมื่อเปิดแอป
  }

  // โหลดประวัติจากไฟล์ JSON
  void _loadHistory() async {
    setState(() {});
  }

  // บันทึกประวัติการคำนวณ
  void _saveHistory(String expression, String result) async {
    Map<String, dynamic> historyData = await readHistory();
    List<String> history = (historyData['history'] ?? []).cast<String>();
    history.add('$expression = $result');
    await writeHistory({'history': history});
    setState(() {});
  }

  // ฟังก์ชันที่ใช้เมื่อกดปุ่มคำนวณ
  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "×" ||
        buttonText == "÷") {
      num1 = double.parse(_output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == "=") {
      num2 = double.parse(_output);
      if (operand == "+") {
        _output = (num1 + num2).toString();
      } else if (operand == "-") {
        _output = (num1 - num2).toString();
      } else if (operand == "×") {
        _output = (num1 * num2).toString();
      } else if (operand == "÷") {
        _output = (num1 / num2).toString();
      }

      // บันทึกการคำนวณในไฟล์ JSON
      _saveHistory('$num1 $operand $num2', _output);

      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "⌫") {
      // ลบตัวเลขทีละตัว
      if (_output.length > 1) {
        _output = _output.substring(0, _output.length - 1);
      } else {
        _output = "0"; // ถ้ามีตัวเลขเดียว ให้รีเซ็ตเป็น 0
      }
    } else {
      if (_output == "0") {
        _output = buttonText;
      } else {
        _output = _output + buttonText;
      }
    }

    setState(() {});
  }

  // สร้างปุ่มต่าง ๆ บนเครื่องคิดเลข
  Widget buildButton(String buttonText,
      {Color color = Colors.blue, double fontSize = 24.0}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0), // เพิ่มระยะห่างระหว่างปุ่ม
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0), // ขอบปุ่มมน
            ),
            padding: const EdgeInsets.all(24.0),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  // ไปยังหน้าจอประวัติ
  void _goToHistoryScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HistoryScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "เครื่องคิดเลข",
          style: GoogleFonts.itim(
            textStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: _goToHistoryScreen, // กดเพื่อไปยังหน้าจอประวัติ
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(_output, style: const TextStyle(fontSize: 48)),
          ),
          const Expanded(child: Divider()),
          Column(children: [
            Row(children: [
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildButton("÷", color: Colors.orange),
            ]),
            Row(children: [
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildButton("×", color: Colors.orange),
            ]),
            Row(children: [
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildButton("-", color: Colors.orange),
            ]),
            Row(children: [
              buildButton("."),
              buildButton("0"),
              buildButton("⌫", color: Colors.red), // ปุ่ม Backspace
              buildButton("+", color: Colors.orange),
            ]),
            Row(children: [
              buildButton("C", color: Colors.grey),
              buildButton("=", color: Colors.green),
            ]),
          ])
        ],
      ),
    );
  }
}
