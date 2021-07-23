import React, { Component } from 'react';
import {
  StyleSheet,
  DeviceEventEmitter,
  View,

  ScrollView,
} from 'react-native';

import PropTypes from 'prop-types';
import {
  Header, Card, Badge, BottomSheet, Button, ButtonGroup,
  CheckBox, Chip, FAB, Icon, Input, LinearProgress,
  ListItem, Overlay, Slider, SocialIcon, SpeedDial,
  Switch, Tab, Text, Tooltip, Tile, TabView

} from 'react-native-elements';
import { l } from 'i18n-js';


export default class ElementView extends React.Component {
  static navigationOptions = ({ navigation, navigationOptions }) => {
    const { params } = navigation.state;
    return {
      header: null
    };
  }
  constructor(props) {
    super(props)
    this.state = {
      showBottomSheet: false,
      showOverlay: false,
      open: false,
    }
    this.count = 0;
    this.list = [
      {
        name: 'Amy Farha',
        subtitle: 'Vice President'
      },
      {
        name: 'Chris Jackson',
        subtitle: 'Vice Chairman'
      },
    ]
  }

  render() {
    return (<View style={{ flex: 1, backgroundColor: 'white' }}>
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

      <ScrollView>

        <Card>
          <Card.Title>card title</Card.Title>
          <Card.Divider></Card.Divider>
          <Text>aaaa</Text>
          <Badge value="100" status="error"></Badge>
          <Badge status="success"></Badge>
          <Button title="showBootomSheet" onPress={() => {
            this.setState({ showBottomSheet: true })
          }}></Button>
          <CheckBox title="click" checked={true}></CheckBox>
          <CheckBox
            center
            title='Click Here'
            checkedIcon='dot-circle-o'
            uncheckedIcon='circle-o'
            checked={true}
          />
          <CheckBox
            center
            title='Click Here'
            iconRight
            iconType='material'
            checkedIcon='clear'
            uncheckedIcon='add'
            checkedColor='red'
            checked={false}
          />
          <Chip title="chip"></Chip>
          <Chip title="chip" type='outline'
            icon={{ name: 'close', type: 'font-awesome', size: 20, color: 'red' }}
            iconRight
            onPress={() => {

            }}
          ></Chip>

          <FAB title="FAB"
            loading={false}
            icon={{ name: 'close', type: 'font-awesome', size: 20, color: 'red' }}
            iconRight
            onPress={() => {

            }}
          ></FAB>
          <Icon
            name='rowing' />
          <Icon
            reverse
            name='ios-american-football'
            type='ionicon'
            color='#517fa4'
          />
          <Input
            placeholder='INPUT WITH ICON'
            leftIcon={{ type: 'ionicon', name: 'ios-american-football' }}
            errorStyle={{ color: 'red' }}
            errorMessage='ENTER A VALID ERROR HERE'
          />
          <LinearProgress color="primary"
            value={0.5}
            variant="determinate"
          ></LinearProgress>

          <View>
            {this.list.map((l, i) => (
              <ListItem key={i} bottomDivider>
                <ListItem.Content>
                  <ListItem.Title>{l.name}</ListItem.Title>
                  <ListItem.Subtitle>{l.subtitle}</ListItem.Subtitle>
                </ListItem.Content>
                <ListItem.Chevron></ListItem.Chevron>
                <ListItem.Input placeholder={'aaaaa'}></ListItem.Input>
              </ListItem>
            ))
            }
          </View>
          {/* <Button title="Open Overlay" onPress={this.setState({ showOverlay: true })} /> */}

          <Slider
            value={0.5}
            trackStyle={{ height: 10, backgroundColor: 'transparent' }}
            thumbStyle={{ height: 20, width: 20, backgroundColor: 'transparent' }}
            thumbProps={{
              children: (
                <Icon
                  name="heartbeat"
                  type="font-awesome"
                  size={15}
                  reverse
                  containerStyle={{ bottom: 15, right: 20 }}
                  color="#f50"
                />
              ),
            }}
          ></Slider>
          <SocialIcon
            type="twitter"
            button
            title="click"
            onPress={() => { }}
            style={{ backgroundColor: 'red' }}
          ></SocialIcon>
          <SpeedDial
            isOpen={this.state.open}
            icon={{ name: 'edit', color: '#fff' }}
            openIcon={{ name: 'close', color: '#fff' }}
            onOpen={() => { this.setState({ open: true }) }}
            onClose={() => { this.setState({ open: false }) }}
          >
            <SpeedDial.Action
              icon={{ name: 'add', color: '#fff' }}
              title="Add"
              onPress={() => console.log('Add Something')}
            />
            <SpeedDial.Action
              icon={{ name: 'delete', color: '#fff' }}
              title="Delete"
              onPress={() => console.log('Delete Something')}
            />
          </SpeedDial>
          <Switch value={true}></Switch>
          <Tooltip popover={<Text>info sss</Text>}>
            <Text>press me</Text>
          </Tooltip>
        </Card>
      </ScrollView>

      <ButtonGroup
        button={["bt1111", "bt2", "bt3"]}
        onPress={(index) => { }}
        selectedIndex={0}
        textStyle={{ color: '#111' }}

      ></ButtonGroup>

      {/* <Overlay isVisible={this.state.showOverlay} onBackdropPress={this.setState({ showOverlay: false })}>
        <Text>Hello from Overlay!</Text>
      </Overlay> */}

      <BottomSheet isVisible={this.state.showBottomSheet}
        containerStyle={{ backgroundColor: 'rgba(0.5, 0.25, 0, 0.2)' }}
      >
        <View style={{ backgroundColor: 'white' }}>
          <Text>aaaaa</Text>
          <Text>bbbb</Text>
          <Text>cccc</Text>
        </View>
        <Button title="cancle" onPress={() => {
          this.setState({ showBottomSheet: false })
        }}></Button>
      </BottomSheet>


    </View >)
  }
}
