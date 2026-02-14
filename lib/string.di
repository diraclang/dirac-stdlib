<!-- String Operations Library for DIRAC Standard Library -->
<dirac>

<!-- SUBSTRING: Extract portion of string -->
<subroutine name="SUBSTRING" param-str="string" param-start="number" param-length="number (optional)">
  <eval name="result">
    const s = String(str);
    const startPos = Number(start);
    if (typeof length !== 'undefined' && length !== null && length !== '') {
      return s.substring(startPos, startPos + Number(length));
    } else {
      return s.substring(startPos);
    }
  </eval>
  <output><variable name="result" /></output>
</subroutine>

<!-- REPLACE: Replace text in string -->
<subroutine name="REPLACE" param-str="string" param-search="string" param-replace="string" param-regex="boolean (optional)">
  <eval name="result">
    const s = String(str);
    const searchStr = String(search);
    const replaceStr = String(replace);
    if (regex === 'true' || regex === true) {
      return s.replace(new RegExp(searchStr, 'g'), replaceStr);
    } else {
      return s.split(searchStr).join(replaceStr);
    }
  </eval>
  <output><variable name="result" /></output>
</subroutine>

<!-- SPLIT: Split string by delimiter -->
<subroutine name="SPLIT" param-str="string" param-delimiter="string">
  <eval name="result">
    return String(str).split(String(delimiter)).join('\n');
  </eval>
  <output><variable name="result" /></output>
</subroutine>

<!-- JOIN: Join array elements (newline-separated input) -->
<subroutine name="JOIN" param-items="string" param-delimiter="string (optional)">
  <eval name="result">
    const itemStr = String(items);
    const delim = (typeof delimiter !== 'undefined' && delimiter !== null && delimiter !== '') ? String(delimiter) : '';
    return itemStr.split('\n').join(delim);
  </eval>
  <output><variable name="result" /></output>
</subroutine>

<!-- TRIM: Remove whitespace from both ends -->
<subroutine name="TRIM" param-str="string">
  <eval name="result">
    return String(str).trim();
  </eval>
  <output><variable name="result" /></output>
</subroutine>

<!-- UPPERCASE: Convert to uppercase -->
<subroutine name="UPPERCASE" param-str="string">
  <eval name="result">
    return String(str).toUpperCase();
  </eval>
  <output><variable name="result" /></output>
</subroutine>

<!-- LOWERCASE: Convert to lowercase -->
<subroutine name="LOWERCASE" param-str="string">
  <eval name="result">
    return String(str).toLowerCase();
  </eval>
  <output><variable name="result" /></output>
</subroutine>

<!-- INDEXOF: Find position of substring (returns -1 if not found) -->
<subroutine name="INDEXOF" param-str="string" param-search="string" param-start="number (optional)">
  <eval name="result">
    const s = String(str);
    const searchStr = String(search);
    if (typeof start !== 'undefined' && start !== null && start !== '') {
      return s.indexOf(searchStr, Number(start));
    } else {
      return s.indexOf(searchStr);
    }
  </eval>
  <output><variable name="result" /></output>
</subroutine>

<!-- INCLUDES: Check if string contains substring (returns true/false) -->
<subroutine name="INCLUDES" param-str="string" param-search="string">
  <eval name="result">
    return String(str).includes(String(search));
  </eval>
  <output><variable name="result" /></output>
</subroutine>

<!-- LENGTH: Get string length -->
<subroutine name="LENGTH" param-str="string">
  <eval name="result">
    return String(str).length;
  </eval>
  <output><variable name="result" /></output>
</subroutine>

<!-- CONCAT: Concatenate strings -->
<subroutine name="CONCAT" param-str1="string" param-str2="string">
  <eval name="result">
    return String(str1) + String(str2);
  </eval>
  <output><variable name="result" /></output>
</subroutine>

</dirac>
