From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/4] iommu/amd: Clean up patches
Date: Thu, 15 Sep 2016 16:50:49 +0800
Message-ID: <1473929453-3533-1-git-send-email-bhe@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, dyoung@redhat.com, xlpang@redhat.com, Vincent.Wan@amd.com, Baoquan He <bhe@redhat.com>
List-Id: iommu@lists.linux-foundation.org

These were found out when I tried to fix the kdump failure on system
with AMD iommu. Pack them into this patchset since they are not related
to the kdump issue and each other.

Baoquan He (4):
  iommu/amd: clean up the cmpxchg64 invocation
  iommu/amd: Use standard bitmap operation to set bitmap
  iommu/amd: Free domain id when free a domain of struct dma_ops_domain
  iommu/amd: No need to wait iommu completion if no dte irq entry change

 drivers/iommu/amd_iommu.c      | 12 ++++++++----
 drivers/iommu/amd_iommu_init.c |  3 ++-
 2 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.5.5
