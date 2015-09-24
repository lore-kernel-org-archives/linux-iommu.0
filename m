From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 10/10] iommu/amd: Copy the old ir table
Date: Thu, 24 Sep 2015 14:37:36 +0800
Message-ID: <1443076656-31776-11-git-send-email-bhe@redhat.com>
References: <1443076656-31776-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1443076656-31776-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1e86f4c..f4f3e63 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3683,12 +3683,25 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
 
 	memset(table->table, 0, MAX_IRQS_PER_TABLE * sizeof(u32));
 
-	if (ioapic) {
-		int i;
-
-		for (i = 0; i < 32; ++i)
-			table->table[i] = IRTE_ALLOCATED;
-	}
+	if (translation_pre_enabled()) {
+		u64 dte;
+                u64 old_intr_virt;
+                dte     = amd_iommu_dev_table[devid].data[2];
+                dte &= DTE_IRQ_PHYS_ADDR_MASK;
+                old_intr_virt = ioremap_cache(dte, MAX_IRQS_PER_TABLE * sizeof(u32));
+                memcpy_fromio(table->table, old_intr_virt, MAX_IRQS_PER_TABLE * sizeof(u32));
+                iounmap(old_intr_virt);
+                iommu_flush_irt(iommu, devid);
+        }
+        else {
+
+                if (ioapic) {
+                        int i;
+
+                        for (i = 0; i < 32; ++i)
+                                table->table[i] = IRTE_ALLOCATED;
+                }
+        }
 
 	irq_lookup_table[devid] = table;
 	set_dte_irq_entry(devid, table);
-- 
2.4.0
