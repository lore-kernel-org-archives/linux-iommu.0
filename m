From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH] iommu: fix trace_map() to report original iova and original size
Date: Thu, 15 Jan 2015 19:29:43 -0700
Message-ID: <1421375383-8930-1-git-send-email-shuahkh@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, alex.williamson@redhat.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

iommu_map() calls trace_map() with iova and size. trace_map()
should report original iova and original size as opposed to
iova and size after they get changed during mapping. size is
always zero at the end of mapping which is useless to report
and iova as it gets incremented, it is not as useful as the
original iova. Change iommu_map() to call trace_map() to
report original iova and original size.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Reported-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f7718d7..fbf8827 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1084,7 +1084,7 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	if (ret)
 		iommu_unmap(domain, orig_iova, orig_size - size);
 	else
-		trace_map(iova, paddr, size);
+		trace_map(orig_iova, paddr, orig_size);
 
 	return ret;
 }
-- 
1.9.1
