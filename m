From: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH] iommu/dma: Setup iova_domain granule for IOMMU_DMA_MSI cookies
Date: Thu, 13 Apr 2017 04:55:15 -0400
Message-ID: <1492073715-7811-1-git-send-email-nwatters@codeaurora.org>
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
To: robin.murphy-5wv7dgnIgG8@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Currently, the __iommu_dma_{map/free} functions call iova_{offset/align}
making them unsuitable for use with iommu_domains having an IOMMU_DMA_MSI
cookie since the cookie's iova_domain member, iovad, is uninitialized.

Now that iommu_dma_get_msi_page() calls __iommu_dma_map() regardless
of cookie type, failures are being seen when mapping MSI target
addresses for devices attached to UNMANAGED domains. To work around
this issue, the iova_domain granule for IOMMU_DMA_MSI cookies is
initialized to the value returned by cookie_msi_granule().

Fixes: a44e6657585b ("iommu/dma: Clean up MSI IOVA allocation")
Signed-off-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 8348f366..d7b0816 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -127,6 +127,16 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 
 	cookie->msi_iova = base;
 	domain->iova_cookie = cookie;
+
+	/*
+	 * Setup granule for compatibility with __iommu_dma_{alloc/free} and
+	 * add a compile time check to ensure that writing granule won't
+	 * clobber msi_iova.
+	 */
+	cookie->iovad.granule = cookie_msi_granule(cookie);
+	BUILD_BUG_ON(offsetof(struct iova_domain, granule) <
+			sizeof(cookie->msi_iova));
+
 	return 0;
 }
 EXPORT_SYMBOL(iommu_get_msi_cookie);
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux
Foundation Collaborative Project.
