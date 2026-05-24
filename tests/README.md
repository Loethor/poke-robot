# Test Suite Structure

This folder contains all automated API tests for the PokéAPI Robot Framework project.

Tests are organized by domain and executed using tags in CI/CD pipelines.

---

## 📁 Folder Overview

### pokemon/
Functional tests for Pokémon data retrieval.
- existence checks
- attribute validation
- data-driven CSV tests

### types/
Validation of Pokémon type system.
- type effectiveness rules
- single vs dual type logic
- type existence checks

### schema/
Contract validation tests.
- JSON schema compliance
- API structure validation
- breaking change detection

### reliability/
Stability and resilience tests.
- repeated calls consistency
- burst/load behavior
- API stability checks
- response time validation

### cross-endpoint/
Integration tests across multiple endpoints.
- Pokémon ↔ Type consistency
- inter-resource validation
- data integrity checks

---

## ▶️ Running Tests

Run all tests:
```bash
uv run robot tests/
```

Run by tag:
```bash
uv run robot -i smoke tests/
uv run robot -i regression tests/
uv run robot -i pokemon tests/
uv run robot -i type tests/
```

## 🧪 Tag Strategy

Tags are used instead of folder coupling for CI execution:

- `smoke` → fast PR validation
- `regression` → full functional coverage
- `reliability` → stability & performance
- `schema` → contract validation
- `negative` → error handling tests
- `type` → type system validation
- `pokemon` → core Pokémon API tests
- `cross-endpoint` → integration between endpoints