import 'package:flutter_riverpod/flutter_riverpod.dart';

// !LEAGUE LIST INDEX PROVIDER
final leagueIndexProvider = StateProvider.autoDispose((ref) => 0);

// LEAGUE PAGE CONTROLLER INDEX WATCHER
final currentPage = StateProvider.autoDispose((ref) => 0);
