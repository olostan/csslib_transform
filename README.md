# csslib_transform

This is just trasnformer that use [csslib][csslib] to transform scss files into css. 

## Usage

Add `csslib_trasnform` as dependency and add it as transformer:

    dependencies:
      ...
      csslib_transform:
      
    transformers:
    -  csslib_transform
    

And all `*.scss` files would be available as CSS files. So if you have `test.scss` file in `styles` folder,
you can refer it as

        <link rel="stylesheet" href="styles/main.css">

       
## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/olostan/csslib_transform/issues
[csslib]: https://github.com/dart-lang/csslib
