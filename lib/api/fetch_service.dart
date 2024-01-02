import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_config.dart';
import '../models/movie.dart';

class FetchService {
  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse(
      '${APIConfig.baseUrl}/movie/popular?api_key=${APIConfig.apiKey}',
    ));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'] as List;
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching movies');
    }
  }
}