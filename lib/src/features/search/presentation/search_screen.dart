import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/src/common/custom_dialog.dart';
import 'package:weather_app/src/features/search/domain/city_model.dart';
import 'package:weather_app/src/features/search/presentation/cities_search_controller.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(appBar: _buildAppBar(ref, context));
  }

  AppBar _buildAppBar(WidgetRef ref, BuildContext context) {
    final searchResults = ref.watch(citySearchProvider);

    return AppBar(
      title: Row(
        children: [
          Expanded(
            child: TypeAheadField<City>(
              suggestionsCallback: (query) async {
                // Trigger the search
                ref.read(citySearchProvider.notifier).searchCities(query);
                return searchResults;
              },
              builder: (context, controller, focusNode) {
                return TextField(
                  autofocus: true,
                  focusNode: focusNode,
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: ' Search for a city',
                  ),
                );
              },
              itemBuilder: (context, City suggestion) {
                // Display the city name in the suggestion list
                return ListTile(title: Text(suggestion.cityName));
              },
              onSelected: (City suggestion) {
                // TODO: Implement logic when city selected
                showCustomSnack(context, 'Selected: ${suggestion.cityName}');
              },
            ),
          ),
          const Gap(8),
        ],
      ),
      titleSpacing: 0,
    );
  }
}
