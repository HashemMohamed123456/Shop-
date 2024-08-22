import 'package:shop/model/Login_Model/login_model.dart';

import '../../../model/change_favourite_model/change_favourites_model.dart';

abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ChangeBottomNavigationBarScreenState extends ShopStates{}
class GetHomeDataLoadingState extends ShopStates{}
class GetHomeDataSuccessState extends ShopStates{}
class GetHomeDataErrorState extends ShopStates{}
class GettingCategoriesLoadingState extends ShopStates{}
class GettingCategoriesSuccessState extends ShopStates{}
class GettingCategoriesErrorState extends ShopStates{}
class ChangeFavouritesIconState extends ShopStates{}
class AddProductOrDeleteToFavoritesSuccessState extends ShopStates{
  final ChangeFavoritesModel model;
  AddProductOrDeleteToFavoritesSuccessState({required this.model});
}
class AddProductOrDeleteToFavoritesErrorState extends ShopStates{}
class GetFavouritesProductsLoadingState extends ShopStates{}
class GetFavouritesProductsSuccessState extends ShopStates{}
class GetFavouritesProductsErrorState extends ShopStates{}
class GetUserProfileLoadingState extends ShopStates{}
class GetUserProfileSuccessState extends ShopStates{
  LoginModel? loginModel;
  GetUserProfileSuccessState({required this.loginModel});
}
class GetUserProfileErrorState extends ShopStates{}
class UpdateUserProfileLoadingState extends ShopStates{}
class UpdateUserProfileSuccessState extends ShopStates{}
class UpdateUserProfileErrorState extends ShopStates{}