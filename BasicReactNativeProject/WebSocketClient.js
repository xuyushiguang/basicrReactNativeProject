import { DeviceEventEmitter } from 'react-native';

// import netconfig from '../../http/netconfig';
import { Buffer } from 'buffer';

// const url = 'ws://192.168.25.121:8000/ws/v1';
// const url = 'wss://iot-ws.quectel.com/ws/v1';
const url = 'ws://127.0.0.1:12345';

let that = null;

export default class WebSocketClient {
  constructor() {
    this.ws = null;
    that = this;
  }

  /**
   * 获取WebSocket单例
   * @returns {WebSocketClient}
   */
  static getInstance() {
    if (!this.instance) {
      this.instance = new WebSocketClient();
    }
    return this.instance;
  }

  /**
   * 初始化WebSocket
   */
  initWebSocket() {
    try {
      //timer为发送心跳的计时器
      this.timer && clearInterval(this.timer);
      this.ws = new WebSocket(url, 'echo-protocol');
      this.initWsEvent();
    } catch (e) {
      console.log('WebSocket err:', e);
      //重连
      this.reconnect();
    }
  }

  // 取消设备订阅
  unsubscribeDevice(imei) {
    // let cmdMsgSubscribe = JSON.stringify({
    //   cmd: 'unsubscribe',
    //   data: [
    //     {
    //       productKey: netconfig.pk,
    //       deviceKey: imei,
    //     },
    //   ],
    // });
    // WebSocketClient.getInstance().sendMessage(cmdMsgSubscribe);
  }

  // 发起设备订阅
  subscribeDevice(imei) {
    // // 发送订阅指令
    // let cmdMsgSubscribe = JSON.stringify({
    //   cmd: 'subscribe',
    //   data: [
    //     {
    //       productKey: netconfig.pk,
    //       deviceKey: imei,
    //       messageType: ['ONLINE', 'STATUS', 'LOCATION-INFO-KV', 'MATTR-REPORT'],
    //     },
    //   ],
    // });
    // WebSocketClient.getInstance().sendMessage(cmdMsgSubscribe);
  }

  /**
   * 初始化WebSocket相关事件
   */
  initWsEvent() {
    //建立WebSocket连接
    this.ws.onopen = function () {
      console.log('WebSocket:', '=====rn=====connect to server');
      console.log('WebSocket:', '=====rn=====发起登录指令');
      WebSocketClient.getInstance().sendMessage(Buffer('123456789', 'utf8'));
      // WebSocketClient.getInstance().subscribeDevice(global.imei);
    };

    //客户端接收服务端数据时触发
    this.ws.onmessage = function (evt) {
      console.log('WebSocket: =====rn====1=response msg:', evt);
      console.log('WebSocket: =====rn====2=response 2msg:', Buffer(evt.data).toString('utf8'));

    };
    //连接错误
    this.ws.onerror = function (err) {
      console.log('WebSocket:', '=====rn=====connect to server error');
      //重连
      that.reconnect();
    };
    //连接关闭
    this.ws.onclose = function () {
      console.log('WebSocket:', '=====rn=====conconnect to servernect close');
      //重连
      that.reconnect();
    };

    //每隔40s向服务器发送一次心跳
    this.timer = setInterval(() => {
      WebSocketClient.getInstance().sendMessage(
        Buffer('123456789q', 'utf8')
      );
      // if (this.ws && this.ws.readyState === WebSocket.OPEN) {
      //   console.log('WebSocket:', 'ping');
      //   WebSocketClient.getInstance().sendMessage(
      //     Buffer('123456789q', 'utf8')
      //   );
      // }
    }, 2000);
  }

  //发送消息
  sendMessage(msg) {
    if (this.ws && this.ws.readyState === WebSocket.OPEN) {
      try {
        this.ws.send(msg);
        console.log('ws =====rn=====sendMessage: ' + msg);
      } catch (err) {
        console.warn('ws =====rn=====sendMessage err:', err.message, msg);
      }
    } else {
      console.log('WebSocket:', '=====rn=====connect not open to send message');
    }
  }

  //重连
  reconnect() {
    if (this.timeout) {
      clearTimeout(this.timeout);
    }
    this.timeout = setTimeout(function () {
      //重新连接WebSocket
      WebSocketClient.getInstance().initWebSocket();
    }, 5000);
  }
}
