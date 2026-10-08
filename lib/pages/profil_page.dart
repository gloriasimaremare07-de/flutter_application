import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ), // CircleAvatar
            SizedBox(height: 16),
            // TODO: ganti dengan nama dan NIM Anda
            Text(
              'Nama Mahasiswa',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ), // Text
            SizedBox(height: 4),
            Text('NIM 000000000', style: TextStyle(color: Colors.grey)),
          ],
        ), // Column
      ), // Center
    ); // Scaffold
  }
}
