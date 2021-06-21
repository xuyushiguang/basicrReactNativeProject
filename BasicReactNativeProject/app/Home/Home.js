import React, { useState ,Component} from 'react';
import { SafeAreaView,
    StyleSheet,
    Text,
    View,
    Image,
    Button,
    Dimensions,
    DeviceEventEmitter,
    NativeModules,
    NativeEventEmitter,
} from 'react-native';

import {Action,
    connect,
} from 'react-redux';

import {bindActionCreators} from 'redux';

import * as actions from '../provider/homeAction';
import * as ActionTypes from '../provider/homeActionTypes';
import I18n from '../l18n/I18n';
import GaodeMapView from './GaodeMapView';
import TestRedView from './TestRedView'

let windowWidth = Dimensions.get('window').width;
let windowHeight = Dimensions.get('window').Height;

class Home extends React.Component{

        constructor(props){
                super(props)
                this.state={
                    age:"100",
                    str:"wwwww",
                    btStr:"1111"
                }
                DeviceEventEmitter.addListener("qwer",(title)=>{
                    this.setState({age:"dddddd"})
                })
                
        }
        static defaultProps={
            name:"0"
        }
        static propTypes={

        }
        render(){
           const region = {
                latitude: 37.48,
                longitude: -122.16,
                latitudeDelta: 0.1,
                longitudeDelta: 0.1,
              };
                return <SafeAreaView style={{flex:1,backgroundColor:'white'}}>
                    <View style={{flex:1,backgroundColor:'white'}}>
                        <Text>{this.props.name}</Text>
                        <Text>{this.state.age}</Text>
                        <Text>btStr={this.state.btStr}</Text>
                        <Text>{I18n.t("signIn.title")}</Text>
                        <Button title={"button1"}
                        onPress={()=>{
                            // this.props.testAction("aaaaaa")
                            //store.dispatch({type:ActionTypes.TestTag,name:"sssqqqqqsss"})
                            // storage.save("123","aaaaa")
                            //this.setState({str:"dddddd"})
                            DeviceEventEmitter.emit("qwer","zzzzzz")
                        }}
                        ></Button>
                        <Button title={"button2"}
                        onPress={()=>{
                            // storage.load("123",(ret)=>{
                            //     this.setState({age:ret})
                            // })
                        }}
                        ></Button>

                        <TestRedView style={{width:100,height:100}}
                        str={this.state.str}
                        onClick={(e)=>{
                            this.setState({btStr:e.nativeEvent["press"]})
                        }}
                        ></TestRedView>

                        <GaodeMapView style={{flex:1}}
                        zoomEnabled={true}
                        region={region}
                        ></GaodeMapView>
                        

                    </View>
                </SafeAreaView>
        }
} 

function mapStateToProps(state) {
    return {
        name:state.home.name
    }
}
function mapDispatchToProps(dispatch) {
    return bindActionCreators(actions,dispatch)
}
export default connect(
    mapStateToProps,
    mapDispatchToProps
)(Home)