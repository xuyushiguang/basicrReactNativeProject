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

import QuecRouter from './app/router/QuecRouter';

import store from './app/provider/store';

import { Buffer } from 'buffer';

class App extends React.Component{
  
  constructor(){
    super();
  }

  componentDidMount(){
    var map = new Map();
    map[1] = {ti:5,ccc:()=>{}};
    console.log('++++============',map.size);
    map.delete(1);
    console.log('++++====delete========',map);
    
  }

  crcSecurity(data){
    let nXor = this.xor_calculation(data.slice(4),data.length - 7);
    let oldXor = data[3];
    if(nXor == oldXor){
      let cmdType = data[4];
      let cmd = data[5];
      if(cmdType == 0x53){
        console.log("=====上报数据 ====",data);
      }else{
        console.log("=====指令 order数据 ====",data);
      }
    }else{
      console.log("=====crc error====",data);
    }
  }

  xor_calculation(data,offset){
    let xor = 0;
    for (let i = 0; i < offset; i++) {
      if (i == 0) {
        xor = data[i];
      }else{
        xor = xor ^ data[i];
      }
    }
    return xor;
  }



  render(){
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
