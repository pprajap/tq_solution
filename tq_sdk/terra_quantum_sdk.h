#ifndef TERRA_QUANTUM_SDK_H
#define TERRA_QUANTUM_SDK_H

namespace terra_quantum {

class TerraQuantumSDK {
public:
    TerraQuantumSDK();
    ~TerraQuantumSDK();

    void initialize();
    void finalize();
};

} // namespace terra_quantum

#endif // TERRA_QUANTUM_SDK_H