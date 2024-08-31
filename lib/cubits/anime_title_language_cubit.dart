import 'package:anime_list/database_helper/database_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef IsEnglish = bool;

class AnimeTitleLanguageCubit extends Cubit<IsEnglish> {
  AnimeTitleLanguageCubit() : super(false) {
    _fetchAnimeTitleLanguage();
  }

  bool get isEnglish => state;

  Future _fetchAnimeTitleLanguage() async {
    final isEnglish = await DatabaseHelper.instance.isEnglish;

    emit(isEnglish);
  }

  Future changeAnimeTitleLanguage({required bool isEnglish}) async {
    await DatabaseHelper.instance.setIsEnglish(isEnglish);
    emit(isEnglish);
  }
}
