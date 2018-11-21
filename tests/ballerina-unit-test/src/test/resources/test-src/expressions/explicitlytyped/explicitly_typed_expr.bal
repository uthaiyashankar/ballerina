// Copyright (c) 2018 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

//////////////////////// from string ////////////////////////

function testStringAsString(string s1) returns boolean {
    string s2 = <string> s1;
    anydata s3 = <string> getString(s1);

    return s1 == s3 && s2 == s1 && s3 is string;
}

function testStringInUnionAsString(string s1) returns boolean {
    Employee|string|int s2 = s1;
    json s3 = s1;
    anydata s4 = s1;
    any s5 = s1;

    string s6 = <string> s2;
    string s7 = <string> s3;
    string s8 = <string> s4;
    string s9 = <string> s5;

    return s1 == s6 && s7 == s6 && s7 == s8 && s9 == s8;
}

//////////////////////// from float ////////////////////////

function testFloatAsString(float f1) returns (boolean, string) {
    string s3 = <string> f1;
    anydata s4 = <string> getFloat(f1);

    return (s3 == s4 && s4 is string, s3);
}

function testFloatInUnionAsString(float f1) returns (boolean, string) {
    Employee|string|float f2 = f1;
    json f3 = f1;
    anydata f4 = f1;
    any f5 = f1;

    string s6 = <string> f2;
    string s7 = <string> f3;
    string s8 = <string> f4;
    string s9 = <string> f5;

    return (s7 == s6 && s7 == s8 && s9 == s8, s6);
}

function testFloatAsFloat(float f1) returns (boolean, float) {
    float s3 = <float> f1;
    anydata s4 = <float> getFloat(f1);

    return (s3 == s4 && s4 is float, s3);
}

function testFloatInUnionAsFloat(float f1) returns (boolean, float) {
    Employee|string|float f2 = f1;
    json f3 = f1;
    anydata f4 = f1;
    any f5 = f1;

    float s6 = <float> f2;
    float s7 = <float> f3;
    float s8 = <float> f4;
    float s9 = <float> f5;

    return (s7 == s6 && s7 == s8 && s9 == s8, s6);
}

function testFloatAsDecimal(float f1) returns (boolean, decimal) {
    decimal s3 = <decimal> f1;
    anydata s4 = <decimal> getFloat(f1);

    return (s3 == s4 && s4 is decimal, s3);
}

function testFloatInUnionAsDecimal(float f1) returns (boolean, decimal) {
    Employee|string|float f2 = f1;
    json f3 = f1;
    anydata f4 = f1;
    any f5 = f1;

    decimal s6 = <decimal> f2;
    decimal s7 = <decimal> f3;
    decimal s8 = <decimal> f4;
    decimal s9 = <decimal> f5;

    return (s7 == s6 && s7 == s8 && s9 == s8, s6);
}

function testFloatAsInt(float f1) returns (boolean, int) {
    int s3 = <int> f1;
    anydata s4 = <int> getFloat(f1);

    return (s3 == s4 && s4 is int, s3);
}

function testFloatInUnionAsInt(float f1) returns (boolean, int) {
    Employee|string|float f2 = f1;
    json f3 = f1;
    anydata f4 = f1;
    any f5 = f1;

    int s6 = <int> f2;
    int s7 = <int> f3;
    int s8 = <int> f4;
    int s9 = <int> f5;

    return (s7 == s6 && s7 == s8 && s9 == s8, s6);
}

function testFloatAsBoolean() returns (boolean, boolean) {
    float f1 = 1.0;
    boolean s3 = <boolean> f1;
    any s4 = <boolean> getFloat(f1);
    boolean nonZeroAsBoolean = s3;
    if (s4 is boolean) {
        nonZeroAsBoolean = nonZeroAsBoolean && s4;
    }

    f1 = -134567.20;
    s3 = <boolean> f1;
    s4 = <boolean> getFloat(f1);
    nonZeroAsBoolean = nonZeroAsBoolean && s3;
    if (s4 is boolean) {
        nonZeroAsBoolean = nonZeroAsBoolean && s4;
    }

    f1 = 0.0;
    s3 = <boolean> f1;
    s4 = <boolean> getFloat(f1);
    boolean zeroAsBoolean = s3;
    if (s4 is boolean) {
        zeroAsBoolean = zeroAsBoolean || s4;
    }
    return (nonZeroAsBoolean, zeroAsBoolean);
}

function testFloatInUnionAsBoolean() returns (boolean, boolean) {
    float f1 = 1.0;
    float|Employee|int f2 = f1;
    json f3 = f1;
    anydata f4 = f1;
    any f5 = f1;

    boolean b1 = <boolean> f2;
    boolean b2 = <boolean> f3;
    boolean b3 = <boolean> f4;
    boolean b4 = <boolean> f5;
    boolean nonZeroAsBoolean = b1 && b2 && b3 && b4;

    f1 = -134567.20;
    f2 = f1;
    f3 = f1;
    f4 = f1;
    f5 = f1;
    b1 = <boolean> f2;
    b2 = <boolean> f3;
    b3 = <boolean> f4;
    b4 = <boolean> f5;
    nonZeroAsBoolean = nonZeroAsBoolean && b1 && b2 && b3 && b4;

    f1 = 0.0;
    f2 = f1;
    f3 = f1;
    f4 = f1;
    f5 = f1;
    b1 = <boolean> f2;
    b2 = <boolean> f3;
    b3 = <boolean> f4;
    b4 = <boolean> f5;
    return (nonZeroAsBoolean, b1 || b2 || b3 || b4);
}

//////////////////////// from decimal ////////////////////////

function testDecimalAsString(decimal f1) returns (boolean, string) {
    string s3 = <string> f1;
    anydata s4 = <string> getDecimal(f1);

    return (s3 == s4 && s4 is string, s3);
}

function testDecimalInUnionAsString(decimal f1) returns (boolean, string) {
    Employee|string|decimal f2 = f1;
    json f3 = f1;
    anydata f4 = f1;
    any f5 = f1;

    string s6 = <string> f2;
    string s7 = <string> f3;
    string s8 = <string> f4;
    string s9 = <string> f5;

    return (s7 == s6 && s7 == s8 && s9 == s8, s6);
}

function testDecimalAsFloat(decimal f1) returns (boolean, float) {
    float s3 = <float> f1;
    anydata s4 = <float> getDecimal(f1);

    return (s3 == s4 && s4 is float, s3);
}

function testDecimalInUnionAsFloat(decimal f1) returns (boolean, float) {
    Employee|string|decimal f2 = f1;
    json f3 = f1;
    anydata f4 = f1;
    any f5 = f1;

    float s6 = <float> f2;
    float s7 = <float> f3;
    float s8 = <float> f4;
    float s9 = <float> f5;

    return (s7 == s6 && s7 == s8 && s9 == s8, s6);
}

function testDecimalAsDecimal(decimal f1) returns (boolean, decimal) {
    decimal s3 = <decimal> f1;
    anydata s4 = <decimal> getDecimal(f1);

    return (s3 == s4 && s4 is decimal, s3);
}

function testDecimalInUnionAsDecimal(decimal f1) returns (boolean, decimal) {
    Employee|string|decimal f2 = f1;
    json f3 = f1;
    anydata f4 = f1;
    any f5 = f1;

    decimal s6 = <decimal> f2;
    decimal s7 = <decimal> f3;
    decimal s8 = <decimal> f4;
    decimal s9 = <decimal> f5;

    return (s7 == s6 && s7 == s8 && s9 == s8, s6);
}

function testDecimalAsInt(decimal f1) returns (boolean, int) {
    int s3 = <int> f1;
    anydata s4 = <int> getDecimal(f1);
    return (s3 == s4 && s4 is int, s3);
}

function testDecimalInUnionAsInt(decimal f1) returns (boolean, int) {
    Employee|string|decimal f2 = f1;
    json f3 = f1;
    anydata f4 = f1;
    any f5 = f1;

    int s6 = <int> f2;
    int s7 = <int> f3;
    int s8 = <int> f4;
    int s9 = <int> f5;

    return (s7 == s6 && s7 == s8 && s9 == s8, s6);
}

function testDecimalAsBoolean() returns (boolean, boolean) {
    decimal f1 = 1.0;
    boolean s3 = <boolean> f1;
    any s4 = <boolean> getDecimal(f1);
    boolean nonZeroAsBoolean = s3;
    if (s4 is boolean) {
        nonZeroAsBoolean = nonZeroAsBoolean && s4;
    }

    f1 = -134567.20;
    s3 = <boolean> f1;
    s4 = <boolean> getDecimal(f1);
    nonZeroAsBoolean = nonZeroAsBoolean && s3;
    if (s4 is boolean) {
        nonZeroAsBoolean = nonZeroAsBoolean && s4;
    }

    f1 = 0.0;
    s3 = <boolean> f1;
    s4 = <boolean> getDecimal(f1);
    boolean zeroAsBoolean = s3;
    if (s4 is boolean) {
        zeroAsBoolean = zeroAsBoolean || s4;
    }
    return (nonZeroAsBoolean, zeroAsBoolean);
}

function testDecimalInUnionAsBoolean() returns (boolean, boolean) {
    decimal f1 = 1.0;
    int|decimal|Employee f2 = f1;
    json f3 = f1;
    anydata f4 = f1;
    any f5 = f1;

    boolean b1 = <boolean> f2;
    boolean b2 = <boolean> f3;
    boolean b3 = <boolean> f4;
    boolean b4 = <boolean> f5;
    boolean nonZeroAsBoolean = b1 && b2 && b3 && b4;

    f1 = -134567.20;
    f2 = f1;
    f3 = f1;
    f4 = f1;
    f5 = f1;
    b1 = <boolean> f2;
    b2 = <boolean> f3;
    b3 = <boolean> f4;
    b4 = <boolean> f5;
    nonZeroAsBoolean = nonZeroAsBoolean && b1 && b2 && b3 && b4;

    f1 = 0.0;
    f2 = f1;
    f3 = f1;
    f4 = f1;
    f5 = f1;
    b1 = <boolean> f2;
    b2 = <boolean> f3;
    b3 = <boolean> f4;
    b4 = <boolean> f5;
    return (nonZeroAsBoolean, b1 || b2 || b3 || b4);
}

//////////////////////// from int ////////////////////////

function testIntAsString(int f1) returns (boolean, string) {
    string s3 = <string> f1;
    anydata s4 = <string> getInt(f1);

    return (s3 == s4 && s4 is string, s3);
}

function testIntInUnionAsString(int f1) returns (boolean, string) {
    Employee|string|int f2 = f1;
    json f3 = f1;
    anydata f4 = f1;
    any f5 = f1;

    string s6 = <string> f2;
    string s7 = <string> f3;
    string s8 = <string> f4;
    string s9 = <string> f5;

    return (s7 == s6 && s7 == s8 && s9 == s8, s6);
}

function testIntAsFloat(int f1) returns (boolean, float) {
    float s3 = <float> f1;
    anydata s4 = <float> getInt(f1);

    return (s3 == s4 && s4 is float, s3);
}

function testIntInUnionAsFloat(int f1) returns (boolean, float) {
    Employee|string|int f2 = f1;
    json f3 = f1;
    anydata f4 = f1;
    any f5 = f1;

    float s6 = <float> f2;
    float s7 = <float> f3;
    float s8 = <float> f4;
    float s9 = <float> f5;

    return (s7 == s6 && s7 == s8 && s9 == s8, s6);
}

function testIntAsDecimal(int f1) returns (boolean, decimal) {
    decimal s3 = <decimal> f1;
    anydata s4 = <decimal> getInt(f1);

    return (s3 == s4 && s4 is decimal, s3);
}

function testIntInUnionAsDecimal(int f1) returns (boolean, decimal) {
    Employee|string|int f2 = f1;
    json f3 = f1;
    anydata f4 = f1;
    any f5 = f1;

    decimal s6 = <decimal> f2;
    decimal s7 = <decimal> f3;
    decimal s8 = <decimal> f4;
    decimal s9 = <decimal> f5;

    return (s7 == s6 && s7 == s8 && s9 == s8, s6);
}

function testIntAsInt(int f1) returns (boolean, int) {
    int s3 = <int> f1;
    anydata s4 = <int> getInt(f1);
    return (s3 == s4 && s4 is int, s3);
}

function testIntInUnionAsInt(int f1) returns (boolean, int) {
    Employee|string|int f2 = f1;
    json f3 = f1;
    anydata f4 = f1;
    any f5 = f1;

    int s6 = <int> f2;
    int s7 = <int> f3;
    int s8 = <int> f4;
    int s9 = <int> f5;

    return (s7 == s6 && s7 == s8 && s9 == s8, s6);
}

function testIntAsBoolean() returns (boolean, boolean) {
    int f1 = 1;
    boolean s3 = <boolean> f1;
    any s4 = <boolean> getInt(f1);
    boolean nonZeroAsBoolean = s3;
    if (s4 is boolean) {
        nonZeroAsBoolean = nonZeroAsBoolean && s4;
    }

    f1 = -134567;
    s3 = <boolean> f1;
    s4 = <boolean> getInt(f1);
    nonZeroAsBoolean = nonZeroAsBoolean && s3;
    if (s4 is boolean) {
        nonZeroAsBoolean = nonZeroAsBoolean && s4;
    }

    f1 = 0;
    s3 = <boolean> f1;
    s4 = <boolean> getInt(f1);
    boolean zeroAsBoolean = s3;
    if (s4 is boolean) {
        zeroAsBoolean = zeroAsBoolean || s4;
    }
    return (nonZeroAsBoolean, zeroAsBoolean);
}

function testIntInUnionAsBoolean() returns (boolean, boolean) {
    int f1 = 1;
    int|decimal|Employee f2 = f1;
    json f3 = f1;
    anydata f4 = f1;
    any f5 = f1;

    boolean b1 = <boolean> f2;
    boolean b2 = <boolean> f3;
    boolean b3 = <boolean> f4;
    boolean b4 = <boolean> f5;
    boolean nonZeroAsBoolean = b1 && b2 && b3 && b4;

    f1 = -134567;
    f2 = f1;
    f3 = f1;
    f4 = f1;
    f5 = f1;
    b1 = <boolean> f2;
    b2 = <boolean> f3;
    b3 = <boolean> f4;
    b4 = <boolean> f5;
    nonZeroAsBoolean = nonZeroAsBoolean && b1 && b2 && b3 && b4;

    f1 = 0;
    f2 = f1;
    f3 = f1;
    f4 = f1;
    f5 = f1;
    b1 = <boolean> f2;
    b2 = <boolean> f3;
    b3 = <boolean> f4;
    b4 = <boolean> f5;
    return (nonZeroAsBoolean, b1 || b2 || b3 || b4);
}

//////////////////////// from boolean ////////////////////////

function testBooleanAsString() returns (string, string, string, string) {
    boolean b1 = true;
    string s1 = <string> b1;
    anydata a = <string> getBoolean(b1);
    string s2;
    if (a is string) {
        s2 = a;
    }

    b1 = false;
    string s3 = <string> b1;
    string s4 = <string> getBoolean(b1);

    return (s1, s2, s3, s4);
}

function testBooleanInUnionAsString() returns (string, string) {
    boolean f1 = true;
    Employee|string|int|boolean f2 = f1;
    json f3 = true;
    anydata f4 = f1;
    any f5 = f1;

    string s6 = <string> f2;
    string s7 = <string> f3;
    string s8 = <string> f4;
    string s9 = <string > f5;

    string st1 = (s7 == s6 && s7 == s8 && s9 == s8) ? s6 : "";

    f1 = false;
    f2 = f1;
    f3 = false;
    f4 = f1;
    f5 = f1;

    s6 = <string> f2;
    s7 = <string> f3;
    s8 = <string> f4;
    s9 = <string> f5;

    string st2 = (s7 == s6 && s7 == s8 && s9 == s8) ? s6 : "";

    return(st1, st2);
}

function testBooleanAsFloat() returns (float, float, float, float) {
    boolean b1 = true;
    float s1 = <float> b1;
    anydata a = <float> getBoolean(b1);
    float s2;
    if (a is float) {
        s2 = a;
    }

    b1 = false;
    float s3 = <float> b1;
    float s4 = <float> getBoolean(b1);

    return (s1, s2, s3, s4);
}

function testBooleanInUnionAsFloat() returns (float, float) {
    boolean f1 = true;
    Employee|string|int|boolean f2 = f1;
    json f3 = true;
    anydata f4 = f1;
    any f5 = f1;

    float s6 = <float> f2;
    float s7 = <float> f3;
    float s8 = <float> f4;
    float s9 = <float > f5;

    float ft1 = (s7 == s6 && s7 == s8 && s9 == s8) ? s6 : 1.23456;

    f1 = false;
    f2 = f1;
    f3 = false;
    f4 = f1;
    f5 = f1;

    s6 = <float> f2;
    s7 = <float> f3;
    s8 = <float> f4;
    s9 = <float> f5;

    float ft2 = (s7 == s6 && s7 == s8 && s9 == s8) ? s6 : 1.23456;

    return(ft1, ft2);
}

function testBooleanAsDecimal() returns (decimal, decimal, decimal, decimal) {
    boolean b1 = true;
    decimal s1 = <decimal> b1;
    anydata a = <decimal> getBoolean(b1);
    decimal s2;
    if (a is decimal) {
        s2 = a;
    }

    b1 = false;
    decimal s3 = <decimal> b1;
    decimal s4 = <decimal> getBoolean(b1);

    return (s1, s2, s3, s4);
}

function testBooleanInUnionAsDecimal() returns (decimal, decimal) {
    boolean f1 = true;
    Employee|string|int|boolean f2 = f1;
    json f3 = true;
    anydata f4 = f1;
    any f5 = f1;

    decimal s6 = <decimal> f2;
    decimal s7 = <decimal> f3;
    decimal s8 = <decimal> f4;
    decimal s9 = <decimal > f5;

    decimal ft1 = (s7 == s6 && s7 == s8 && s9 == s8) ? s6 : 1.23456;

    f1 = false;
    f2 = f1;
    f3 = false;
    f4 = f1;
    f5 = f1;

    s6 = <decimal> f2;
    s7 = <decimal> f3;
    s8 = <decimal> f4;
    s9 = <decimal> f5;

    decimal ft2 = (s7 == s6 && s7 == s8 && s9 == s8) ? s6 : 1.23456;

    return(ft1, ft2);
}

function testBooleanAsInt() returns (int, int, int, int) {
    boolean b1 = true;
    int s1 = <int> b1;
    anydata a = <int> getBoolean(b1);
    int s2;
    if (a is int) {
        s2 = a;
    }

    b1 = false;
    int s3 = <int> b1;
    int s4 = <int> getBoolean(b1);

    return (s1, s2, s3, s4);
}

function testBooleanInUnionAsInt() returns (int, int) {
    boolean f1 = true;
    Employee|string|int|boolean f2 = f1;
    json f3 = true;
    anydata f4 = f1;
    any f5 = f1;

    int s6 = <int> f2;
    int s7 = <int> f3;
    int s8 = <int> f4;
    int s9 = <int > f5;

    int ft1 = (s7 == s6 && s7 == s8 && s9 == s8) ? s6 : 123456;

    f1 = false;
    f2 = f1;
    f3 = false;
    f4 = f1;
    f5 = f1;

    s6 = <int> f2;
    s7 = <int> f3;
    s8 = <int> f4;
    s9 = <int> f5;

    int ft2 = (s7 == s6 && s7 == s8 && s9 == s8) ? s6 : 123456;

    return(ft1, ft2);
}

function testBooleanAsBoolean() returns (boolean, boolean, boolean, boolean) {
    boolean b1 = true;
    boolean s1 = <boolean> b1;
    anydata a = <boolean> getBoolean(b1);
    boolean s2;
    if (a is boolean) {
        s2 = a;
    }

    b1 = false;
    boolean s3 = <boolean> b1;
    boolean s4 = <boolean> getBoolean(b1);

    return (s1, s2, s3, s4);
}

function testBooleanInUnionAsBoolean() returns (boolean, boolean) {
    boolean f1 = true;
    Employee|string|int|boolean f2 = f1;
    json f3 = true;
    anydata f4 = f1;
    any f5 = f1;

    boolean s6 = <boolean> f2;
    boolean s7 = <boolean> f3;
    boolean s8 = <boolean> f4;
    boolean s9 = <boolean > f5;

    boolean ft1 = (s7 == s6 && s7 == s8 && s9 == s8) ? s6 : false;

    f1 = false;
    f2 = f1;
    f3 = false;
    f4 = f1;
    f5 = f1;

    s6 = <boolean> f2;
    s7 = <boolean> f3;
    s8 = <boolean> f4;
    s9 = <boolean> f5;

    boolean ft2 = (s7 == s6 && s7 == s8 && s9 == s8) ? s6 : true;

    return(ft1, ft2);
}

function getString(string s) returns string {
    return s;
}

function getFloat(float f) returns float {
    return f;
}

function getDecimal(decimal d) returns decimal {
    return d;
}

function getInt(int i) returns int {
    return i;
}

function getBoolean(boolean b) returns boolean {
    return b;
}

type Employee record {
    string name;
};
