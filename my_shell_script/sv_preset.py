import requests
import time
import aircv as ac
import cv2
import os
from threading import Thread
from datetime import datetime  # 导入 datetime 模块


def multithreading(f):
    def wrapper(*args, **kwargs):
        thr = Thread(target=f, args=args, kwargs=kwargs)
        thr.start()

    return wrapper


def get_token(ip):
    url = 'http://' + ip + '/api/v1/auth/login'
    params = {
        'user': 'admin',
        'pwd': '21232f297a57a5a743894a0e4a801fc3'
    }

    response = requests.post(url, json=params)

    if response.status_code == 200:
        json_obj = response.json()
        data = json_obj['data']
        token = data['token']
        return token
    else:
        return None


def call_preset(camera_ip, Position):
    url = f"http://{camera_ip}/api/v1/media/ptz/closeUp/presetPosition/apply"
    headers = {
        'token': get_token(camera_ip)
    }
    params = {
        'position': Position,
    }

    response = requests.post(url, json=params, headers=headers)
    if response.status_code == 200:
        print(f"摄像机 {camera_ip} 的预置位 {Position} 调用成功，当前时间：{datetime.now()}")  # 打印当前时间
    else:
        print(f"摄像机 {camera_ip} 的预置位 {Position} 调用失败，当前时间：{datetime.now()}")  # 打印当前时间


@multithreading
def aaa(camera):
    for i in range(6000000):
        for Position in camera['Position']:
            call_preset(camera['ip'], Position)
            print(f"第{i + 1}次调用，当前时间：{datetime.now()}")  # 打印当前时间
            time.sleep(2)


if __name__ == '__main__':
    cameras = [
        {'ip': '10.66.30.53', 'Position': [5, 6]},
    ]
    for camera in cameras:
        aaa(camera)
