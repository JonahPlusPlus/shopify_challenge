#!/bin/bash

rails db:drop db:create db:migrate dartsass:build
