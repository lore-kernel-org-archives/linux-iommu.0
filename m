From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] iommu/amd: Add align parameter to alloc_irq_index()
Date: Fri,  6 Oct 2017 13:34:11 +0200
Message-ID: <1507289652-30166-2-git-send-email-joro@8bytes.org>
References: <1507289652-30166-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1507289652-30166-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

For multi-MSI IRQ ranges the IRQ index needs to be aligned
to the power-of-two of the requested IRQ count. Extend the
alloc_irq_index() function to allow such an allocation.

Reported-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Fixes: 2b324506341cb ('iommu/amd: Add routines to manage irq remapping tables')
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 51f8215..2d4ee25 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3660,11 +3660,11 @@ static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
 	return table;
 }
 
-static int alloc_irq_index(u16 devid, int count)
+static int alloc_irq_index(u16 devid, int count, bool align)
 {
 	struct irq_remap_table *table;
+	int index, c, alignment = 1;
 	unsigned long flags;
-	int index, c;
 	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
 
 	if (!iommu)
@@ -3674,16 +3674,22 @@ static int alloc_irq_index(u16 devid, int count)
 	if (!table)
 		return -ENODEV;
 
+	if (align)
+		alignment = roundup_pow_of_two(count);
+
 	spin_lock_irqsave(&table->lock, flags);
 
 	/* Scan table for free entries */
-	for (c = 0, index = table->min_index;
+	for (index = ALIGN(table->min_index, alignment), c = 0;
 	     index < MAX_IRQS_PER_TABLE;
-	     ++index) {
-		if (!iommu->irte_ops->is_allocated(table, index))
+	     index++) {
+		if (!iommu->irte_ops->is_allocated(table, index)) {
 			c += 1;
-		else
-			c = 0;
+		} else {
+			c     = 0;
+			index = ALIGN(index, alignment);
+			continue;
+		}
 
 		if (c == count)	{
 			for (; c != 0; --c)
@@ -4096,7 +4102,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		else
 			ret = -ENOMEM;
 	} else {
-		index = alloc_irq_index(devid, nr_irqs);
+		index = alloc_irq_index(devid, nr_irqs, false);
 	}
 	if (index < 0) {
 		pr_warn("Failed to allocate IRTE\n");
-- 
2.7.4
