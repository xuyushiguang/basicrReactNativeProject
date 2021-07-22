import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  Button,
  DeviceEventEmitter,
} from 'react-native';
import { Action, connect, } from 'react-redux';


import { bindActionCreators } from 'redux';
import PropTypes from 'prop-types';
import * as actions from '../provider/MY/actions';
import * as actionsType from '../provider/MY/actionsTypes';


class Home2 extends React.Component {
  static navigationOptions = ({ navigation, navigationOptions }) => {
    const { params } = navigation.state;

    return {
      header: null
    };
  }
  constructor(props) {
    super(props)
    this.state = {
    }
    this.count = 0;
  }
  static defaultProps = {
  }
  static propTypes = {
  }
  componentDidMount() {
  }
  componentWillUnmount() {
  }
  componentDidUpdate(prevProps) {
  }
  render() {
    return (<View style={{ flex: 1, backgroundColor: 'red' }}>
      <Button title={this.props.name + "button"}
        onPress={() => {
          this.props.testAction("mymymy" + (++this.count))
        }}
      ></Button>
    </View>)
  }
}
function mapStateToProps(state) {
  return {
    name: state.my.name
  }
}
function mapDispatchToProps(dispatch) {
  return bindActionCreators(actions, dispatch)
}
export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Home2)