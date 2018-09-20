From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 00/10] Shared Virtual Addressing for the IOMMU
Date: Thu, 20 Sep 2018 18:00:36 +0100
Message-ID: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is version 3 of the core changes for Shared Virtual Addressing in
the IOMMU. It provides an API for sharing process address spaces with
devices, using for example PCI PASID and PRI.

This time I didn't append the VFIO and SMMUv3 example users. A smaller
series is easier for me to manage and may be less intimidating for
reviewers. If you're adding or updating SVA support to your IOMMU or
device driver, you can find my complete patch stack at [1] for
inspiration.

Changes to patches 1-9 address feedback from v2 [2]. Mostly small tweaks
and comments, that I tried to detail on each patch.

I added patch 10/10 from Jordan Crouse, for managing PASID without
sharing process address spaces. This interface might get superseded by
auxiliary domains [3], since they are more suitable than io_mm for Intel
vt-d's mdev virtualization. Auxiliary domains reuse existing iommu_map/
iommu_unmap/etc ops instead of introducing new ones, so even though it's
more invasive, I tend to prefer that solution. But since we need
something for testing right now, I'm appending patch 10 to the series.

The series depends on Jacob Pan's patches for fault reporting [4].
  iommu: introduce device fault data
  driver core: add per device iommu param
  iommu: add a timeout parameter for prq response
  iommu: introduce device fault report API
  iommu: introduce page response function

[1] git://linux-arm.org/linux-jpb.git sva/v3
[2] https://www.spinics.net/lists/kvm/msg168742.html
[3] https://lwn.net/ml/linux-kernel/20180830040922.30426-1-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org/
[4] https://lwn.net/ml/linux-kernel/1526072055-86990-1-git-send-email-jacob.jun.pan%40linux.intel.com/

Jean-Philippe Brucker (10):
  iommu: Introduce Shared Virtual Addressing API
  iommu/sva: Bind process address spaces to devices
  iommu/sva: Manage process address spaces
  iommu/sva: Add a mm_exit callback for device drivers
  iommu/sva: Track mm changes with an MMU notifier
  iommu/sva: Search mm by PASID
  iommu: Add a page fault handler
  iommu/iopf: Handle mm faults
  iommu/sva: Register page fault handler
  iommu/sva: Add support for private PASIDs

 drivers/iommu/Kconfig      |   9 +
 drivers/iommu/Makefile     |   2 +
 drivers/iommu/io-pgfault.c | 464 ++++++++++++++++++
 drivers/iommu/iommu-sva.c  | 967 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c      | 143 +++++-
 include/linux/iommu.h      | 289 ++++++++++-
 6 files changed, 1855 insertions(+), 19 deletions(-)
 create mode 100644 drivers/iommu/io-pgfault.c
 create mode 100644 drivers/iommu/iommu-sva.c

-- 
2.18.0
