import matplotlib.pyplot as plt
import sys

def plot_data(data_file):
    kbps1s_data = []
    
    with open(data_file, 'r') as file:
        # 跳过第一行标题行
        next(file)
        
        for line in file:
            fields = line.split()
            kbps1s_data.append(int(fields[7]))
    
    # 绘制图表
    plt.plot(kbps1s_data)
    plt.xlabel('Time (seconds)')
    plt.ylabel('kbps1s')
    plt.title('kbps1s Over Time')
    plt.grid(True)
    plt.show()

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 plot_data.py <data_file>")
        sys.exit(1)
    
    data_file = sys.argv[1]
    plot_data(data_file)