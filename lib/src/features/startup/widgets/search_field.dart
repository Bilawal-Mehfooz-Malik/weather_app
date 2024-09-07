import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/src/localization/string_hardcoded.dart';
import 'package:weather_app/src/features/search/domain/city_model.dart';
import 'package:weather_app/src/features/search/presentation/search_screen.dart';
import 'package:weather_app/src/features/startup/services/location_controller.dart';
import 'package:weather_app/src/features/search/presentation/cities_search_controller.dart';

class SearchField extends ConsumerWidget {
  final TextEditingController controller;

  const SearchField({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationProvider);

    return TextField(
      readOnly: true,
      controller: controller,
      onChanged: (value) {},
      enabled: !locationState.isLoading,
      onTap: () => _navigateToSearchScreen(context, ref, controller),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'Enter a location'.hardcoded,
      ),
    );
  }

  void _navigateToSearchScreen(
    BuildContext context,
    WidgetRef ref,
    TextEditingController controller,
  ) async {
    // opening database so that search query work efficiently
    await ref.read(citySearchProvider.notifier).openDatabase();

    // navigating to next to search screen
    if (context.mounted) {
      City city = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SearchScreen()),
      );
      controller.text = city.cityName;
    }
  }
}
