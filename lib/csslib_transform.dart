// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// The csslib_transform library.
///
/// This library is just transformer that use csslib.
library csslib_transform;

import 'package:barback/barback.dart';

import 'dart:async';
import 'package:csslib/parser.dart' show compile;
import 'package:csslib/src/messages.dart';
import 'package:csslib/src/options.dart';
import 'package:csslib/visitor.dart';
import 'package:logging/logging.dart';
//import 'package:csslib/css.dart';

const csslibOptions = const PreprocessorOptions(
    useColors: true,
    checked: true,
    polyfill: true,
    inputFile: 'memory');

class CSSLib_Tranform extends Transformer {
  String copyright = "Copyright (c) 2015, Valentyn Shybanov (olostan).\n";

  CSSLib_Tranform.asPlugin();

  Future<bool> isPrimary(AssetId id) async => id.extension == '.scss';

  Future apply(Transform transform) async {
    var content = await transform.primaryInput.readAsString();
    var id = transform.primaryInput.id.changeExtension('.css');
    var errors = new List<Message>();
    var stylesheet = compile(content,errors:errors,options:csslibOptions,polyfill:true);
    var emitCss = new CssPrinter();
    var result = (emitCss..visitTree(stylesheet, pretty: true)).toString();
    errors.forEach((m) {
      if (m.level==Level.SEVERE)
        transform.logger.error(m.message,span:m.span);
      else if (m.level==Level.WARNING)
        transform.logger.warning(m.message,span:m.span);
      else transform.logger.info(m.message,span:m.span);
    });
    transform.addOutput(new Asset.fromString(id,result));
  }
}