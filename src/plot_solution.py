import matplotlib.pyplot as plt
import numpy as np


def plot_solution(w, h, n, xs, ys, widths, heights, instance=""):
    image = np.ones((h, w, 3))
    np.random.seed(666)

    for i in range(n):
        x, y = xs[i], ys[i]
        width, height = widths[i], heights[i]
        image[y:y+height, x:x+width] = np.random.random(3)

    plt.matshow(image[::-1])
    plt.tick_params(top=False, labeltop=False, bottom=True, labelbottom=True)
    plt.title("Instance " + instance)
    ax = plt.gca()
    ax.set_xticks(np.arange(-.5, w, 1))
    ax.set_yticks(np.arange(-.5, h, 1))
    ax.set_xticklabels(np.arange(0, w+1, 1))
    ax.set_yticklabels(np.arange(h, -1, -1))

    plt.show()


if __name__ == "__main__":
    name = "5"
    w = 12
    h = 12
    n = 8
    xs = [0, 6, 9, 3, 0, 9, 6, 3]
    ys = [0, 0, 0, 0, 9, 7, 8, 6]
    widths = [3, 3, 3, 3, 6, 3, 3, 3]
    heights = [9, 8, 7, 6, 3, 5, 4, 3]

    plot_solution(w, h, n, xs, ys, widths, heights, name)
