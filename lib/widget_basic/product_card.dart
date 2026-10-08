import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String nama;
  final int harga;
  final VoidCallback onTap;
  final IconData ikon;
  final VoidCallback? onHapus;

  const ProductCard({
    super.key,
    required this.nama,
    required this.harga,
    required this.onTap,
    this.ikon = Icons.shopping_bag,
    this.onHapus,
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
        ),
        child: Row(
          children: [
            Icon(ikon, size: 36, color: Colors.grey[700]),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp $harga',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            if (onHapus != null)
              IconButton(
                onPressed: onHapus,
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}