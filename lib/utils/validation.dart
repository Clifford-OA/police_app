class Validation {
  String? firstNameValidation(value) {
    if (value!.isEmpty) {
      return 'Please Enter First Name';
    }
    return null;
  }

  String? momoValidation(value) {
    if (value!.isNotEmpty) {
      if (value!.toString().length != 10) {
        return 'Momo number should be 10 digits';
      }
    }
    return null;
  }
  // momoValidation

  String? chassisNumberValidation(value) {
    if (value!.isEmpty) {
      return 'Please Enter Chassis Number';
    }
    return null;
  }

  String? addressValidation(value) {
    if (value!.isEmpty) {
      return 'Please Enter Address';
    }
    return null;
  }

  String? surnameValidation(value) {
    if (value!.isEmpty) {
      return 'Please Enter Surname';
    }
    return null;
  }

  // String? emailValidation(value) {
  //   if (value!.isEmpty) {
  //     return 'Please Enter E-Mail';
  //   } else {
  //     final bool isValid = EmailValidator.validate(value);
  //     return isValid
  //         ? null
  //         : 'Please Enter a Valid E-mail\neg "kofimintah@gmail.com"';
  //   }
  // }

  String? phoneValidation(value) {
    if (value!.isEmpty) {
      return 'Please Enter Phone Number';
    } else if (value.length < 10) {
      return 'Please enter valid Phone Number\nMust be 10 digits';
    }
    return null;
  }

  String? reportFineValidation(value) {
    if (value!.isEmpty) {
      return 'Please Enter Complaint';
    }
    return null;
  }

  String? regionValidation(value) {
    List<String> regionCodes = [
      'AS',
      'AE',
      'AW',
      'BA',
      'CR',
      'ER',
      'GR',
      'GC',
      'GE',
      'GL',
      'GM',
      'GN',
      'GT',
      'GS',
      'GG',
      'GW',
      'GY',
      'GX',
      'NR',
      'UE',
      'UW',
      'VR',
      'WR'
    ];
    if (value!.isEmpty) {
      return 'Please Enter\nRegion Code';
    } else {
      final bool isValid = regionCodes.contains(value);
      return isValid ? null : 'Region Code\nNot Found';
    }
  }

  String? vehicleNumberValidation(value) {
    if (value!.isEmpty) {
      return 'Please Enter\nVehicle Number';
    }
    return null;
  }

  String? locationValidation(value) {
    if (value!.isEmpty || value.toString().length < 3) {
      return 'Location cannot be empty or less than 3 characters';
    }
    return null;
  }

  String? yearValidation(value) {
    int currentYear = DateTime.now().year % 2000;
    if (value!.isEmpty) {
      return 'Please Enter\nYear';
    } else if ((int.parse(value) < 09) || (int.parse(value) > currentYear)) {
      String returnValue = 'Please Enter\nYear from\n09 - 22';
      return returnValue;
    }
    return null;
  }

  String? passwordValidation(value) {
    if (value!.isEmpty) {
      return 'Please Enter Password';
    } else if (value.toString().length < 8) {
      return 'Weak Password\nMust be > 8 characters';
    }
    return null;
  }
}
