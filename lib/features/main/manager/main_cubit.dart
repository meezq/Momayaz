import 'package:momayaz/features/chats/view/screens/chats_screen.dart';
import 'package:momayaz/features/home/view/screens/home_screen.dart';
import 'package:momayaz/features/my_ads/view/screens/my_ads_screen.dart';
import 'package:momayaz/features/profile/view/screens/profile_screen.dart';
import 'package:momayaz/features/sell_Product/view/screens/sell_product_screen.dart';
import 'package:bloc/bloc.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
  int index = 0;
  List screens = [
    const HomeScreen(),
    ChatsScreen(),
    SellProductScreen(),
    const MyAdsScreen(),
    const ProfileScreen(),
  ];

  void goToHome() {
    index = 0;
    emit(MainHome());
  }

  void goToChats() {
    index = 1;
    emit(MainChats());
  }

  void goToAds() {
    index = 3;
    emit(MainCategories());
  }

  void goToProfile() {
    index = 4;
    emit(MainChats());
  }
}
