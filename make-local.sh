#!/bin/bash

localize() {
  coffee -r fs -e '
    f = process.argv[process.argv.length - 1]
    p = JSON.parse(fs.readFileSync(f))
    for k in ["dependencies", "devDependencies"]
      for pkg in Object.keys(p[k] or {})
        if pkg.match(/^pug-/)
          p[k][pkg] = "file:../#{pkg}"
    fs.writeFileSync f, JSON.stringify(p, null, "  ")
  ' "$1"
}

git ls-files | grep /package.json | while read -r f; do
  localize "$f"
done
