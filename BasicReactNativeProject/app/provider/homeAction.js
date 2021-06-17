import * as actionTypes from './homeActionTypes';

export function testAction(data){
    return {
        type:actionTypes.TestTag,
        name:data
    }
}