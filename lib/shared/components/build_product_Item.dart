import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/model/home_model/home_model.dart';
import 'package:shop/shared/bloc/shop_cubit/shop_states.dart';
import '../bloc/shop_cubit/shop_cubit.dart';
class BuildProductItem extends StatelessWidget {
  final Products? product;
   const BuildProductItem({super.key,this.product});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(image: NetworkImage('${product?.image}',),height: 200,width: double.infinity,),
              if(product?.discount!=0)Container(color:Colors.green,child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('Discount',style: TextStyle(color: Colors.white),),
              ),),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${product?.name}',maxLines: 2,overflow: TextOverflow.ellipsis,style: const TextStyle(height: 1.3),),
                    Row(
                      children: [
                        Text('${product?.price} EGP',maxLines: 2,overflow: TextOverflow.ellipsis,style: const TextStyle(color:Colors.deepOrange,fontSize: 12),),
                        const SizedBox(width: 5,),
                        if(product?.discount!=0)Text('${product?.oldPrice}',style: const TextStyle(color: Colors.blueGrey,fontSize: 10,decoration: TextDecoration.lineThrough),),
                        const Spacer(),
                            IconButton(onPressed:(){
                              ShopCubit.get(context).addOrDeleteFavourites(product!.id!);
                              }, icon: CircleAvatar(radius: 15,backgroundColor:ShopCubit.get(context).favourites[product!.id]!?Colors.deepOrange:Colors.grey[300],child:const Icon(Icons.favorite_border_outlined,color: Colors.white,size: 14,)))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
