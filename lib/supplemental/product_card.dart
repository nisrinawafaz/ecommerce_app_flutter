// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../colors.dart';
import '../model/product.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {this.imageAspectRatio = 33 / 49, required this.product, Key? key})
      : assert(imageAspectRatio > 0),
        super(key: key);

  final double imageAspectRatio;
  final Product product;

  static const kTextBoxHeight = 65.0;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  static bool _isHovering = false;

  void _onHoverChanged(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        decimalDigits: 0, locale: Localizations.localeOf(context).toString());
    final ThemeData theme = Theme.of(context);

    final imageWidget = Image.asset(
      widget.product.assetName,
      package: widget.product.assetPackage,
      fit: BoxFit.cover,
    );

    return MouseRegion(
        onEnter: (_) {
          _onHoverChanged(true);
        },
        onExit: (_) {
          _onHoverChanged(false);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: widget.imageAspectRatio,
              child: imageWidget,
            ),
            SizedBox(
              height: ProductCard.kTextBoxHeight *
                  MediaQuery.of(context).textScaleFactor,
              width: 121.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.product.name,
                    style: theme.textTheme.labelLarge,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4.0),
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 5.0),
                      Text(
                        formatter.format(widget.product.price),
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8.0),
                      Visibility(
                        visible: _isHovering,
                        child: Container(
                          width: 70.0,
                          height: 2.0,
                          color: kShrinePink400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
