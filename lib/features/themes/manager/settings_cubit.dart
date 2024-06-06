import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:momayaz/core/styles/colors.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  void setLight (){
    AppColors.primary=AppColors.malibu;
    AppColors.second=AppColors.offWhite;
    AppColors.text=Color(0xff151515);

  }
  void setDark (){
    AppColors.primary=Color.fromARGB(255, 244, 11, 11);
    AppColors.second=Color(0xff000000);
    AppColors.text=Color(0xff8B8B8B);

  }



}
