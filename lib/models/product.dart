import 'package:flutter/material.dart';

/// Model data produk (seperti class Barang pada modul OOP).
class Product {
  final String nama;
  final int harga;
  final String deskripsi;
  final IconData ikon;

  const Product({
    required this.nama,
    required this.harga,
    this.deskripsi = 'Belum ada deskripsi untuk produk ini.',
    this.ikon = Icons.inventory_2,
  });
}
