From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [PATCHv3 0/9] VFIO support for platform devices
Date: Wed, 11 Dec 2013 21:58:24 +0100
Message-ID: <1386795513-32426-1-git-send-email-a.motakis@virtualopensystems.com>
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
Cc: B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch series aims to implement VFIO support for platform devices that
reside behind an IOMMU. Examples of such devices are devices behind an ARM SMMU,
or behind a Samsung Exynos System MMU.

The API used is based on the existing VFIO API that is also used with PCI
devices. Only devices that include a basic set of IRQs and memory regions are
targeted; devices with complex relationships with other devices on a device tree
are not taken into account at this stage.

These patches apply on the latest version of Will Deacon's iommu/devel branch
for the ARM SMMU driver, with also Kim Phillips' patches to allow platform
drivers to bind to any device.

A copy with all the dependencies applied can be cloned from branch
vfio-platform-v3 at git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:virtualopensystems/linux-kvm-arm.git

The following IOCTLs have been found to be working on FastModels with an
ARM SMMU (MMU400). Testing was based on the ARM PL330 DMA Controller featured
on those models.
 - VFIO_GET_API_VERSION
 - VFIO_CHECK_EXTENSION

The TYPE1 fix proposed here enables the following IOCTLs:
 - VFIO_GROUP_GET_STATUS
 - VFIO_GROUP_SET_CONTAINER
 - VFIO_SET_IOMMU
 - VFIO_IOMMU_GET_INFO
 - VFIO_IOMMU_MAP_DMA
     For this ioctl specifically, a new flag has been added:
     VFIO_DMA_MAP_FLAG_EXEC. This flag is taken into account on systems with an
     ARM SMMU.

The VFIO platform driver proposed here implements the following:
 - VFIO_GROUP_GET_DEVICE_FD
 - VFIO_DEVICE_GET_INFO
 - VFIO_DEVICE_GET_REGION_INFO
 - VFIO_DEVICE_GET_IRQ_INFO
 - VFIO_DEVICE_SET_IRQS
     IRQs are implemented partially using this ioctl. Handling incoming
     interrupts with an eventfd is supported, as is masking and unmasking.
     Level sensitive interrupts are automasked. What is not implemented is
     masking/unmasking via eventfd.

In addition, the VFIO platform driver implements the following through
the VFIO device file descriptor:
 - MMAPing memory regions to the virtual address space of the VFIO user.
 - Read / write of memory regions directly through the file descriptor.

What still needs to be done, includes:
 - Eventfd for masking/unmasking
 - Extend the driver and API for device tree metadata
 - QEMU / KVM integration
 - Device specific functionality (e.g. VFIO_DEVICE_RESET)
 - Improve VFIO_IOMMU_TYPE1 driver to support multiple buses at the same time
 - Bind to ARM AMBA devices
 - IOMMUs with nested page tables (Stage 1 & 2 translation on ARM SMMUs)

Changes since v2:
 - Fixed Read/Write and MMAP on device regions
 - Removed dependency on Device Tree
 - Interrupts support
 - Interrupt masking/unmasking
 - Automask level sensitive interrupts
 - Introduced VFIO_DMA_MAP_FLAG_EXEC
 - Code clean ups

Antonios Motakis (9):
  VFIO_IOMMU_TYPE1: Introduce the VFIO_DMA_MAP_FLAG_EXEC flag
  VFIO_IOMMU_TYPE1: workaround to build for platform devices
  VFIO_PLATFORM: Initial skeleton of VFIO support for platform devices
  VFIO_PLATFORM: Return info for device and its memory mapped IO regions
  VFIO_PLATFORM: Read and write support for the device fd
  VFIO_PLATFORM: Support MMAP of MMIO regions
  VFIO_PLATFORM: Return IRQ info
  VFIO_PLATFORM: Initial interrupts support
  VFIO_PLATFORM: Support for maskable and automasked interrupts

 drivers/vfio/Kconfig                          |   3 +-
 drivers/vfio/Makefile                         |   1 +
 drivers/vfio/platform/Kconfig                 |   9 +
 drivers/vfio/platform/Makefile                |   4 +
 drivers/vfio/platform/vfio_platform.c         | 448 ++++++++++++++++++++++++++
 drivers/vfio/platform/vfio_platform_irq.c     | 289 +++++++++++++++++
 drivers/vfio/platform/vfio_platform_private.h |  50 +++
 drivers/vfio/vfio_iommu_type1.c               |  27 +-
 include/uapi/linux/vfio.h                     |   2 +
 9 files changed, 827 insertions(+), 6 deletions(-)
 create mode 100644 drivers/vfio/platform/Kconfig
 create mode 100644 drivers/vfio/platform/Makefile
 create mode 100644 drivers/vfio/platform/vfio_platform.c
 create mode 100644 drivers/vfio/platform/vfio_platform_irq.c
 create mode 100644 drivers/vfio/platform/vfio_platform_private.h

-- 
1.8.3.2
