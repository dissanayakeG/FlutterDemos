import 'package:http/http.dart' as http;
import 'package:newproject/models/Users.dart';
import 'package:newproject/models/photos.dart';

class Service {
  static const String usersUrl = "https://jsonplaceholder.typicode.com/users";
  static const String photosUrl = "https://jsonplaceholder.typicode.com/photos";

  static Future<List<User>> getUsers() async {
    try {
      final response = await http.get(usersUrl);
      if (200 == response.statusCode) {
        final List<User> users = usersFromJson(response.body);
        return users;
      } else {
        return List<User>();
      }
    } catch (e) {
      return List<User>();
    }
  }

  static Future<List<Photo>> getPhotos() async {
    try {
      final response = await http.get(photosUrl);
      if (200 == response.statusCode) {
        final List<Photo> photos = photosFromJson(response.body);
        return photos;
      } else {
        return List<Photo>();
      }
    } catch (e) {
      return List<Photo>();
    }
  }
}
