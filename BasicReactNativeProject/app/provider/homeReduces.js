import * as ActionsTypes from './homeActionTypes';


const homeReduces = (state = {name:"0"}, action) => {
    switch (action.type) {
        case ActionsTypes.TestTag:
            return {
                name:action.name
            };
        default:
            return state;
    }
}

export default homeReduces;