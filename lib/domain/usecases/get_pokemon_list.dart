import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonList {
  final IPokemonRepository repo;
  const GetPokemonList(this.repo);

  Future<List<Pokemon>> call({int limit = 30}) {
    return repo.getPokemons(limit: limit);
  }
}
