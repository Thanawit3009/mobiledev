import '../entities/pokemon.dart';

abstract class IPokemonRepository {
  Future<List<Pokemon>> getPokemons({int limit});
}
