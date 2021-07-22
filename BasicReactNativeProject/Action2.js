
import { Buffer } from "buffer"
import Action from "./Action";

export default class Action2 extends Action{

    constructor(){
        super();
        
    }


    crcSecurity(data){
        let crcBuf = data.slice(5);
        let nXor = this.sum_calculation(crcBuf,crcBuf.length);
        let oldXor = data[4];
        if(nXor == oldXor){
          let packetID = data.readUInt16BE(5);
          if(packetID == 0 || packetID == 0xFFFF){
              console.log("=packetID 非法=",packetID);
              return;
          }
          let cmd = data.readUInt16BE(7);
          if(cmd == 0 || cmd == 0xFFFF){
            console.log("=cmd 非法=",cmd);
            return;
          }
          console.log("=====crc ok====",data);
        }else{
          console.log("=====crc error====",data);
        }
      }


sum_calculation(data,offset){
    let xor = 0;
    for (let i = 0; i < offset; i++) {
      if (i == 0) {
        xor = data[i];
      }else{
        xor = xor + data[i];
      }
    }
    return xor;
  }

}