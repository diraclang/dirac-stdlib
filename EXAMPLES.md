# DIRAC Standard Library Examples

## Math Operations

### Addition
```xml
<dirac>
  <import src="dirac-stdlib/lib/math.di"/>
  <call name="ADD" a="5" b="3"/>
  <!-- Output: 8 -->
</dirac>
```

### Square
```xml
<dirac>
  <import src="dirac-stdlib/lib/math.di"/>
  <call name="SQUARE" x="7"/>
  <!-- Output: 49 -->
</dirac>
```

### Factorial
```xml
<dirac>
  <import src="dirac-stdlib/lib/math.di"/>
  <call name="FACTORIAL" num="5"/>
  <!-- Output: 120 -->
</dirac>
```

## String Operations

### SUBSTRING - Extract portion of string
```xml
<dirac>
  <import src="dirac-stdlib/lib/string.di"/>
  <call name="SUBSTRING" str="hello world" start="0" length="5"/>
  <!-- Output: hello -->
</dirac>
```

### REPLACE - Replace text
```xml
<dirac>
  <import src="dirac-stdlib/lib/string.di"/>
  <call name="REPLACE" str="hello world" search="world" replace="universe"/>
  <!-- Output: hello universe -->
</dirac>
```

### SPLIT - Split string by delimiter
```xml
<dirac>
  <import src="dirac-stdlib/lib/string.di"/>
  <call name="SPLIT" str="apple,banana,cherry" delimiter=","/>
  <!-- Output:
  apple
  banana
  cherry
  -->
</dirac>
```

### JOIN - Join array into string
```xml
<dirac>
  <import src="dirac-stdlib/lib/string.di"/>
  <call name="JOIN" items="apple
banana
cherry" delimiter=", "/>
  <!-- Output: apple, banana, cherry -->
</dirac>
```

### TRIM - Remove whitespace
```xml
<dirac>
  <import src="dirac-stdlib/lib/string.di"/>
  <call name="TRIM" str="  hello world  "/>
  <!-- Output: hello world -->
</dirac>
```

### UPPERCASE / LOWERCASE - Case conversion
```xml
<dirac>
  <import src="dirac-stdlib/lib/string.di"/>
  <call name="UPPERCASE" str="hello"/>
  <!-- Output: HELLO -->
  
  <call name="LOWERCASE" str="WORLD"/>
  <!-- Output: world -->
</dirac>
```

### INDEXOF - Find position of substring
```xml
<dirac>
  <import src="dirac-stdlib/lib/string.di"/>
  <call name="INDEXOF" str="hello world" search="world"/>
  <!-- Output: 6 -->
  
  <call name="INDEXOF" str="hello world" search="xyz"/>
  <!-- Output: -1 (not found) -->
</dirac>
```

### INCLUDES - Check if string contains substring
```xml
<dirac>
  <import src="dirac-stdlib/lib/string.di"/>
  <call name="INCLUDES" str="hello world" search="world"/>
  <!-- Output: true -->
  
  <call name="INCLUDES" str="hello world" search="xyz"/>
  <!-- Output: false -->
</dirac>
```

### LENGTH - Get string length
```xml
<dirac>
  <import src="dirac-stdlib/lib/string.di"/>
  <call name="LENGTH" str="hello"/>
  <!-- Output: 5 -->
</dirac>
```

### CONCAT - Concatenate strings
```xml
<dirac>
  <import src="dirac-stdlib/lib/string.di"/>
  <call name="CONCAT" str1="hello" str2=" world"/>
  <!-- Output: hello world -->
</dirac>
```

## Combining Operations

### Text Processing Pipeline
```xml
<dirac>
  <import src="dirac-stdlib/lib/string.di"/>
  
  <!-- Clean and process text -->
  <call name="TRIM" str="  HELLO WORLD  "/>
  <assign name="cleaned">{{result}}</assign>
  
  <call name="LOWERCASE" str="{{cleaned}}"/>
  <assign name="lower">{{result}}</assign>
  
  <call name="REPLACE" str="{{lower}}" search="world" replace="universe"/>
  <output>{{result}}</output>
  <!-- Output: hello universe -->
</dirac>
```

### Math and String Combination
```xml
<dirac>
  <import src="dirac-stdlib/lib/math.di"/>
  <import src="dirac-stdlib/lib/string.di"/>
  
  <!-- Calculate and format result -->
  <call name="SQUARE" x="8"/>
  <assign name="num">{{result}}</assign>
  
  <call name="CONCAT" str1="The square is: " str2="{{num}}"/>
  <output>{{result}}</output>
  <!-- Output: The square is: 64 -->
</dirac>
```
