import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/model/search_model/search_model.dart';
import 'package:shop/shared/bloc/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/bloc/shop_cubit/shop_states.dart';
class SearchForProductItem extends StatelessWidget {
  final SearchProduct? product;
  const SearchForProductItem({super.key,this.product});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Container(
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
                    child: Image.network(product?.image??'',width: 150,height:150,fit: BoxFit.cover,)),
                const SizedBox(width: 15,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product?.name??'',style: const TextStyle(fontSize: 20,color: Colors.white,overflow:TextOverflow.ellipsis),maxLines: 2,),
                      const Spacer(),
                      Row(
                        children: [
                          Text('${product?.price}',style:const  TextStyle(fontSize: 20,color: Colors.white)),
                          const SizedBox(width: 15,),
                          const Spacer(),
                          IconButton(onPressed:(){
                            ShopCubit.get(context).addOrDeleteFavourites(product!.id!);
                          }, icon:  CircleAvatar(radius: 15,backgroundColor:ShopCubit.get(context).favourites[product!.id!]!?Colors.white:Colors.grey,child:Icon(Icons.favorite_border_outlined,color: ShopCubit.get(context).favourites[product!.id]!?Colors.deepOrange:Colors.white,size: 14,)))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },

    );
  }
}
