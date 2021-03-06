import React, { useState, Component } from 'react';
import {
    SafeAreaView,
    StyleSheet,
    Text,
    View,
    Image,
    Button,
} from 'react-native';
import { Drawer, Router, Scene, Tabs } from 'react-native-router-flux';

import Home from '../Home/Home';
import Home2 from '../Home/Home2';
import My from '../My/My';
import ElementView from '../Home/ElementView';
// import Home from '../android/Home'
// import My from '../android/My'

class TabIcon extends React.Component {
    render() {
        return (
            <Text>{this.props.title}</Text>
        )
    }
}

export default class QuecRouter extends React.Component {

    constructor(props) {
        super(props)
        this.state = {
        }
    }
    componentDidMount() {
    }
    componentWillUnmount() {
    }
    componentDidUpdate(prevProps) {
    }
    render() {
        return <Router>
            <Scene key="root">
                <Scene key="tabbar"
                    tabs={true}
                    default="Home"
                    hideNavBar={true}
                >
                    <Scene key="Home"
                        component={Home}
                        title="Home"
                        icon={TabIcon}
                        initial
                    >
                    </Scene>
                    <Scene key="ElementView"
                        component={ElementView}
                        title="ElementView"
                        icon={TabIcon}
                    >
                    </Scene>

                    <Scene key="My"
                        component={My}
                        title="My"
                        icon={TabIcon}
                    >
                    </Scene>

                </Scene>
                <Scene key="Home2"
                    component={Home2}
                    title="Home2"
                ></Scene>
            </Scene>
        </Router>
    }
}