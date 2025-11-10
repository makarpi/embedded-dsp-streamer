import numpy as np

N = 1024
amp = (2**11) - 1  # 12-bit

samples = (amp * np.sin(2*np.pi*np.arange(N)/N)).astype(int)

with open("sine1024.hex", "w") as f:
    for s in samples:
        f.write(f"{(s & 0xFFF):03X}\n")
