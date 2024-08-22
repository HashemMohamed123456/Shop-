import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/model/categories_model/category_model.dart';
import 'package:shop/model/favourite_model/favourite_model.dart';
import 'package:shop/model/home_model/home_model.dart';
import 'package:shop/modules/categories/categories_screen.dart';
import 'package:shop/modules/favourites/favourites_screen.dart';
import 'package:shop/modules/products/products_screen.dart';
import 'package:shop/modules/settings/settings_screen.dart';
import 'package:shop/shared/bloc/shop_cubit/shop_states.dart';
import 'package:shop/shared/network/local/shared_keys/shared_keys.dart';
import 'package:shop/shared/network/remote/Dio_Helper/dio_helper.dart';
import 'package:shop/shared/network/remote/Dio_Helper/endpoints/endpoints.dart';
import '../../../model/Login_Model/login_model.dart';
import '../../../model/change_favourite_model/change_favourites_model.dart';
class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context)=>BlocProvider.of<ShopCubit>(context);
List<Widget>bottomNavBarScreens=[
  const ProductsScreen(),
  const CategoriesScreen(),
  const FavouritesScreen(),
  const SettingsScreen()
];
int currentProductIndex=0;
int currentIndex=0;
HomeModel? homeModel;
CategoriesModel? categoriesModel;
FavouritesModel? favouritesModel;
ChangeFavoritesModel? changeFavoritesModel;
LoginModel? profileModel;
Map<int?,bool?> favourites={};
TextEditingController userProfileNameController=TextEditingController();
TextEditingController userProfileEmailController=TextEditingController();
TextEditingController userProfilePhoneController=TextEditingController();
var formKey=GlobalKey<FormState>();
void changeBottomNavBarIndex(int index){
  currentIndex=index;
  emit(ChangeBottomNavigationBarScreenState());
}
void getHomeData(){
  emit(GetHomeDataLoadingState());
  DioHelper.getData(path:Endpoints.home,token: SharedKeys.token).then((value){
    homeModel=HomeModel.fromJson(value.data);
    //print(homeModel?.data?.banners![0].image);
    //print(homeModel?.status);
    homeModel?.data?.products?.forEach((element){
      favourites.addAll({
        element.id:element.inFavorites
      });
    });
    print(favourites.toString());
    emit(GetHomeDataSuccessState());
  }).catchError((error){
    print(error.toString());
    emit(GetHomeDataErrorState());
  });
}
void getCategories(){
  DioHelper.getData(path: Endpoints.categories).then((value){
    categoriesModel=CategoriesModel.fromJson(value.data);
    print(categoriesModel?.data?.data);
    emit(GettingCategoriesSuccessState());
  }).catchError((error){
    print(error);
    emit(GettingCategoriesErrorState());
  });
}
void addOrDeleteFavourites(int productId){
  favourites[productId]=!favourites[productId]!;
  emit(ChangeFavouritesIconState());
DioHelper.postData(path: Endpoints.favorites, body:{
  "product_id":productId
},token: SharedKeys.token).then((value){
  changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
  if(!changeFavoritesModel!.status!){
    favourites[productId]=!favourites[productId]!;
  }else{
    getFavouriteProducts();
  }
  print(value.data);
  emit(AddProductOrDeleteToFavoritesSuccessState(model: changeFavoritesModel!));
}).catchError((error){
  print(error.toString());
  emit(AddProductOrDeleteToFavoritesErrorState());
});
}
void getFavouriteProducts(){
  emit(GetFavouritesProductsLoadingState());
  DioHelper.getData(path:Endpoints.favorites,token: SharedKeys.token).then((value){
    favouritesModel=FavouritesModel.fromJson(value.data);
    print(value.data);
    emit(GetFavouritesProductsSuccessState());
  }).catchError((error){
    print(error);
    emit(GetFavouritesProductsErrorState());
  });
}
void getUserProfile(){
emit(GetUserProfileLoadingState());
DioHelper.getData(path:Endpoints.profile,token: SharedKeys.token).then((value){
  profileModel=LoginModel.fromJson(value.data);
  print(profileModel!.data!.name);
  emit(GetUserProfileSuccessState(loginModel: profileModel));
}).catchError((error){
  print(error.toString());
  emit(GetUserProfileErrorState());
});
}
void updateUserProfile({required String name,required String phone,required String email}){
  emit(UpdateUserProfileLoadingState());
  DioHelper.putData(path:Endpoints.update,
      body:{
        "name":name,
        "phone":phone,
        "email":email,
      },token: SharedKeys.token).then((value){
        profileModel=LoginModel.fromJson(value.data);
        print(value.data);
        emit(UpdateUserProfileSuccessState());
  }).catchError((error){
    emit(UpdateUserProfileErrorState());
  });
}
}