/// Mengubah 350000 menjadi "Rp 350.000".
String formatRupiah(int angka) {
  final s = angka.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    final sisa = s.length - i;
    buffer.write(s[i]);
    if (sisa > 1 && sisa % 3 == 1) buffer.write('.');
  }
  return 'Rp $buffer';
}
