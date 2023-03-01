import 'package:app_test/modules/shop_app/search/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/shop_home_cubit.dart';
import '../../../model/shop/search_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';
import 'cubit/search_states.dart';

class ShopSearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, HomeSearchStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text("Search"),
          ),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormField(
                      controller: searchController,
                      hint: "Enter your Value",
                      label: "Search",
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return "Search value must not be empty";
                        }
                        return null;
                      },
                      onSubmit: (newValue) {
                        if (formKey.currentState?.validate() == true) {
                          SearchCubit.get(context).search(newValue);
                        }
                      },
                      prefixIcon: Icons.search,
                      textInputType: TextInputType.text),
                ),
                if (state is HomeSearchLoadingState)
                  const LinearProgressIndicator(),
                if (state is HomeSearchGetDataSuccessState)
                  Expanded(
                    child: ListView.separated(

                        itemBuilder: (context, index) => buildSearchItem(
                            SearchCubit.get(context).model?.data?.data![index],
                            context),
                        separatorBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                color: Colors.grey,
                                height: 1,
                              ),
                            ),
                        itemCount: SearchCubit.get(context)
                                .model
                                ?.data
                                ?.data
                                ?.length ??
                            0),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSearchItem(Product? product, context) => Padding(
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
                    image: NetworkImage(product?.image ?? ""),
                    width: 120.0,
                    height: 120.0,
                    fit: BoxFit.cover,
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
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product?.name ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(height: 1.3, fontSize: 14.0),
                    ),
                    const Spacer(),
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
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(product?.id ?? 0);
                          },
                          icon: CircleAvatar(
                              backgroundColor: ShopCubit.get(context)
                                      .isFavourite(product?.id)
                                  ? defaultColor
                                  : Colors.grey,
                              radius: 15.0,
                              child: const Icon(
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
