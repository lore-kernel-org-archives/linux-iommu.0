From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/4] iommu: Check for valid pgsize_bitmap in iommu_map/unmap
Date: Wed, 30 Jan 2013 22:43:46 +0100
Message-ID: <1359582228-21552-3-git-send-email-joro@8bytes.org>
References: <1359582228-21552-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1359582228-21552-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

In case the page-size bitmap is zero the code path in
iommu_map and iommu_unmap is undefined. Make it defined and
return -ENODEV in this case.

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/iommu.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ddbdaca..622360f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -734,7 +734,8 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	size_t orig_size = size;
 	int ret = 0;
 
-	if (unlikely(domain->ops->map == NULL))
+	if (unlikely(domain->ops->unmap == NULL ||
+		     domain->ops->pgsize_bitmap == 0UL))
 		return -ENODEV;
 
 	/* find out the minimum page size supported */
@@ -808,7 +809,8 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 	size_t unmapped_page, unmapped = 0;
 	unsigned int min_pagesz;
 
-	if (unlikely(domain->ops->unmap == NULL))
+	if (unlikely(domain->ops->unmap == NULL ||
+		     domain->ops->pgsize_bitmap == 0UL))
 		return -ENODEV;
 
 	/* find out the minimum page size supported */
-- 
1.7.9.5
