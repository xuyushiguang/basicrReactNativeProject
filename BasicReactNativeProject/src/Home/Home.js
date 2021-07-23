import React, { useState, Component } from 'react';
import {
    SafeAreaView,
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
import { Actions } from 'react-native-router-flux';
import {
    Action,
    connect,
} from 'react-redux';
import { bindActionCreators } from 'redux';

import * as actions from '../provider/home/actions';
import * as ActionTypes from '../provider/home/actionsTypes';
import I18n from '../l18n/I18n';
// import GaodeMapView from './GaodeMapView';
// import TestRedView from './TestRedView';
import Home2 from './Home2';
import { Header } from 'react-native-elements';

let windowWidth = Dimensions.get('window').width;
let windowHeight = Dimensions.get('window').Height;

class Home extends React.Component {


    static navigationOptions = ({ navigation, navigationOptions }) => {
        const { params } = navigation.state;

        return {
            header: null
        };
    }

    constructor(props) {
        super(props)
        this.state = {
            age: "100",
            str: "wwwww",
            btStr: "1111"
        }
        DeviceEventEmitter.addListener("qwer", (title) => {
            this.setState({ age: "dddddd" })
        })
        this.count = 0;
        // this.props.navigation.setParams({ name: "homeq" })
    }
    static defaultProps = {
        name: "home"
    }
    static propTypes = {

    }
    render() {

        console.log("=====aaaaaaa======");
        return <View style={{ flex: 1, backgroundColor: 'white' }}>
            <Header
                leftComponent={{
                    icon: 'menu', color: '#fff', iconStyle: { color: '#fff' },
                    onPress: () => {
                        console.log("=====onPressonPress======");
                    }

                }}
                centerComponent={{ text: 'MY TITLE', style: { color: '#fff' } }}
                rightComponent={{ icon: 'home', color: '#fff' }}
                backgroundColor="red"


            ></Header>
            <View style={{ flex: 1, backgroundColor: 'white' }}>
                <Text>{this.props.name}</Text>
                <Text>{this.state.age}</Text>
                <Text>btStr={this.state.btStr}</Text>
                <Text>{I18n.t("signIn.title")}</Text>
                <Button title={"button1"}
                    onPress={() => {
                        // this.props.testAction("aaaaaa")
                        // this.props.navigation.setParams({ name: this.props.name })
                        //store.dispatch({type:ActionTypes.TestTag,name:"sssqqqqqsss"})
                        // storage.save("123","aaaaa")
                        //this.setState({str:"dddddd"})
                        // DeviceEventEmitter.emit("qwer", "zzzzzz")
                    }}
                ></Button>
                <Button title={this.props.name + "button"}
                    onPress={() => {
                        // this.props.testAction("home" + (++this.count))
                        Actions.Home2();
                    }}
                ></Button>

                <View style={{ width: 300, height: 50, backgroundColor: 'red' }}>
                    <Home2></Home2>
                </View>


                {/* <TestRedView style={{ width: 100, height: 100 }}
                    str={this.state.str}
                    onClick={(e) => {
                        this.setState({ btStr: e.nativeEvent["press"] })
                    }}
                ></TestRedView> */}

                {/* <GaodeMapView style={{ flex: 1 }}
                    zoomEnabled={true}
                    region={{
                        latitude: 37.48,
                        longitude: -122.16,
                        latitudeDelta: 0.1,
                        longitudeDelta: 0.1,
                    }}
                ></GaodeMapView> */}


            </View>
        </View >
    }
}

function mapStateToProps(state) {
    return {
        name: state.home.name
    }
}
function mapDispatchToProps(dispatch) {
    return bindActionCreators(actions, dispatch)
}
export default connect(
    mapStateToProps,
    mapDispatchToProps
)(Home)