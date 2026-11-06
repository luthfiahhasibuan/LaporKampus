const List<String> _months = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember',
];

String _two(int n) => n.toString().padLeft(2, '0');

String formatDate(DateTime d) =>
    '${d.day} ${_months[d.month - 1].substring(0, 3)} ${d.year}';

String formatDateTime(DateTime d) =>
    '${_two(d.day)} ${_months[d.month - 1]} ${d.year}, '
    '${_two(d.hour)}:${_two(d.minute)}';
