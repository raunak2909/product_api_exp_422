import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_api_exp_422/api_helper.dart';
import 'package:product_api_exp_422/bloc/wallpaper_event.dart';
import 'package:product_api_exp_422/bloc/wallpaper_state.dart';
import 'package:product_api_exp_422/wallpaper_model.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  ApiHelper apiHelper;

  WallpaperBloc({required this.apiHelper}) : super(WallpaperInitialState()) {
    on<GetTrendingWallpaperEvent>((event, emit) async{
      emit(WallpaperLoadingState());

      var res = await apiHelper.getAPI(
        url: "https://api.pexels.com/v1/curated",
        mHeaders: {
          "Authorization":
              "IsdZkUsWondOOmqNkNSFGtBuaoRofOkF8VKuftMElAFV4KDCD2Bi5rPr",
        },
      );

      print(res);

      if(res!=null){
        emit(WallpaperLoadedState(allWallpapers: WallpaperDataModel.fromJson(res).photos ?? []));
      } else {
        emit(WallpaperErrorState(errorMsg: "Something went wrong!!"));
      }

    });
  }
}
