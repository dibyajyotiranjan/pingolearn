
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pingolearn/provider/product_provider.dart';
import 'package:pingolearn/services/provider/api_helper.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
    //
    // });
    Provider.of<ProductProvider>(context, listen: false).getAllProduct();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(child: Text("e-Shop",style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Consumer<ProductProvider>(
        builder: (context,value,child){
          return value.isloading?CircularProgressIndicator():Padding(
            padding: const EdgeInsets.all(18.0),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 9,
                  crossAxisSpacing: 8,
                  //childAspectRatio: 2,
                  mainAxisExtent: 280
                ),
              itemCount: value.product.length,
              itemBuilder: (context,index){
                  return Container(

                    height: 800,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Image.network(value.product[index].thumbnail,fit: BoxFit.cover,)),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:[
                              AutoSizeText(value.product[index].title.substring(0,8),style: TextStyle(fontWeight: FontWeight.bold),maxLines: 2,),
                              AutoSizeText("${value.product[index].description.substring(0,35)}...",maxLines: 3,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AutoSizeText(" \$${value.product[index].price}  ",style: TextStyle(decoration: TextDecoration.lineThrough),),
                                  AutoSizeText("\$${value.product[index].price-(value.product[index].price*value.product[index].discountPercentage/100).round()}"),
                                  AutoSizeText("${value.product[index].discountPercentage}% off",style: TextStyle(color: Colors.green),)
                                ],
                              )
                            ]

                          ),
                        )

                      ],
                    ),
                  );
              },
            ),
          );
          // View.builder(
          //   itemCount: value.product.length,
          //     itemBuilder: (context,index){
          //       return ListTile(
          //        title: Text(value.product[index].title),
          //       );
          //     }
          // );
        },

      ),
    );
  }
}
