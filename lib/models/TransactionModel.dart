import 'package:flutter/cupertino.dart';

class TransactionModel {
  String? id;
  num? transactionType;
  num? transactionAction;
  String? date;
  String? fullDate;
  num? status;
  num? amount;

  TransactionModel({
    this.id,
    this.transactionType,
    this.transactionAction,
    this.status,
    this.date,
    this.fullDate,
    this.amount,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      // id: json['id'],
      transactionType: json['transactionType'],
      transactionAction: json['transactionAction'],
      date: json['date'],
      status: json['status'],
      amount: json['amount'] != null ? json['amount'] : 0,
      // buildingName: json['buildingName'],
      // orderNum: json['orderNum'],
      // priority: json['priority'],
      // status: json['status'],
    );
  }
}
