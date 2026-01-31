# Use AWS Lambda Node.js 20 base image
FROM public.ecr.aws/lambda/nodejs:20

# Copy package files
COPY package*.json ${LAMBDA_TASK_ROOT}/

# Install production dependencies
RUN npm ci --omit=dev

# Copy TypeScript config and source code
COPY tsconfig.json ${LAMBDA_TASK_ROOT}/
COPY src ${LAMBDA_TASK_ROOT}/src

# Install dev dependencies for building
RUN npm install --include=dev

# Build TypeScript to JavaScript
RUN npm run build

# Remove dev dependencies after build
RUN npm prune --omit=dev

# Set the Lambda handler
CMD [ "dist/index.handler" ]
