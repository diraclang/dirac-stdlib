# DIRAC Stdlib Test Suite

Unit tests for dirac-stdlib library (Math & String operations).

## Running Tests

```bash
npm test
```

## Test Structure

Each test file follows the format:
```xml
<!-- TEST: test_name -->
<!-- EXPECT: expected output -->
<dirac>
  <!-- test code -->
</dirac>
```

## Test Coverage

### Math Operations (lib/math.di)
- ✅ ADD - Addition with type coercion
- ✅ SQUARE - Squaring numbers
- ✅ FACTORIAL - Factorial calculation
- TODO: Edge cases (negative numbers, zero, large numbers)

### String Operations (lib/string.di)
- TODO: SUBSTRING
- TODO: REPLACE
- TODO: SPLIT
- TODO: JOIN
- TODO: TRIM
- TODO: UPPERCASE/LOWERCASE

## Notes

- Tests use the `dirac` test runner from dirac-lang
- All tests must handle type coercion (XML attributes are strings)
- Expected output must match exactly (including whitespace)
