#!/bin/bash

# Update frontend/src/App.js
update_app_js() {
    sed -i '' '
    /const handleAttributeUpdate/,/};/ c\
  const handleAttributeUpdate = async (productId, attributeId, newValue) => {\
    try {\
      await axios.put(`${process.env.REACT_APP_API_URL}/api/products/${productId}/attributes/${attributeId}`, {\
        value: newValue\
      });\
      fetchProducts();\
    } catch (error) {\
      console.error('\''Error updating attribute:'\'', error);\
    }\
  };
    ' frontend/src/App.js
}

# Update render.yaml
update_render_yaml() {
    cat > render.yaml << EOL
services:
  - type: web
    name: product-attribution-backend
    env: python
    buildCommand: cd backend && pip install --upgrade pip && pip install -r requirements.txt
    startCommand: cd backend && gunicorn app:app
  - type: web
    name: product-attribution-frontend
    env: static
    buildCommand: cd frontend && npm install && npm run build
    staticPublishPath: ./frontend/build
    routes:
      - type: rewrite
        source: /*
        destination: /index.html
EOL
}

# Create frontend/.env
create_frontend_env() {
    echo "REACT_APP_API_URL=https://your-backend-service-name.onrender.com" > frontend/.env
    echo "Don't forget to replace 'your-backend-service-name' with your actual backend service name on Render."
}

# Main execution
echo "Updating project files..."

update_app_js
echo "Updated frontend/src/App.js"

update_render_yaml
echo "Updated render.yaml"

create_frontend_env
echo "Created frontend/.env"

echo "All updates completed. Please review the changes and update the REACT_APP_API_URL in frontend/.env with your actual backend URL."

# Git commands
git add frontend/src/App.js render.yaml frontend/.env
git commit -m "Fix handleAttributeUpdate function, render.yaml indentation, and add .env file"
git push origin main

echo "Changes have been committed and pushed to the main branch."
echo "Please go to your Render.com dashboard and redeploy both the backend and frontend services."
