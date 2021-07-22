import * as actionTypes from './actionsTypes';

export function testAction(data) {
    return {
        type: actionTypes.TestTag,
        name: data
    }
}