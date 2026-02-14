# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2026-02-14

### Added
- **Math Operations Library** (`lib/math.di`)
  - ADD: Add two numbers
  - SQUARE: Square a number
  - FACTORIAL: Calculate factorial
  - Automatic Number() type coercion for all operations
  
- **String Operations Library** (`lib/string.di`)
  - SUBSTRING: Extract portion of string with optional length
  - REPLACE: Replace text (literal and regex support)
  - SPLIT: Split string by delimiter
  - JOIN: Join newline-separated items with delimiter
  - TRIM: Remove leading/trailing whitespace
  - UPPERCASE: Convert to uppercase
  - LOWERCASE: Convert to lowercase
  - INDEXOF: Find position of substring
  - INCLUDES: Check if string contains substring
  - LENGTH: Get string length
  - CONCAT: Concatenate two strings
  - Automatic String() type coercion for all operations

- **Unit Testing Infrastructure**
  - 24 comprehensive unit tests (8 math + 16 string)
  - Custom test runner using dirac-lang test-runner
  - Test coverage for edge cases (negative numbers, zero, empty strings, optional parameters)

- **Documentation**
  - Comprehensive README.md with API reference
  - EXAMPLES.md with detailed usage examples
  - Three practical examples: CSV processor, URL builder, report formatter

### Testing
- All 24 tests passing
- Math operations: 8/8 tests passing
- String operations: 16/16 tests passing

[0.1.0]: https://github.com/wangzhi63/dirac-stdlib/releases/tag/v0.1.0
