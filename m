From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/2] iommu / vfio: Clean up iommu_map[_fast] interface
Date: Tue, 30 Jan 2018 20:48:03 -0500
Message-ID: <1517363285-89304-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, jroedel@suse.de, alex.williamson@redhat.com, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
List-Id: iommu@lists.linux-foundation.org

Change iommu_unmap[_fast] interfaces return type to ssize_t since
it can also return error code.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Alex Williamson <alex.williamson@redhat.com>

Suravee Suthikulpanit (2):
  iommu: Fix iommu_unmap and iommu_unmap_fast return type
  vfio/type1: Add iommu_unmap error check when vfio_unmap_unpin

 drivers/iommu/amd_iommu.c       |  6 +++---
 drivers/iommu/intel-iommu.c     |  4 ++--
 drivers/iommu/iommu.c           | 16 ++++++++--------
 drivers/vfio/vfio_iommu_type1.c |  5 +++--
 include/linux/iommu.h           | 20 ++++++++++----------
 5 files changed, 26 insertions(+), 25 deletions(-)

-- 
1.8.3.1
