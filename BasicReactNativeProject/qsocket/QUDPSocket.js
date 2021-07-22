import UdpSockets from 'react-native-udp';
import { Buffer } from 'buffer';

export default class QUDPSocket {

  constructor() {
    // this.socket = null;
    this.port = 0;
  }

  bindPort(port) {
    this.port = port;
    this.socket = UdpSockets.createSocket({ type: 'udp4' });
    this.socket.bind(port);
    this.socket.once('listening', () => {
      console.log('Message listening ok')
      console.log('Message listening ok=====', this.socket.address())
    });

    this.socket.on('message', (msg, rinfo) => {
      console.log('Message received', msg);
      console.log('Message sent!===', rinfo);
      let buf = Buffer('Hello World!', 'utf8');
      this.write('qqqqqqq', 1233, '127.0.0.1')
      console.log('Message listening ok===2==', this.socket.address())
    });
  }

  write(data, port, host) {
    this.socket.send(data, undefined, undefined, port, host, function (err) {
      console.log('Message sent!==err=', err)
    });
  }

  closeUDP() {
    this.socket.close();
  }


}