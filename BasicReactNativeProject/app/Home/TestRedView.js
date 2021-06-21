import React, { useState ,Component} from 'react';
import { SafeAreaView,
    StyleSheet,
    Text,
    View,
    Image,
    Button,
    requireNativeComponent,
    Dimensions,
    NativeModules,
    
} from 'react-native';
// import  RCTDeviceEventEmitter from 'RCTDe'

import PropTypes from 'prop-types'

class TestRedView extends React.Component{

        constructor(props){
                super(props)
                this.state={
                }
        }
        static defaultProps={
            str : "qqqqqqq",
            onClick:null,

        }
        static propTypes={
            zoomEnabled: PropTypes.string,
            onClick:PropTypes.func,
        }
        
        render(){
                return <QRedView style={{flex:1,backgroundColor:'red'}}
                {...this.props}
                >
                </QRedView>
        }
} 


const QRedView = requireNativeComponent('QRedView',TestRedView);

export default  TestRedView;