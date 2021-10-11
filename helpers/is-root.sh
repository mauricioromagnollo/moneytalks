#!/bin/bash

function is-root {
  return $( test `whoami` == "root" )
}
