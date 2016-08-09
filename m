From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 1/2] iommu/dma: Don't put uninitialised IOVA domains
Date: Tue,  9 Aug 2016 16:23:17 +0100
Message-ID: <3feb8016c2def4aabc5513b548e17bbf57c27959.1470755555.git.robin.murphy@arm.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Due to the limitations of having to wait until we see a device's DMA
restrictions before we know how we want an IOVA domain initialised,
there is a window for error if a DMA ops domain is allocated but later
freed without ever being used. In that case, init_iova_domain() was
never called, so calling put_iova_domain() from iommu_put_dma_cookie()
ends up trying to take an uninitialised lock and crashing.

Make things robust by skipping the call unless the IOVA domain actually
has been initialised, as we probably should have done from the start.

Fixes: 0db2e5d18f76 ("iommu: Implement common IOMMU ops for DMA mapping")
Cc: stable@vger.kernel.org
Reported-by: Nate Watterson <nwatters@codeaurora.org>
Reviewed-by: Nate Watterson <nwatters@codeaurora.org>
Tested-by: Nate Watterson <nwatters@codeaurora.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 08a1e2f3690f..7d991c81c4fa 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -68,7 +68,8 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	if (!iovad)
 		return;
 
-	put_iova_domain(iovad);
+	if (iovad->granule)
+		put_iova_domain(iovad);
 	kfree(iovad);
 	domain->iova_cookie = NULL;
 }
-- 
2.8.1.dirty
