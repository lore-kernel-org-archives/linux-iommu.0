From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 23/23] ARM: dma-mapping: Drop GFP_COMP for DMA memory
	allocations
Date: Wed, 26 Jun 2013 12:28:26 +0300
Message-ID: <1372238906-9346-24-git-send-email-hdoyu@nvidia.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

arm_iommu_alloc_attrs wants to split pages after allocation in order
to reduce the memory footprint. This does not work well with GFP_COMP
pages, so drop this flag before allocation.

(ref: ea2e7057c0234cfb8b09467d8f137760d371fc72)

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/mm/dma-mapping.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7f9b179..cad35a3 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1322,6 +1322,13 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	struct page **pages;
 	void *addr = NULL;
 
+	/* Following is a work-around (a.k.a. hack) to prevent pages
+	 * with __GFP_COMP being passed to split_page() which cannot
+	 * handle them.  The real problem is that this flag probably
+	 * should be 0 on ARM as it is not supported on this
+	 * platform--see CONFIG_HUGETLB_PAGE. */
+	gfp &= ~(__GFP_COMP);
+
 	*handle = DMA_ERROR_CODE;
 	size = PAGE_ALIGN(size);
 
-- 
1.8.1.5
