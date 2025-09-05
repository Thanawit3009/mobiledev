import 'package:get/get.dart';

class ApiService extends GetConnect {
  Future<List<Map<String, dynamic>>> fetchPokemonsRaw({int limit = 30}) async {
    final res = await get('https://pokeapi.co/api/v2/pokemon?limit=$limit');
    if (res.statusCode == 200 && res.body != null) {
      final results = (res.body['results'] as List);
      return results.cast<Map<String, dynamic>>();
    }
    return [];
  }
}
