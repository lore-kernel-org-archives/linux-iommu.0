From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/2] iommu/vt-d: Improve fault handler error messages
Date: Thu, 17 Mar 2016 14:12:31 -0600
Message-ID: <20160317201230.29049.33605.stgit@gimli.home>
References: <20160317200557.29049.32879.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160317200557.29049.32879.stgit-GCcqpEzw8uZBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Remove new line in error logs, avoid duplicate and explicit pr_fmt.

Suggested-by: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/dmar.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 8f8bfff..6a86b5d 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1579,18 +1579,14 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 	reason = dmar_get_fault_reason(fault_reason, &fault_type);
 
 	if (fault_type == INTR_REMAP)
-		pr_err("INTR-REMAP: Request device [[%02x:%02x.%d] "
-		       "fault index %llx\n"
-			"INTR-REMAP:[fault reason %02d] %s\n",
-			(source_id >> 8), PCI_SLOT(source_id & 0xFF),
+		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index %llx [fault reason %02d] %s\n",
+			source_id >> 8, PCI_SLOT(source_id & 0xFF),
 			PCI_FUNC(source_id & 0xFF), addr >> 48,
 			fault_reason, reason);
 	else
-		pr_err("DMAR:[%s] Request device [%02x:%02x.%d] "
-		       "fault addr %llx \n"
-		       "DMAR:[fault reason %02d] %s\n",
-		       (type ? "DMA Read" : "DMA Write"),
-		       (source_id >> 8), PCI_SLOT(source_id & 0xFF),
+		pr_err("[%s] Request device [%02x:%02x.%d] fault addr %llx [fault reason %02d] %s\n",
+		       type ? "DMA Read" : "DMA Write",
+		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
 		       PCI_FUNC(source_id & 0xFF), addr, fault_reason, reason);
 	return 0;
 }
