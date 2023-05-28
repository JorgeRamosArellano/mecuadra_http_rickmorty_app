import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class FavoriteButton extends StatefulWidget {
  final Function onPressed;
  bool favoriteColor;
  FavoriteButton(
      {Key? key, required this.onPressed, this.favoriteColor = false})
      : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50,
      elevation: 0,
      color: widget.favoriteColor ? Colors.green : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Color.fromARGB(255, 84, 212, 88),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.favoriteColor ? Icons.favorite : Icons.favorite_border,
            color: widget.favoriteColor
                ? Colors.white
                : Color.fromARGB(255, 84, 212, 88),
          ),
          Text(
            widget.favoriteColor ? ' En favoritos' : ' Añadir a favoritos',
            style: GoogleFonts.raleway(
              fontWeight: FontWeight.bold,
              color: widget.favoriteColor
                  ? Colors.white
                  : const Color.fromARGB(255, 84, 212, 88),
            ),
          ),
        ],
      ),
      onPressed: () {
        widget.onPressed();
        setState(() {
          widget.favoriteColor = !widget.favoriteColor;
        });
      },
    );
  }
}
