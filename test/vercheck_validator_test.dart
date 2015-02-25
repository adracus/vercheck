library vercheck.test.validator;

import 'package:unittest/unittest.dart';

import 'package:vercheck/vercheck.dart';


defineValidatorTests() {
  group("Validator", () {
    test("createPubUri", () {
      var url1 = createPubUri("pub.dartlang.org", prefix: "api");
      var url2 = createPubUri("my.pub.org", secure: false);
      var url3 = createPubUri("my.own.pub", prefix: "api/pub/v1", secure: false);
      
      expect(url1.toString(), equals("https://pub.dartlang.org/api"));
      expect(url2.toString(), equals("http://my.pub.org"));
      expect(url3.toString(), equals("http://my.own.pub/api/pub/v1"));
    });
    
    test("join", () {
      var url1 = Uri.parse("http://my.own.pub/api/pub/v1/");
      var url2 = Uri.parse("http://pub.dartlang.org/api");
      
      expect(join("mypackage", url1).toString(),
          equals("http://my.own.pub/api/pub/v1/mypackage"));
      expect(join("mypackage", url2).toString(),
          equals("http://pub.dartlang.org/api/mypackage"));
    });
    
    test("getPackageJson", () {
      getPackageJson("rsa").then(expectAsync((json) {
        var pubspec = json["latest"]["pubspec"];
        var package = new Package.parse(pubspec);
      }));
    });
  });
}