#!/usr/bin/env node
// Simple test runner wrapper for dirac-stdlib
// Uses the dirac test-runner from node_modules

import { spawn } from 'child_process';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const testsDir = join(__dirname, '../tests');

// Run dirac test-runner
const proc = spawn('node', [
  join(__dirname, '../node_modules/dirac-lang/dist/test-runner.js'),
  testsDir
], {
  stdio: 'inherit',
  cwd: __dirname
});

proc.on('exit', (code) => {
  process.exit(code || 0);
});
