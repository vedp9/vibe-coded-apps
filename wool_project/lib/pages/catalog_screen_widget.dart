import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'catalog_screen_model.dart';
export 'catalog_screen_model.dart';

class CatalogScreenWidget extends StatefulWidget {
  const CatalogScreenWidget({super.key});

  static String routeName = 'CatalogScreen';
  static String routePath = '/catalogScreen';

  @override
  State<CatalogScreenWidget> createState() => _CatalogScreenWidgetState();
}

class _CatalogScreenWidgetState extends State<CatalogScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  late Future<List<Map<String, dynamic>>> _fetchData;

  @override
  void initState() {
    super.initState();
    _fetchData = _fetchCatalogItems();
  }
  
  Future<List<Map<String, dynamic>>> _fetchCatalogItems() async {
    final response = await Supabase.instance.client
        .from('catlog')
        .select()
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> _deleteItem(int id) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await Supabase.instance.client
          .from('catlog')
          .delete()
          .eq('id', id);
          
      setState(() {
        _fetchData = _fetchCatalogItems();
      });
      messenger.showSnackBar(
        const SnackBar(content: Text('Item deleted successfully')),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Failed to delete item: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CatalogScreenModel(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: const Color(0xF1CD8754),
            automaticallyImplyLeading: false,
            title: Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Text(
                'Wool Items',
                textAlign: TextAlign.center,
                style: GoogleFonts.interTight(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            elevation: 2,
          ),
          body: SafeArea(
            top: true,
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No items found.'));
                }

                final itemData = snapshot.data!;

                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 11,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: itemData.length,
                  itemBuilder: (context, index) {
                    final item = itemData[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: InkWell(
                                onTap: () {
                                  if (item['image_url'] != null && item['image_url'].isNotEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return BackdropFilter(
                                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                          child: Dialog(
                                            backgroundColor: Colors.transparent,
                                            insetPadding: const EdgeInsets.all(20),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                InteractiveViewer(
                                                  panEnabled: true,
                                                  minScale: 0.5,
                                                  maxScale: 4,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(16),
                                                    child: Image.network(
                                                      item['image_url'],
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: IconButton(
                                                    icon: const Icon(Icons.close, color: Colors.white, size: 30),
                                                    onPressed: () => Navigator.of(context).pop(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: item['image_url'] != null && item['image_url'].isNotEmpty
                                      ? Hero(
                                          tag: 'image_${item['id']}',
                                          child: Image.network(
                                            item['image_url'],
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(
                                          color: Colors.grey[300],
                                          child: const Center(child: Icon(Icons.image, color: Colors.grey)),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(1, -1),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: InkWell(
                                onTap: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: const Text('Delete Item?'),
                                        content: const Text('Are you sure you want to delete this item?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(alertDialogContext, false),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.pop(alertDialogContext, true),
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      );
                                    },
                                  ) ?? false;

                                  if (confirm) {
                                    await _deleteItem(item['id']);
                                  }
                                },
                                child: Icon(
                                  Icons.delete_sharp,
                                  color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              item['title'] ?? 'No Title',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '₹ ${item['price'] ?? '0.00'}',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF313636),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
