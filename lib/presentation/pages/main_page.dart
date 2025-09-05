import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/team_controller.dart';
import '../widgets/pokemon_list.dart';
import 'team_preview_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final teamCtrl = Get.find<TeamController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pokémon Team Builder (GetX)")),
      body: Column(
        children: [
          Expanded(child: PokemonList()),
          Obx(() {
            final count = teamCtrl.team.length;
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: count > 0 ? () => Get.to(() => TeamPreviewPage()) : null,
                child: Text("Preview Team ($count / 3)"),
              ),
            );
          }),
        ],
      ),
    );
  }
}
