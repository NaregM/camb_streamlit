#!/bin/bash

echo PORT $PORT
streamlit run app.py --server.port $PORT
