import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:weather_app/src/features/search/domain/city_model.dart';
import 'package:weather_app/src/features/search/presentation/cities_search_controller.dart';
import 'package:weather_app/src/localization/string_hardcoded.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(appBar: _buildAppBar(ref, context));
  }

  AppBar _buildAppBar(WidgetRef ref, BuildContext context) {
    final searchResults = ref.watch(citySearchProvider);

    return AppBar(
      leading: _backButton(context),
      title: Row(
        children: [
          Expanded(
            child: TypeAheadField<City>(
              suggestionsCallback: (query) async {
                ref.read(citySearchProvider.notifier).searchCities(query);
                return searchResults;
              },
              builder: (_, controller, focusNode) {
                return _buildTextField(focusNode, controller);
              },
              onSelected: (city) => _handlePop(context, city),
              itemBuilder: (_, city) => ListTile(title: Text(city.cityName)),
            ),
          ),
          const Gap(8),
        ],
      ),
      titleSpacing: 0,
    );
  }

  BackButton _backButton(BuildContext context) {
    return BackButton(onPressed: () => _handlePop(context));
  }

  TextField _buildTextField(
    FocusNode focusNode,
    TextEditingController controller,
  ) {
    return TextField(
      autofocus: true,
      focusNode: focusNode,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: ' Search for a city'.hardcoded,
      ),
    );
  }

  // Handle navigation pop with optional city data
  void _handlePop(BuildContext context, [City? city]) async {
    FocusScope.of(context).unfocus();
    await Future.delayed(const Duration(milliseconds: 300));

    if (context.mounted) {
      if (city != null) {
        Navigator.of(context).pop(city); // Pop with city if provided
      } else {
        Navigator.of(context).pop(); // Pop without city (back button case)
      }
    }
  }
}
