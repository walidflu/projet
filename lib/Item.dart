import 'package:flutter/material.dart';



class Item {
  final int id;
  final String title;
  final DateTime creationDate;
  int quantity;
  double price;

  Item({
    required this.id,
    required this.title,
    required this.creationDate,
    this.quantity = 0,
    this.price = 0,
  });
}