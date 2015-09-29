From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] iommu/vt-d: Adjsut the return value of the
	parse_ioapics_under_ir
Date: Tue, 29 Sep 2015 15:26:09 +0800
Message-ID: <1443511569-9187-2-git-send-email-bhe@redhat.com>
References: <1443511569-9187-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1443511569-9187-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Adjust the return value of parse_ioapics_under_ir as "-1" representing
failure and "0" representing succcess. Just make it consistent with other
function implementation, and we can judge if calling is successfull by
if (!parse_ioapics_under_ir()) style.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 37b93f5..0f441b7 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -672,7 +672,7 @@ static int __init intel_prepare_irq_remapping(void)
 	if (!dmar_ir_support())
 		return -ENODEV;
 
-	if (parse_ioapics_under_ir() != 1) {
+	if (!parse_ioapics_under_ir()) {
 		pr_info("Not enabling interrupt remapping\n");
 		goto error;
 	}
@@ -918,7 +918,7 @@ static int __init parse_ioapics_under_ir(void)
 		}
 
 	if (!ir_supported)
-		return 0;
+		return -1;
 
 	for (ioapic_idx = 0; ioapic_idx < nr_ioapics; ioapic_idx++) {
 		int ioapic_id = mpc_ioapic_id(ioapic_idx);
@@ -930,7 +930,7 @@ static int __init parse_ioapics_under_ir(void)
 		}
 	}
 
-	return 1;
+	return 0;
 }
 
 static int __init ir_dev_scope_init(void)
-- 
2.1.0
