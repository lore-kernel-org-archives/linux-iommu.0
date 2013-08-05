From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC 0/3] WIP VFIO for device tree devices on Arndale
Date: Mon,  5 Aug 2013 15:17:09 +0200
Message-ID: <1375708632-26356-1-git-send-email-a.motakis@virtualopensystems.com>
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
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is a very early base work, towards VFIO support on ARM platforms
with an IOMMU. It forms a base on to which to implement the functionality
necessary to enable using device tree devices on ARM (and other platforms
based on device trees) with VFIO.

This very early work of progress is only published for the sake of openness,
and is very far from usable yet. However the driver can bind to devices,
and return to userspace the info about the memory regions and IRQs.

This patch series has been tested on the Arndale board (with the Exynos 5250
System MMU).

It depends on Cho KyongHo's patch series "iommu/exynos: Fixes and Enhancements
of System MMU driver with DT", applied on a Linux 3.10.1 kernel, and also my
own "iommu/exynos: add devices attached to the System MMU to an IOMMU group".
Those patches are required at least in order to test the proposed module on
Arndale.

This should not be treated as anything more than a work in progress. Numerous
functions still need to be implemented properly, e.g.
 - Proper binding of the VFIO_DT driver to devices; currently to test the
   driver, one has to edit the device tree and add the "vfio-dt" to the
   compatible property. However Linux does not support OF drivers that
   can be dynamically bound to any device.
 - Most IOCTLs are not implemented yet. Memory region mapping, DMA mapping,
   IRQFD still need to be added.
 - The VFIO_IOMMU_TYPE1 is patched to work instead of PCI IOMMU, with platform
   IOMMUs such as the one that is found on Arndale. This is a proof of concept
   hack, and a more permanent fix will be proposed as the code matures.

The API used is identical to the existing VFIO API that is also used with
PCI devices. Only devices that include a basic set of IRQs and memory regions
are targeted; devices with complicated relationships with other devices on the
device tree are not taken into account at this stage.

The API is not extended with device tree specific information; this would
complicate the driver unnecessarily as it is not needed for the base use cases.

Antonios Motakis (3):
  VFIO_IOMMU_TYPE1 workaround to build for platform devices
  Initial skeleton of VFIO support for Device Tree based devices
  Return info for device and its memory regions and interrupts

 drivers/vfio/Kconfig            |  12 ++-
 drivers/vfio/Makefile           |   1 +
 drivers/vfio/vfio_dt.c          | 233 ++++++++++++++++++++++++++++++++++++++++
 drivers/vfio/vfio_iommu_type1.c |  15 ++-
 include/uapi/linux/vfio.h       |   1 +
 5 files changed, 258 insertions(+), 4 deletions(-)
 create mode 100644 drivers/vfio/vfio_dt.c

-- 
1.8.1.2
