From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/4] iommu: Clean up the comments for iommu_group_alloc
Date: Fri,  4 May 2018 13:08:16 +0800
Message-ID: <1525410499-18632-2-git-send-email-baolu.lu@linux.intel.com>
References: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

@name parameter has been removed.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d2aa2320..d87e7c2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -322,7 +322,6 @@ static struct kobj_type iommu_group_ktype = {
 
 /**
  * iommu_group_alloc - Allocate a new group
- * @name: Optional name to associate with group, visible in sysfs
  *
  * This function is called by an iommu driver to allocate a new iommu
  * group.  The iommu group represents the minimum granularity of the iommu.
-- 
2.7.4
