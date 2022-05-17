#!/bin/bash

rails db:create db:migrate

rails dartsass:build
