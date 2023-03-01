import 'package:app_test/layout/shop_app/cubit/shop_home_cubit.dart';
import 'package:app_test/layout/shop_app/cubit/states.dart';
import 'package:app_test/model/shop/favorites_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopHomeStates>(
      listener: (context,state){},
      builder:(context,state)=>ConditionalBuilder(
        condition: state is! ShopHomeGetFavouriteLoadingState,
        fallback: (context)=>const Center(child: CircularProgressIndicator(),),
        builder:(context)=> ListView.separated(
          itemCount: ShopCubit.get(context).favoritesModel?.data?.data?.length ??0 ,
          itemBuilder:(context,index)=>buildFavouriteItem(
              ShopCubit.get(context).favoritesModel?.data?.data![index],context) ,
          separatorBuilder: (context,index)=>Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(color: Colors.grey,height: 1,),
          ),),
      ),
    );
  }

  Widget buildFavouriteItem(FavoriteData? data,context) =>  Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      height: 120.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(data?.product?.image ?? ""),
                width: 120.0,
                height: 120.0,
                fit: BoxFit.cover,
              ),
              if (data?.product?.discount != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: const Text(
                    "DISCOUNT",
                    style: TextStyle(fontSize: 10.0, color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data?.product?.name ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(height: 1.3, fontSize: 14.0),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${data?.product?.price}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (data?.product?.discount != 0)
                      Text(
                        '${data?.product?.oldPrice}',
                        style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(data?.product?.id ??0);
                      },

                      icon:  CircleAvatar(
                          backgroundColor: ShopCubit.get(context).isFavourite(data?.product?.id )? defaultColor:Colors.grey,
                          radius: 15.0,
                          child:const  Icon(
                            Icons.favorite_outline,
                            size: 18.0,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
