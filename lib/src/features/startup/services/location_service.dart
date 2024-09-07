import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_app/src/common/custom_dialog.dart';
import 'package:weather_app/src/localization/string_hardcoded.dart';

class LocationService {
  Future<String?> getCityFromLocation(BuildContext context) async {
    Position? position = await _getCurrentPosition(context);

    if (position == null && context.mounted) {
      showCustomSnack(
          context,
          'Unable to retrieve location. Please enable location services and permissions.'
              .hardcoded);
      return null;
    }

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position!.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      return placemarks.first.locality ?? 'Location not found';
    } else {
      if (context.mounted) {
        showCustomSnack(
          context,
          'No placemark found for the location'.hardcoded,
        );
      }
      return null;
    }
  }

  // Method to get the current position
  Future<Position?> _getCurrentPosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (context.mounted) {
        showCustomSnack(
          context,
          'Location services are disabled. Please enable them.'.hardcoded,
        );
      }

      await Geolocator.openLocationSettings();
      return null;
    }

    // Check and request location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied && context.mounted) {
        showCustomSnack(context, 'Location permissions are denied.'.hardcoded);
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever && context.mounted) {
      // If permissions are permanently denied, show a dialog and guide the user to settings
      _showPermissionDialog(context);
      return null;
    }

    // If everything is fine, get the current position
    return await Geolocator.getCurrentPosition();
  }

  // Method to show a dialog for permanently denied permissions
  void _showPermissionDialog(BuildContext context) {
    twoButtonDialog(
      context: context,
      title: 'Permissions Denied'.hardcoded,
      content:
          'Location permissions are permanently denied. Please enable them in app settings.'
              .hardcoded,
      leftButtonText: 'Cancel'.hardcoded,
      rightButtonText: 'Open Settings'.hardcoded,
      leftButtonAction: () => Navigator.of(context).pop(),
      rightButtonAction: () async {
        await Geolocator.openAppSettings();
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
