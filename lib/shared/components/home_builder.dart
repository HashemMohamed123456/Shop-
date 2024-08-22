import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/bloc/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/bloc/shop_cubit/shop_states.dart';
import '../../model/categories_model/category_model.dart';
import '../../model/home_model/home_model.dart';
import 'build_product_Item.dart';
import 'components.dart';
class HomeBuilder extends StatelessWidget {
  final HomeModel? homeModel;
  final CategoriesModel? categoriesModel;
  const HomeBuilder({super.key,this.homeModel,this.categoriesModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return  SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            CarouselSlider(items:homeModel?.data?.banners?.map((e)=>Image(image:NetworkImage('${e.image}',),
              fit: BoxFit.cover,width: double.infinity,)).toList(),
                options:CarouselOptions(
                    height: 250,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlay: true,
                    reverse: false,
                    autoPlayInterval:const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds:1 ),
                    viewportFraction: 1,
                    scrollDirection: Axis.horizontal,
                    initialPage: 0,
                    enlargeCenterPage: true,
                    aspectRatio: 16/10,
                    enlargeFactor: 0.2

                )),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Categories',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 24),),
                  const SizedBox(height: 10,),
                  SizedBox(height: 100,child: ListView.separated(physics: const BouncingScrollPhysics()
                      ,scrollDirection: Axis.horizontal,
                      itemBuilder:(context,index)=>buildCategoryItem(model: categoriesModel?.data?.data?[index]), separatorBuilder:(context,index)=>const SizedBox(width: 5,), itemCount:categoriesModel?.data?.data?.length??0)),
                  const SizedBox(height: 10,),
                  const Text('New Products',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 24),),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  childAspectRatio: 1/1.6,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  shrinkWrap: true,
                  crossAxisCount:2,
                  children: List.generate(homeModel?.data?.products?.length??0,(index)=>
                      BuildProductItem(product: homeModel?.data?.products?[index])
                  )
              ),
            ),
          ],),
        );
      },
    );
  }
}
