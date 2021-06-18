import React, { useState ,Component} from 'react';
import ReactNative, { SafeAreaView,
    StyleSheet,
    Text,
    View,
    Image,
    Button,
    requireNativeComponent,
    Dimensions,
    NativeModules,
} from 'react-native';
import PropTypes from 'prop-types'

let windowWidth = Dimensions.get('window').width;
let windowHeight = Dimensions.get('window').Height;

const QMapViewFun = NativeModules.QMapView;
const RCT_QMAP_REF = "QMapView"

class GaodeMapView extends React.Component{

        constructor(props){
                super(props)
                this.state={
                }
        }

        static defaultProps={
                zoomEnabled : true,
                region: {
                        latitude: 37.48,
                        longitude: -122.16,
                        latitudeDelta: 0.1,
                        longitudeDelta: 0.1,
                      },

        }
        static propTypes={
                zoomEnabled: PropTypes.bool,
                region: PropTypes.shape({
                
                latitude: PropTypes.number.isRequired,
                longitude: PropTypes.number.isRequired,
            
                latitudeDelta: PropTypes.number.isRequired,
                longitudeDelta: PropTypes.number.isRequired,
                }),
        }
        
        componentDidMount(){
                QMapViewFun.reload(100) 
                QMapViewFun.blockCallbackEvent((error,events)=>{
                        console.log("回调结果:" + events);
                })
        }

        render(){
                return <MapViewManager style={{flex:1}}
                {...this.props}
                ></MapViewManager>
        }
} 

const MapViewManager = requireNativeComponent('QMapView',GaodeMapView);

export default  GaodeMapView;