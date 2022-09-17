import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';

import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var _isInit = true;
  var _isloading = false;
  var _initvalueMap = {
    'title': '',
    'description': '',
    'imageUrl': '',
    'price': '',
  };
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: '',
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
    isFavorite: false,
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //for edit product data
    if (_isInit) {
      final productid = ModalRoute.of(context)?.settings.arguments;
      if ((productid) != null) {
        print("hhh");
        final _editedProduct =
            Provider.of<ProductProvider>(context).findById(productid as String);
        _initvalueMap = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (_imageUrlFocusNode.hasFocus == false) {
      if ((!_imageUrlController.text.startsWith('http') &&
          !_imageUrlController.text.startsWith('https'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final _isvalid = _form.currentState!.validate();
    if (_isvalid == false) {
      //so do not need to save form
      return;
    } else {
      //if it is valid thaen save
      _form.currentState!.save();
      setState(() {
        _isloading =
            true; //when future fun addproduct is not complete at that time loading true
      });
      try {
        await Provider.of<ProductProvider>(context, listen: false)
            .addProduct(_editedProduct); //because addproduct is a async and future fun so use await
      } catch (error) {
      await  showDialog(// showDialog is also future fuction
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('A error occurred!'),
                content: Text('somethings wents wrong.${error}'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("okey"),
                  ),
                ],
              );
            });
      } finally {
        //if sucessed or fail no matter this cade will always be executed
        setState(() {
          _isloading =
              false; // future function of addProduct is completed then we do isloading is flase
        });
        Navigator.of(context).pop();
      }

      //here i am not changing the product
      print("addProduct true");
      //but only sumbmit data
    }
  }

  void _editForm() {
    final _isvalid = _form.currentState!.validate();
    if (_isvalid == false) {
      //so do not need to save form
      return;
    } else {
      //if it is valid thaen save
      _form.currentState!.save();
      // print(_editedProduct.title);
      // print(_editedProduct.description);
      // print(_editedProduct.price);
      // print(_editedProduct.imageUrl);
      // if(){

      // }

      Provider.of<ProductProvider>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      print("updateProduct true");

      //but only sumbmit data
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit_attributes_rounded),
            // onPressed: _saveForm,
            onPressed: () {
              _editForm();
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            // onPressed: _saveForm,
            onPressed: () {
              _saveForm();
            },
          ),
        ],
      ),
      body: (_isloading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                // mow we can manage state with the hlp of form key
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initvalueMap['title'],
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        // if we retrun null mean input is current
                        // if it retrun Stirng then it denote error text //masage which is shown to user
                        if (value!.isEmpty) {
                          //error
                          return 'Enter the Title';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: value.toString(),
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                          imageUrl: _editedProduct.imageUrl,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initvalueMap['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      validator: (value) {
                        // if we retrun null mean input is current
                        // if it retrun Stirng then it denote error text //masage which is shown to user
                        if (value!.isEmpty) {
                          //error
                          return 'Enter the Price';
                        }
                        if (double.tryParse(value) == null) {
                          //for abcd
                          return 'enter valid number';
                        }
                        if (double.parse(value) <= 0) {
                          return 'enter enter grater then 0 number';
                        }

                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            title: _editedProduct.title,
                            price: double.parse(value.toString()),
                            description: _editedProduct.description,
                            imageUrl: _editedProduct.imageUrl,
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initvalueMap['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      validator: (value) {
                        // if we retrun null mean input is current
                        // if it retrun Stirng then it denote error text //masage which is shown to user
                        if (value!.isEmpty) {
                          //error
                          return 'Enter the Description';
                        }
                        if (value.length < 10) {
                          return 'should be at least 10 char long';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            title: _editedProduct.title,
                            price: _editedProduct.price,
                            description: value.toString(),
                            imageUrl: _editedProduct.imageUrl,
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite);
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            //if we use controler then we can not apply initialvlaue
                            //  initialValue: _initvalueMap['imageUrl'],
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            validator: (value) {
                              // if we retrun null mean input is current
                              // if it retrun Stirng then it denote error text //masage which is shown to user
                              if (value!.isEmpty) {
                                //error
                                return 'Enter the image url';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'enter valid URL';
                              }
                              // if ((!_imageUrlController.text.endsWith('.png') &&
                              //     !_imageUrlController.text.endsWith('.jpg') &&
                              //     !_imageUrlController.text.endsWith('.jpeg'))) {
                              //   return 'enter valid web URL';
                              // }
                              return null;
                            },
                            onFieldSubmitted: (context) {
                              print("object");
                              _saveForm();
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                  title: _editedProduct.title,
                                  price: _editedProduct.price,
                                  description: _editedProduct.description,
                                  imageUrl: value.toString(),
                                  id: _editedProduct.id,
                                  isFavorite: _editedProduct.isFavorite);
                            },
                          ),
                        ),
                        // IconButton(
                        //   onPressed: () {
                        //     setState(() {});
                        //   },
                        //   icon: Icon(Icons.check),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}



//if we working with focus node then when page is end then it will be stay as it is
  //so we need to despose it