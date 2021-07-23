/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React from 'react';

import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  View,
  EventEmitter
} from 'react-native';

import {
  Colors,
  DebugInstructions,
  Header,
  LearnMoreLinks,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

import {
  Provider,

} from 'react-redux';

import QuecRouter from './src/router/QuecRouter';

import store from './src/provider/store';

import { Buffer } from 'buffer';

import Action2 from './Action2';

import WebSocketClient from './WebSocketClient';
// import UdpSockets from 'react-native-udp';
import QUDPSocket from './qsocket/QUDPSocket';
import deviceInfoModule from 'react-native-device-info';
import { NetworkInfo } from 'react-native-network-info';

import QueryString from 'querystring';



var SocketIO = require('react-native-socket-io');

global.rootStore = store;

class App extends React.Component {

  constructor() {
    super();
    this.serialNum = 0;
    this.bufferdata = Buffer(0);
    this.bluetoothReceiveData = Buffer(0);
    this.action2 = new Action2();
  }

  u64_buffer(bigValue) {
    let buf = Buffer(8);
    let temLen = buf.writeBigUInt64BE(bigValue);
    let arr = [];
    let hasValue = false;
    for (let i = 0; i < temLen; i++) {
      if (buf[i] != 0) {
        hasValue = true;
      }
      if (hasValue) {
        arr.push(buf[i])
      }
    }
    return Buffer(arr);
  }

  aaa() {
    let buf = Buffer(20);
    let value = -256;
    console.log('=====value < 0======', value < 0);
    buf[0] = 0x00;
    if (value < 0) {
      buf[2] = 1 << 7;
      value = 0 - value;
    } else {
      buf[2] = 0;
    }
    console.log('=====value < 0==w====', value);
    let temLen = buf.writeBigUInt64BE(BigInt(value), 3) - 3;
    console.log('=====temLen======', temLen);
    buf[1] |= 2;
    buf[2] |= temLen - 1;
    console.log('=====buf======', buf);

    let aaa = this.u64_buffer(BigInt(value));
    console.log('=====buf======', aaa);

    let negative = (buf[2] >> 7) ? true : false;
    let amp = (buf[2] >> 3) & 0x0F;
    let tmpLen = ((buf[2]) & 0x07) + 1;

    let ss = 0;
    for (let i = 0; i < tmpLen; i++) {
      ss <<= 8;
      ss |= buf[3 + i];
    }

    if (negative) {
      ss = 0 - ss;
    }
    console.log("======ss=======", ss);

  }

  componentDidMount() {


  }


  garbleBuffer(data) {
    let count = 2;
    let mData = Buffer(data);
    let arr = [0xAA, 0xAA];

    while (count < mData.length - 1) {
      arr.push(mData[count]);
      if ((mData[count] == 0xAA && mData[count + 1] == 0x55) ||
        (mData[count] == 0xAA && mData[count + 1] == 0xAA)) {
        arr.push(0x55);
      }
      count++;
    }

    arr.push(mData[count]);
    return Buffer(arr);
  }

  spliceBuffer(data) {
    let arr = [];
    for (const value of data) {
      arr.push(value);
    }
    for (let i = 0; i < arr.length - 1; i++) {
      const element = arr[i];
      if (arr[i] == 0xAA && arr[i + 1] == 0x55) {
        arr.splice(i + 1, 1)
      }
    }
    return Buffer(arr);
  }


  crcSecurity(data) {
    let crcBuf = data.slice(5);
    let nXor = this.sum_calculation(crcBuf, crcBuf.length);
    let oldXor = data[4];
    if (nXor == oldXor) {
      let packetID = data.readUInt16BE(5);
      if (packetID == 0 || packetID == 0xFFFF) {
        console.log("=packetID 非法=", packetID);
        return;
      }
      let cmd = data.readUInt16BE(7);
      if (cmd == 0 || cmd == 0xFFFF) {
        console.log("=cmd 非法=", cmd);
        return;
      }
      console.log("=====crc ok====", data);
    } else {
      console.log("=====crc error====", data);
    }
  }

  getSerialNum() {
    this.serialNum++;
    if (this.serialNum == 0 || this.serialNum >= 0xFFFF) {
      this.serialNum = 1;
    }
    return this.serialNum;
  }

  /*
  callback回调函数:(ack,data)=>{}
  ack = -1,超时,
  data :收到的应答数据
  */
  write(cmd, payload, callback) {
    let length = 9 + payload.length;
    let cmdData = Buffer.alloc(length, 0);
    cmdData[0] = 0xAA;
    cmdData[1] = 0xAA;
    //数据域长度
    cmdData[2] = ((5 + payload.length) >> 8) & 0xFF;
    cmdData[3] = (5 + payload.length) & 0xFF;

    let packetId = this.getSerialNum();
    cmdData[5] = (packetId >> 8) & 0xFF;
    cmdData[6] = packetId & 0xFF;

    cmdData[7] = (cmd >> 8) & 0xFF;
    cmdData[8] = cmd & 0xFF;

    if (payload.length > 0) {
      for (let i = 0; i < payload.length; i++) {
        cmdData[9 + i] = payload[i];
      }
    }

    let crcBuf = cmdData.slice(5);
    cmdData[4] = this.sum_calculation(crcBuf, crcBuf.length);

    console.log("======cmdData====", cmdData);

    return cmdData;

  }

  sum_calculation(data, offset) {
    let xor = 0;
    for (let i = 0; i < offset; i++) {
      if (i == 0) {
        xor = data[i];
      } else {
        xor = xor + data[i];
      }
    }
    return xor;
  }



  // crcSecurity(data){
  //   let nXor = this.xor_calculation(data.slice(4),data.length - 7);
  //   let oldXor = data[3];
  //   if(nXor == oldXor){
  //     let cmdType = data[4];
  //     let cmd = data[5];
  //     if(cmdType == 0x53){
  //       console.log("=====上报数据 ====",data);
  //     }else{
  //       console.log("=====指令 order数据 ====",data);
  //     }
  //   }else{
  //     console.log("=====crc error====",data);
  //   }
  // }

  xor_calculation(data, offset) {
    let xor = 0;
    for (let i = 0; i < offset; i++) {
      if (i == 0) {
        xor = data[i];
      } else {
        xor = xor ^ data[i];
      }
    }
    return xor;
  }



  render() {
    return <Provider store={store}>
      <QuecRouter></QuecRouter>
    </Provider>
  }

};

const styles = StyleSheet.create({
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
  },
  highlight: {
    fontWeight: '700',
  },
});

export default App;
