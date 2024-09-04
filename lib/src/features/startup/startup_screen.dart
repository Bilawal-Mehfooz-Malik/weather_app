import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import 'package:weather_app/src/features/startup/widgets/search_field.dart';
import 'package:weather_app/src/features/startup/widgets/use_my_location.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildImageSection(),
          _buildSearchAndButtonSection(),
        ],
      ),
    );
  }

  Image _buildImageSection() {
    return Image.asset(
      height: 350,
      fit: BoxFit.cover,
      'assets/images/startup_image.jpg',
    );
  }

  Padding _buildSearchAndButtonSection() {
    final style = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // [Title Text]
          Text(
            'Welcome to the weather app',
            style: style.textTheme.titleMedium,
          ),
          const Gap(16),

          // [Search Field]
          SearchField(controller: _controller),
          const Gap(16),

          // [Use My Location Button]
          UseMyLocation(controller: _controller),

          // [Next button it is only displayed when the location is entered]
          if (_controller.text.isNotEmpty) ...[
            const Gap(32),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _navigateNextScreen,
                child: const Icon(Icons.arrow_forward),
              ),
            )
          ]
        ],
      ),
    );
  }

  void _navigateNextScreen() {
    //   TODO: Implement navigation logic
  }
}
