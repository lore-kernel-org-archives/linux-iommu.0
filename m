From: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Subject: [PATCH] iommu/amd: tell kmemleak about the irq_remap_table
Date: Wed, 26 Oct 2016 13:09:53 +0200
Message-ID: <1477480193-2741-1-git-send-email-dev@lynxeye.de>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This will get rid of a lot false positives caused by kmemleak being
unaware of the irq_remap_table. Based on a suggestion from Catalin Marinas.

Signed-off-by: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 157e934..971154c 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -28,6 +28,7 @@
 #include <linux/amd-iommu.h>
 #include <linux/export.h>
 #include <linux/iommu.h>
+#include <linux/kmemleak.h>
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
 #include <asm/gart.h>
@@ -2090,6 +2091,7 @@ static struct syscore_ops amd_iommu_syscore_ops = {
 
 static void __init free_on_init_error(void)
 {
+	kmemleak_free(irq_lookup_table);
 	free_pages((unsigned long)irq_lookup_table,
 		   get_order(rlookup_table_size));
 
@@ -2321,6 +2323,8 @@ static int __init early_amd_iommu_init(void)
 		irq_lookup_table = (void *)__get_free_pages(
 				GFP_KERNEL | __GFP_ZERO,
 				get_order(rlookup_table_size));
+		kmemleak_alloc(irq_lookup_table, rlookup_table_size,
+			       1, GFP_KERNEL);
 		if (!irq_lookup_table)
 			goto out;
 	}
-- 
2.7.4
