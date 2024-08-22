import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/model/favourite_model/favourite_model.dart';
import 'package:shop/shared/bloc/shop_cubit/shop_cubit.dart';

import '../bloc/shop_cubit/shop_states.dart';
class FavouriteProductItem extends StatelessWidget {
  final FavouriteProductData? favouriteProductData;
  const FavouriteProductItem({super.key,this.favouriteProductData});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      builder: (context,state){
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(30)
            ),
            height: 150,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.network(favouriteProductData?.product?.image??'',width: 150,height:150,fit: BoxFit.cover,)),
                  const SizedBox(width: 15,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(favouriteProductData?.product?.name??'',style: const TextStyle(fontSize: 20,color: Colors.white,overflow:TextOverflow.ellipsis),maxLines: 2,),
                        const Spacer(),
                        Row(
                          children: [
                            Text('${favouriteProductData?.product?.price}',style:const  TextStyle(fontSize: 20,color: Colors.white)),
                            const SizedBox(width: 15,),
                            favouriteProductData!.product!.oldPrice==favouriteProductData!.product!.price?const Text(''):Text('${favouriteProductData?.product?.oldPrice} ',style: const TextStyle(fontSize: 15,color:Colors.black,decoration:TextDecoration.lineThrough),),
                            const Spacer(),
                            IconButton(onPressed:(){
                              ShopCubit.get(context).addOrDeleteFavourites(favouriteProductData!.product!.id!);
                            }, icon:  CircleAvatar(radius: 15,backgroundColor:ShopCubit.get(context).favourites[favouriteProductData!.product!.id!]!?Colors.white:Colors.grey,child:Icon(Icons.favorite_border_outlined,color: ShopCubit.get(context).favourites[favouriteProductData!.product!.id]!?Colors.deepOrange:Colors.white,size: 14,)))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      listener: (context,state){},
    );
  }
}
