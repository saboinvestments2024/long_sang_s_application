import '../../../core/app_export.dart';

class TournamentCardModel extends Equatable {
  String? ballNumber;
  String? title;
  String? date;
  String? participants;
  String? level;
  String? prize;
  String? networkCount;

  TournamentCardModel({
    this.ballNumber,
    this.title,
    this.date,
    this.participants,
    this.level,
    this.prize,
    this.networkCount,
  }) {
    ballNumber = ballNumber ?? '8';
    title = title ?? 'SABO POOL 8 BALL';
    date = date ?? '07/09 - Thứ 7';
    participants = participants ?? '0/16';
    level = level ?? 'K - I+';
    prize = prize ?? '10 Million';
    networkCount = networkCount ?? '2 Mạng';
  }

  @override
  List<Object?> get props => [
        ballNumber,
        title,
        date,
        participants,
        level,
        prize,
        networkCount,
      ];

  TournamentCardModel copyWith({
    String? ballNumber,
    String? title,
    String? date,
    String? participants,
    String? level,
    String? prize,
    String? networkCount,
  }) {
    return TournamentCardModel(
      ballNumber: ballNumber ?? this.ballNumber,
      title: title ?? this.title,
      date: date ?? this.date,
      participants: participants ?? this.participants,
      level: level ?? this.level,
      prize: prize ?? this.prize,
      networkCount: networkCount ?? this.networkCount,
    );
  }
}
