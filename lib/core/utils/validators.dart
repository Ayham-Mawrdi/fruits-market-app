bool isValidExpiryDate(String input) {
  if (input.length != 5) return false;
  final parts = input.split('/');
  if (parts.length != 2) return false;
  final month = int.tryParse(parts[0]);
  final year = int.tryParse(parts[1]);
  if (month == null || year == null) return false;
  if (month < 1 || month > 12) return false;

  final now = DateTime.now();
  final fourDigitYear = 2000 + year;
  final lastDateOfMonth = DateTime(fourDigitYear, month + 1, 0);

  return lastDateOfMonth.isAfter(now);
}