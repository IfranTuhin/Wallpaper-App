import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/photos_model.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/widgets/wallpaper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  List<PhotosModel> photos = [];
  bool search = false;

  getSearchWallpaper(String searchQuery) async {
    await http.get(
      Uri.parse("https://api.pexels.com/v1/search?query=$searchQuery&per_page=100"),
      headers: {
        "Authorization": "qwaYE5zqBErQbLUTtB3wJHO7fHhtCeUiUXuuVDbaSf1oYPbvP1S9Th34"
      },
    ).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        PhotosModel photosModel = PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
      });
      setState(() { search = true;});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              // Search Text
              const Center(
                child: Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        getSearchWallpaper(searchController.text);
                      },
                      child: search ? GestureDetector(
                        onTap: () {
                          photos = [];
                          search = false;
                          searchController.clear();
                          setState(() {

                          });
                        },
                        child: const Icon(
                          Icons.close,
                          color: Color.fromARGB(255, 84, 87, 93),
                          size: 28,
                        ),
                      ) : const Icon(
                        Icons.search_outlined,
                        color: Color.fromARGB(255, 84, 87, 93),
                        size: 28,
                      )  ,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(child: wallpaper(photos, context)),
            ],
          ),
        ),
      ),
    );
  }
}
