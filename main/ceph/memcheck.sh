#!/bin/sh
function memory_limit
{
  awk -F: '/^[0-9]+:memory:/ {
    filepath="/sys/fs/cgroup/memory"$3"/memory.limit_in_bytes";
    getline line < filepath;
    print line
  }' /proc/self/cgroup
}

if [[ $(memory_limit) < 419430400 ]]; then
  echo "Memory limit was set too small. Minimum 400m."
  exit 1
fi
