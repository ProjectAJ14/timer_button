# Timer Button
A new Flutter package for timer button.

![timer_button](https://cdn-images-1.medium.com/max/640/1*NhgmN1C4ltcQA-o34SYbIQ.gif)


A Button which will be enabled after specified time.

## Usage
Set ButtonType for Button. There are 3 Type of button :
 - RaisedButton ```buttonType: ButtonType.RaisedButton``` (default)
 - FlatButton ```buttonType: ButtonType.FlatButton```
 - OutlineButton ```buttonType: ButtonType.OutlineButton```
 


Set text/lable  ``` label: "Try Again" ```

Set timeout in secounds ``` timeOutInSeconds: 20 ```

Set color ```color: Colors.deepPurple```

Set disabled color ``` disabledColor: Colors.red ```

## Example

``` 
                new TimerButton(
                  label: "Send OTP Again",
                  timeOutInSeconds: 20,
                  onPressed: () {},
                  disabledColor: Colors.red,
                  color: Colors.deepPurple,
                  disabledTextStyle: new TextStyle(fontSize: 20.0),
                  activeTextStyle: new TextStyle(fontSize: 20.0, color: Colors.white),
                )

```


[For issues and source code](https://github.com/ajaynonstopio/timer_button)








