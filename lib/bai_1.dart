import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Class Student: email và phone có thể null (kiểu String?)
class Student {
  String name;
  String? email;
  String? phone;

  Student(this.name, this.email, this.phone);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bai1(),
    );
  }
}

class Bai1 extends StatelessWidget {
  Bai1({super.key});

  // Danh sách 5 sinh viên, có người thiếu email hoặc phone (null)
  final List<Student> danhSach = [
    Student('Nguyễn Văn An', 'an@sv.edu.vn', '0901 234 567'),
    Student('Trần Thị Bình', null, '0912 888 999'),
    Student('Lê Minh Chi', 'chi@sv.edu.vn', null),
    Student('Phạm Quốc Dũng', null, null),
    Student('Võ Thanh Em', 'em@sv.edu.vn', '0933 111 222'),
  ];

  @override
  Widget build(BuildContext context) {
    // Dùng for để tạo các thẻ sinh viên
    List<Widget> cacThe = [];
    for (int i = 0; i < danhSach.length; i++) {
      Student sv = danhSach[i];

      // Toán tử ?? : nếu null thì dùng chữ "Chưa cập nhật"
      String email = sv.email ?? 'Chưa cập nhật';
      String phone = sv.phone ?? 'Chưa cập nhật';

      cacThe.add(
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sv.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Email: $email',
                // Nếu null thì chữ màu đỏ
                style: TextStyle(
                  fontSize: 12,
                  color: sv.email == null ? Colors.red : Colors.black54,
                ),
              ),
              Text(
                'SĐT: $phone',
                style: TextStyle(
                  fontSize: 12,
                  color: sv.phone == null ? Colors.red : Colors.black54,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Dùng for để đếm số sinh viên thiếu email
    int thieuEmail = 0;
    for (int i = 0; i < danhSach.length; i++) {
      if (danhSach[i].email == null) {
        thieuEmail++;
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C4A7C),
        foregroundColor: Colors.white,
        title: const Text('Danh sách sinh viên'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...cacThe, // dấu ... để đưa cả danh sách thẻ vào Column
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.blue[50],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tổng: ${danhSach.length} sinh viên'),
                  Text('Thiếu email: $thieuEmail'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
