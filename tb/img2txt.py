from PIL import Image
import numpy as np

filename = "test"

img = np.array(Image.open(filename + ".png").convert("RGB"))

height, width, components = img.shape

with open(filename + ".txt", "w") as f:
    f.write(f"{components}\n")
    f.write(f"{height}\n")
    f.write(f"{width}\n")

    for y in range(height):
        for x in range(width):
            r, g, b = img[y, x]
            f.write(f"{r:02x}{g:02x}{b:02x}")
        f.write("\n")
