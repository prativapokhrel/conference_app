import React, { Component } from "react";
import axios from "axios";


class MainForm extends Component {

  state = {
      post: {},
      roomName: ""
    };
  
  // handle room create 
  handleButtonPress = () => {
    const params = {
      name: this.state.roomName,
      responseType: "json",
    };

    //  show error message if no name entered
    if (this.state.roomName.length === 0) {
      return this.setState({ errorMessage: "Please enter a name" });
    }

    // post request to rooms 
    axios
      .post("rooms.json", params)
      .then(() => {
        return (window.location = `/rooms/${this.state.roomName}`);
      })
      .catch(() =>
        this.setState({ errorMessage: "Oops! Something went wrong." })
      );
  };


  render() {
    return (
      <div>
        {this.state.errorMessage &&
          <div className="alert alert-danger text-center">
            <button
              type="button"
              className="close"
              data-dismiss="alert"
              aria-label="Close"
            >
              <span aria-hidden="true">&times;</span>
            </button>
            <div id="flash-message">
              {this.state.errorMessage}
            </div>
          </div>}

        <div className="">
          <div className="card-block">
            <div className="col-md-6 offset-md-3">
              <div className="form-group">
                <input
                  type="text"
                  placeholder="Enter Room Name"
                  maxLength="15"
                  id="room-name"
                  className="form-control"
                  value={this.state.roomName}
                  onChange={e => this.setState({ roomName: e.target.value })}
                />
              </div>
            </div>
            <div className="col-md-6 offset-md-3">
              <div className="form-group">
                <button
                  className="btn btn-blue btn-block"
                  onClick={this.handleButtonPress}
                >
                  {"Create A Room"}
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

    );
  }
}

export default MainForm;
