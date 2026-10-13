import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ThucHanh3(),
    );
  }
}

// Màn hình có state (thay đổi được) nên dùng StatefulWidget
class ThucHanh3 extends StatefulWidget {
  const ThucHanh3({super.key});

  @override
  State<ThucHanh3> createState() => _ThucHanh3State();
}

class _ThucHanh3State extends State<ThucHanh3> {
  // Controller để lấy chữ người dùng gõ trong TextField
  final TextEditingController soA = TextEditingController();
  final TextEditingController soB = TextEditingController();

  // State: phép toán đang chọn và kết quả
  String phepToan = '+';
  String ketQua = '';

  // Hàm tính toán
  void tinh() {
    double? a = double.tryParse(soA.text);
    double? b = double.tryParse(soB.text);

    // Chưa nhập đủ 2 số thì chưa tính
    if (a == null || b == null) {
      ketQua = '';
      return;
    }

    double kq = 0;
    if (phepToan == '+') {
      kq = a + b;
    } else if (phepToan == '-') {
      kq = a - b;
    } else if (phepToan == 'x') {
      kq = a * b;
    } else if (phepToan == '/') {
      if (b == 0) {
        ketQua = 'Không chia được cho 0';
        return;
      }
      kq = a / b;
    }

    // Nếu kết quả là số nguyên (8.0) thì hiện 8
    if (kq == kq.toInt()) {
      ketQua = kq.toInt().toString();
    } else {
      ketQua = kq.toString();
    }
  }

  // Tạo 1 nút phép toán
  Widget nutPhepToan(String ky, Color mau) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            // Nút đang chọn có màu đậm, các nút khác màu xám
            backgroundColor: phepToan == ky ? mau : Colors.grey[300],
            foregroundColor: phepToan == ky ? Colors.white : Colors.black,
          ),
          onPressed: () {
            setState(() {
              phepToan = ky;
              tinh();
            });
          },
          child: Text(ky, style: const TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thực hành 03')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Ô nhập số thứ nhất
            TextField(
              controller: soA,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Số thứ nhất',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  tinh();
                });
              },
            ),
            const SizedBox(height: 16),

            // 4 nút phép toán
            Row(
              children: [
                nutPhepToan('+', Colors.red),
                nutPhepToan('-', Colors.orange),
                nutPhepToan('x', Colors.purple),
                nutPhepToan('/', Colors.black),
              ],
            ),
            const SizedBox(height: 16),

            // Ô nhập số thứ hai
            TextField(
              controller: soB,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Số thứ hai',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  tinh();
                });
              },
            ),
            const SizedBox(height: 24),

            // Hiển thị kết quả
            Text(
              'Kết quả: $ketQua',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
