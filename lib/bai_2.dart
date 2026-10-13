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
      home: Bai2(),
    );
  }
}

// Hàm nhận điểm, trả về xếp loại (dùng if / else)
String xepLoai(double diem) {
  if (diem < 0 || diem > 10) {
    return 'Không hợp lệ';
  } else if (diem >= 8.0) {
    return 'Giỏi';
  } else if (diem >= 6.5) {
    return 'Khá';
  } else if (diem >= 5.0) {
    return 'Trung bình';
  } else {
    return 'Yếu';
  }
}

// Hàm chọn màu chữ theo xếp loại (cũng dùng if)
Color mauXepLoai(String loai) {
  if (loai == 'Giỏi') {
    return Colors.green;
  } else if (loai == 'Khá') {
    return Colors.blue;
  } else if (loai == 'Trung bình') {
    return Colors.orange;
  } else if (loai == 'Yếu') {
    return Colors.red;
  } else {
    return Colors.grey;
  }
}

class Bai2 extends StatelessWidget {
  const Bai2({super.key});

  @override
  Widget build(BuildContext context) {
    // Biến điểm có giá trị 8.5
    double diem = 8.5;
    String loai = xepLoai(diem);

    // Danh sách điểm để kiểm tra thêm
    List<double> diemKiemTra = [9, 7, 5.5, 3, 11];

    // Dùng for tạo các dòng kiểm tra thêm
    List<Widget> cacDong = [];
    for (int i = 0; i < diemKiemTra.length; i++) {
      double d = diemKiemTra[i];
      String l = xepLoai(d);

      cacDong.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Điểm $d'),
              Text(
                l,
                style: TextStyle(
                  color: mauXepLoai(l),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C4A7C),
        foregroundColor: Colors.white,
        title: const Text('Xếp loại học lực'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Khung điểm trung bình
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text('Điểm trung bình'),
                  Text(
                    '$diem',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    color: Colors.green[50],
                    child: Text(
                      loai,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: mauXepLoai(loai), // màu chọn bằng if
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'KIỂM TRA THÊM',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 8),

            // Khung danh sách kiểm tra thêm
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(children: cacDong),
            ),
          ],
        ),
      ),
    );
  }
}
