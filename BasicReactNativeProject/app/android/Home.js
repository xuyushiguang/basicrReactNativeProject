import React, { useState ,Component} from 'react';
import { SafeAreaView,
    StyleSheet,
    Text,
    View,
    Image,
    Button,
    requireNativeComponent,
    NativeModules,
} from 'react-native';

const MyColorView = requireNativeComponent('MyColorView');

var MyTestModule = NativeModules.MyTestModule;


export default class Home extends React.Component{

    constructor(props){
        super(props)
        this.state={
            name:"1111",
            age:"0000"
        }
    }
    componentDidMount(){
    }
    componentWillUnmount(){
    }
    componentDidUpdate(prevProps){
    }
    render(){
        return <SafeAreaView style={{flex:1,backgroundColor:'white'}}>
            <View style={{flex:1,backgroundColor:"white"}}>
                <Text>{this.state.name}</Text>
                <Text>{this.state.age}</Text>
                <Button title={"button1"}
                        onPress={()=>{
                            MyTestModule.addTest("aaaaa",(msg)=>{
                                this.setState({name:msg})
                            })
                        }}
                        ></Button>
                        
                <Button title={"button2"}
                        onPress={()=>{
                            MyTestModule.testPromise("3333dddd").then(ret=>{
                                this.setState({age:ret})
                            })
                        }}
                ></Button>
                <MyColorView style={{width:100,height:100,backgroundColor:"red"}}
                text="99999999"
                ></MyColorView>
            </View>
        </SafeAreaView>
    }
} 

