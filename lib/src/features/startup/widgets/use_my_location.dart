import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/src/common/custom_dialog.dart';
import 'package:weather_app/src/localization/string_hardcoded.dart';

import 'package:weather_app/src/features/startup/services/location_controller.dart';

class UseMyLocation extends ConsumerWidget {
  final TextEditingController controller;

  const UseMyLocation({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationProvider);

    ref.listen<LocationState>(locationProvider, (_, data) {
      if (data.city != null) {
        controller.text = data.city!;
      }
      if (data.error != null) {
        showCustomSnack(context, 'Error: ${data.error}');
      }
    });

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: locationState.isLoading
            ? null
            : () => ref.read(locationProvider.notifier).getLocation(),
        child: locationState.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text('Use my location'.hardcoded),
      ),
    );
  }
}
