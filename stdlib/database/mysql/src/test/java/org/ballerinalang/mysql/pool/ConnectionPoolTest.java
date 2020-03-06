/*
 *  Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *  WSO2 Inc. licenses this file to you under the Apache License,
 *  Version 2.0 (the "License"); you may not use this file except
 *  in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 */
package org.ballerinalang.mysql.pool;

import org.ballerinalang.config.ConfigRegistry;
import org.ballerinalang.model.values.BString;
import org.ballerinalang.model.values.BValue;
import org.ballerinalang.model.values.BValueArray;
import org.ballerinalang.mysql.BaseTest;
import org.ballerinalang.mysql.utils.SQLDBUtils;
import org.ballerinalang.test.util.BCompileUtil;
import org.ballerinalang.test.util.BRunUtil;
import org.ballerinalang.test.util.CompileResult;
import org.testng.Assert;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.util.HashMap;

/**
 * This validates the functionality of the connection pool.
 *
 * @since 1.2.0
 */
public class ConnectionPoolTest {
    private CompileResult result;
    private static final String DB_NAME1 = "TEST_SQL_CONN_POOL_1";
    private static final String DB_NAME2 = "TEST_SQL_CONN_POOL_2";
    private static final String SQL_SCRIPT = SQLDBUtils.SQL_RESOURCE_DIR + File.separator + SQLDBUtils.POOL_DIR +
            File.separator + "connection_pool_test_data.sql";
    private static final String CONNECTION_TIMEOUT_ERROR_STRING =
            "Connection is not available, request timed out after";

    static {
        BaseTest.addDBSchema(DB_NAME1, SQL_SCRIPT);
        BaseTest.addDBSchema(DB_NAME2, SQL_SCRIPT);
    }

    @BeforeClass
    public void setup() throws IOException {
        Path ballerinaConfPath = SQLDBUtils.getResourcePath("ballerina.conf");
        ConfigRegistry registry = ConfigRegistry.getInstance();
        registry.initRegistry(new HashMap<>(), null, ballerinaConfPath);
        result = BCompileUtil.compileOffline(SQLDBUtils.getBalFilesDir(SQLDBUtils.POOL_DIR,
                "connection-pool-test.bal"));
    }

    @Test
    public void testGlobalConnectionPoolSingleDestination() {
        BValue[] args = {new BString(DB_NAME1)};
        BValue[] returnVal = BRunUtil.invokeFunction(result, "testGlobalConnectionPoolSingleDestination",
                args);
        SQLDBUtils.assertNotError(returnVal[0]);
        Assert.assertEquals(returnVal[0].size(), 11, "11 elements are expected as a return value");
        Assert.assertTrue(returnVal[0] instanceof BValueArray);
        for (int i = 0; i < 10; i++) {
            Assert.assertEquals((((BValueArray) returnVal[0])).getRefValue(i).stringValue(), "1");
        }
        String error = (((BValueArray) returnVal[0])).getRefValue(10).stringValue();
        Assert.assertTrue(error.contains(CONNECTION_TIMEOUT_ERROR_STRING), "Actual Error: " + error);
    }

    @Test
    public void testGlobalConnectionPoolsMultipleDestinations() {
        BValue[] args = {new BString(DB_NAME1), new BString(DB_NAME2)};
        BValue[] returns = BRunUtil.invokeFunction(result, "testGlobalConnectionPoolsMultipleDestinations"
                , args);
        Assert.assertTrue(returns[0] instanceof BValueArray);
        Assert.assertEquals(returns[0].size(), 2);
        BValueArray returnVal1 = ((BValueArray) (((BValueArray) returns[0]).getRefValue(0)));
        BValueArray returnVal2 = ((BValueArray) (((BValueArray) returns[0]).getRefValue(1)));
        for (int i = 0; i < 10; i++) {
            Assert.assertEquals("1", returnVal1.getRefValue(i).stringValue());
        }
        String error1 = returnVal1.getRefValue(10).stringValue();
        Assert.assertTrue(error1.contains(CONNECTION_TIMEOUT_ERROR_STRING), "Actual Error: " + error1);

        for (int i = 0; i < 10; i++) {
            Assert.assertEquals("1", returnVal2.getRefValue(i).stringValue());
        }
        String error2 = returnVal2.getRefValue(10).stringValue();
        Assert.assertTrue(error2.contains(CONNECTION_TIMEOUT_ERROR_STRING), "Actual Error: " + error2);
    }

    @Test
    public void testGlobalConnectionPoolSingleDestinationConcurrent() {
        BValue[] args = {new BString(DB_NAME1)};
        BValue[] returns = BRunUtil.invokeFunction(result,
                "testGlobalConnectionPoolSingleDestinationConcurrent", args);
        Assert.assertTrue(returns[0] instanceof BValueArray);
        for (int i = 0; i < 5; i++) {
            BValueArray array = ((BValueArray) ((BValueArray) returns[0]).getRefValue(i));
            Assert.assertEquals(array.getRefValue(0).stringValue(), "1");
            Assert.assertEquals(array.getRefValue(1).stringValue(), "1");
        }
        BValueArray array = ((BValueArray) ((BValueArray) returns[0]).getRefValue(4));
        String error = array.getRefValue(2).stringValue();
        Assert.assertTrue(error.contains(CONNECTION_TIMEOUT_ERROR_STRING), "Actual Error: " + error);
    }


}
