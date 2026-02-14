# Contributing to dirac-stdlib

Thank you for your interest in contributing to dirac-stdlib! This document provides guidelines for contributing to the project.

## Development Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/wangzhi63/dirac-stdlib.git
   cd dirac-stdlib
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Run tests:
   ```bash
   npm test
   ```

## Project Structure

```
dirac-stdlib/
├── lib/              # Library source code (.di files)
│   ├── index.di     # Main entry point
│   ├── math.di      # Math operations
│   └── string.di    # String operations
├── tests/           # Unit tests
├── examples/        # Example usage
├── scripts/         # Build and test scripts
└── package.json     # Package configuration
```

## Adding New Operations

### 1. Implement the Operation

Add your operation to the appropriate library file (e.g., `lib/math.di` or `lib/string.di`):

```xml
<subroutine name="YOUR_OPERATION" param-input="type">
  <eval name="result">
    // JavaScript implementation
    return yourLogic(input);
  </eval>
  <output><variable name="result" /></output>
</subroutine>
```

**Guidelines:**
- Use String() coercion for string parameters
- Use Number() coercion for numeric parameters
- Handle optional parameters with typeof checks
- Add clear comments explaining the operation

### 2. Write Tests

Create test files in `tests/` following the naming convention `<operation>-<scenario>.test.di`:

```xml
<!-- TEST: operation_scenario -->
<!-- EXPECT: expected_output -->
<dirac>
  <import src="../lib/yourlib.di"/>
  <call name="YOUR_OPERATION" input="test_value"/>
</dirac>
```

**Test Coverage:**
- Basic functionality
- Edge cases (zero, negative, empty, null)
- Optional parameters
- Error conditions

### 3. Update Documentation

- Add the operation to README.md API Reference section
- Add examples to EXAMPLES.md
- Update CHANGELOG.md with the new feature

### 4. Run Tests

Ensure all tests pass:
```bash
npm test
```

## Code Style

- Use consistent indentation (2 spaces)
- Add XML comments for clarity
- Follow existing patterns in the codebase
- Keep operations focused and single-purpose

## Testing Guidelines

- Write tests before implementing (TDD)
- Cover both success and failure cases
- Use descriptive test names
- Each test should be independent

## Pull Request Process

1. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes and commit:
   ```bash
   git add .
   git commit -m "feat: add YOUR_OPERATION to math library"
   ```

3. Run tests and ensure they pass:
   ```bash
   npm test
   ```

4. Push to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```

5. Open a Pull Request with:
   - Clear description of changes
   - Test results
   - Example usage
   - Updated documentation

## Commit Message Convention

Follow [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `test:` - Test changes
- `refactor:` - Code refactoring
- `chore:` - Maintenance tasks

Examples:
```
feat: add POWER operation to math library
fix: handle empty string in TRIM operation
docs: update SUBSTRING examples
test: add edge cases for FACTORIAL
```

## Questions or Issues?

- Open an issue on GitHub
- Check existing issues and discussions
- Be respectful and constructive

Thank you for contributing to DIRAC!
