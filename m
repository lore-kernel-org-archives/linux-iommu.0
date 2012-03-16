From: Gerard Snitselaar <dev@snitselaar.org>
Subject: [PATCH] iommu: amd: fix section mismatch
Date: Fri, 16 Mar 2012 11:38:22 -0700
Message-ID: <1331923102-28625-1-git-send-email-dev@snitselaar.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joerg.roedel@amd.com
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

amd_iommu_enable_interrupts() called in amd_iommu_resume().

Signed-off-by: Gerard Snitselaar <dev@snitselaar.org>
---
 drivers/iommu/amd_iommu_init.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index d4f0854..c567903 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -196,7 +196,7 @@ static u32 rlookup_table_size;	/* size if the rlookup table */
  */
 extern void iommu_flush_all_caches(struct amd_iommu *iommu);
 
-static int __init amd_iommu_enable_interrupts(void);
+static int amd_iommu_enable_interrupts(void);
 
 static inline void update_last_devid(u16 devid)
 {
@@ -1598,7 +1598,7 @@ free:
 	return ret;
 }
 
-static int __init amd_iommu_enable_interrupts(void)
+static int amd_iommu_enable_interrupts(void)
 {
 	struct amd_iommu *iommu;
 	int ret = 0;
-- 
1.7.7.6
