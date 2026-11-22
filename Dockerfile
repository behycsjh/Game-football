# Выделенный сервер Football Online (Godot headless). Подходит для Render.com (бесплатный Web Service).
FROM debian:bookworm-slim
ARG GODOT_VERSION=4.7-stable
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget unzip ca-certificates libfontconfig1 libx11-6 libxcursor1 libxinerama1 libxrandr2 libxi6 libgl1 libasound2 \
    && rm -rf /var/lib/apt/lists/*
RUN wget -q "https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}/Godot_v${GODOT_VERSION}_linux.x86_64.zip" -O /tmp/g.zip \
    && unzip -q /tmp/g.zip -d /tmp && mv /tmp/Godot_v${GODOT_VERSION}_linux.x86_64 /usr/local/bin/godot \
    && chmod +x /usr/local/bin/godot && rm /tmp/g.zip
WORKDIR /app
COPY . /app
RUN godot --headless --path /app --import || true
# порт берётся из переменной PORT (её выдаёт Render)
CMD ["godot", "--headless", "--path", "/app", "--", "--server"]
