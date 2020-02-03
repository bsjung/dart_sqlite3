import "package:dart_sqlite3/dart_sqlite3.dart";

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
