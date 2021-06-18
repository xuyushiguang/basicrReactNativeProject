import React, { useState ,Component} from 'react';
import { SafeAreaView,
    StyleSheet,
    Text,
    View,
    Image,
    Button,
    requireNativeComponent,
} from 'react-native';


var MapViewManager = requireNativeComponent('QMapViewManager');

export default class GaodeMapView extends React.Component{

        constructor(props){
                super(props)
                this.state={
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
                    <View style={{flex:1}}>
                    <MapViewManager style={{with:100,height:50,backgroundColor:"red"}}></MapViewManager>
                    </View>
                </SafeAreaView>
        }
} 