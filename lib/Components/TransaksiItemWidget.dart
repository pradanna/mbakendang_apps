import 'package:flutter/material.dart';
import 'package:mbakendang/Components/helper.dart';

class TransaksiItemWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int quantity;
  final int price;
  final int total;

  const TransaksiItemWidget({
    required this.imageUrl,
    required this.name,
    required this.quantity,
    required this.price,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            // Gambar item
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12),
            // Informasi item
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text('Qty: $quantity', style: TextStyle(fontSize: 14)),
                  Text('Harga: '+formatRupiah(price), style: TextStyle(fontSize: 14)),
                  SizedBox(height: 4),
                  Text('Total: '+formatRupiah(total), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
