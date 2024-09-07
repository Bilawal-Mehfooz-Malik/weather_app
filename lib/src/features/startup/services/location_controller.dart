import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/src/features/startup/services/location_service.dart';

class LocationState {
  final bool isLoading;
  final String? city;
  final String? error;

  LocationState({
    required this.isLoading,
    this.city,
    this.error,
  });
}

class LocationNotifier extends StateNotifier<LocationState> {
  final LocationService _locationService;

  LocationNotifier(this._locationService)
      : super(LocationState(isLoading: false));

  // Pass BuildContext directly when calling this method from UI
  Future<void> getLocation(BuildContext context) async {
    state = LocationState(isLoading: true);
    try {
      final city = await _locationService.getCityFromLocation(context);
      state = LocationState(isLoading: false, city: city);
    } catch (e) {
      state = LocationState(isLoading: false, error: e.toString());
    }
  }
}

final locationProvider = StateNotifierProvider<LocationNotifier, LocationState>(
  (ref) => LocationNotifier(LocationService()),
);
