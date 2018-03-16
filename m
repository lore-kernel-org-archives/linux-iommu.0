From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 08/10] iommu/amd: factor out setting the remap table for a
	devid
Date: Fri, 16 Mar 2018 21:18:34 +0100
Message-ID: <20180316201836.7864-9-bigeasy@linutronix.de>
References: <20180316201836.7864-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180316201836.7864-1-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Setting the IRQ remap table for a specific devid (or its alias devid)
includes three steps. Those three steps are always repeated each time
this is done.
Introduce a new helper function, move those steps there and use that
function instead. The compiler can still decide if it is worth to
inline.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 6ee8ef22ad51..7dd4c27a941d 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3602,6 +3602,14 @@ static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
 	amd_iommu_dev_table[devid].data[2] = dte;
 }
 
+static void set_remap_table_entry(struct amd_iommu *iommu, u16 devid,
+				  struct irq_remap_table *table)
+{
+	irq_lookup_table[devid] = table;
+	set_dte_irq_entry(devid, table);
+	iommu_flush_dte(iommu, devid);
+}
+
 static struct irq_remap_table *get_irq_table(u16 devid)
 {
 	struct irq_remap_table *table = NULL;
@@ -3622,9 +3630,7 @@ static struct irq_remap_table *get_irq_table(u16 devid)
 	alias = amd_iommu_alias_table[devid];
 	table = irq_lookup_table[alias];
 	if (table) {
-		irq_lookup_table[devid] = table;
-		set_dte_irq_entry(devid, table);
-		iommu_flush_dte(iommu, devid);
+		set_remap_table_entry(iommu, devid, table);
 		goto out;
 	}
 
@@ -3651,14 +3657,9 @@ static struct irq_remap_table *get_irq_table(u16 devid)
 		       (MAX_IRQS_PER_TABLE * (sizeof(u64) * 2)));
 
 
-	irq_lookup_table[devid] = table;
-	set_dte_irq_entry(devid, table);
-	iommu_flush_dte(iommu, devid);
-	if (devid != alias) {
-		irq_lookup_table[alias] = table;
-		set_dte_irq_entry(alias, table);
-		iommu_flush_dte(iommu, alias);
-	}
+	set_remap_table_entry(iommu, devid, table);
+	if (devid != alias)
+		set_remap_table_entry(iommu, alias, table);
 
 out:
 	iommu_completion_wait(iommu);
-- 
2.16.2
