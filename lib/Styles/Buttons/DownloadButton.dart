import 'package:flutter/material.dart';

class DownloadButton extends StatelessWidget {
  // Flutter download button style, args: (context, onPressed)
  final Function onPressed;

  const DownloadButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.download),
          SizedBox(width: 10),
          Text('Descargar'),
        ],
      ),
    );
  }
}
