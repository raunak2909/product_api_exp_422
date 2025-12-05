import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:product_api_exp_422/bloc/wallpaper_bloc.dart';
import 'package:product_api_exp_422/bloc/wallpaper_state.dart';
import 'package:product_api_exp_422/product_model.dart';
import 'package:product_api_exp_422/wallpaper_model.dart';

import 'bloc/wallpaper_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<WallpaperBloc>().add(GetTrendingWallpaperEvent());

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: BlocBuilder<WallpaperBloc, WallpaperState>(
        builder: (_, state) {
          if (state is WallpaperLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is WallpaperErrorState) {
            return Center(child: Text(state.errorMsg));
          }

          if (state is WallpaperLoadedState) {
            return state.allWallpapers.isNotEmpty
                ? Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: GridView.builder(
                    itemCount: state.allWallpapers.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 11,
                        crossAxisSpacing: 11,
                        childAspectRatio: 9/16
                      ),
                      itemBuilder: (_, index) {
                        WallpaperModel eachWallpaper = state.allWallpapers[index];

                        return eachWallpaper.src != null
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(21),
                                  image: DecorationImage(
                                    image: eachWallpaper.src!.portrait != null
                                        ? NetworkImage(
                                            eachWallpaper.src!.portrait!,
                                          )
                                        : AssetImage(""),
                                    fit: BoxFit.cover
                                  ),
                                ),
                              )
                            : Center(
                                child: Text('No Wallpaper meta data found!!'),
                              );
                      },
                    ),
                )
                : Center(child: Text('No Trending Wallpaper to show..'));
          }

          return Container();
        },
      ),
    );
  }

  ///FutureBuilder<List<ProductModel>>(
  //         future: getProducts(),
  //         builder: (_, snapshot) {
  //           if (snapshot.connectionState == ConnectionState.waiting) {
  //             return Center(child: CircularProgressIndicator());
  //           }
  //
  //           if (snapshot.hasError) {
  //             return Center(child: Text(snapshot.error.toString()));
  //           }
  //
  //           if (snapshot.hasData) {
  //             return snapshot.data!.isNotEmpty
  //                 ? ListView.builder(
  //               itemCount: snapshot.data!.length,
  //                 itemBuilder: (_, index){
  //                   return Card(
  //                     child: Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         ListTile(
  //                           leading: CircleAvatar(
  //                             backgroundImage: NetworkImage(snapshot.data![index].thumbnail),
  //                           ),
  //                           title: Text(snapshot.data![index].title),
  //                           subtitle: Text(snapshot.data![index].brand ?? "No Brand"),
  //                         ),
  //                         snapshot.data![index].reviews!=null ? SizedBox(
  //                           height: 100,
  //                           child: ListView.builder(
  //                               scrollDirection: Axis.horizontal,
  //                               itemCount: snapshot.data![index].reviews!.length,
  //                               itemBuilder: (_, childIndex){
  //                             return SizedBox(
  //                               width: 200,
  //                               child: ListTile(
  //                                 title: Text(snapshot.data![index].reviews![childIndex].comment ?? ""),
  //                                 subtitle: Text(snapshot.data![index].reviews![childIndex].reviewerName ?? ""),
  //                               ),
  //                             );
  //                           }),
  //                         ) : Container(),
  //                       ],
  //                     ),
  //                   );
  //             })
  //                 : Center(child: Text('No Data'));
  //           }
  //
  //           return Container();
  //         },
  //       ),

  Future<List<ProductModel>> getProducts() async {
    String url = "https://dummyjson.com/products";

    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      var mData = jsonDecode(res.body);
      return ProductDataModel.fromJson(mData).products;
    } else {
      return [];
    }
  }

  Future<List<WallpaperModel>> getTrendingWallpapers() async {
    String url = "https://api.pexels.com/v1/curated";

    var res = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization":
            "IsdZkUsWondOOmqNkNSFGtBuaoRofOkF8VKuftMElAFV4KDCD2Bi5rPr",
      },
    );

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return WallpaperDataModel.fromJson(data).photos ?? [];
    } else {
      return [];
    }
  }
}
