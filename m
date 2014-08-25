From: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] iommu/vt-d: Add domain field for dmar fault message
Date: Mon, 25 Aug 2014 14:38:04 +0800
Message-ID: <1408948684-18019-1-git-send-email-wangyijing@huawei.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Maybe there are the same bus:dev.fn in different domains,
so add the domain field for dmar fault message to
identify the exact source device.

Signed-off-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/dmar.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 8ed55b0..4f469c7 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1466,17 +1466,17 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 	reason = dmar_get_fault_reason(fault_reason, &fault_type);
 
 	if (fault_type == INTR_REMAP)
-		pr_err("INTR-REMAP: Request device [[%02x:%02x.%d] "
+		pr_err("INTR-REMAP: Request device [[%04x:%02x:%02x.%d] "
 		       "fault index %llx\n"
-			"INTR-REMAP:[fault reason %02d] %s\n",
+			"INTR-REMAP:[fault reason %02d] %s\n", iommu->segment,
 			(source_id >> 8), PCI_SLOT(source_id & 0xFF),
 			PCI_FUNC(source_id & 0xFF), addr >> 48,
 			fault_reason, reason);
 	else
-		pr_err("DMAR:[%s] Request device [%02x:%02x.%d] "
+		pr_err("DMAR:[%s] Request device [%04x:%02x:%02x.%d] "
 		       "fault addr %llx \n"
 		       "DMAR:[fault reason %02d] %s\n",
-		       (type ? "DMA Read" : "DMA Write"),
+		       (type ? "DMA Read" : "DMA Write"), iommu->segment,
 		       (source_id >> 8), PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr, fault_reason, reason);
 	return 0;
-- 
1.7.1
