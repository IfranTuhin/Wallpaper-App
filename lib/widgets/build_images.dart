
import 'package:flutter/material.dart';

Widget buildImages(String urlImage, int index, BuildContext context) => Container(
  margin: const EdgeInsets.only(left: 10),
  height: MediaQuery.of(context).size.height / 1.5,
  width: MediaQuery.of(context).size.width,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Image.asset(
      urlImage,
      fit: BoxFit.cover,
    ),
  ),
);