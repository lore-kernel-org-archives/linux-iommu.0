From: Antonios Motakis <a.motakis@virtualopensystems.com>
Subject: [RFC PATCH v6 00/20] VFIO support for platform devices on ARM
Date: Thu,  5 Jun 2014 19:03:08 +0200
Message-ID: <1401987808-23596-1-git-send-email-a.motakis@virtualopensystems.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
To: alex.williamson@redhat.com, kvmarm@lists.cs.columbia.edu, iommu@lists.linux-foundation.org
Cc: tech@virtualopensystems.com, a.rigo@virtualopensystems.com, kvm@vger.kernel.org, christoffer.dall@linaro.org, will.deacon@arm.com, kim.phillips@freescale.com, stuart.yoder@freescale.com, eric.auger@linaro.org, Antonios Motakis <a.motakis@virtualopensystems.com>
List-Id: iommu@lists.linux-foundation.org

This patch series aims to implement VFIO support for platform devices that
reside behind an IOMMU. Examples of such devices are devices behind an ARM
SMMU, or behind a Samsung Exynos System MMU.

The effort on VFIO_PLATFORM has been partially conducted under the SAVE FP7
project.
http://www.virtualopensystems.com/en/research/innovation-projects/fp7-save/

This version of the VFIO_PLATFORM patch series includes a number of fixes, and
introduces more complete support for eventfds. An eventfd can now be set by the
user, that can be used to mask and unmask a given interrupt.

The API used is based on the existing VFIO API that is also used with PCI
devices. Only devices that include a basic set of IRQs and memory regions are
targeted; devices with complex relationships with other devices on a device
tree are not taken into account at this stage.

Using the VFIO_IOMMU_TYPE1 driver with the VFIO_PLATFORM driver introduced here,
the standard VFIO ioctls have been found to be working on FastModels with an
ARM SMMU (MMU400). Testing was based on the ARM PL330 DMA Controller featured
on those models. Reading/writing to and MMAPing device memory regions is also
supported via the device file descriptor.

Kim Phillip's driver_override patch for platform bus devices is included in the
patch series.

A copy with all the dependencies applied can be cloned from branch
vfio-platform-v6 at git@github.com:virtualopensystems/linux-kvm-arm.git

For those who want to apply manually, these patches are based on Linux version
3.15-rc8.

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


Antonios Motakis (19):
  iommu/arm-smmu: change IOMMU_EXEC to IOMMU_NOEXEC
  iommu: add capability IOMMU_CAP_NOEXEC
  iommu/arm-smmu: add IOMMU_CAP_NOEXEC to the ARM SMMU driver
  iommu/arm-smmu: add capability IOMMU_CAP_INTR_REMAP
  vfio/iommu_type1: support for platform bus devices on ARM
  vfio: introduce the VFIO_DMA_MAP_FLAG_NOEXEC flag
  vfio/iommu_type1: implement the VFIO_DMA_MAP_FLAG_NOEXEC flag
  vfio/platform: initial skeleton of VFIO support for platform devices
  vfio/platform: return info for device and its memory mapped IO regions
  vfio/platform: read and write support for the device fd
  vfio/platform: support MMAP of MMIO regions
  vfio/platform: return IRQ info
  vfio/platform: initial interrupts support
  vfio/platform: support for maskable and automasked interrupts
  vfio: move eventfd support code for VFIO_PCI to a sepparate file
  vfio: add local lock in virqfd instead of depending on VFIO PCI
  vfio: pass an opaque pointer on virqfd initialization
  vfio: initialize the virqfd workqueue in VFIO generic code
  vfio/platform: implement IRQ masking/unmasking via an eventfd

Kim Phillips (1):
  driver core: platform: add device binding path 'driver_override'

 Documentation/ABI/testing/sysfs-bus-platform  |  20 ++
 drivers/base/platform.c                       |  47 +++
 drivers/iommu/arm-smmu.c                      |   4 +-
 drivers/vfio/Kconfig                          |   3 +-
 drivers/vfio/Makefile                         |   3 +-
 drivers/vfio/pci/vfio_pci.c                   |   8 -
 drivers/vfio/pci/vfio_pci_intrs.c             | 234 +-------------
 drivers/vfio/pci/vfio_pci_private.h           |   3 -
 drivers/vfio/platform/Kconfig                 |   9 +
 drivers/vfio/platform/Makefile                |   4 +
 drivers/vfio/platform/vfio_platform.c         | 445 ++++++++++++++++++++++++++
 drivers/vfio/platform/vfio_platform_irq.c     | 343 ++++++++++++++++++++
 drivers/vfio/platform/vfio_platform_private.h |  62 ++++
 drivers/vfio/vfio.c                           |   8 +
 drivers/vfio/vfio_iommu_type1.c               |  30 +-
 drivers/vfio/virqfd.c                         | 213 ++++++++++++
 include/linux/iommu.h                         |   7 +-
 include/linux/platform_device.h               |   1 +
 include/linux/vfio.h                          |  26 ++
 include/uapi/linux/vfio.h                     |   3 +
 20 files changed, 1233 insertions(+), 240 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform
 create mode 100644 drivers/vfio/platform/Kconfig
 create mode 100644 drivers/vfio/platform/Makefile
 create mode 100644 drivers/vfio/platform/vfio_platform.c
 create mode 100644 drivers/vfio/platform/vfio_platform_irq.c
 create mode 100644 drivers/vfio/platform/vfio_platform_private.h
 create mode 100644 drivers/vfio/virqfd.c

-- 
1.8.3.2

