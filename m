From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 0/8] KVM PCIe/MSI passthrough on ARM/ARM64 (Alt II)
Date: Thu,  3 Nov 2016 21:39:30 +0000
Message-ID: <1478209178-3009-1-git-send-email-eric.auger@redhat.com>
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
To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Following Will & Robin's suggestions, this series attempts to propose
an alternative to [1] where the host would arbitrarily decide the
location of the IOVA MSI window and would be able to report to the
userspace the list of reserved IOVA regions that cannot be used
along with VFIO_IOMMU_MAP_DMA. This would allow the userspace to react
in case of conflict.

Userspace can retrieve all the reserved regions through the VFIO_IOMMU_GET_INFO
IOCTL by querying the new RESV_IOVA_RANGE chained capability. Each reserved
IOVA range is put in a separate capability.

At IOMMU level, the reserved regions are stored in an iommu_domain list
which is populated on each device attachment. An IOMMU add_reserved_regions
callback specializes the registration of the reserved regions.

On x86, the [FEE0_0000h - FEF0_000h] MSI window is registered (NOT tested).

On ARM, the PCI host bridge windows (ACS check to be added?) + the MSI IOVA
reserved regions are populated by the arm-smmu driver. Currently the MSI
IOVA region is arbitrarily located at 0x8000000 and 1MB sized.  An IOVA domain
is created in add_reserved_regions callback. Then MSIs are transparently
mapped using this IOVA domain.

This series currently does not address some features addressed in [1]:
- MSI IOVA size requirement computation
- IRQ safety assessment

This RFC was just tested on ARM Overdrive with QEMU and is sent to help
potential discussions at LPC. Additionnal development + testing is needed.

2 tentative fixes may be submitted separately:
- vfio: fix vfio_info_cap_add/shift
- iommu/iova: fix __alloc_and_insert_iova_range

Best Regards

Eric

[1] [PATCH v14 00/16] KVM PCIe/MSI passthrough on ARM/ARM64
https://lkml.org/lkml/2016/10/12/347

Git: complete series available at
https://github.com/eauger/linux/tree/v4.9-rc3-reserved-rfc


Eric Auger (7):
  vfio: fix vfio_info_cap_add/shift
  iommu/iova: fix __alloc_and_insert_iova_range
  iommu: Add a list of iommu_reserved_region in iommu_domain
  vfio/type1: Introduce RESV_IOVA_RANGE capability
  iommu: Handle the list of reserved regions
  iommu/vt-d: Implement add_reserved_regions callback
  iommu/arm-smmu: implement add_reserved_regions callback

Robin Murphy (1):
  iommu/dma: Allow MSI-only cookies

 drivers/iommu/arm-smmu.c        | 63 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/dma-iommu.c       | 39 +++++++++++++++++++++++++
 drivers/iommu/intel-iommu.c     | 48 ++++++++++++++++++++++---------
 drivers/iommu/iommu.c           | 25 ++++++++++++++++
 drivers/iommu/iova.c            |  2 +-
 drivers/vfio/vfio.c             |  5 ++--
 drivers/vfio/vfio_iommu_type1.c | 63 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/dma-iommu.h       |  9 ++++++
 include/linux/iommu.h           | 23 +++++++++++++++
 include/uapi/linux/vfio.h       | 16 ++++++++++-
 10 files changed, 275 insertions(+), 18 deletions(-)

-- 
1.9.1
