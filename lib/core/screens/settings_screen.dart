import 'package:anime_list/common/styles/paddings.dart';
import 'package:anime_list/cubits/anime_title_language_cubit.dart';
import 'package:anime_list/cubits/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "App Settings",
        ),
        centerTitle: true,
      ),
      body: const Padding(
        padding: Paddings.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThemeSwitchWidget(),
            SizedBox(
              height: 20,
            ),
            AnimeTitleLanguageSwitch(),
          ],
        ),
      ),
    );
  }
}

class ThemeSwitchWidget extends StatefulWidget {
  const ThemeSwitchWidget({super.key});

  @override
  State<ThemeSwitchWidget> createState() => _ThemeSwitchWidgetState();
}

class _ThemeSwitchWidgetState extends State<ThemeSwitchWidget> {
  bool isDarkMode = false;

  Future<void> toggleDarkMode(value) async {
    setState(() => isDarkMode = !isDarkMode);
    context.read<ThemeCubit>().changeTheme(isDarkMode: isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Dark Mode"),
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, state) {
            isDarkMode = state == ThemeMode.dark;

            return CupertinoSwitch(
              value: isDarkMode,
              onChanged: toggleDarkMode,
            );
          },
        )
      ],
    );
  }
}

class AnimeTitleLanguageSwitch extends StatefulWidget {
  const AnimeTitleLanguageSwitch({super.key});

  @override
  State<AnimeTitleLanguageSwitch> createState() =>
      _AnimeTitleLanguageSwitchState();
}

class _AnimeTitleLanguageSwitchState extends State<AnimeTitleLanguageSwitch> {
  @override
  Widget build(BuildContext context) {
    bool isEnglish = false;

    Future<void> toggleAnimeTitleLanguageSwitch(value) async {
      setState(() => isEnglish = !isEnglish);
      context
          .read<AnimeTitleLanguageCubit>()
          .changeAnimeTitleLanguage(isEnglish: isEnglish);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("English Title"),
        BlocBuilder<AnimeTitleLanguageCubit, bool>(
          builder: (context, state) {
            isEnglish = state;

            return CupertinoSwitch(
              value: isEnglish,
              onChanged: toggleAnimeTitleLanguageSwitch,
            );
          },
        )
      ],
    );
  }
}
