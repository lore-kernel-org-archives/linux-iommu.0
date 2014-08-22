From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC 0/5] vfio: AMBA devices support
Date: Fri, 22 Aug 2014 11:01:23 +0200
Message-ID: <1408698088-5349-1-git-send-email-a.motakis@virtualopensystems.com>
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
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch series depends on the VFIO for PLATFORM devices patch series,
and implements AMBA device support for VFIO.

This can be used for example with the PL330 DMA Controller, which is an
AMBA device and not a proper platform device. By using the VFIO AMBA driver
introduced here, one can bind VFIO directly to such a device without hacking
the host device tree to make the device look like a platform device to the
system.

Also adding driver_override support to ARM AMBA bus devices, one can
alternate between using the proper host device driver and VFIO without
restarting the host system with a new device tree.

Antonios Motakis (5):
  driver core: amba: add device binding path 'driver_override'
  vfio: platform: decouple code probing devices from the platform bus
  vfio: platform: move code that can be shared with AMBA to a common
    file
  vfio: amba: VFIO support for AMBA devices
  vfio: amba: add the VFIO for AMBA devices module to Kconfig

 drivers/amba/bus.c                            |  43 +++
 drivers/vfio/platform/Kconfig                 |  10 +
 drivers/vfio/platform/Makefile                |   6 +-
 drivers/vfio/platform/vfio_amba.c             | 129 +++++++++
 drivers/vfio/platform/vfio_platform.c         | 355 +-----------------------
 drivers/vfio/platform/vfio_platform_common.c  | 380 ++++++++++++++++++++++++++
 drivers/vfio/platform/vfio_platform_irq.c     |   6 +-
 drivers/vfio/platform/vfio_platform_private.h |   9 +-
 include/linux/amba/bus.h                      |   1 +
 9 files changed, 591 insertions(+), 348 deletions(-)
 create mode 100644 drivers/vfio/platform/vfio_amba.c
 create mode 100644 drivers/vfio/platform/vfio_platform_common.c

-- 
1.8.3.2
