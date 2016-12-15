From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Updates for Linux v4.10
Date: Thu, 15 Dec 2016 18:01:23 +0100
Message-ID: <20161215170117.GA23331@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7783885760870413638=="
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


--===============7783885760870413638==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

This time there are a few patches from the driver-core tree in this
pull-request, which you already pulled from Greg. The reason is that I
had to merge the driver-core-next branch to get the device dependency
link patches into my tree, because the changes for the Exynos IOMMU
driver in this pull-request depend on them.

This is also the reason for a minor merge conflict in
drivers/base/power/main.c caused by the IOMMU updates this time.

Also the ACPI/IORT patches make changes outside of the IOMMU code. These
changes were acked by their respective maintainers.

With this disclaimer in mind, here is the meat:

The following changes since commit 3e5de27e940d00d8d504dfb96625fb654f641509:

  Linux 4.9-rc8 (2016-12-04 12:50:51 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v4.10

for you to fetch changes up to 1465f481460cbfc60dc119873099d89a58f9be4f:

  Merge branches 'arm/mediatek', 'arm/smmu', 'x86/amd', 's390', 'core' and 'arm/exynos' into next (2016-12-06 17:32:16 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v4.10

These changes include:

	* Support for the ACPI IORT table on ARM systems and patches to
	  make the ARM-SMMU driver make use of it

	* Conversion of the Exynos IOMMU driver to device dependency
	  links and implementation of runtime pm support based on that
	  conversion

	* Update the Mediatek IOMMU driver to use the new
	  struct device->iommu_fwspec member

	* Implementation of dma_map/unmap_resource in the generic ARM
	  dma-iommu layer

	* A number of smaller fixes and improvements all over the place

----------------------------------------------------------------
Arnd Bergmann (1):
      debugfs: improve DEFINE_DEBUGFS_ATTRIBUTE for !CONFIG_DEBUG_FS

Ben Hutchings (1):
      driver core: Add deferred_probe attribute to devices in sysfs

Bhumika Goyal (3):
      iommu/arm-smmu: Constify iommu_gather_ops structures
      iommu/arm-smmu: Constify iommu_gather_ops structures
      iommu/io-pgtable-arm: Use const and __initconst for iommu_gather_ops structures

Dan Carpenter (1):
      iommu/amd: Missing error code in amd_iommu_init_device()

Dmitry Torokhov (1):
      driver-core: add test module for asynchronous probing

Geliang Tang (1):
      iommu/s390: Drop duplicate header pci.h

Greg Kroah-Hartman (1):
      Merge 4.9-rc3 into driver-core-next

Joerg Roedel (3):
      Merge remote-tracking branch 'gregkh-driver-core/driver-core-next' into arm/exynos
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/.../will/linux into arm/smmu
      Merge branches 'arm/mediatek', 'arm/smmu', 'x86/amd', 's390', 'core' and 'arm/exynos' into next

Julia Lawall (1):
      kobject: improve function-level documentation

Kefeng Wang (1):
      iommu/io-pgtable-arm: Use for_each_set_bit to simplify the code

Lorenzo Pieralisi (17):
      ACPI: Add FWNODE_ACPI_STATIC fwnode type
      ACPI/IORT: Introduce linker section for IORT entries probing
      ACPI/IORT: Add support for IOMMU fwnode registration
      iommu: Make of_iommu_set/get_ops() DT agnostic
      iommu/arm-smmu: Convert struct device of_node to fwnode usage
      iommu/arm-smmu-v3: Convert struct device of_node to fwnode usage
      ACPI: Implement acpi_dma_configure
      ACPI/IORT: Add node match function
      ACPI/IORT: Add support for ARM SMMU platform devices creation
      iommu/arm-smmu-v3: Split probe functions into DT/generic portions
      iommu/arm-smmu-v3: Add IORT configuration
      iommu/arm-smmu: Split probe functions into DT/generic portions
      iommu/arm-smmu: Add IORT configuration
      ACPI/IORT: Replace rid map type with type mask
      ACPI/IORT: Add single mapping function
      ACPI/IORT: Introduce iort_iommu_configure
      ACPI/IORT: Make dma masks set-up IORT specific

Lucas Stach (1):
      iommu/amd: Tell kmemleak about the irq_remap_table

Marek Szyprowski (8):
      iommu/exynos: Add support for page access protection bits
      iommu/exynos: Remove excessive, useless debug
      iommu/exynos: Remove dead code
      iommu/exynos: Simplify internal enable/disable functions
      iommu/exynos: Set master device once on boot
      iommu/exynos: Rework and fix internal locking
      iommu/exynos: Add runtime pm support
      iommu/exynos: Use device dependency links to control runtime pm

Nipun Gupta (1):
      iommu/arm-smmu: Set SMTNMB_TLBEN in ACR to enable caching of bypass entries

Rafael J. Wysocki (5):
      driver core: Add a wrapper around __device_release_driver()
      driver core: Functional dependencies tracking support
      PM / sleep: Make async suspend/resume of devices use device links
      PM / runtime: Use device links
      PM / runtime: Optimize the use of device links

Robin Murphy (10):
      iommu/mediatek: Convert M4Uv2 to iommu_fwspec
      iommu/mediatek: Convert M4Uv1 to iommu_fwspec
      iommu/dma: Implement dma_{map,unmap}_resource()
      arm64: Wire up iommu_dma_{map, unmap}_resource()
      iommu: Allow taking a reference on a group directly
      iommu/arm-smmu: Fix group refcounting
      iommu/amd: Fix group refcounting
      iommu/mediatek: Fix M4Uv2 group refcounting
      iommu/mediatek: Fix M4Uv1 group refcounting
      iommu/iova: Extend cached node lookup condition

Russell King (1):
      iommu/mediatek: Convert DT component matching to component_match_add_release()

Sudeep Holla (4):
      drivers: base: cacheinfo: fix x86 with CONFIG_OF enabled
      drivers: base: cacheinfo: fix boot error message when acpi is enabled
      drivers: base: cacheinfo: add pr_fmt logging
      drivers: base: cacheinfo: support DT overrides for cache properties

 .../ABI/testing/sysfs-devices-deferred_probe       |  12 +
 arch/arm64/mm/dma-mapping.c                        |   2 +
 arch/x86/kernel/cpu/intel_cacheinfo.c              |   2 +
 drivers/acpi/arm64/iort.c                          | 607 ++++++++++++++++++++-
 drivers/acpi/glue.c                                |   4 +-
 drivers/acpi/scan.c                                |  33 ++
 drivers/base/Kconfig                               |   2 +
 drivers/base/Makefile                              |   2 +
 drivers/base/base.h                                |  15 +
 drivers/base/cacheinfo.c                           | 138 ++++-
 drivers/base/core.c                                | 578 ++++++++++++++++++++
 drivers/base/dd.c                                  |  79 ++-
 drivers/base/power/main.c                          |  87 ++-
 drivers/base/power/power.h                         |  10 +
 drivers/base/power/runtime.c                       | 174 +++++-
 drivers/base/test/Kconfig                          |   9 +
 drivers/base/test/Makefile                         |   1 +
 drivers/base/test/test_async_driver_probe.c        | 171 ++++++
 drivers/iommu/amd_iommu.c                          |   2 +
 drivers/iommu/amd_iommu_init.c                     |   4 +
 drivers/iommu/amd_iommu_v2.c                       |   4 +-
 drivers/iommu/arm-smmu-v3.c                        | 104 +++-
 drivers/iommu/arm-smmu.c                           | 177 ++++--
 drivers/iommu/dma-iommu.c                          |  24 +-
 drivers/iommu/exynos-iommu.c                       | 293 +++++-----
 drivers/iommu/io-pgtable-arm-v7s.c                 |   5 +-
 drivers/iommu/io-pgtable-arm.c                     |   7 +-
 drivers/iommu/iommu.c                              |  53 ++
 drivers/iommu/iova.c                               |   2 +-
 drivers/iommu/mtk_iommu.c                          |  85 +--
 drivers/iommu/mtk_iommu.h                          |  11 +-
 drivers/iommu/mtk_iommu_v1.c                       | 105 ++--
 drivers/iommu/of_iommu.c                           |  39 --
 drivers/iommu/s390-iommu.c                         |   1 -
 drivers/pci/probe.c                                |   3 +-
 include/acpi/acpi_bus.h                            |   2 +
 include/asm-generic/vmlinux.lds.h                  |   1 +
 include/linux/acpi.h                               |  26 +
 include/linux/acpi_iort.h                          |  16 +
 include/linux/cacheinfo.h                          |   1 +
 include/linux/debugfs.h                            |  44 +-
 include/linux/device.h                             |  86 +++
 include/linux/dma-iommu.h                          |   4 +
 include/linux/fwnode.h                             |   3 +-
 include/linux/iommu.h                              |  15 +
 include/linux/of_iommu.h                           |  12 +-
 include/linux/pm.h                                 |   2 +
 include/linux/pm_runtime.h                         |  10 +
 lib/kobject_uevent.c                               |   6 +-
 49 files changed, 2621 insertions(+), 452 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-deferred_probe
 create mode 100644 drivers/base/test/Kconfig
 create mode 100644 drivers/base/test/Makefile
 create mode 100644 drivers/base/test/test_async_driver_probe.c

Please pull.

Thanks,

	Joerg

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJYUsxdAAoJECvwRC2XARrjBR8QAL9ILIFXv87kWpjLeiTdXBLo
ZJjy+hNSc9QGnqabg1wObMNDTe51ZWaf7U9PQyRPQe4EjrorKteI4Zn33PYuKYoW
/caJdogYZiJeaLg14DHZ3Ghw5VQdEU9SDlZrstN23JR5dnuBnKE99d85gKCoBK8P
a8TUEsZsdI1S240v1JeNvDFimNypbjJXsZFv7CkgAlr2DDnoYovPF9AClbt/leID
VYfSc3+v7tmzlkZ7IjwR2WiD72KVjhoLkZ1NrYXPzCrwrW8crtZa4IN4prJz02Ag
BYRb7yNE/U/RdfUW4Hp509Y3ZLXg9soxzw2rjqMffxzBrXhEwVlN0FzRMBr4dVZX
aY8zEtmlRFBjXKvpPYZeIKbKaYgjCAMxiJ4r2lGQCSMOBmxZrkpOkPFQZYxMc+/V
Bv1MyGEfAKlIffGZzUnj4Kt2J7UjsuuoGjX5ND5wc1br4kry0IYgK6pRYBUSXKxY
9l7tHw3JycXXtcqZMFlin6lA90/w1ySu5pgGVA0wZruVJ/e+ZcKGxSzcdwUFsJ5o
EpDayxuDcprX3jHmfMWYepbamUGkoGWXNEW4r627jf/PU4RzKGGRGZPC6TooUMD7
BUoaSBi4hCcsf5a5ctf4plywRTAimBDHSeKGC9KU/YXOm96ZhID6Gya9YvFaELM+
XoWhS3+eJXALSBVWiIM6
=lu+x
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

--===============7783885760870413638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7783885760870413638==--
