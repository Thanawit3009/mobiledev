import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../services/api_service.dart';

class PokemonRepositoryImpl implements IPokemonRepository {
  final ApiService api;

  PokemonRepositoryImpl(this.api);

  @override
  Future<List<Pokemon>> getPokemons({int limit = 30}) async {
    final raw = await api.fetchPokemonsRaw(limit: limit);
    // PokeAPI ให้ url แบบ .../pokemon/1/ .../pokemon/25/ → ดึงเลขท้ายมาสร้าง image URL
    return raw.map((e) {
      final name = (e['name'] as String);
      final url = (e['url'] as String);
      final id = RegExp(r'pokemon/(\d+)/').firstMatch(url)?.group(1) ?? '1';
      final image = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
      return Pokemon(name: name, imageUrl: image);
    }).toList();
  }
}
