# significant_format
This package provides a `SignificantFormat` class which formats a double value in significant figure in roundup or truncate mode.
If `locale` is provided in input, the number will be formatted with thousands separator (`,` or `.`) according to the locale provided.

<a href="https://www.buymeacoffee.com/khpiyak" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-blue.png" alt="Buy Me A Coffee" height="60px"></a>

## Getting Started
In your flutter project add the dependency:

```yml
dependencies: 
 ... 
 significant_format:
```

## Usage example
 ```dart
import 'package:significant_format/significant_format.dart'

void main() {
 // format 0.000012345 with 4 significant figure using truncate
 // formatted = 0.00001234 
 String formatted = SignificantFormat().truncate(0.000012345, 4);

 // format 12345 with 4 significant figure using roundup
 // formatted = 12350
 String formatted = SignificantFormat().roundup(12345, 4);

 // pass optional locale will format the value as amount which containing thousands separator
 // amount = 12,350
 String amount = SignificantFormat().roundup(12345, 4, locale: "en");
}
 ```

