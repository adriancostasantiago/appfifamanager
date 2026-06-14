import 'package:flutter/material.dart';

import 'pages/finance_page.dart';
import 'pages/home_page.dart';
import 'pages/leagues_page.dart';
import 'pages/login_page.dart';
import 'pages/player_detail_page.dart';
import 'pages/register_match_page.dart';
import 'pages/splash_page.dart';
import 'pages/champion_page.dart';
import 'pages/sponsors_page.dart';
import 'pages/squad_page.dart';
import 'pages/trophy_room_page.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FC Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case AppRoutes.splash:
            page = const SplashPage();
            break;
          case AppRoutes.login:
            page = const LoginPage();
            break;
          case AppRoutes.home:
            page = const DashboardPage();
            break;
          case AppRoutes.leagues:
            page = const LeaguesPage();
            break;
          case AppRoutes.registerMatch:
            page = const RegisterMatchPage();
            break;
          case AppRoutes.squad:
            page = const SquadPage();
            break;
          case AppRoutes.playerDetail:
            page = const PlayerDetailPage(player: samplePlayerProfile);
            break;
          case AppRoutes.champion:
            page = const ChampionPage(
              teamName: 'APEX SC',
              jogos: 38,
              vitorias: 29,
              gols: 84,
            );
          case AppRoutes.trophies:
            page = const TrophyRoomPage();
            break;
          case AppRoutes.finance:
            page = const FinancePage();
            break;
          case AppRoutes.sponsors:
            page = const SponsorsPage();
            break;
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
