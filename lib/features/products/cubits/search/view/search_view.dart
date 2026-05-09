import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/features/home/views/widgets/search_text_field.dart';
import 'package:yum_quick/features/products/cubits/search/search_cubit.dart';
import 'package:yum_quick/features/products/cubits/search/search_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFDF8),
        body: SafeArea(
          child: Column(
            children: [
              SearchTextField(),

              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchInitial) {
                      return const Center(
                        child: Text(
                          'Search',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      );
                    } else if (state is SearchLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFD84315),
                        ),
                      );
                    } else if (state is SearchSuccess) {
                      if (state.products.isEmpty) {
                        return const Center(
                          child: Text(
                            'No Products',
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: state.products.length,
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          var product = state.products[index];
                          return _buildProductItem(product);
                        },
                      );
                    } else if (state is SearchError) {
                      return Center(
                        child: Text(
                          'Error ${state.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductItem(dynamic product) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),

        // الصورة بتاعة المنتج
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 60,
            height: 60,
            color: Colors.grey.shade200,
            // لو الداتا راجعة فيها صورة حقيقية، شيل الـ Icon واستخدم Image.network
            child: const Icon(Icons.fastfood, color: Colors.orange),
            /*
            child: Image.network(
              product['image'] ?? '', // غير 'image' حسب الكلمة اللي في الـ API
              fit: BoxFit.cover,
            ),
            */
          ),
        ),

        // اسم المنتج
        title: Text(
          product['name'] ?? 'اسم المنتج', // غير 'name' حسب الـ API عندك
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        // وصف بسيط
        subtitle: Text(
          product['description'] ??
              'وصف المنتج', // غير 'description' حسب الـ API
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        // السعر
        trailing: Text(
          '\$${product['price'] ?? '0.0'}', // غير 'price' حسب الـ API
          style: const TextStyle(
            color: Color(0xFFD84315),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
