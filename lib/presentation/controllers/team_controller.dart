import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/usecases/get_pokemon_list.dart';

class TeamController extends GetxController {
  final GetPokemonList getPokemonList;

  TeamController(this.getPokemonList);

  final storage = GetStorage();

  final pokemons = <Pokemon>[].obs;
  final team = <Pokemon>[].obs;
  final isLoading = false.obs;

  static const _storageKey = 'team_names'; // เก็บเป็นรายชื่ออย่างเดียว

  @override
  void onInit() {
    super.onInit();
    _restoreTeam();
    loadPokemons();
    ever(team, (_) => _persistTeam());
  }

  Future<void> loadPokemons() async {
    isLoading.value = true;
    try {
      final list = await getPokemonList(limit: 30); // ≥ 20 ตามโจทย์
      pokemons.assignAll(list);
      _rebuildTeamFromNames();
    } finally {
      isLoading.value = false;
    }
  }

  void togglePokemon(Pokemon p) {
    if (team.contains(p)) {
      team.remove(p);
    } else {
      if (team.length >= 3) {
        Get.snackbar("Limit Reached", "You can select up to 3 only!");
        return;
      }
      team.add(p);
    }
  }

  void resetTeam() => team.clear();

  // --- Persist helpers ---
  void _persistTeam() {
    final names = team.map((e) => e.name).toList();
    storage.write(_storageKey, names);
  }

  void _restoreTeam() {
    final names = List<String>.from(storage.read(_storageKey) ?? []);
    // ยังไม่มี pokemons ตอนเริ่ม → ไว้ประกอบทีหลัง
    // เก็บไว้ชั่วคราวใน storage อยู่แล้ว
  }

  void _rebuildTeamFromNames() {
    final names = List<String>.from(storage.read(_storageKey) ?? []);
    final selected = <Pokemon>[];
    for (final n in names) {
      final match = pokemons.firstWhereOrNull((p) => p.name == n);
      if (match != null) selected.add(match);
    }
    team.assignAll(selected.take(3));
  }
}
