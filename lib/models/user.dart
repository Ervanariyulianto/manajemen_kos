import 'dart:convert';

class User {
  final String? id, tanggal, Nama, email, kategori, Telepon, Alamat, catatan;

  User({
    this.id,
    this.tanggal,
    this.Nama,
    this.email,
    this.kategori,
    this.Telepon,
    this.Alamat,
    this.catatan,
  });

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      id: jsonData['id'],
      tanggal: jsonData['tanggal'],
      Nama: jsonData['Nama'],
      email: jsonData['email'],
      kategori: jsonData['kategori'],
      Telepon: jsonData['telepon'],
      Alamat: jsonData['alamat'],
      catatan: jsonData['alamat'],
    );
  }

  static Map<String, dynamic> toMap(User user) => {
        'id': user.id,
        'tanggal': user.tanggal,
        'Nama': user.Nama,
        'email': user.email,
        'kategori': user.kategori,
        'Telepom': user.Telepon,
        'Alamat': user.Alamat,
        'catatan': user.catatan,
      };

  static String encode(List<User> user) => json.encode(
      user.map<Map<String, dynamic>>((user) => User.toMap(user)).toList());

  static List<User> decode(String cats) => (json.decode(cats) as List<dynamic>)
      .map<User>((item) => User.fromJson(item))
      .toList();
}
