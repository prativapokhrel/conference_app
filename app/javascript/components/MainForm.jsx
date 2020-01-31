import React, { Component } from "react";
import axios from "axios";


class MainForm extends Component {


    state = {
      post: {},
      roomName: "",
      willCreateRoom: true
    };

  handleButtonPress = () => {
    const params = {
      name: this.state.roomName,
      responseType: "json",
      // headers: ReactOnRails.authenticityHeaders()
    };

    if (this.state.roomName.length === 0) {
      return this.setState({ errorMessage: "Please enter a name 😔" });
    }

    if (this.state.willCreateRoom) {
      axios
        .post("rooms.json", params)
        .then(() => {
          return (window.location = `/rooms/${this.state.roomName}`);
        })
        .catch(() =>
          this.setState({ errorMessage: "Oops! Something went wrong." })
        );
    } else {
      window.location = `/rooms/${this.createSlug()}`;
    }
  };

  createSlug = () => {
    const regexSpaces = /\s/g;
    const regexChars = /\W/g;
    let { roomName } = this.state;
    let slug = roomName.replace(regexSpaces, "-");
    slug = slug.replace(regexChars, "-");

    return slug;
  };

  render() {
    return (
      <div>
        {this.state.errorMessage &&
          <div className="alert alert-dismissible fade show alert-notice m-0 btn-square">
            <button
              type="button"
              className="close"
              data-dismiss="alert"
              aria-label="Close"
              onClick={() => this.setState({ errorMessage: null })}
            >
              <span aria-hidden="true">&times;</span>
            </button>
            <div id="flash-message">
              {this.state.errorMessage}
            </div>
          </div>}

        <div className="">
          <div className="card-block">
            {/* <h2 className="text-secondary">
              {"Enter Room Name"}
            </h2> */}

            {/* {this.state.roomName &&
              <div className="card-header border-0">
                {`${window.location.origin}/rooms/${this.createSlug()}`}
              </div>} */}
            <div className="col-md-6 offset-md-3">
              <div className="form-group">
                <input
                  type="text"
                  placeholder="Enter Room Name"
                  maxLength="15"
                  className="form-control"
                  value={this.state.roomName}
                  onChange={e => this.setState({ roomName: e.target.value })}
                />
              </div>
            </div>
            <div className="col-md-6 offset-md-3">
              <div className="form-group">
                <button
                  className="btn btn-salmon btn-block"
                  onClick={this.handleButtonPress}
                >
                  {this.state.willCreateRoom ? "Create A Room" : "Enter Room"}
                </button>
              </div>
            </div>

            {/* <button
              className="mt-3 btn btn-link btn-block"
              onClick={this.handleToggleForm}
            >
              {willCreateRoom
                ? "Know where you're going?"
                : "Need to Create a Room?"}
            </button> */}
          </div>
        </div>
      </div>

    );
  }
}

export default MainForm;
