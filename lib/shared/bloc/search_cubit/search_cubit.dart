import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/model/search_model/search_model.dart';
import 'package:shop/shared/bloc/search_cubit/search_states.dart';
import 'package:shop/shared/network/local/shared_keys/shared_keys.dart';
import 'package:shop/shared/network/remote/Dio_Helper/dio_helper.dart';
import 'package:shop/shared/network/remote/Dio_Helper/endpoints/endpoints.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of<SearchCubit>(context);
SearchModel? searchModel;
TextEditingController searchController=TextEditingController();
var formKey=GlobalKey<FormState>();
void searchForProducts({required String searchValue}){
  emit(SearchLoadingState());
  DioHelper.postData(path:Endpoints.searchForProduct,
      body:{
    'text':searchValue
  },token:SharedKeys.token).then((value){
    searchModel=SearchModel.fromJson(value.data);
    print(value.data);
    emit(SearchSuccessState());
  }).catchError((error){
    print(error.toString());
    emit(SearchErrorState());
  });
}
}