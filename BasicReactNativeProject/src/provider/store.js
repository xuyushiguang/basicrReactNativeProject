import {
    createStore,
    combineReducers,
} from 'redux';

import {
    Action,
    connect,
} from 'react-redux';

import homeReduces from './home/reduces';
import myReduces from './MY/reduces';

//把多个reducer合并成一个，并给每个reducer去一个别名
//这个别名就是state的属性名
const combineReducer = combineReducers({
    home: homeReduces,
    my: myReduces,
});

let store = createStore(combineReducer);

export default store;