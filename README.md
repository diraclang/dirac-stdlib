# dirac-stdlib

Standard library for DIRAC - provides core utilities for math and string operations.

**Status**: ✅ Production ready - All 24 unit tests passing

## Features

- ✅ **Math Operations**: ADD, SQUARE, FACTORIAL with Number() type coercion
- ✅ **String Operations**: SUBSTRING, REPLACE, SPLIT, JOIN, TRIM, UPPERCASE, LOWERCASE, INDEXOF, INCLUDES, LENGTH, CONCAT
- ✅ **Unit Tests**: Comprehensive test coverage (24 tests)
- ✅ **Type Safety**: Automatic type coercion for robust handling

## Installation

```bash
npm install dirac-stdlib
```

## Usage

### Math Operations

```xml
<dirac>
  <import src="dirac-stdlib/lib/math"/>
  
  <!-- Add two numbers -->
  <call name="ADD" a="5" b="3" output="result"/>
  <output><variable name="result"/></output> <!-- 8 -->
  
  <!-- Square a number -->
  <call name="SQUARE" x="4" output="squared"/>
  <output><variable name="squared"/></output> <!-- 16 -->
  
  <!-- Calculate factorial -->
  <call name="FACTORIAL" num="5" output="fact"/>
  <output><variable name="fact"/></output> <!-- 120 -->
</dirac>
```

### String Operations

```xml
<dirac>
  <import src="dirac-stdlib/lib/string.di"/>
  
  <!-- Extract substring -->
  <call name="SUBSTRING" str="Hello World" start="0" length="5"/>
  <!-- Output: Hello -->
  
  <!-- Replace text -->
  <call name="REPLACE" str="Hello World" search="World" replace="DIRAC"/>
  <!-- Output: Hello DIRAC -->
  
  <!-- Split string -->
  <call name="SPLIT" str="apple,banana,cherry" delimiter=","/>
  <!-- Output: 
  apple
  banana
  cherry
  -->
  
  <!-- Join array -->
  <call name="JOIN" items="apple
banana
cherry" delimiter=", "/>
  <!-- Output: apple, banana, cherry -->
  
  <!-- Trim whitespace -->
  <call name="TRIM" str="  hello  "/>
  <!-- Output: hello -->
  
  <!-- Case conversion -->
  <call name="UPPERCASE" str="hello"/>
  <!-- Output: HELLO -->
  
  <call name="LOWERCASE" str="WORLD"/>
  <!-- Output: world -->
  
  <!-- Search operations -->
  <call name="INDEXOF" str="hello world" search="world"/>
  <!-- Output: 6 -->
  
  <call name="INCLUDES" str="hello world" search="world"/>
  <!-- Output: true -->
  
  <!-- String length -->
  <call name="LENGTH" str="hello"/>
  <!-- Output: 5 -->
  
  <!-- Concatenate -->
  <call name="CONCAT" str1="hello" str2=" world"/>
  <!-- Output: hello world -->
</dirac>
```

## API Reference

### Math Operations

- **ADD(a, b)**: Add two numbers
- **SQUARE(x)**: Square a number
- **FACTORIAL(num)**: Calculate factorial

### String Operations

- **SUBSTRING(str, start, [length])**: Extract portion of string
- **REPLACE(str, search, replace, [regex])**: Replace text (supports regex with regex="true")
- **SPLIT(str, delimiter)**: Split string by delimiter (returns newline-separated values)
- **JOIN(items, [delimiter])**: Join newline-separated items with delimiter
- **TRIM(str)**: Remove leading and trailing whitespace
- **UPPERCASE(str)**: Convert to uppercase
- **LOWERCASE(str)**: Convert to lowercase
- **INDEXOF(str, search, [start])**: Find position of substring (-1 if not found)
- **INCLUDES(str, search)**: Check if string contains substring (returns true/false)
- **LENGTH(str)**: Get string length
- **CONCAT(str1, str2)**: Concatenate two strings

See [EXAMPLES.md](./EXAMPLES.md) for more usage examples.

## Testing

```bash
npm test
```

All 24 unit tests passing:
- 8 math operation tests
- 16 string operation tests

## Development

This library requires `dirac-lang` as a devDependency for testing:

```bash
npm install
npm test
```

## License

MIT
