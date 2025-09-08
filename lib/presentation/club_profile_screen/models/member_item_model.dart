import '../../../core/app_export.dart';

/// This class is used in the [member_item_widget] widget.

// ignore_for_file: must_be_immutable
class MemberItemModel extends Equatable {
  MemberItemModel({
    this.avatar,
    this.name,
    this.rank,
    this.date,
  }) {
    avatar = avatar ?? ImageConstant.imgUser;
    name = name ?? 'Unknown User';
    rank = rank ?? 'Rank Unknown';
    date = date ?? '00/00/0000';
  }

  String? avatar;
  String? name;
  String? rank;
  String? date;

  MemberItemModel copyWith({
    String? avatar,
    String? name,
    String? rank,
    String? date,
  }) {
    return MemberItemModel(
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      rank: rank ?? this.rank,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [
        avatar,
        name,
        rank,
        date,
      ];
}
