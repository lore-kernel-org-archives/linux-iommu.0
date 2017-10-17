From: Gary R Hook <gary.hook@amd.com>
Subject: [PATCH] iommu: Limit the IOVA page range to the specified addresses
Date: Tue, 17 Oct 2017 16:22:01 -0500
Message-ID: <150827532101.76237.2380796046683480798.stgit@sosxen2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: amd <amd@sosxen2.amd.com>

The extent of pages specified when applying a reserved region should
include up to the last page of the range, but not the page following
the range.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/amd_iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 27eb0d6fcdc2..bb3ef33e3784 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3271,7 +3271,7 @@ static void amd_iommu_apply_resv_region(struct device *dev,
 	unsigned long start, end;
 
 	start = IOVA_PFN(region->start);
-	end   = IOVA_PFN(region->start + region->length);
+	end   = IOVA_PFN(region->start + region->length - 1);
 
 	WARN_ON_ONCE(reserve_iova(&dma_dom->iovad, start, end) == NULL);
 }
