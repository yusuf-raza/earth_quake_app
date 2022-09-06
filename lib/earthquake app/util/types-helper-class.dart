
//this class saves from types mismatch between
//int and double type properties from Json data

class TypesHelperClass {

  static int toInt(num? val) {
    try {
      if (val == null) {
        return 0;
      }
      if (val is int) {
        return val;
      } else {
        return val.toInt();
      }
    }catch(error) {
      print(error);
      return 0;
    }

  }

  static double toDouble(num? val){
    try{
      if (val == null) {
        return 0;
      }
      if (val is double) {
        return val;
      } else {
        return val.toDouble();
      }

    }catch(error){
      print(error);
      return 0;
    }
  }

}