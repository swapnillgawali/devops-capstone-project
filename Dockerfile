# Use Python 3.9 slim as the base image
FROM python:3.9-slim

# Create working folder and install dependencies
WORKDIR /app
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application contents
COPY service/ ./service/

# Create a non-root user and change ownership
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Expose port 8080 for the application
EXPOSE 8080

# Run the service using gunicorn
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
