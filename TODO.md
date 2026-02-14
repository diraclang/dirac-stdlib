# DIRAC Stdlib - TODO

**Project**: Standard library for DIRAC (Math & String operations)  
**Location**: `/Users/zhiwang/diraclang/dirac-stdlib/`  
**Parent TODO**: See `/Users/zhiwang/diraclang/dirac/TODO.md`

## ✅ Completed

- [x] **Math library**: Ported from dirac-lang/lib/math.di
  - Functions: ADD, SUBTRACT, MULTIPLY, DIVIDE, SQUARE, FACTORIAL
  - Uses Number() type coercion (v0.1.26)
  - 8 unit tests passing

- [x] **Testing infrastructure**: Unit test framework
  - Uses dirac test-runner from dirac-lang
  - ES module wrapper: scripts/test.js
  - Test format: `<!-- TEST: name -->` `<!-- EXPECT: output -->`
  - 24 unit tests passing (8 math + 16 string)

- [x] **String operations library**: Core string manipulation
  - **Why**: Core utilities needed for practical scripting
  - Implemented operations:
    - SUBSTRING: Extract portion of string
    - REPLACE: Replace text (literal and regex support)
    - SPLIT: Split string by delimiter into array
    - JOIN: Join array into string
    - TRIM: Remove whitespace
    - UPPERCASE, LOWERCASE: Case conversion
    - INDEXOF: Find position of substring
    - INCLUDES: Check if string contains substring
    - LENGTH: Get string length
    - CONCAT: Concatenate strings
  - File: `lib/string.di`
  - 16 unit tests passing

## 🔴 High Priority

### Pending

- [ ] **Advanced math operations**: Port from advanced-math.di
  - **Why**: Extend math capabilities for scientific computing
  - MATH_SQRT, MATH_STATS, MATH_GCD, MATH_PRIME, MATH_RANDOM
  - Already implemented in dirac-lang
  - Need unit tests

- [ ] **String validation**: Pattern matching and validation
  - **Why**: Common validation needs (email, URLs, phone numbers)
  - EMAIL, URL, PHONE validation patterns
  - Custom regex validation
  - Need unit tests

- [ ] **Documentation**: API reference and examples
  - **Why**: Enable adoption; users need examples
  - Each function documented with examples
  - Common use cases
  - Migration guide from dirac-lang/lib

## 🟢 Low Priority / Future

### Pending
- [ ] **Performance optimization**: Benchmark and optimize
  - Compare with native JS operations
  - Cache compiled regexes

- [ ] **Additional utilities**: As needed
  - Date/time operations
  - Base64 encode/decode
  - Hash functions

## ✅ Completed

- [x] **Math library**: Port from dirac-lang/lib/math.di (v0.1.0)
  - Functions: ADD, SQUARE, FACTORIAL
  - Has Number() type coercion
  - ✅ 8 unit tests passing (add, square, factorial with edge cases)

- [x] **Testing infrastructure**: Unit test framework (v0.1.0)
  - Uses dirac test-runner
  - 8 math tests: basic operations, negative numbers, zero, edge cases
  - Test script: `npm test`

- [x] **Project structure**
  - Created package.json
  - Created lib/index.di
  - Basic README

---

## Notes
- **Last updated**: 2026-02-14
- **Current version**: 0.1.0 (not yet published)
- **Priority**: High - core utilities needed for scripting
- **Dependencies**: None (pure DIRAC)
- **Strategy**: Port existing math.di, create new string.di
