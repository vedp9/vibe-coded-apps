import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'add_item_model.dart';
export 'add_item_model.dart';

class AddItemScreenWidget extends StatefulWidget {
  const AddItemScreenWidget({super.key});

  static String routeName = 'AddItemScreen';
  static String routePath = '/addItemScreen';

  @override
  State<AddItemScreenWidget> createState() => _AddItemScreenWidgetState();
}

class _AddItemScreenWidgetState extends State<AddItemScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _picker = ImagePicker();
  File? _localImage;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddItemScreenModel(),
      child: Consumer<AddItemScreenModel>(
        builder: (context, model, child) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: const Color(0xFFC0B6A4),
              appBar: AppBar(
                backgroundColor: const Color(0xF1CD8754),
                automaticallyImplyLeading: false,
                title: Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Text(
                    'Upload Image',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.interTight(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
                centerTitle: false,
                elevation: 2,
              ),
              body: SafeArea(
                top: true,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: _localImage != null
                                ? Image.file(
                                    _localImage!,
                                    width: MediaQuery.sizeOf(context).width,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  )
                                : (model.uploadedPhotoUrl.isNotEmpty
                                    ? Image.network(
                                        model.uploadedPhotoUrl,
                                        width: MediaQuery.sizeOf(context).width,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        width: MediaQuery.sizeOf(context).width,
                                        height: 200,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.image, size: 50, color: Colors.grey),
                                      )),
                          ),
                        ),
                        Opacity(
                          opacity: 0.9,
                          child: Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: ElevatedButton(
                                onPressed: () async {
                                  final messenger = ScaffoldMessenger.of(context);
                                  final XFile? image = await _picker.pickImage(
                                    source: ImageSource.gallery,
                                    maxWidth: 1080,
                                    maxHeight: 1080,
                                    imageQuality: 80,
                                  );

                                  if (image != null) {
                                    setState(() {
                                      _localImage = File(image.path);
                                    });
                                    model.isDataUploading = true;
                                    try {
                                      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${image.name}';
                                      await Supabase.instance.client.storage
                                          .from('wool_images')
                                          .upload(fileName, _localImage!);
                                      
                                      final downloadUrl = Supabase.instance.client.storage
                                          .from('wool_images')
                                          .getPublicUrl(fileName);
                                      
                                      model.uploadedPhotoUrl = downloadUrl;
                                    } catch (e) {
                                      messenger.showSnackBar(
                                        SnackBar(content: Text('Upload failed: $e')),
                                      );
                                    } finally {
                                      model.isDataUploading = false;
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF985E54),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  minimumSize: const Size(0, 40),
                                  elevation: 0,
                                ),
                                child: model.isDataUploading 
                                    ? const SizedBox(
                                        width: 20, 
                                        height: 20, 
                                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                                      )
                                    : Text(
                                        'Take Photo',
                                        style: GoogleFonts.interTight(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: SizedBox(
                            width: 200,
                            child: TextFormField(
                              controller: model.titleFieldTextController,
                              focusNode: model.titleFieldFocusNode,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Item Title',
                                hintStyle: GoogleFonts.inter(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Theme.of(context).colorScheme.surface,
                              ),
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
                              ),
                              validator: model.titleFieldTextControllerValidator,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                            width: 200,
                            child: TextFormField(
                              controller: model.priceFieldTextController,
                              focusNode: model.priceFieldFocusNode,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Price',
                                prefixText: '₹ ',
                                prefixStyle: GoogleFonts.inter(
                                  color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
                                  fontSize: 14,
                                ),
                                hintStyle: GoogleFonts.inter(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Theme.of(context).colorScheme.surface,
                              ),
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
                              ),
                              validator: model.priceFieldTextControllerValidator,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (model.titleFieldTextController.text.isEmpty ||
                              model.priceFieldTextController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please fill all fields')),
                            );
                            return;
                          }

                          final messenger = ScaffoldMessenger.of(context);

                          try {
                            await Supabase.instance.client.from('catlog').insert({
                              'title': model.titleFieldTextController.text,
                              'price': model.priceFieldTextController.text,
                              'image_url': model.uploadedPhotoUrl,
                            });
                            
                            messenger.showSnackBar(
                              const SnackBar(content: Text('Item saved successfully!')),
                            );
                            
                            // Clear form
                            model.titleFieldTextController.clear();
                            model.priceFieldTextController.clear();
                            setState(() {
                              _localImage = null;
                            });
                            model.uploadedPhotoUrl = '';
                          } catch (e) {
                            messenger.showSnackBar(
                              SnackBar(content: Text('Error saving item: $e')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF433D75),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(0, 40),
                          elevation: 0,
                        ),
                        child: Text(
                          'Save Item',
                          style: GoogleFonts.interTight(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
