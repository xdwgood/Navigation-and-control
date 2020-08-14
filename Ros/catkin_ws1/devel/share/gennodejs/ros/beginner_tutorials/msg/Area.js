// Auto-generated. Do not edit!

// (in-package beginner_tutorials.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class Area {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.triangleArea = null;
      this.squareAresa = null;
    }
    else {
      if (initObj.hasOwnProperty('triangleArea')) {
        this.triangleArea = initObj.triangleArea
      }
      else {
        this.triangleArea = 0.0;
      }
      if (initObj.hasOwnProperty('squareAresa')) {
        this.squareAresa = initObj.squareAresa
      }
      else {
        this.squareAresa = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Area
    // Serialize message field [triangleArea]
    bufferOffset = _serializer.float64(obj.triangleArea, buffer, bufferOffset);
    // Serialize message field [squareAresa]
    bufferOffset = _serializer.float64(obj.squareAresa, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Area
    let len;
    let data = new Area(null);
    // Deserialize message field [triangleArea]
    data.triangleArea = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [squareAresa]
    data.squareAresa = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'beginner_tutorials/Area';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5648e7ac35be221a65813918d3e85b48';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 triangleArea
    float64 squareAresa
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Area(null);
    if (msg.triangleArea !== undefined) {
      resolved.triangleArea = msg.triangleArea;
    }
    else {
      resolved.triangleArea = 0.0
    }

    if (msg.squareAresa !== undefined) {
      resolved.squareAresa = msg.squareAresa;
    }
    else {
      resolved.squareAresa = 0.0
    }

    return resolved;
    }
};

module.exports = Area;
