import '../../../core/app_export.dart';
import './tournament_card_model.dart';

class UserProfileModel extends Equatable {
  String? username;
  String? displayName;
  String? rank;
  String? elo;
  String? spa;
  String? xh;
  String? matches;
  List<TournamentCardModel>? tournaments;

  UserProfileModel({
    this.username,
    this.displayName,
    this.rank,
    this.elo,
    this.spa,
    this.xh,
    this.matches,
    this.tournaments,
  }) {
    username = username ?? 'longsang';
    displayName = displayName ?? 'Anh Long Magic';
    rank = rank ?? 'G';
    elo = elo ?? '1485';
    spa = spa ?? '320';
    xh = xh ?? '#89';
    matches = matches ?? '37';
    tournaments = tournaments ?? [];
  }

  @override
  List<Object?> get props => [
        username,
        displayName,
        rank,
        elo,
        spa,
        xh,
        matches,
        tournaments,
      ];

  UserProfileModel copyWith({
    String? username,
    String? displayName,
    String? rank,
    String? elo,
    String? spa,
    String? xh,
    String? matches,
    List<TournamentCardModel>? tournaments,
  }) {
    return UserProfileModel(
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      rank: rank ?? this.rank,
      elo: elo ?? this.elo,
      spa: spa ?? this.spa,
      xh: xh ?? this.xh,
      matches: matches ?? this.matches,
      tournaments: tournaments ?? this.tournaments,
    );
  }
}
