/**
 * Copyright (c) 2017, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

import React from 'react'
import ConnectorActionDefinition from './connector-action-definition.jsx'
import StatementView from './statement-decorator.jsx'
import PanelDecorator from './panel-decorator';
import {getComponentForNodeArray} from './utils';

class ConnectorDefinition extends React.Component {

    render() {
        let model = this.props.model;
        let bBox = model.viewState.bBox;

        //get the connector name
        let title = model.getConnectorName();

        let children = getComponentForNodeArray(this.props.model.getChildren());

        let titleComponentData = [{
            isNode: true,
            model: this.props.model.getArgumentParameterDefinitionHolder()
        }];

        return (<PanelDecorator icon="tool-icons/connector" title={title} bBox={bBox}
                                model={model}
                                dropTarget={this.props.model}
                                dropSourceValidateCB={(node) => this.canDropToPanelBody(node)}
                                titleComponentData={titleComponentData}>
            {children}
        </PanelDecorator>);
    }

    canDropToPanelBody(nodeBeingDragged) {
        let nodeFactory = this.props.model.getFactory();
        // IMPORTANT: override default validation logic
        // Panel's drop zone is for resource defs and connector declarations only.
        return nodeFactory.isConnectorDeclaration(nodeBeingDragged)
            || nodeFactory.isConnectorAction(nodeBeingDragged);
    }
}

export default ConnectorDefinition;
