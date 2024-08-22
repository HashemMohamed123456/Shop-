import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/bloc/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/bloc/shop_cubit/shop_states.dart';

import '../../shared/components/favourite_item.dart';
class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return state is GetFavouritesProductsLoadingState?const Center(child: CircularProgressIndicator(),):ListView.separated(physics: const BouncingScrollPhysics(),
            itemBuilder:(context,index)=>FavouriteProductItem(favouriteProductData: ShopCubit.get(context).favouritesModel!.data!.data![index],), separatorBuilder:(context,index)=>Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(height: 2,width: double.infinity,color:Colors.deepOrange.withOpacity(0.6),)),itemCount: ShopCubit.get(context).favouritesModel!.data!.data!.length,) ;
        },
    );
  }
}