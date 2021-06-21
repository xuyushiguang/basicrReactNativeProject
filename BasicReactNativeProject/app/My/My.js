import React, { useState ,Component} from 'react';
import { SafeAreaView,
    StyleSheet,
    Text,
    View,
    Image,
    Button,
} from 'react-native';


export default class My extends React.Component{

        constructor(props){
                super(props)
                this.state={
                }
        }
        componentDidMount(){
        }
        componentWillUnmount(){
        }
        
        render(){
                return <SafeAreaView style={{flex:1,backgroundColor:'white'}}>
                <View style={{flex:1,backgroundColor:'white'}}>
                    <Text></Text>
                    <Text></Text>
                    <Text>btStr</Text>
                    <Text></Text>
                    <Button title={"button1"}
                    onPress={()=>{
                        
                    }}
                    ></Button>
                    <Button title={"button2"}
                    onPress={()=>{
                        
                    }}
                    ></Button>

                </View>
            </SafeAreaView>
        }
} 