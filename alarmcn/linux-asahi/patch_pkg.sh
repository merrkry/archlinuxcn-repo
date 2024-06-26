#!/bin/sh

sed -i -e 's/_package_kernel()/_origin_package_kernel()/' PKGBUILD

cat >> PKGBUILD <<EOF
_package_kernel() {
  _origin_package_kernel "\$@"
  cd "\$srcdir/\$_srcname"
  local kernver="\$(<\$O/version)"
  local modulesdir="\$pkgdir/usr/lib/modules/\$kernver"
  install -Dm644 "\$O/\$(make -s image_name O="\$O")" "\$modulesdir/vmlinuz"
  install -Dm644 "\$O"/arch/arm64/boot/Image "\$modulesdir/vmlinuz-nogz"
}
EOF
