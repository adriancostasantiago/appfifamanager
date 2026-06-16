import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/splash_page.dart';
import 'pages/champion/champion_page.dart';
import 'pages/finance/finance_page.dart';
import 'pages/finance/sponsors_page.dart';
import 'pages/home/home_page.dart';
import 'pages/leagues/leagues_page.dart';
import 'pages/match/register_match_page.dart';
import 'pages/squad/squad_page.dart';
import 'pages/trophy/trophy_room_page.dart';
import 'routes/app_routes.dart';
import 'core/theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await themeController.loadTheme();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    themeController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FC Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      themeMode: themeController.themeMode,
      // themeMode: ThemeMode.system,
      // themeMode: ThemeMode.light,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: (settings) {
        final Widget page;
        switch (settings.name) {
          case AppRoutes.splash:
            page = const SplashPage();
          case AppRoutes.login:
            page = const LoginPage();
          case AppRoutes.home:
            page = const DashboardPage();
          case AppRoutes.leagues:
            page = const LeaguesPage();
          case AppRoutes.registerMatch:
            page = const RegisterMatchPage();
          case AppRoutes.squad:
            page = const SquadPage();
          // case AppRoutes.champion:
          //   page = const ChampionPage(
          //     teamName: 'APEX SC',
          //     jogos: 38,
          //     vitorias: 29,
          //     gols: 84,
          //   );
          case AppRoutes.trophies:
            page = const TrophyRoomPage();
          case AppRoutes.finance:
            page = const FinancePage();
          case AppRoutes.sponsors:
            page = const SponsorsPage();
          default:
            page = const SplashPage();
        }
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, _, _) => page,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
      },
    );
  }
}
