# dart_sqlite3
 
It is from Dart SDK v2.8.0-dev6.0 ( https://github.com/dart-lang/sdk/tree/master/samples/ffi/sqlite ).

## Prerequirement

For Linux, you should make sure, sqlite dev lib installed on your system.
For example, there are packages for ubuntu.

```
% sudo apt-get install sqlite3 libsqlite3-dev
```

For Mac, user can install with brew.
```
% brew install sqlite3 
```

For Windows, user can download dll from https://www.sqlite.org/download.html

If you do not have any sqlite3.dll or so file, you may found error message:

```
Unhandled exception:
Invalid argument(s): Failed to load dynamic library (126)
#0      _open (dart:ffi-patch/ffi_dynamic_library_patch.dart:13:55)
#1      new DynamicLibrary.open (dart:ffi-patch/ffi_dynamic_library_patch.dart:22:12)
```

## Example

This is a sample dart program for SQLite3.

```dart
import "package:dart_sqlite3/sqlite.dart";

void main() {
  Database d = Database("test.db");
  d.execute("drop table if exists stocks;");
  d.execute("""
      create table stocks (
        date text not null,
        trans text not null,
        symbol text not null,
        qty integer,
        price real
      );""");
  d.execute("""
      insert into stocks (date, trans, symbol, qty, price)
      values
        ('2006-01-05','BUY','RHAT',100,35.14),
        ('2006-01-05','SELL','IBM',1000,45)
      ;""");
  Result result = d.query("select * from stocks where symbol = 'IBM';");
  for (Row r in result) {
    String date = r.readColumn("date");
    String trans = r.readColumn("trans");
    String symbol = r.readColumn("symbol");
    int qty = r.readColumnAsInt("qty");
    double price = r.readColumnAsDouble("price");
    print("$date $trans $symbol $qty $price");
  }

  //d.execute("drop table stocks;");
  d.close();
}
```

## Tutorial

A tutorial walking through the code is available in [docs/sqlite-tutorial.md](docs/sqlite-tutorial.md).
For information on how to use this package within a Flutter app, see [docs/android.md](docs/android.md).
(Note: iOS is not yet supported).

## Authors

 Daco Harkes <dacoharkes@google.com>

 Samir Jindel <sjindel@google.com>

 Benjamin Jung <bsjung@google.com>

## License

Copyright 2012, the Dart project authors.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of Google Inc. nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

