From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Updates for Linux v4.6
Date: Tue, 22 Mar 2016 12:01:03 +0100
Message-ID: <20160322110103.GA28122@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8869277581751235904=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============8869277581751235904==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit b562e44f507e863c6792946e4e1b1449fbbac85d:

  Linux 4.5 (2016-03-13 21:28:54 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-u=
pdates-v4.6

for you to fetch changes up to 70cf769c5ba283483a42c46f3734202b55dd3041:

  Merge branches 'arm/rockchip', 'arm/exynos', 'arm/smmu', 'arm/mediatek', =
'arm/io-pgtable', 'arm/renesas' and 'core' into next (2016-03-21 14:58:47 +=
0100)

----------------------------------------------------------------

IOMMU Updates for Linux v4.6

This time with:

	* Updates for the Exynos IOMMU driver to make use of default
	  domains and to add support for the SYSMMU v5

	* New Mediatek IOMMU driver

	* Support for the ARMv7 short descriptor format in the
	  io-pgtable code

	* Default domain support for the ARM SMMU

	* Couple of other small fixes all over the place

----------------------------------------------------------------
Andrzej Hajda (1):
      iommu/mediatek: Fix handling of of_count_phandle_with_args result

Anup Patel (1):
      of: iommu: Increment DT node refcount in of_iommu_set_ops()

Arnd Bergmann (3):
      iommu/exynos: Pointers are nto physical addresses
      iommu/mediatek: Select ARM_DMA_USE_IOMMU
      iommu/mediatek: Mark PM functions as __maybe_unused

Dan Carpenter (1):
      iommu/mediatek: Check for NULL instead of IS_ERR()

Joerg Roedel (3):
      Merge branch 'for-joerg/io-pgtable' of git://git.kernel.org/.../will/=
linux into arm/io-pgtable
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/...=
/will/linux into arm/smmu
      Merge branches 'arm/rockchip', 'arm/exynos', 'arm/smmu', 'arm/mediate=
k', 'arm/io-pgtable', 'arm/renesas' and 'core' into next

Magnus Damm (1):
      iommu/ipmmu-vmsa: Add r8a7795 DT binding

Marek Szyprowski (14):
      iommu/exynos: Rework iommu group initialization
      iommu/exynos: Add support for IOMMU_DOMAIN_DMA domain type
      iommu/exynos: Remove ARM-specific cache flush interface
      iommu/exynos: Simplify master clock operations
      iommu/exynos: Refactor code (no direct register access)
      iommu/exynos: Refactor fault handling code
      iommu/exynos: Refactor init config code
      iommu/exynos: Unify code for fldp cache invalidation
      iommu/exynos: Add support for SYSMMU controller with bogus version reg
      iommu/exynos: Update device tree documentation
      iommu/exynos: Add support for v5 SYSMMU
      iommu/exynos: Add Maintainers entry for Exynos SYSMMU driver
      iommu/exynos: Support multiple attach_device calls
      iommu/exynos: Use proper readl/writel register interface

Robin Murphy (9):
      iommu/io-pgtable: Add ARMv7 short descriptor support
      iommu/io-pgtable: Add helper functions for TLB ops
      iommu/io-pgtable: Avoid redundant TLB syncs
      iommu/io-pgtable: Rationalise quirk handling
      iommu/arm-smmu: Treat all device transactions as unprivileged
      iommu/arm-smmu: Support DMA-API domains
      iommu/arm-smmu: Allow disabling unmatched stream bypass
      iommu/dma: Fix NEED_SG_DMA_LENGTH dependency
      iommu/io-pgtable-armv7s: Fix kmem_cache_alloc() flags

Simon Horman (1):
      iommu/ipmmu-vmsa: Use ARCH_RENESAS

Will Deacon (3):
      MAINTAINERS: update ARM SMMU entry
      iommu/arm-smmu: Don't fail device attach if already attached to a dom=
ain
      iommu/arm-smmu: Treat IOMMU_DOMAIN_DMA as bypass for now

Yong Wu (5):
      dt-bindings: iommu: Add binding for mediatek IOMMU
      dt-bindings: mediatek: Add smi dts binding
      memory: mediatek: Add SMI driver
      iommu/mediatek: Add mt8173 IOMMU driver
      dts: mt8173: Add iommu/smi nodes for mt8173

Yoshihiro Shimoda (1):
      iommu: Fix second argument of trace_map() to report correct paddr

ZhengShunQian (1):
      iommu/rockchip: Reconstruct to support multi slaves

 .../devicetree/bindings/iommu/mediatek,iommu.txt   |  68 ++
 .../bindings/iommu/renesas,ipmmu-vmsa.txt          |  15 +-
 .../devicetree/bindings/iommu/samsung,sysmmu.txt   |  22 +-
 .../memory-controllers/mediatek,smi-common.txt     |  24 +
 .../memory-controllers/mediatek,smi-larb.txt       |  25 +
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  81 ++
 drivers/iommu/Kconfig                              |  42 +-
 drivers/iommu/Makefile                             |   2 +
 drivers/iommu/arm-smmu-v3.c                        |  50 +-
 drivers/iommu/arm-smmu.c                           |  79 +-
 drivers/iommu/exynos-iommu.c                       | 608 +++++++++------
 drivers/iommu/io-pgtable-arm-v7s.c                 | 846 +++++++++++++++++=
++++
 drivers/iommu/io-pgtable-arm.c                     |  34 +-
 drivers/iommu/io-pgtable.c                         |   5 +-
 drivers/iommu/io-pgtable.h                         |  53 +-
 drivers/iommu/iommu.c                              |   3 +-
 drivers/iommu/mtk_iommu.c                          | 736 ++++++++++++++++++
 drivers/iommu/of_iommu.c                           |   1 +
 drivers/iommu/rockchip-iommu.c                     | 214 ++++--
 drivers/memory/Kconfig                             |   8 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/mtk-smi.c                           | 273 +++++++
 include/dt-bindings/memory/mt8173-larb-port.h      | 111 +++
 include/soc/mediatek/smi.h                         |  58 ++
 25 files changed, 2953 insertions(+), 414 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.=
txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/me=
diatek,smi-common.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/me=
diatek,smi-larb.txt
 create mode 100644 drivers/iommu/io-pgtable-arm-v7s.c
 create mode 100644 drivers/iommu/mtk_iommu.c
 create mode 100644 drivers/memory/mtk-smi.c
 create mode 100644 include/dt-bindings/memory/mt8173-larb-port.h
 create mode 100644 include/soc/mediatek/smi.h

There will be a trivial conflict in arch/arm64/boot/dts/mediatek/mt8173.dtsi
when merging. I attach my resolution below anyway for reference.

Please pull.

Thanks,

	Joerg

diff --cc arch/arm64/boot/dts/mediatek/mt8173.dtsi
index f4bd3c9,8048811..f3fc041
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@@ -277,11 -278,17 +278,22 @@@
  			reg =3D <0 0x10200620 0 0x20>;
  		};
 =20
 +		efuse: efuse@10206000 {
 +			compatible =3D "mediatek,mt8173-efuse";
 +			reg =3D <0 0x10206000 0 0x1000>;
 +		};
 +
+ 		iommu: iommu@10205000 {
+ 			compatible =3D "mediatek,mt8173-m4u";
+ 			reg =3D <0 0x10205000 0 0x1000>;
+ 			interrupts =3D <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
+ 			clocks =3D <&infracfg CLK_INFRA_M4U>;
+ 			clock-names =3D "bclk";
+ 			mediatek,larbs =3D <&larb0 &larb1 &larb2
+ 					  &larb3 &larb4 &larb5>;
+ 			#iommu-cells =3D <1>;
+ 		};
+=20
  		apmixedsys: clock-controller@10209000 {
  			compatible =3D "mediatek,mt8173-apmixedsys";
  			reg =3D <0 0x10209000 0 0x1000>;

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJW8SXvAAoJECvwRC2XARrjOKsQAJ/SCU9eWdWlwoFVOawVcXAB
bsfyB3nAoHtBrXgRhe6+IAH4bXSGiNDVCGOvfBb/PBOsSUToj+2EYn/7TbLsmNHS
CGxSmEen2PdVHJzUcziVlF6vUYAyfixAwSKwL9aL9gwXI2DXB6043HTrt+s9Doew
UCcolcQTXWpJTtu5AeVYGYUsuGvqY2euhm7IzFWHZ1JsYH6m4EaW+tQp2opOviuB
Fh2Fm90SptgA9h8J4NRw/wAdpnHI0K0JSMYFf+Mxbgojidqt0Eb5U1y0esOj6R5W
A31ewnqA/ugo+2re4TOTIn4jVkrQeqqYqSfKRn6lopmfXzrjZRqjl7eXQdKWz/pJ
dNkFl1DPTyFl1Egnzg+c/Ql0qZmsE4NB759JjvBScge97pO3i8kDOZ7VdSav09Oc
6tKl38MGe1Fggf5NRHnvScg0WCi6LkH5RprLaHFVPLYDgtBRbE6V42goAzi1cL55
UvNgRZ51XwzWggls6QsLpstKV/vlqTdtqAQJBdIi3+Tf1HZoe9cGJrJ6GK8r4GtG
ZuY2v/dPZQ9PXGVAMB7O9OzlpfA+AQcMj/2qF+MkoZFf0Q5tNu84VIXXLn0bP+e5
z+SnBy89h0BRh6Koodax2aMHXTljzlrukiayc5x+HXcxTX/LwX4wB9YF+bjfN+VA
U2lL60mfMaWw8fUSCaEX
=8bkN
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--

--===============8869277581751235904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8869277581751235904==--
