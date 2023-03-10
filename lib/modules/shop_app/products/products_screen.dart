
import 'package:app_test/layout/shop_app/cubit/shop_home_cubit.dart';
import 'package:app_test/layout/shop_app/cubit/states.dart';
import 'package:app_test/model/shop/categories_model.dart';
import 'package:app_test/model/shop/home_model.dart';
import 'package:app_test/shared/components/components.dart';
import 'package:app_test/shared/styles/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopHomeStates>(
        listener: (context, state) {
          if(state is ShopHomeFavouriteChangeSuccessState){
             if(state.status==false){
                 showToast("An Error Happen Pleas Try Again.", ToastStates.ERROR);
             }
          }

        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesHomeModel != null,
            builder: (context) => productsBuilder(
                ShopCubit.get(context).homeModel,
                ShopCubit.get(context).categoriesHomeModel,context),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Widget productsBuilder(
      HomeModel? homeModel, CategoriesModel? categoriesHomeModel, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: homeModel?.data?.banners
                  .map((bannerItem) => Image(
                        image: NetworkImage(bannerItem.image ?? ""),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal)),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(fontSize: 24.0),
                ),
                SizedBox(
                  height: 100.0,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoryItem(
                          categoriesHomeModel?.data?.data![index].image ?? "",
                          categoriesHomeModel?.data?.data![index].name ?? ""),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 20,
                          ),
                      itemCount: categoriesHomeModel?.data?.data?.length ?? 0),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "New Products",
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.6,
            children: List.generate(homeModel?.data?.products.length ?? 0,
                (index) => buildItemGrid(homeModel?.data?.products[index],context)),
          )
        ],
      ),
    );
  }

  Widget buildCategoryItem(image, title) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage(image),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
              width: 100,
              color: Colors.black.withOpacity(.8),
              child: Text(
                title,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ))
        ],
      );

  Widget buildItemGrid(ProductModel? product, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(product?.image ?? ""),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (product?.discount != 0)
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    product?.name ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.3, fontSize: 14.0),
                  ),
                  Row(
                    children: [
                      Text(
                        '${product?.price}',
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
                      if (product?.discount != 0)
                        Text(
                          '${product?.oldPrice}',
                          style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(product?.id ??0);
                        },

                        icon:  CircleAvatar(
                        backgroundColor: ShopCubit.get(context).isFavourite(product?.id)? defaultColor:Colors.grey,
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
      );
}
