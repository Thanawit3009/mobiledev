import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/team_controller.dart';

class TeamPreviewPage extends StatelessWidget {
  TeamPreviewPage({super.key});

  final teamCtrl = Get.find<TeamController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Team Preview")),
      body: Obx(() {
        final team = teamCtrl.team;
        if (team.isEmpty) {
          return const Center(child: Text("No members selected yet."));
        }
        return ListView.builder(
          itemCount: team.length,
          itemBuilder: (_, i) {
            final p = team[i];
            return Card(
              child: ListTile(
                leading: Image.network(p.imageUrl, width: 40, height: 40),
                title: Text(p.name),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text("Reset Team"),
            onPressed: teamCtrl.resetTeam,
          ),
        ),
      ),
    );
  }
}
