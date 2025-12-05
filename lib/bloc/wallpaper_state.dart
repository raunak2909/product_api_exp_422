import 'package:product_api_exp_422/wallpaper_model.dart';

abstract class WallpaperState {}

class WallpaperInitialState extends WallpaperState {}

class WallpaperLoadingState extends WallpaperState {}

class WallpaperLoadedState extends WallpaperState {
  List<WallpaperModel> allWallpapers;
  WallpaperLoadedState({required this.allWallpapers});
}

class WallpaperErrorState extends WallpaperState {
  String errorMsg;
  WallpaperErrorState({required this.errorMsg});
}
