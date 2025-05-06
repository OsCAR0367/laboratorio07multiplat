import 'package:flutter/material.dart';

class H1 extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign; // Agregamos el parámetro opcional para alineación
  
  const H1(this.text, {super.key, this.color, this.textAlign}); // Inicializamos la variable en el constructor
  
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign, // Usamos la propiedad textAlign
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color
      ),
    );
  }
}