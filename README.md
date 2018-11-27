# Button Debounce Example

## What is it?

It is an example working project demonstrate the usage of the [Button Debounce library](https://github.com/the-cave/button-debounce).

## The hardware

If you really want to run this project you need the [STM8S development board](https://web.archive.org/web/20160623002534/https://www.cnx-software.com/2015/01/18/one-dollar-development-board/) with a tact switch connecting between pin C3 and ground. However, I don't recommend buying the hardware just to run the example. The library is hardware and platform agnostic. It will work everywhere regardless of the hardware you use. The objective of this project is to show the actual working example of the library.

## List of software prerequisites to compile the code

* [Git](https://git-scm.com/)
* [Small Device C Compiler](http://sdcc.sourceforge.net/)
* [GNU Make](https://www.gnu.org/software/make/)

## Build instructions

Simply clone this repository with submodules and `make`
```
$ git clone --recurse-submodules https://github.com/midnight-wonderer/button-debounce-example.git
$ cd button-debounce-example
$ make
```

## License

Button Debounce is released under the [MIT License](https://opensource.org/licenses/MIT).
