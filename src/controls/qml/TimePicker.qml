/****************************************************************************************
**
** Copyright (C) 2018 Chupligin Sergey <neochapay@gmail.com>
** All rights reserved.
**
** You may use this file under the terms of BSD license as follows:
**
** Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are met:
**     * Redistributions of source code must retain the above copyright
**       notice, this list of conditions and the following disclaimer.
**     * Redistributions in binary form must reproduce the above copyright
**       notice, this list of conditions and the following disclaimer in the
**       documentation and/or other materials provided with the distribution.
**     * Neither the name of the author nor the
**       names of its contributors may be used to endorse or promote products
**       derived from this software without specific prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
** ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
** DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
** ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
** (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
** ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
** SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
****************************************************************************************/

import QtQuick 2.6
import QtQuick.Controls.Nemo 1.0

Item{
    id: timePicker
    width: 400
    height: width

    property date date: new Date();

    Rectangle{
        anchors.fill: parent
        color: "black"
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            var context = getContext("2d");

            var centerX = canvas.width / 2
            var centerY = canvas.height / 2

            var hour_radius = canvas.width/2*0.8 - 1.5*Theme.itemHeightExtraSmall/4 - Theme.itemHeightExtraSmall/5/2
            var hour_end_angle = getHourAngle()

            var minute_radius = canvas.width/2*0.8
            var minute_end_angle = getMinuteAngle();

/*Draw hours */
            context.beginPath();
            context.arc(centerX, centerY, hour_radius, -0.5*Math.PI, hour_end_angle, false);
            context.lineWidth = Theme.itemHeightExtraSmall/2;
            context.strokeStyle = Theme.accentColor;
            context.globalAlpha = 1;
            context.stroke();
/*Draw subhours if time AM*/
            if(date.getHours() > 12)
            {
                context.beginPath();
                context.arc(centerX, centerY, hour_radius, 0, 2 * Math.PI, false);
                context.lineWidth = Theme.itemHeightExtraSmall/2;
                context.strokeStyle = Theme.accentColor;
                context.globalAlpha = 0.5;
                context.stroke();
            }
/*Draw minute*/
            context.beginPath();
            context.arc(centerX, centerY, minute_radius, -0.5*Math.PI, minute_end_angle, false);
            context.lineWidth = Theme.itemHeightExtraSmall/5;
            context.strokeStyle = Theme.accentColor;
            context.globalAlpha = 0.5;
            context.stroke();
        }
    }

    Label{
        id: hourLabel
        text: timePicker.date.getHours()
        font.pixelSize: Theme.itemHeightExtraSmall/2
        font.bold: true
        x: canvas.width/2-hourLabel.contentWidth-Theme.itemHeightExtraSmall/10
        y: canvas.height/2-(canvas.width/2*0.8 - 1.5*Theme.itemHeightExtraSmall/4 - Theme.itemHeightExtraSmall/5/2) - Theme.itemHeightExtraSmall/4
    }

    Label{
        id: minuteLabel
        text: timePicker.date.getMinutes()
        font.pixelSize: Theme.itemHeightExtraSmall/5
        x: canvas.width/2-minuteLabel.contentWidth-Theme.itemHeightExtraSmall/10
        y: canvas.width/2-canvas.width/2*0.8-Theme.itemHeightExtraSmall/5/2
    }

    Component.onCompleted: console.log(date)

    function getHourAngle()
    {
        var hour = timePicker.date.getHours();
        if(hour > 12)
        {
            hour = hour-12
        }
        return 2*Math.PI/12*hour-0.5*Math.PI;
    }

    function getMinuteAngle()
    {
        var minute = timePicker.date.getMinutes()
        return 2*Math.PI/60*minute-0.5*Math.PI;
    }
}
