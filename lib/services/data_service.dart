import 'package:demo_app/models/recipe.dart';
import 'http_service.dart';

class DataService {
  static final DataService _singleton = DataService._internal();

  final HttpService _httpService = HttpService();

  factory DataService() {
    return _singleton;
  }

  DataService._internal();

  Future<List<Recipe>?> getRecipes(String? mealType) async {
    try {
      var path = "/recipes";

      if (mealType != null) {
        // path = "/recipes/meal-type/${mealType}";
        path += "/meal-type/$mealType";
      }

      final response = await _httpService.get(path);

      if (response!.statusCode == 200 && response.data != null) {
        List data = response.data["recipes"];

        List<Recipe> products =
            data.map((toElement) => Recipe.fromJson(toElement)).toList();

        return products;
      } else {
        print("Response is null or status code is not 200");
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
