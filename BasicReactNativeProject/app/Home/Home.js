import React, { useState ,Component} from 'react';
import { SafeAreaView,
    StyleSheet,
    Text,
    View,
    Image,
    Button,
    AsyncStorageStatic
} from 'react-native';

import {Action,
    connect,
} from 'react-redux';

import {bindActionCreators} from 'redux';

import * as actions from '../provider/homeAction';
import * as ActionTypes from '../provider/homeActionTypes';
import I18n from '../l18n/I18n';

import  storage  from '../storage';

class Home extends React.Component{

        constructor(props){
                super(props)
                this.state={
                    age:"100"
                }
        }
        static defaultProps={
            name:"0"
        }
        static propTypes={

        }
        componentDidMount(){
            
        }
        componentWillUnmount(){
        }
        componentDidUpdate(prevProps){
        }
        render(){
                return <SafeAreaView style={{flex:1,backgroundColor:'white'}}>
                    <View style={{flex:1,backgroundColor:'white'}}>
                        <Text>{this.props.name}</Text>
                        <Text>{this.state.age}</Text>
                        <Text>{I18n.t("signIn.title")}</Text>
                        <Button title={"button"}
                        onPress={()=>{
                            // this.props.testAction("aaaaaa")
                            //store.dispatch({type:ActionTypes.TestTag,name:"sssqqqqqsss"})
                            storage.save("123","aaaaa")
                        }}
                        ></Button>
                        <Button title={"button"}
                        onPress={()=>{
                            storage.load("123",(ret)=>{
                                this.setState({age:ret})
                            })
                        }}
                        ></Button>
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