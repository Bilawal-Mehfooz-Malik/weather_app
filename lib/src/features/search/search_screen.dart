import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/src/localization/string_hardcoded.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBAr(),
    );
  }

  AppBar _buildAppBAr() {
    return AppBar(
      title: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration:
                  InputDecoration(hintText: 'Search for a city'.hardcoded),
            ),
          ),
          const Gap(8)
        ],
      ),
      titleSpacing: 0,
    );
  }
}
