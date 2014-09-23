From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [PATCHv7 00/26] VFIO support for platform and AMBA devices on ARM
Date: Tue, 23 Sep 2014 16:45:59 +0200
Message-ID: <1411483586-29304-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch series aims to implement VFIO support for platform devices that
reside behind an IOMMU. Examples of such devices are devices behind an ARM
SMMU, or behind a Samsung Exynos System MMU.

This version of the patch series introduces numerous fixes and cleanups based
on the feedback received on the previous version, and also features support
for ARM AMBA devices.

The API used is based on the existing VFIO API that is also used with PCI
devices. Only devices that include a basic set of IRQs and memory regions are
targeted; devices with complex relationships with other devices on a device
tree are not taken into account at this stage.

This patch series is based on Linux 3.17-rc5 and can be cloned from the
branch vfio-platform-v7 at git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:virtualopensystems/linux-kvm-arm.git

Changes since v6:
 - Integrated support for AMBA devices
 - Numerous cleanups and fixes
Changes since v5:
 - Full eventfd support for IRQ masking and unmasking.
 - Changed IOMMU_EXEC to IOMMU_NOEXEC, along with related flags in VFIO.
 - Other fixes based on reviewer comments.
Changes since v4:
 - Use static offsets for each region in the VFIO device fd
 - Include patch in the series for the ARM SMMU to expose IOMMU_EXEC
   availability via IOMMU_CAP_DMA_EXEC
 - Rebased on VFIO multi domain support:
   - IOMMU_EXEC is now available if at least one IOMMU in the container
     supports it
   - Expose IOMMU_EXEC if available via the capability VFIO_IOMMU_PROT_EXEC
 - Some bug fixes
Changes since v3:
 - Use Kim Phillips' driver_probe_device()
Changes since v2:
 - Fixed Read/Write and MMAP on device regions
 - Removed dependency on Device Tree
 - Interrupts support
 - Interrupt masking/unmasking
 - Automask level sensitive interrupts
 - Introduced VFIO_DMA_MAP_FLAG_EXEC
 - Code clean ups

Antonios Motakis (26):
  iommu/arm-smmu: change IOMMU_EXEC to IOMMU_NOEXEC
  iommu: add capability IOMMU_CAP_NOEXEC
  iommu/arm-smmu: add IOMMU_CAP_NOEXEC to the ARM SMMU driver
  vfio/iommu_type1: support for platform bus devices on ARM
  vfio: introduce the VFIO_DMA_MAP_FLAG_NOEXEC flag
  vfio/iommu_type1: implement the VFIO_DMA_MAP_FLAG_NOEXEC flag
  driver core: amba: add device binding path 'driver_override'
  driver core: amba: add documentation for binding path
    'driver_override'
  vfio/platform: initial skeleton of VFIO support for platform devices
  vfio: platform: probe to devices on the platform bus
  vfio: platform: add the VFIO PLATFORM module to Kconfig
  vfio: amba: VFIO support for AMBA devices
  vfio: amba: add the VFIO for AMBA devices module to Kconfig
  vfio/platform: return info for bound device
  vfio/platform: return info for device memory mapped IO regions
  vfio/platform: read and write support for the device fd
  vfio/platform: support MMAP of MMIO regions
  vfio/platform: return IRQ info
  vfio/platform: initial interrupts support code
  vfio/platform: trigger an interrupt via eventfd
  vfio/platform: support for maskable and automasked interrupts
  vfio: move eventfd support code for VFIO_PCI to a separate file
  vfio: add local lock in virqfd instead of depending on VFIO PCI
  vfio: pass an opaque pointer on virqfd initialization
  vfio: initialize the virqfd workqueue in VFIO generic code
  vfio/platform: implement IRQ masking/unmasking via an eventfd

 Documentation/ABI/testing/sysfs-bus-amba      |  20 ++
 drivers/amba/bus.c                            |  44 +++
 drivers/iommu/arm-smmu.c                      |  11 +-
 drivers/vfio/Kconfig                          |   3 +-
 drivers/vfio/Makefile                         |   5 +-
 drivers/vfio/pci/vfio_pci.c                   |   8 -
 drivers/vfio/pci/vfio_pci_intrs.c             | 234 +-------------
 drivers/vfio/pci/vfio_pci_private.h           |   3 -
 drivers/vfio/platform/Kconfig                 |  19 ++
 drivers/vfio/platform/Makefile                |   8 +
 drivers/vfio/platform/vfio_amba.c             | 108 +++++++
 drivers/vfio/platform/vfio_platform.c         |  96 ++++++
 drivers/vfio/platform/vfio_platform_common.c  | 432 ++++++++++++++++++++++++++
 drivers/vfio/platform/vfio_platform_irq.c     | 354 +++++++++++++++++++++
 drivers/vfio/platform/vfio_platform_private.h |  77 +++++
 drivers/vfio/vfio.c                           |   8 +
 drivers/vfio/vfio_iommu_type1.c               |  38 ++-
 drivers/vfio/virqfd.c                         | 215 +++++++++++++
 include/linux/amba/bus.h                      |   1 +
 include/linux/iommu.h                         |   3 +-
 include/linux/vfio.h                          |  27 ++
 include/uapi/linux/vfio.h                     |   4 +
 22 files changed, 1477 insertions(+), 241 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-amba
 create mode 100644 drivers/vfio/platform/Kconfig
 create mode 100644 drivers/vfio/platform/Makefile
 create mode 100644 drivers/vfio/platform/vfio_amba.c
 create mode 100644 drivers/vfio/platform/vfio_platform.c
 create mode 100644 drivers/vfio/platform/vfio_platform_common.c
 create mode 100644 drivers/vfio/platform/vfio_platform_irq.c
 create mode 100644 drivers/vfio/platform/vfio_platform_private.h
 create mode 100644 drivers/vfio/virqfd.c

-- 
1.8.3.2
