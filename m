From: Nadav Amit <namit-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] iommu/vt-d: Remove unnecassary qi clflushes
Date: Fri, 24 Jun 2016 06:13:14 -0700
Message-ID: <1466773994-242872-1-git-send-email-namit@vmware.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Nadav Amit <namit-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

According to the manual: "Hardware access to ...  invalidation queue ...
are always coherent."

Remove unnecassary clflushes accordingly.

Signed-off-by: Nadav Amit <namit-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>

---

Build-tested since I do not have an IOMMU that does not support
coherency.
---
 drivers/iommu/dmar.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 6a86b5d..ca56ec3 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1155,8 +1155,6 @@ static int qi_check_fault(struct intel_iommu *iommu, int index)
 				(unsigned long long)qi->desc[index].high);
 			memcpy(&qi->desc[index], &qi->desc[wait_index],
 					sizeof(struct qi_desc));
-			__iommu_flush_cache(iommu, &qi->desc[index],
-					sizeof(struct qi_desc));
 			writel(DMA_FSTS_IQE, iommu->reg + DMAR_FSTS_REG);
 			return -EINVAL;
 		}
@@ -1231,9 +1229,6 @@ restart:
 
 	hw[wait_index] = wait_desc;
 
-	__iommu_flush_cache(iommu, &hw[index], sizeof(struct qi_desc));
-	__iommu_flush_cache(iommu, &hw[wait_index], sizeof(struct qi_desc));
-
 	qi->free_head = (qi->free_head + 2) % QI_LENGTH;
 	qi->free_cnt -= 2;
 
-- 
2.7.4
