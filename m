From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH] iommu: fix trace_unmap() to report original iova
Date: Fri, 16 Jan 2015 16:47:19 -0700
Message-ID: <1421452039-7646-1-git-send-email-shuahkh@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, alex.williamson@redhat.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

iommu_unmap() calls trace_unmap() with changed iova and original
size. trace_unmap() should report original iova instead. Change
iommu_unmap() to call trace_unmap() with original iova.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Reported-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/iommu/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index fbf8827..2eb7554 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1094,6 +1094,7 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 {
 	size_t unmapped_page, unmapped = 0;
 	unsigned int min_pagesz;
+	unsigned long orig_iova = iova;
 
 	if (unlikely(domain->ops->unmap == NULL ||
 		     domain->ops->pgsize_bitmap == 0UL))
@@ -1133,7 +1134,7 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 		unmapped += unmapped_page;
 	}
 
-	trace_unmap(iova, 0, size);
+	trace_unmap(orig_iova, 0, size);
 	return unmapped;
 }
 EXPORT_SYMBOL_GPL(iommu_unmap);
-- 
2.1.0
