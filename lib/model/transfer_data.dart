import 'dart:convert';

class TransferData {
  double amount;
  String senderName;
  String receiverName;
  double senderBalance;
  double receiverBalance;

  TransferData({
    required this.amount,
    required this.senderName,
    required this.receiverName,
    required this.senderBalance,
    required this.receiverBalance,
  });

  TransferData copyWith({
    double? amount,
    String? senderName,
    String? receiverName,
    double? senderBalance,
    double? receiverBalance,
  }) {
    return TransferData(
      amount: amount ?? this.amount,
      senderName: senderName ?? this.senderName,
      receiverName: receiverName ?? this.receiverName,
      senderBalance: senderBalance ?? this.senderBalance,
      receiverBalance: receiverBalance ?? this.receiverBalance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'senderName': senderName,
      'receiverName': receiverName,
      'senderBalance': senderBalance,
      'receiverBalance': receiverBalance,
    };
  }

  factory TransferData.fromMap(Map<String, dynamic> map) {
    return TransferData(
      amount: map['amount']?.toDouble() ?? 0.0,
      senderName: map['senderName'] ?? '',
      receiverName: map['receiverName'] ?? '',
      senderBalance: map['senderBalance']?.toDouble() ?? 0.0,
      receiverBalance: map['receiverBalance']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransferData.fromJson(String source) =>
      TransferData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransferData(amount: $amount, senderName: $senderName, receiverName: $receiverName, senderBalance: $senderBalance, receiverBalance: $receiverBalance)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransferData &&
        other.amount == amount &&
        other.senderName == senderName &&
        other.receiverName == receiverName &&
        other.senderBalance == senderBalance &&
        other.receiverBalance == receiverBalance;
  }

  @override
  int get hashCode {
    return amount.hashCode ^
        senderName.hashCode ^
        receiverName.hashCode ^
        senderBalance.hashCode ^
        receiverBalance.hashCode;
  }
}
