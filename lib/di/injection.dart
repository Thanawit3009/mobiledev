import 'package:get_it/get_it.dart';
import 'package:get/get.dart';
import '../data/services/api_service.dart';
import '../data/repositories/pokemon_repository_impl.dart';
import '../domain/repositories/pokemon_repository.dart';
import '../domain/usecases/get_pokemon_list.dart';
import '../presentation/controllers/team_controller.dart';

final getIt = GetIt.instance;

Future<void> setupInjection() async {
  // Services
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  // Repository
  getIt.registerLazySingleton<IPokemonRepository>(
    () => PokemonRepositoryImpl(getIt<ApiService>()),
  );

  // UseCase
  getIt.registerLazySingleton<GetPokemonList>(
    () => GetPokemonList(getIt<IPokemonRepository>()),
  );

  // Controller (GetX)
  if (!Get.isRegistered<TeamController>()) {
    Get.put<TeamController>(TeamController(getIt<GetPokemonList>()));
  }
}
