part of 'main_cubit.dart';

abstract class MyHomePageState extends Equatable {
  const MyHomePageState({required this.tagList});

  final List<Tag>? tagList;

  @override
  List<Object?> get props => [tagList];
}

class QuoteListTagSelected extends MyHomePageState {
  const QuoteListTagSelected({tagList}) : super(tagList: tagList);

  @override
  List<Object?> get props => [
        tagList,
      ];
}
