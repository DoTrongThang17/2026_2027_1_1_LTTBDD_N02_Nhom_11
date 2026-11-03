String doiThoiGian(Duration d) {
  final phut = d.inMinutes;
  final giay = d.inSeconds % 60;
  return '$phut:${giay.toString().padLeft(2, '0')}';
}

String soGon(int n) {
  if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
  if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
  return '$n';
}
