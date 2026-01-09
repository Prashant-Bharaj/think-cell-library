# think-cell Library Study Guide

## 🎯 Interview Preparation Plan

This guide will help you prepare for the think-cell C++ Developer interview by studying their actual codebase.

---

## 📚 Phase 1: Understanding the Library Structure

### 1.1 Start with Examples
- **File**: `range.example.cpp`
- **Goal**: Understand how the library is used
- **Key Concepts**:
  - Range-based iteration
  - Filter adaptors
  - Generator ranges
  - Break/continue semantics

**Study Questions**:
- How does `tc::filter` work differently from `std::filter`?
- What is the purpose of `break_or_continue`?
- How do generator ranges work?

### 1.2 Core Range Library
- **Directory**: `tc/range/`
- 









**Study Questions**:
- How are ranges implemented? (iterators vs. callbacks)
- What makes their range library different from Boost.Range?
- How do they handle both internal and external iteration?

### 1.3 Algorithm Library
- **Directory**: `tc/algorithm/`
- **Key Files**:
  - `algorithm.h` - Main algorithm header (1252 lines!)
  - `for_each.h` - Range iteration
  - `accumulate.h` - Accumulation operations
  - `find.h` - Search algorithms
  - `minmax.h` - Min/max operations

**Study Questions**:
- How do they implement generic algorithms?
- What patterns do they use for algorithm composition?
- How do they handle different container types?

---

## 🔍 Phase 2: Deep Dive into Key Concepts

### 2.1 Modern C++ Features Used
Look for examples of:
- **Concepts** (C++20): Search for `requires` keyword
- **Ranges**: Their custom range implementation
- **constexpr**: Many functions are constexpr
- **Templates**: Heavy use of template metaprogramming
- **SFINAE**: Type trait patterns
- **Perfect Forwarding**: `std::forward` usage

**Exercise**: Find 5 examples of each feature in the codebase.

### 2.2 Design Patterns
- **Adaptor Pattern**: Range adaptors (filter, transform, etc.)
- **RAII**: Resource management
- **Type Erasure**: How they handle different range types
- **Expression Templates**: For efficient range operations

### 2.3 Boost Integration
- **Boost.Spirit**: Used for parsing (see `tc/string/spirit.h`)
- **Boost.Range**: Comparison and compatibility
- **Boost utilities**: Various Boost libraries

**Exercise**: Compare `tc::filter` with `boost::adaptors::filtered` in `range.example.cpp`

---

## 💻 Phase 3: Hands-On Practice

### 3.1 Build and Run
```powershell
# Check environment
.\check_env.ps1

# Build the library
.\build.ps1

# Run tests
cd build
ctest -C Release
```

### 3.2 Modify Examples
1. Create your own range adaptor
2. Implement a new algorithm using their patterns
3. Write unit tests for existing functions

### 3.3 Code Reading Exercises
1. **Read `any_accu.h`** (currently open):
   - What does `any_accu` do?
   - Why is it in `no_adl` namespace?
   - What is `tc_inplace`?

2. **Read `algorithm.h`**:
   - How is `is_sorted` implemented?
   - What makes it different from `std::is_sorted`?
   - Study the template patterns

3. **Read range adaptors**:
   - How does `filter_adaptor` work?
   - How does it compose with other adaptors?

---

## 🎓 Phase 4: Interview Topics

### 4.1 Algorithms & Data Structures
Based on their work:
- **Layout Algorithms**: Automatic slide layout (mentioned in job description)
- **Graph Algorithms**: For chart positioning
- **Geometric Algorithms**: Point cloud labeling
- **Optimization**: Linear programming (simplex solver)

**Practice**: Implement a simple layout algorithm (e.g., arranging boxes in a container)

### 4.2 C++ Language Deep Dive
Be ready to discuss:
- **Templates**: Advanced template metaprogramming
- **Ranges**: C++20 ranges vs. their custom implementation
- **Memory Management**: Smart pointers, RAII
- **Move Semantics**: When and how to use
- **constexpr**: Compile-time computation

### 4.3 Code Quality & Design
Their values:
- **Elegant algorithms**: Study their algorithm implementations
- **Clean code**: Notice their naming conventions and structure
- **Performance**: How they optimize without sacrificing clarity

---

## 📝 Phase 5: Practice Problems

### Problem 1: Range Adaptor
Implement a `take` adaptor that takes the first N elements:
```cpp
auto r = tc::take(tc::iota(0, 100), 10);
// Should yield: 0, 1, 2, ..., 9
```

### Problem 2: Algorithm Implementation
Implement `tc::transform` following their patterns:
```cpp
auto r = tc::transform(v, [](int x) { return x * 2; });
```

### Problem 3: Custom Range
Create a range that generates Fibonacci numbers:
```cpp
auto fib = fibonacci_range();
tc::for_each(tc::take(fib, 10), [](int n) { /* ... */ });
```

---

## 🔗 Key Files to Study

### Must Read (Priority Order):
1. `range.example.cpp` - Start here!
2. `tc/range/filter_adaptor.h` - Core range concept
3. `tc/algorithm/for_each.h` - Range iteration
4. `tc/algorithm/algorithm.h` - Main algorithms
5. `tc/range/meta.h` - Type system

### Important to Understand:
- `tc/container/container.h` - Their container utilities
- `tc/string/spirit.h` - Boost.Spirit usage
- `tc/base/` - Foundation utilities

### Unit Tests:
- All `*.t.cpp` files show usage examples
- Study these to understand expected behavior

---

## 🎯 Interview Preparation Checklist

- [ ] Can explain how their range library works
- [ ] Understand the difference between their ranges and std::ranges
- [ ] Can read and understand their template-heavy code
- [ ] Familiar with Boost libraries they use
- [ ] Can implement algorithms following their patterns
- [ ] Understand modern C++ features (C++17/20/23)
- [ ] Can discuss algorithm complexity and optimization
- [ ] Familiar with their coding style and conventions

---

## 💡 Tips

1. **Read Code Actively**: Don't just read—ask "why?" for every design decision
2. **Experiment**: Modify their code and see what breaks
3. **Compare**: Compare their implementations with STL/Boost equivalents
4. **Document**: Write notes on interesting patterns you find
5. **Practice**: Implement similar functionality yourself

---

## 📚 Additional Resources

- **think-cell Developer Blog**: https://www.think-cell.com/devblog
- **Their Talks**: https://www.think-cell.com/career/talks/overview.shtml
- **C++ Standard**: https://cppreference.com/
- **Boost Documentation**: https://www.boost.org/doc/

---

## 🚀 Next Steps

1. Run `.\check_env.ps1` to verify your setup
2. Build the project with `.\build.ps1`
3. Start with `range.example.cpp` - run it and understand each example
4. Pick one algorithm file and study it deeply
5. Try to implement a simple range adaptor yourself

Good luck with your interview preparation! 🎉
