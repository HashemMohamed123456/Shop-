import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/bloc/search_cubit/search_cubit.dart';
import 'package:shop/shared/bloc/search_cubit/search_states.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/search_for_product_item.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Screen',style:  TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w900
        ),),
      ),
      body: BlocProvider(
        create: (context)=>SearchCubit(),
        child: BlocConsumer<SearchCubit,SearchStates>(
          listener: (context,state){},
          builder:(context,state){
            return Form(
              key: SearchCubit.get(context).formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                children: [
                  textFormFieldCustom(
                    controller:SearchCubit.get(context).searchController,
                    label: 'Search',
                    prefix: Icons.search,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'You didn\'t search for any product';
                      }
                    },
                  onFieldSubmitted: (value){
                    SearchCubit.get(context).searchForProducts(searchValue:value);
                  },
                    keyboardType: TextInputType.text
                  ),
                const SizedBox(height: 10,),
                  if(state is SearchLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 10,),
                  if(state is SearchSuccessState)
                    Expanded(
                    child: ListView.separated(physics: const BouncingScrollPhysics(),
                      itemBuilder:(context,index)=>SearchForProductItem(product:SearchCubit.get(context).searchModel?.data!.data![index],), separatorBuilder:(context,index)=>Padding(
                          padding: const EdgeInsets.all (10),
                            child: 
                            Container(height: 2,width: double.infinity,
                              color:Colors.deepOrange.withOpacity(0.6),)),
                        itemCount:SearchCubit.get(context).searchModel?.data!.data!.length??0),
                  )
                ],
                ),
              ),
            );
          }
        ),
      ),

    );
  }
}