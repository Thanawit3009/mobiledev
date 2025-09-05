import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/team_controller.dart';

class PokemonList extends StatelessWidget {
  PokemonList({super.key});

  final teamCtrl = Get.find<TeamController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (teamCtrl.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
        itemCount: teamCtrl.pokemons.length,
        itemBuilder: (ctx, i) {
          final p = teamCtrl.pokemons[i];
          final selected = teamCtrl.team.contains(p);
          return ListTile(
            leading: Image.network(p.imageUrl, width: 40, height: 40),
            title: Text(p.name),
            trailing: Icon(
              selected ? Icons.check_circle : Icons.add_circle_outline,
              color: selected ? Colors.green : null,
            ),
            onTap: () => teamCtrl.togglePokemon(p),
          );
        },
      );
    });
  }
}
