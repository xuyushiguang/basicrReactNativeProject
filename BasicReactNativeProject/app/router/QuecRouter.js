import React, { useState ,Component} from 'react';
import { SafeAreaView,
    StyleSheet,
    Text,
    View,
    Image,
    Button,
} from 'react-native';
import {Drawer, Router,Scene, Tabs} from 'react-native-router-flux';

import Home from '../Home/Home';
import My from '../My/My';

class TabIcon extends React.Component{
    render(){
        return (
            <Text>{this.props.title}</Text>
         )
    }
}

export default class QuecRouter extends React.Component{

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
                                initial
                                >
                        </Scene>
                        <Scene key="My" 
                            component={My}
                            title="My"
                            icon={TabIcon}
                            >
                        </Scene>
                    </Scene>
                </Scene>
            </Router>
        }
} 