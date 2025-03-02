set -e

python create_metricity_db.py
alembic upgrade head

if [ -e /tmp/bot/metricity-config.toml ]; then
    echo "Detected metricity running in bot context, copying config." 
    cp --force /tmp/bot/metricity-config.toml ./config.toml
fi

shopt -s nocasematch
if [ "${USE_METRICITY:-true}" = "true" ]; then
    poetry run start
fi
