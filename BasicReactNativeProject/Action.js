
import { Buffer } from "buffer"

export default class Action{

    constructor(){

        this.bluetoothReceiveData = Buffer(0);
    }



  packetSlice(){
    while(this.bluetoothReceiveData.length){

      if(this.bluetoothReceiveData.length < 9){
        console.log("==数据长度不够=",this.bluetoothReceiveData);
        return;
      }
      let startIndex = this.bluetoothReceiveData.indexOf(Buffer([0xAA,0xAA]));
       //找到包头
      if(startIndex != -1 && startIndex < this.bluetoothReceiveData.length){
        //现在找数据域长度(校验和到数据域的长度)  
        let payloadLen = this.bluetoothReceiveData.readUInt16BE(startIndex + 2);
        //收到的缓存数据必须大于等于数据长度+包头+数据域长度
        if (this.bluetoothReceiveData.length < payloadLen + 4) {
          console.log("=====数据长度不够,继续接收数据===",this.bluetoothReceiveData);
            return;
        }
        let nBuf = this.bluetoothReceiveData.slice(startIndex,startIndex + payloadLen + 4);
        console.log("=====完整数据=1==",nBuf);
        this.crcSecurity(Buffer(nBuf));
        this.bluetoothReceiveData = this.bluetoothReceiveData.slice(startIndex + payloadLen + 4);
        console.log("=====完整数据=2==",this.bluetoothReceiveData);
      }else{
        //没找到包头,没找到包头，判断最后一个字节是否是0xAA
        if(this.bluetoothReceiveData.length >= 1){
          if(this.bluetoothReceiveData[this.bluetoothReceiveData.length - 1] == 0xAA){
            //最后一个字节可能是包头的第一字节，清除之前的数据
            console.log("=可能是包头第一个字节 0xAA=",this.bluetoothReceiveData);
            this.bluetoothReceiveData = this.bluetoothReceiveData.slice(this.bluetoothReceiveData.length - 1);
            return;
          }else{
            //====废数据===
            console.log("=====废数据====",this.bluetoothReceiveData);
            this.bluetoothReceiveData = Buffer(0);
            return;
          }
        }else{
          console.log("=====空数据====",this.bluetoothReceiveData);
          this.bluetoothReceiveData = Buffer(0);
            return;
        }
      } 
    }
}

}