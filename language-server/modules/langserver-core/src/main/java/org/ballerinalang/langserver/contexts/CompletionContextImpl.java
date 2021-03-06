/*
 *  Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *  WSO2 Inc. licenses this file to you under the Apache License,
 *  Version 2.0 (the "License"); you may not use this file except
 *  in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 */
package org.ballerinalang.langserver.contexts;

import io.ballerina.compiler.syntax.tree.Node;
import io.ballerina.compiler.syntax.tree.NonTerminalNode;
import io.ballerina.compiler.syntax.tree.Token;
import org.ballerinalang.langserver.LSContextOperation;
import org.ballerinalang.langserver.commons.CompletionContext;
import org.ballerinalang.langserver.commons.LSOperation;
import org.ballerinalang.langserver.commons.workspace.WorkspaceManager;
import org.eclipse.lsp4j.CompletionCapabilities;
import org.eclipse.lsp4j.Position;

import java.util.ArrayList;
import java.util.List;

/**
 * Language server context implementation.
 *
 * @since 1.2.0
 */
public class CompletionContextImpl extends AbstractDocumentServiceContext implements CompletionContext {

    private final CompletionCapabilities capabilities;
    private final Position cursorPosition;
    private final List<Node> resolverChain = new ArrayList<>();
    private Token tokenAtCursor;
    private NonTerminalNode nodeAtCursor;
    private int cursorPosInTree = -1;

    CompletionContextImpl(LSOperation operation,
                          String fileUri,
                          WorkspaceManager wsManager,
                          CompletionCapabilities capabilities,
                          Position cursorPosition) {
        super(operation, fileUri, wsManager);
        this.capabilities = capabilities;
        this.cursorPosition = cursorPosition;
    }

    @Override
    public CompletionCapabilities getCapabilities() {
        return this.capabilities;
    }

    @Override
    public void setTokenAtCursor(Token token) {
        if (this.tokenAtCursor != null) {
            throw new RuntimeException("Setting the token more than once is not allowed");
        }
        this.tokenAtCursor = token;
    }

    @Override
    public Token getTokenAtCursor() {
        return this.tokenAtCursor;
    }

    @Override
    public void setNodeAtCursor(NonTerminalNode node) {
        if (this.nodeAtCursor != null) {
            throw new RuntimeException("Setting the node more than once is not allowed");
        }
        this.nodeAtCursor = node;
    }

    @Override
    public NonTerminalNode getNodeAtCursor() {
        return this.nodeAtCursor;
    }

    @Override
    public void addResolver(Node node) {
        this.resolverChain.add(node);
    }

    @Override
    public List<Node> getResolverChain() {
        return this.resolverChain;
    }

    @Override
    public void setCursorPositionInTree(int offset) {
        if (this.cursorPosInTree > -1) {
            throw new RuntimeException("Setting the cursor offset more than once is not allowed");
        }
        this.cursorPosInTree = offset;
    }

    @Override
    public int getCursorPositionInTree() {
        return this.cursorPosInTree;
    }

    @Override
    public Position getCursorPosition() {
        return this.cursorPosition;
    }

    /**
     * Represents Language server completion context Builder.
     *
     * @since 2.0.0
     */
    protected static class CompletionContextBuilder extends AbstractContextBuilder<CompletionContextBuilder> {

        private CompletionCapabilities capabilities;
        private Position cursor;

        /**
         * Context Builder constructor.
         */
        public CompletionContextBuilder() {
            super(LSContextOperation.TXT_COMPLETION);
        }

        /**
         * Setter for the capabilities.
         *
         * @param capabilities completion capabilities to set
         */
        public CompletionContextBuilder withCapabilities(CompletionCapabilities capabilities) {
            this.capabilities = capabilities;
            return self();
        }

        /**
         * Setter for the position.
         *
         * @param position cursor position where the completion triggered
         */
        public CompletionContextBuilder withCursorPosition(Position position) {
            this.cursor = position;
            return self();
        }

        public CompletionContext build() {
            return new CompletionContextImpl(this.operation,
                    this.fileUri,
                    this.wsManager,
                    this.capabilities,
                    this.cursor);
        }

        @Override
        public CompletionContextBuilder self() {
            return this;
        }
    }
}
