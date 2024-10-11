FROM python:3.13-alpine

WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --chown=appuser:appgroup app/requirements.txt .

USER appuser

RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=appuser:appgroup app/app.py .

EXPOSE 5000

CMD ["python", "app.py"]