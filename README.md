# Product Attribution Matching Tool

This tool allows users to view and update product attributes across various categories.

## Setup and Running the Application

### Backend (Flask)

1. Navigate to the backend directory:
   ```
   cd backend
   ```

2. Activate the virtual environment:
   ```
   source venv/bin/activate
   ```

3. Install the required packages:
   ```
   pip install -r requirements.txt
   ```

4. Run the Flask application:
   ```
   python app.py
   ```

   The backend will be available at http://localhost:5000

### Frontend (React)

1. Open a new terminal window and navigate to the frontend directory:
   ```
   cd frontend
   ```

2. Install the required npm packages:
   ```
   npm install
   ```

3. Start the React development server:
   ```
   npm start
   ```

   The frontend will be available at http://localhost:3000

## Testing

1. Open your web browser and go to http://localhost:3000
2. You should see a list of products on the left side of the page
3. Click on a product to view its details and attributes on the right side
4. Try updating an attribute value by editing the input field. The change should be saved automatically.

## Troubleshooting

- If you encounter a "Module not found" error, make sure you've installed all required packages in both the backend and frontend directories.
- If you see a CORS error in the browser console, ensure that the backend is running and that the frontend is making requests to the correct URL (http://localhost:5000).
- If the database is empty, try deleting the 'products.db' file in the backend directory and restart the Flask application to recreate the database with sample data.

## Deployment

To deploy this application on Render.com:

1. Create a new Web Service for the backend:
   - Set the build command to: `pip install -r requirements.txt`
   - Set the start command to: `gunicorn app:app`
   - Add an environment variable: `PYTHON_VERSION=3.9.0`

2. Create a new Static Site for the frontend:
   - Set the build command to: `npm install && npm run build`
   - Set the publish directory to: `build`

3. Update the API endpoint in the frontend code to use the deployed backend URL instead of localhost.

Remember to push your code to a Git repository before deploying on Render.com.

