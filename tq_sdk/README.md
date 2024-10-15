# Terra Quantum SDK

## Overview

The Terra Quantum SDK is a comprehensive toolkit for scientific tools and libraries developed by Terra Quantum.

## Installation

To build and install the SDK, follow these steps:

```sh
mkdir build
cd build
cmake ..
make
sudo make install
```

## Example usage

```cpp
#include <terra_quantum_sdk.h>

int main() {
    terra_quantum::TerraQuantumSDK sdk;
    sdk.initialize();

    // Use the SDK...

    sdk.finalize();
    return 0;
}
```


## Contributing
Thank you for your interest in contributing to the Terra Quantum SDK! Please follow the guidelines outlined in the CONTRIBUTING.md file.

## License
MIT

### Directory Structure

Your directory structure should look like this:

```
terra_quantum_sdk/
├── CMakeLists.txt
├── README.md
├── include/
│   ├── terra_quantum_sdk.h // Use factory design pattern ??
│   └── ttopt.h
│   ... // other interfaces
└── src/
    ├── terra_quantum_sdk.cpp // initialize all into individual .so libraries
    └── ttopt.cpp
    ... // other implementations
```
