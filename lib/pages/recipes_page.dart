import 'package:demo_app/models/recipe.dart';
import 'package:demo_app/pages/components/custome_app_bar.dart';
import 'package:demo_app/pages/recipe_page.dart';
import '../../services/data_service.dart';
import 'package:flutter/material.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RecipesPageState();
  }
}

class _RecipesPageState extends State<RecipesPage> {
  late Future<List<Recipe>?> _recipesList;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  void getRecipes({String? mealType}) {
    setState(() {
      _recipesList = DataService().getRecipes(mealType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(flex: 1, child: _buildSearchButtons()),
              Expanded(flex: 7, child: _buildRecipeList()),
            ],
          ),
        ));
  }

  PreferredSizeWidget _appBar() {
    return const CustomAppBar(
      title: '🧆 Recipe Details',
    );
  }

  Widget _buildSearchButtons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ElevatedButton(
              onPressed: () {
                getRecipes(mealType: "snack");
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.green[400]),
              child: const Text("Snack"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ElevatedButton(
              onPressed: () {
                getRecipes(mealType: "breakfast");
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.green[400]),
              child: const Text("Breakfast"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ElevatedButton(
              onPressed: () {
                getRecipes(mealType: "lunch");
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.green[400]),
              child: const Text("Lunch"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ElevatedButton(
              onPressed: () {
                getRecipes(mealType: "dinner");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[400],
              ),
              child: const Text("Dinner"),
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder _buildRecipeList() {
    return FutureBuilder(
        future: _recipesList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Couldn't load the data"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("No data available")));
          }

          return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Recipe product = snapshot.data![index];

                return Material(
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text("${product.cuisine} ${product.difficulty}"),
                    leading: Image.network(product.image),
                    trailing: Text(
                      "${product.rating} ⭐",
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RecipePage(recipe: product)));
                    },
                  ),
                );
              });
        });
  }
}
