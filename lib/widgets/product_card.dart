import 'package:flutter/material.dart';
import 'package:katalog_produk/utils/format.dart';

/// Widget kustom (reusable) untuk menampilkan satu produk.
class ProductCard extends StatelessWidget {
  final String nama;
  final int harga;
  final IconData ikon;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const ProductCard({
    super.key,
    required this.nama,
    required this.harga,
    required this.onTap,
    this.ikon = Icons.inventory_2,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ), // BoxDecoration
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(ikon, size: 40, color: Colors.deepPurple),
                if (onDelete != null)
                  InkWell(
                    onTap: onDelete,
                    child: const Icon(Icons.delete_outline, color: Colors.red),
                  ), // InkWell
              ],
            ), // Row
            const Spacer(),
            Text(
              nama,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ), // Text
            const SizedBox(height: 4),
            Text(
              formatRupiah(harga),
              style: const TextStyle(color: Colors.grey),
            ), // Text
          ],
        ), // Column
      ), // Container
    ); // GestureDetector
  }
}
