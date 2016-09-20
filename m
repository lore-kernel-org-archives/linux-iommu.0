From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH RESEND 4/4] iommu/amd: No need to wait iommu completion if no
	dte irq entry change
Date: Tue, 20 Sep 2016 09:05:34 +0800
Message-ID: <20160920010534.GA11495@x1.redhat.com>
References: <1473929453-3533-1-git-send-email-bhe@redhat.com>
	<1473929453-3533-5-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1473929453-3533-5-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent.Wan-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is a clean up. In get_irq_table() only if DTE entry is changed
iommu_completion_wait() need be called. Otherwise no need to do it.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b5b117b..a2479d0 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3634,7 +3634,7 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
 
 	table = irq_lookup_table[devid];
 	if (table)
-		goto out;
+		goto out_unlock;
 
 	alias = amd_iommu_alias_table[devid];
 	table = irq_lookup_table[alias];
@@ -3648,7 +3648,7 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
 	/* Nothing there yet, allocate new irq remapping table */
 	table = kzalloc(sizeof(*table), GFP_ATOMIC);
 	if (!table)
-		goto out;
+		goto out_unlock;
 
 	/* Initialize table spin-lock */
 	spin_lock_init(&table->lock);
@@ -3661,7 +3661,7 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
 	if (!table->table) {
 		kfree(table);
 		table = NULL;
-		goto out;
+		goto out_unlock;
 	}
 
 	if (!AMD_IOMMU_GUEST_IR_GA(amd_iommu_guest_ir))
-- 
2.5.5
