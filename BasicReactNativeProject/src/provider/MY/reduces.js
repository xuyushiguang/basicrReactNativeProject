import * as ActionsTypes from './actionsTypes';


const myReduces = (state = { name: "0" }, action) => {
    switch (action.type) {
        case ActionsTypes.TestTag:
            return {
                name: action.name
            };
        default:
            return state;
    }
}

export default myReduces;