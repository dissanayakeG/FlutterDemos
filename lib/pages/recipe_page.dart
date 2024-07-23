import 'package:demo_app/models/recipe.dart';
import 'package:demo_app/pages/components/custome_app_bar.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: '🧆 Recipe Details',
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                // Add share functionality here
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  recipe.image,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Rating ${recipe.rating} ⭐",
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ));
  }
}
