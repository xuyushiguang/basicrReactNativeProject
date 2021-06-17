import React, { useState ,Component} from 'react';
import { SafeAreaView,
    StyleSheet,
    Text,
    View,
    Image,
    Button,
} from 'react-native';

import {Action,
    connect,
} from 'react-redux';

import {bindActionCreators} from 'redux';

import * as actions from '../provider/homeAction';
import * as ActionTypes from '../provider/homeActionTypes';
import I18n from '../l18n/I18n'

class Home extends React.Component{

        constructor(props){
                super(props)
                this.state={
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
                        <Text>{I18n.t("signIn.title")}</Text>
                        <Button title={"button"}
                        onPress={()=>{
                            this.props.testAction("aaaaaa")
                            //store.dispatch({type:ActionTypes.TestTag,name:"sssqqqqqsss"})
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