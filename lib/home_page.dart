import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_api_exp_422/product_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: FutureBuilder<List<ProductModel>>(
        future: getProducts(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView.builder(
              itemCount: snapshot.data!.length,
                itemBuilder: (_, index){
                  return Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data![index].thumbnail),
                          ),
                          title: Text(snapshot.data![index].title),
                          subtitle: Text(snapshot.data![index].brand ?? "No Brand"),
                        ),
                        snapshot.data![index].reviews!=null ? SizedBox(
                          height: 100,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data![index].reviews!.length,
                              itemBuilder: (_, childIndex){
                            return SizedBox(
                              width: 200,
                              child: ListTile(
                                title: Text(snapshot.data![index].reviews![childIndex].comment ?? ""),
                                subtitle: Text(snapshot.data![index].reviews![childIndex].reviewerName ?? ""),
                              ),
                            );
                          }),
                        ) : Container(),
                      ],
                    ),
                  );
            })
                : Center(child: Text('No Data'));
          }

          return Container();
        },
      ),
    );
  }

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
}
