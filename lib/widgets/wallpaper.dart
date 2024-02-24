import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/photos_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wallpaper_app/screen/categories/full_screen.dart';

Widget wallpaper(List<PhotosModel> listPhotos, BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: GridView.count(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 15),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: listPhotos.map((PhotosModel photosModel) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => FullScreen(imagePath: photosModel.src!.portrait!),));
            },
            child: Hero(
              tag: photosModel.src!.portrait!,
              child: CachedNetworkImage(
                imageUrl: photosModel.src!.portrait!,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
