import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
ApplicationWindow {
    id:mainWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Calculator")

    property string temp:" "
    property var historyList:[""]

    header: ToolBar
    {
        RowLayout
        {
            anchors.fill:parent
            ToolButton
            {
                //tool bar
                id:toolBarButton
                text: "☰"
                onClicked:
                {
                    menu.open()
                }
                Menu
                {
                    id:menu
                    MenuItem
                    {
                        text:"Standard"
                    }
                    MenuItem
                    {
                        text:"Scientific"
                    }
                    MenuItem
                    {
                        text:"Graphing"

                    }
                    MenuItem
                    {
                        text:"Programmer"
                    }
                    MenuItem
                    {
                        text:"Date calculation"
                    }
                }
            }
            Label
            {
                id:toolBarLabel
                text:"Calculator"
                elide:Label.ElideLeft
                horizontalAlignment: Qt.AlignCenter
                verticalAlignment: Qt.AlignHCenter
                font.pixelSize:14

            }

        }
    }
    RowLayout
    {
        function checkCalc(value)
        {
            if(value ==="+" || value === "-" || value === "*" || value ==="/")
                return true;
            return false;
        }
        //keyboard handle
        Keys.onPressed:
        {
            if (event.key >= Qt.Key_1 && event.key <= Qt.Key_9)
            {
                labelTopScreen.text +=String.fromCharCode(event.key)
            }
            if (event.key === Qt.Key_Backspace )
            {
                labelTopScreen.text=labelTopScreen.text.substring(0, labelTopScreen.text.length - 1)
            }
            if(checkCalc(String.fromCharCode(event.key)))
            {
                if(checkCalc(labelTopScreen2.text.charAt(labelTopScreen2.text.length - 1)))
                {
                    labelTopScreen2.text=labelTopScreen2.text.substring(0, labelTopScreen2.text.length - 1)
                    labelTopScreen2.text = labelTopScreen2.text + String.fromCharCode(event.key)
                }
                else
                {
                    labelTopScreen2.text = labelTopScreen.text +" "+ String.fromCharCode(event.key)
                    labelTopScreen.text = " "
                }
            }
            if(String.fromCharCode(event.key) === "=")
            {

                if(!checkCalc(labelTopScreen2.text.charAt(labelTopScreen2.text.length - 1)))
                {
                    labelTopScreen2.text = labelTopScreen.text +"="
                    var res = " " + labelTopScreen2.text + " " + labelTopScreen.text
                    return;
                }
                temp = labelTopScreen.text
                __calculating.normalCalculating(labelTopScreen2.text,labelTopScreen.text);
                labelTopScreen2.text = labelTopScreen2.text + temp + " ="
                var historyTestToPush =labelTopScreen2.text + " " + labelTopScreen.text
                historyList.push(historyTestToPush)
                historyListView.model.append({historyText:historyList.pop()})
            }

        }


        focus:true
        anchors.fill:parent
        Rectangle
        {
            focus:true
            id:screenAndButton
            anchors
            {
                top:parent.top
                bottom:parent.bottom
                left:parent.left
                //right:parent.right
            }

            height: parent.height
            width:parent.width*3/4

            ColumnLayout
            {
                focus:true
                anchors.fill:parent
                anchors
                {
                    margins:10

                }
                spacing:5

                //Screen
                Rectangle
                {
                    id:topScreen
                    anchors
                    {
                        left:parent.left
                        right:parent.right
                        top:parent.top
                    }
                    radius:10
                    border.width: 2
                    width: parent.width
                    height: parent.height/4
                    //color:"#ADADAD"
                    Label
                    {
                        id:labelTopScreen
                        anchors
                        {
                            bottom:parent.bottom
                            right:parent.right
                        }
                        text:" "
                        font.pixelSize: 40
                        font.bold:true
                        clip:true
                    }
                    Label
                    {
                        id:labelTopScreen2
                        anchors
                        {
                            bottom:labelTopScreen.top
                            right:parent.right
                        }
                        text:" "
                        font.pixelSize: 20
                        font.bold:true
                        clip:true
                    }

                    states:
                        [
                        State
                        {
                            when:labelTopScreen.text===" " && labelTopScreen2.text===" "
                            PropertyChanges {
                                target: topScreen
                                color:"white"

                            }
                        },
                        State
                        {
                            when:labelTopScreen.text!==" " || labelTopScreen2.text!==" "
                            PropertyChanges {
                                target: topScreen
                                color:"#ADADAD"
                                opacity:0.95
                            }
                        }
                    ]
                    transitions:
                        [
                        Transition {
                            reversible: true
                            PropertyAnimation
                            {
                                target: topScreen
                                properties: color
                                duration:10000
                            }

                        }
                    ]

                }
                //buttons
                Rectangle
                {
                    focus:true
                    id:bottomButtons
                    anchors
                    {
                        top : topScreen.bottom
                        bottom:parent.bottom
                        left:parent.left
                        right:parent.right
                        topMargin:5
                    }

                    color: "#f5f5f5"

                    Component.onCompleted:
                    {
                        //for(var i =9;i>=0;i--)
                        buttonList.model.append({buttonsText: "%"})
                        buttonList.model.append({buttonsText: "CE"})
                        buttonList.model.append({buttonsText: "C"})
                        buttonList.model.append({buttonsText: "Del"})

                        buttonList.model.append({buttonsText: "1/x"})
                        buttonList.model.append({buttonsText: "x^2"})
                        buttonList.model.append({buttonsText: "can2"})
                        buttonList.model.append({buttonsText: "/"})

                        buttonList.model.append({buttonsText: "7"})
                        buttonList.model.append({buttonsText: "8"})
                        buttonList.model.append({buttonsText: "9"})
                        buttonList.model.append({buttonsText: "*"})

                        buttonList.model.append({buttonsText: "4"})
                        buttonList.model.append({buttonsText: "5"})
                        buttonList.model.append({buttonsText: "6"})
                        buttonList.model.append({buttonsText: "-"})

                        buttonList.model.append({buttonsText: "1"})
                        buttonList.model.append({buttonsText: "2"})
                        buttonList.model.append({buttonsText: "3"})
                        buttonList.model.append({buttonsText: "+"})

                        buttonList.model.append({buttonsText: "+/-"})
                        buttonList.model.append({buttonsText: "0"})
                        buttonList.model.append({buttonsText: "."})
                        buttonList.model.append({buttonsText: "="})
                    }
                    GridView
                    {
                        focus:true


                        //anchors.fill:parent
                        id:buttonList
                        anchors
                        {
                            top:parent.top
                            bottom:parent.bottom
                            left:parent.left
                            right:parent.right

                        }

                        model:ListModel{}
                        cellWidth: parent.width/4
                        cellHeight: parent.height/6

                        delegate:Button
                        {
                            id:button
                            focus:true


                            function checkNumeric(value)
                            {
                                if(value ==="0"||value ==="1" || value==="2"||value ==="3"||value==="4"||value==="5"||value==="6"||value==="7"||value==="8"||value==="9")
                                    return true;
                                return false;
                            }
                            function checkCalc(value)
                            {
                                if(value ==="+" || value === "-" || value === "*" || value ==="/")
                                    return true;
                                return false;
                            }
                            Text
                            {
                                id:buttonText
                                text:buttonsText
                                anchors
                                {
                                    centerIn:parent
                                }
                                font.pixelSize: 20
                                font.family: "Lato"

                            }
                            width:bottomButtons.width/4
                            height:bottomButtons.height/6

                            MouseArea {

                                id:mouseAreaButon
                                hoverEnabled:true
                                anchors.fill: parent
                                onEntered: {

                                    button.opacity = 0.65
                                    buttonText.font.bold = true
                                }

                                onExited: {
                                    button.opacity = 1
                                    buttonText.font.bold = false
                                }

                                onClicked:
                                {
                                    //console.log(buttonsText)
                                    //xoa 1 dong
                                    if(buttonsText ==="CE")
                                    {
                                        labelTopScreen.text = " ";
                                    }

                                    //xoa toan bo man hinh
                                    if(buttonsText === "C")
                                    {
                                        labelTopScreen.text = " ";
                                        labelTopScreen2.text = " ";
                                    }
                                    //thuc hien phep tinh moi
                                    if(checkNumeric(buttonsText) && labelTopScreen2.text.charAt(labelTopScreen2.text.length - 1)
                                            === "=")
                                    {
                                        labelTopScreen.text = " ";
                                        labelTopScreen2.text = " ";
                                    }
                                    //nhap so
                                    if(checkNumeric(buttonsText) || buttonsText ===".")
                                        labelTopScreen.text = labelTopScreen.text + buttonsText
                                    //kiem tra nhap phep tinh
                                    if(checkCalc(buttonsText))
                                    {
                                        if(checkCalc(labelTopScreen2.text.charAt(labelTopScreen2.text.length - 1)))
                                        {
                                            labelTopScreen2.text=labelTopScreen2.text.substring(0, labelTopScreen2.text.length - 1)
                                            labelTopScreen2.text = labelTopScreen2.text + buttonsText
                                        }
                                        else
                                        {
                                            labelTopScreen2.text = labelTopScreen.text +" "+ buttonsText
                                            labelTopScreen.text = " "
                                        }
                                    }
                                    //xoa 1 ky tu
                                    if(buttonsText === "Del")
                                    {
                                        labelTopScreen.text=labelTopScreen.text.substring(0, labelTopScreen.text.length - 1)

                                    }
                                    //doi dau
                                    if(buttonsText === "+/-")
                                    {

                                        labelTopScreen.text = - labelTopScreen.text

                                    }
                                    //thuc hien phep tinh
                                    if(buttonsText ==="=")
                                    {

                                        if(!checkCalc(labelTopScreen2.text.charAt(labelTopScreen2.text.length - 1)))
                                        {
                                            labelTopScreen2.text = labelTopScreen.text +"="
                                            var res = " " + labelTopScreen2.text + " " + labelTopScreen.text
                                            //                                       historyListView.text = historyListView.text +"\n" + res +" "
                                            //                                        if(historyListView.text.length > 320)
                                            //                                        {
                                            //                                            historyListView.text = " "
                                            //                                            historyListView.text = historyListView.text +"\n" + res
                                            //                                        }


                                            return;
                                        }

                                        temp = labelTopScreen.text
                                        __calculating.normalCalculating(labelTopScreen2.text,labelTopScreen.text);
                                        labelTopScreen2.text = labelTopScreen2.text + temp + " ="
                                        var historyTestToPush =labelTopScreen2.text + " " + labelTopScreen.text

                                        //Shortcut

                                        historyList.push(historyTestToPush)

                                        //var res =" " + labelTopScreen2.text + " " + labelTopScreen.text
                                        //historyListView.text = historyListView.text +"\n" + res +" "

                                        //                                    if(historyListView.text.length > 320)
                                        //                                    {
                                        //                                        historyListView.text = " "
                                        //                                        historyListView.text = historyListView.text +"\n" + res
                                        //                                    }
                                        //                                    historyList.push(historyListView.text +"\n" + res +" ")



                                        historyListView.model.append({historyText:historyList.pop()})
                                        //console.log()
                                    }
                                    //binh phuong
                                    if(buttonsText === "x^2")
                                    {
                                        __calculating.square(labelTopScreen.text);
                                    }
                                    // 1 /x
                                    if(buttonsText === "1/x")
                                    {
                                        __calculating.oneperx(labelTopScreen.text);
                                        if(labelTopScreen.text.length > 8)
                                            labelTopScreen.text = labelTopScreen.text.substring(0,8)

                                    }
                                    //can 2
                                    if(buttonsText ==="can2")
                                    {
                                        __calculating.__sqrt(labelTopScreen.text);

                                    }
                                    //phan tram
                                    if(buttonsText === "%")
                                    {
                                        __calculating.percent(labelTopScreen.text)
                                        if(labelTopScreen.text.length > 8)
                                            labelTopScreen.text = labelTopScreen.text.substring(0,8)
                                    }
                                }

                            }

                            background: Rectangle
                            {
                                color: "white"
                                radius:10
                                border.width:1
                                border.color:"#ADADAD"

                            }
                            Connections{
                                target: __calculating;
                                //ignoreUnknownSignal:true;
                                onSendResult:
                                {

                                    labelTopScreen.text = result;
                                }

                            }
                        }
                    }
                }
            }
        }
        Rectangle
        {
            //memory list
            id:memory
            anchors
            {
                top:parent.top
                bottom:parent.bottom
                left:screenAndButton.right
                right:parent.right
                margins:5
            }
            height: parent.height
            width:parent.width/4
            ColumnLayout
            {
                anchors.fill:parent
                Rectangle
                {

                    id:memoryButtons
                    anchors
                    {
                        top:parent.top
                        right:parent.right
                        left:parent.left
                        //bottom:parent.bottom
                    }
                    width:parent.width
                    height: parent.height/8
                    RowLayout
                    {

                        Button
                        {
                            text: "Memory"
                            width:Layout.fillWidth/2
                            background: Rectangle
                            {
                                color: "white"
                                radius:10
                                border.width:1
                                border.color:"#ADADAD"
                            }
                        }
                        Button
                        {
                            id:clearButton
                            text: "Clear"
                            background: Rectangle
                            {
                                color: "white"
                                radius:10
                                border.width:1
                                border.color:"#ADADAD"

                            }
                            MouseArea
                            {
                                hoverEnabled:true
                                anchors.fill: parent
                                onEntered: {
                                    clearButton.opacity = 0.65
                                    clearButton.font.bold = true
                                }

                                onExited:
                                {
                                    clearButton.opacity = 1
                                    clearButton.font.bold = false
                                }
                                onClicked:
                                {
                                    historyListView.model.clear()

                                }
                            }


                        }

                    }
                }
                Rectangle
                {
                    id:memoryScreen
                    anchors
                    {
                        top:memoryButtons.bottom
                        right:parent.right
                        left:parent.left
                        bottom:parent.bottom
                    }
                    width:parent.width
                    height: parent.height*3/5
                    Rectangle{
                        anchors.fill:parent
                        color:"#f5f5f5"
                        radius:5

                        ListView
                        {
                            id:historyListView
                            anchors.fill:parent
                            spacing:4
                            model:ListModel{}
                            delegate: Text
                            {
                                width:parent.width
                                height:12
                                text:model.historyText
                            }
                        }
                    }

                    //                    Label
                    //                    {

                    //                        id:historyListView
                    //                        width:parent.width
                    //                        height:parent.height

                    //                        text: " "
                    //                        clip:true
                    //                        Layout.fillWidth: true
                    //                        background: Rectangle
                    //                        {
                    //                            color:"#f5f5f5"
                    //                            border.color:"black"
                    //                            border.width:1
                    //                            radius:4

                    //                        }
                    //                    }


                }
            }
        }
    }
}

