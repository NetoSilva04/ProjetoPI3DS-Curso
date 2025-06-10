import 'package:flutter/material.dart';

class TextoMotivadorWidget extends StatelessWidget {
  final String titulo;
  final String conteudo;

  const TextoMotivadorWidget({
    super.key,
    required this.titulo,
    required this.conteudo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple.shade50,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              child: Text(
                conteudo,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 14),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
