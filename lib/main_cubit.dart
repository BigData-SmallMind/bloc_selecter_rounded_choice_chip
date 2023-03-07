import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphing_widgets/main.dart';

part 'main_state.dart';

class MyHomePageCubit extends Cubit<MyHomePageState> {
  MyHomePageCubit() : super(const QuoteListTagSelected());

  onTagSelected({required bool isSelected, required Tag tag}) {
    List<Tag> tagListNew = [if (state.tagList != null)...state.tagList!];
    isSelected
        ? tagListNew.add(tag)
        : tagListNew.removeWhere((tagElement) => tagElement == tag);
    emit(QuoteListTagSelected(tagList: tagListNew));
  }
}
