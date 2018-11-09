From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/7] iommu/amd: Always allow to map huge pages
Date: Fri,  9 Nov 2018 12:07:05 +0100
Message-ID: <20181109110712.12469-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

Hi,

the AMD IOMMU driver had an issue for a long time where it
didn't allow to map a huge-page when smaller mappings
existed at that address range before. The VFIO driver even
had a workaround for that behavior.

These patches fix the issue and remove the workaround from
the VFIO driver.

Please review.

Thanks,

	Joerg

Joerg Roedel (7):
  iommu/amd: Collect page-table pages in freelist
  iommu/amd: Introduce free_sub_pt() function
  iommu/amd: Ignore page-mode 7 in free_sub_pt()
  iommu/amd: Allow downgrading page-sizes in alloc_pte()
  iommu/amd: Restart loop if cmpxchg64 succeeded in alloc_pte()
  iommu/amd: Allow to upgrade page-size
  vfio/type1: Remove map_try_harder() code path

 drivers/iommu/amd_iommu.c       | 204 +++++++++++++++++++++-----------
 drivers/iommu/amd_iommu_types.h |   1 +
 drivers/vfio/vfio_iommu_type1.c |  33 +-----
 3 files changed, 137 insertions(+), 101 deletions(-)

-- 
2.17.1
