from PIL import Image
import numpy as np

original = np.array(Image.open("test.png").convert("RGB"))
decoded  = np.array(Image.open("test_out.jpg").convert("RGB"))

a = original.astype(np.int16)
b = decoded.astype(np.int16)

error = a - b

mae = np.mean(np.abs(error))
max_error = np.max(np.abs(error))
mse = np.mean(error.astype(np.float64) ** 2)

if mse == 0:
    psnr = float("inf")
else:
    psnr = 10 * np.log10((255.0 ** 2) / mse)

print("MAE:      ", mae) # Mean Absolute Error
print("Max error:", max_error)
print("MSE:      ", mse) # Mean Squared Error
print("PSNR:     ", psnr, "dB") # Peak Signal-to-Noise Ratio

for c, name in enumerate(["R", "G", "B"]):
    err = (
        original[:, :, c].astype(np.int16)
        - decoded[:, :, c].astype(np.int16)
    )

    print(
        name,
        "MAE =", np.mean(np.abs(err)),
        "MAX =", np.max(np.abs(err))
    )

for limit in [5, 10, 20, 40, 80, 100]:
    n = np.sum(error > limit)
    p = n / error.size * 100
    print(f"> {limit:3}: {n:6} samples ({p:.5f} %)")
