import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Class Student: score có thể null (double?) vì có người chưa có điểm
class Student {
  String name;
  double? score;

  Student(this.name, this.score);
}

// Hàm xếp loại (dùng lại từ Bài 2)
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bai3(),
    );
  }
}

class Bai3 extends StatelessWidget {
  Bai3({super.key});

  // Dữ liệu: An 9.0 · Bình 7.2 · Chi (chưa có) · Dũng 4.5 · Em 5.8
  final List<Student> danhSach = [
    Student('Nguyễn Văn An', 9.0),
    Student('Trần Thị Bình', 7.2),
    Student('Lê Minh Chi', null),
    Student('Phạm Quốc Dũng', 4.5),
    Student('Võ Thanh Em', 5.8),
  ];

  @override
  Widget build(BuildContext context) {
    // Các biến thống kê
    double tong = 0;
    int soCoDiem = 0;
    int soGioi = 0;
    int soChuaCoDiem = 0;
    double diemCaoNhat = 0;

    // Dùng for + if để tính
    for (int i = 0; i < danhSach.length; i++) {
      double? diem = danhSach[i].score;

      if (diem == null) {
        soChuaCoDiem++; // chưa có điểm thì chỉ đếm, bỏ qua không tính TB
      } else {
        tong = tong + diem;
        soCoDiem++;

        if (diem >= 8.0) {
          soGioi++;
        }
        if (diem > diemCaoNhat) {
          diemCaoNhat = diem;
        }
      }
    }

    double trungBinh = 0;
    if (soCoDiem > 0) {
      trungBinh = tong / soCoDiem;
    }

    // Dùng for tạo các dòng sinh viên
    List<Widget> cacDong = [];
    for (int i = 0; i < danhSach.length; i++) {
      Student sv = danhSach[i];

      String loai = 'Chưa có điểm';
      String diemText = '—';
      Color mau = Colors.grey;

      if (sv.score != null) {
        loai = xepLoai(sv.score!); // dấu ! vì đã kiểm tra khác null
        diemText = sv.score.toString();
        mau = mauXepLoai(loai);
      }

      cacDong.add(
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sv.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(loai, style: TextStyle(fontSize: 12, color: mau)),
                ],
              ),
              Text(
                diemText,
                style: const TextStyle(
                  fontSize: 20,
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
        title: const Text('Bảng điểm lớp'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Khung thống kê
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF2C4A7C),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Điểm trung bình lớp',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    trungBinh.toStringAsFixed(2), // làm tròn 2 chữ số
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Giỏi: $soGioi',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Chưa có điểm: $soChuaCoDiem',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Cao nhất: $diemCaoNhat',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Text(
              'DANH SÁCH · ${danhSach.length} SINH VIÊN',
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 8),

            ...cacDong,
          ],
        ),
      ),
    );
  }
}
