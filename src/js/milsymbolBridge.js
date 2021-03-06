'use strict';

var ms = require('milsymbol');
var _ = require('lodash');

export function processSymbol(description) {
    var data = {
        path: "",
        cx: 0,
        cy: 0,
        r: 0,
        x: 0,
        y: 0,
        degree: 0,
        textAnchor: "",
        fontSize: 0,
        fontFamily: "",
        fontweight: "",
        factor: 0,
        dP: null,
        linecap: "",
        drawParent: null,
        svg: null
    };
    var reduxFunction = function (acc, val) {
        var parent = null;
        function reduxInner(acc, val) {
            var valAct = acc[0] + 1;
            var listAct = acc[1];
            //If the object has a list of draw, call this function over the list
            var t = _.omit(_.assign(data, _.assign(val, {
                id: valAct,
                symbolType: val.type,
                dP: {
                    fill: _.isNil(val.fill) || _.isBoolean(val.fill) ? null : val.fill,
                    fillopacity: _.isNil(val.fillopacity) ? null : val.fillopacity,
                    stroke: _.isNil(val.stroke) ? null : val.stroke,
                    strokewidth: _.isNil(val.strokewidth) ? null : val.strokewidth,
                    strokedasharray: _.isNil(val.strokedasharray) ? null : val.strokedasharray
                },
                drawParent : parent
            })), ['draw', 'type']);
            var h2 = [valAct, [t]]
            if (!_.isNil(val.draw) && val.draw.length > 0) {
                parent = valAct;
                h2 = _.reduce(val.draw, reduxInner, h2);
                parent = null;
            }
            return [h2[0], _.concat(acc[1], h2[1])];
        };
        return reduxInner(acc, val);
    };
    var locualo = new ms.Symbol(description);
    var loQue = locualo.drawInstructions;
    var m = _.reduce(loQue, reduxFunction, [-1, []]);
    var ptemp = locualo.getProperties();
    var baseG = {
        bbox : ptemp.baseGeometry.bbox,
        g : {
            typeG : ptemp.baseGeometry.g.type,
            d : _.isNil(ptemp.baseGeometry.g.d) ? null: ptemp.baseGeometry.g.d
        }
    }
    ptemp.baseGeometry = baseG;

    return {
        draws: m[1],
        props: ptemp
    };
};