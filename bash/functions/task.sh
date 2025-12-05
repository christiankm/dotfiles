#!/bin/bash

create_task()
{
    TASKDIR="${HOME}/tasks"
    mkdir -p "${TASKDIR}"

    touch "${TASKDIR}/$1";
    echo "Task '$1' created in ${TASKDIR}/"
}
