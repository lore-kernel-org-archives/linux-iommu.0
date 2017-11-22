From: <miles.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] dma-debug: use virt_addr_valid() to check linear addresses
Date: Wed, 22 Nov 2017 11:17:35 +0800
Message-ID: <1511320655-22752-1-git-send-email-miles.chen@mediatek.com>
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
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Miles Chen <miles.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsd_upstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Miles Chen <miles.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Coverity found that the commit 3aaabbf1c39e ("lib/dma-debug.c:
fix incorrect pfn calculation") uses incorrect API to check
if a given address is a linear address.
The condition should be: (as discussed in Christoph's review)
if (!is_vmalloc_addr(virt) && !virt_addr_valid(virt))
not
if (!is_vmalloc_addr(virt) && !virt_to_page(virt))

Fix it by using virt_addr_valid() instead of virt_to_page().

Signed-off-by: Miles Chen <miles.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 lib/dma-debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index 1b34d21..4c08eb6 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -1496,7 +1496,7 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
 		return;
 
 	/* handle vmalloc and linear addresses */
-	if (!is_vmalloc_addr(virt) && !virt_to_page(virt))
+	if (!is_vmalloc_addr(virt) && !virt_addr_valid(virt))
 		return;
 
 	entry->type      = dma_debug_coherent;
@@ -1528,7 +1528,7 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
 	};
 
 	/* handle vmalloc and linear addresses */
-	if (!is_vmalloc_addr(virt) && !virt_to_page(virt))
+	if (!is_vmalloc_addr(virt) && !virt_addr_valid(virt))
 		return;
 
 	if (is_vmalloc_addr(virt))
-- 
1.9.1
