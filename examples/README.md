# DIRAC stdlib Examples

This directory contains practical examples demonstrating how to use the dirac-stdlib library.

## Running Examples

To run any example:

```bash
# Make sure dirac-lang is installed
npm install -g dirac-lang

# Run an example
dirac examples/csv-processor.di
```

## Available Examples

### 1. CSV Processor (`csv-processor.di`)

Demonstrates CSV parsing and data processing using string operations.

**Features:**
- Parse CSV data
- Split rows and columns
- Calculate statistics
- Format output reports

**Usage:**
```bash
dirac examples/csv-processor.di
```

**Output:**
```
DATA PROCESSING REPORT
========================
Original CSV:
name,age,score
Alice,25,95
Bob,30,87
Carol,28,92

Total Score: 274
Average Score: 91.33

End of Report
```

### 2. URL Builder (`url-builder.di`)

Shows how to construct and validate URLs using string operations.

**Features:**
- Build URLs from components
- URL encoding (space to %20)
- HTTPS validation
- Domain extraction

**Usage:**
```bash
dirac examples/url-builder.di
```

**Output:**
```
Built URL:
https://api.example.com/users/search?name=John%20Doe

Is Secure (HTTPS): true
Domain: api.example.com
```

### 3. Report Formatter (`report-formatter.di`)

Creates nicely formatted text reports with box-drawing characters.

**Features:**
- ASCII box drawing
- Text alignment and padding
- Math calculations
- Professional report layout

**Usage:**
```bash
dirac examples/report-formatter.di
```

**Output:**
```
╔════════════════════════════════════╗
║  MONTHLY SALES REPORT              ║
╠════════════════════════════════════╣
║ Period: January 2024               ║
╠════════════════════════════════════╣
║ Q1 Sales: $15000                   ║
║ Q2 Sales: $18000                   ║
╠════════════════════════════════════╣
║ TOTAL: $33000                      ║
║ AVERAGE: $16500                    ║
╚════════════════════════════════════╝

Total revenue for January 2024 was $33000
```

## Creating Your Own Examples

Follow this pattern:

```xml
<dirac>
  <!-- Import libraries -->
  <import src="../lib/math.di"/>
  <import src="../lib/string.di"/>
  
  <!-- Your logic here -->
  <call name="OPERATION" param="value"/>
  <output>{{result}}</output>
</dirac>
```

## Common Patterns

### String Processing Pipeline

```xml
<call name="TRIM" str="  text  "/>
<assign name="cleaned">{{result}}</assign>

<call name="UPPERCASE" str="{{cleaned}}"/>
<assign name="upper">{{result}}</assign>

<call name="REPLACE" str="{{upper}}" search="OLD" replace="NEW"/>
<output>{{result}}</output>
```

### Math Calculations

```xml
<call name="ADD" a="10" b="20"/>
<assign name="sum">{{result}}</assign>

<call name="SQUARE" x="{{sum}}"/>
<assign name="squared">{{result}}</assign>

<output>Result: {{squared}}</output>
```

### Combining Operations

```xml
<call name="FACTORIAL" num="5"/>
<assign name="fact">{{result}}</assign>

<call name="CONCAT" str1="Factorial is: " str2="{{fact}}"/>
<output>{{result}}</output>
```

## Tips

1. **Type Coercion**: All operations automatically handle type conversion
2. **Optional Parameters**: Check the API reference for which parameters are optional
3. **Error Handling**: Operations will fail gracefully with descriptive errors
4. **Chaining**: Use `<assign>` to store intermediate results for chaining operations

## More Information

- See [README.md](../README.md) for API reference
- See [EXAMPLES.md](../EXAMPLES.md) for detailed usage examples
- Check [tests/](../tests/) for comprehensive test cases
