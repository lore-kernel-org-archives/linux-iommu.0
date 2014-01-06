From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part1 V3 05/20] iommu/vt-d,
	trivial: refine support of 64bit guest address
Date: Mon,  6 Jan 2014 14:18:12 +0800
Message-ID: <1388989107-4795-6-git-send-email-jiang.liu@linux.intel.com>
References: <1388989107-4795-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1388989107-4795-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

In Intel IOMMU driver, it calculate page table level from adjusted guest
address width as 'level = (agaw - 30) / 9', which assumes (agaw -30)
could be divided by 9. On the other hand, 64bit is a valid agaw and
(64 - 30) can't be divided by 9, so it needs special handling.

This patch enhances Intel IOMMU driver to correctly handle 64bit agaw.
It's mainly for code readability because there's no hardware supporting
64bit agaw yet.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index e32d815..b2e73c2 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -63,6 +63,7 @@
 #define DEFAULT_DOMAIN_ADDRESS_WIDTH 48
 
 #define MAX_AGAW_WIDTH 64
+#define MAX_AGAW_PFN_WIDTH	(MAX_AGAW_WIDTH - VTD_PAGE_SHIFT)
 
 #define __DOMAIN_MAX_PFN(gaw)  ((((uint64_t)1) << (gaw-VTD_PAGE_SHIFT)) - 1)
 #define __DOMAIN_MAX_ADDR(gaw) ((((uint64_t)1) << gaw) - 1)
@@ -106,12 +107,12 @@ static inline int agaw_to_level(int agaw)
 
 static inline int agaw_to_width(int agaw)
 {
-	return 30 + agaw * LEVEL_STRIDE;
+	return min_t(int, 30 + agaw * LEVEL_STRIDE, MAX_AGAW_WIDTH);
 }
 
 static inline int width_to_agaw(int width)
 {
-	return (width - 30) / LEVEL_STRIDE;
+	return DIV_ROUND_UP(width - 30, LEVEL_STRIDE);
 }
 
 static inline unsigned int level_to_offset_bits(int level)
@@ -141,7 +142,7 @@ static inline unsigned long align_to_level(unsigned long pfn, int level)
 
 static inline unsigned long lvl_to_nr_pages(unsigned int lvl)
 {
-	return  1 << ((lvl - 1) * LEVEL_STRIDE);
+	return  1 << min_t(int, (lvl - 1) * LEVEL_STRIDE, MAX_AGAW_PFN_WIDTH);
 }
 
 /* VT-d pages must always be _smaller_ than MM pages. Otherwise things
@@ -865,7 +866,6 @@ static int dma_pte_clear_range(struct dmar_domain *domain,
 	int addr_width = agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
 	unsigned int large_page = 1;
 	struct dma_pte *first_pte, *pte;
-	int order;
 
 	BUG_ON(addr_width < BITS_PER_LONG && start_pfn >> addr_width);
 	BUG_ON(addr_width < BITS_PER_LONG && last_pfn >> addr_width);
@@ -890,8 +890,7 @@ static int dma_pte_clear_range(struct dmar_domain *domain,
 
 	} while (start_pfn && start_pfn <= last_pfn);
 
-	order = (large_page - 1) * 9;
-	return order;
+	return min_t(int, (large_page - 1) * 9, MAX_AGAW_PFN_WIDTH);
 }
 
 static void dma_pte_free_level(struct dmar_domain *domain, int level,
-- 
1.7.10.4
