From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/4] iommu/amd: No need to wait iommu completion if no dte irq
	entry change
Date: Thu, 15 Sep 2016 16:50:53 +0800
Message-ID: <1473929453-3533-5-git-send-email-bhe@redhat.com>
References: <1473929453-3533-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1473929453-3533-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent.Wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is a clean up. In get_irq_table() only if DTE entry is changed
iommu_completion_wait() need be called. Otherwise no need to do it.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a9f78c2..461c2fe 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3581,7 +3581,7 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
 
 	table = irq_lookup_table[devid];
 	if (table)
-		goto out;
+		goto out_unlock;
 
 	alias = amd_iommu_alias_table[devid];
 	table = irq_lookup_table[alias];
@@ -3595,7 +3595,7 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
 	/* Nothing there yet, allocate new irq remapping table */
 	table = kzalloc(sizeof(*table), GFP_ATOMIC);
 	if (!table)
-		goto out;
+		goto out_unlock;
 
 	/* Initialize table spin-lock */
 	spin_lock_init(&table->lock);
@@ -3608,7 +3608,7 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
 	if (!table->table) {
 		kfree(table);
 		table = NULL;
-		goto out;
+		goto out_unlock;
 	}
 
 	memset(table->table, 0, MAX_IRQS_PER_TABLE * sizeof(u32));
-- 
2.5.5
