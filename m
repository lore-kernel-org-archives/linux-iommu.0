From: Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2] iommu/amd: Avoid locking get_irq_table() from atomic
	context
Date: Wed, 14 Feb 2018 17:36:28 -0600
Message-ID: <20180214233628.29560-1-swood@redhat.com>
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
Cc: "Luis Claudio R. Goncalves" <lgoncalv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Clark Williams <williams-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

get_irq_table() previously acquired amd_iommu_devtable_lock which is not
a raw lock, and thus cannot be acquired from atomic context on
PREEMPT_RT.  Many calls to modify_irte*() come from atomic context due to
the IRQ desc->lock, as does amd_iommu_update_ga() due to the preemption
disabling in vcpu_load/put().

The only difference between calling get_irq_table() and reading from
irq_lookup_table[] directly, other than the lock acquisition and
amd_iommu_rlookup_table[] check, is if the table entry is unpopulated,
which should never happen when looking up a devid that came from an
irq_2_irte struct, as get_irq_table() would have already been called on
that devid during irq_remapping_alloc().

The lock acquisition is not needed in these cases because entries in
irq_lookup_table[] never change once non-NULL -- nor would the
amd_iommu_devtable_lock usage in get_irq_table() provide meaningful
protection if they did, since it's released before using the looked up
table in the get_irq_table() caller.

Rename the old get_irq_table() to alloc_irq_table(), and create a new
lockless get_irq_table() to be used in non-allocating contexts that WARNs
if it doesn't find what it's looking for.

Signed-off-by: Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
v2: Added new get_irq_table() with WARNs rather than accessing
irq_lookup_table[] directly.
---
 drivers/iommu/amd_iommu.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index e4026133aa1d..5d41e0733cb3 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3594,7 +3594,22 @@ static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
 	amd_iommu_dev_table[devid].data[2] = dte;
 }
 
-static struct irq_remap_table *get_irq_table(u16 devid, bool ioapic)
+static struct irq_remap_table *get_irq_table(u16 devid)
+{
+	struct irq_remap_table *table;
+
+	if (WARN_ONCE(!amd_iommu_rlookup_table[devid],
+		      "%s: no iommu for devid %x\n", __func__, devid))
+		return NULL;
+
+	table = irq_lookup_table[devid];
+	if (WARN_ONCE(!table, "%s: no table for devid %x\n", __func__, devid))
+		return NULL;
+
+	return table;
+}
+
+static struct irq_remap_table *alloc_irq_table(u16 devid, bool ioapic)
 {
 	struct irq_remap_table *table = NULL;
 	struct amd_iommu *iommu;
@@ -3681,7 +3696,7 @@ static int alloc_irq_index(u16 devid, int count, bool align)
 	if (!iommu)
 		return -ENODEV;
 
-	table = get_irq_table(devid, false);
+	table = alloc_irq_table(devid, false);
 	if (!table)
 		return -ENODEV;
 
@@ -3732,7 +3747,7 @@ static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
 	if (iommu == NULL)
 		return -EINVAL;
 
-	table = get_irq_table(devid, false);
+	table = get_irq_table(devid);
 	if (!table)
 		return -ENOMEM;
 
@@ -3765,7 +3780,7 @@ static int modify_irte(u16 devid, int index, union irte *irte)
 	if (iommu == NULL)
 		return -EINVAL;
 
-	table = get_irq_table(devid, false);
+	table = get_irq_table(devid);
 	if (!table)
 		return -ENOMEM;
 
@@ -3789,7 +3804,7 @@ static void free_irte(u16 devid, int index)
 	if (iommu == NULL)
 		return;
 
-	table = get_irq_table(devid, false);
+	table = get_irq_table(devid);
 	if (!table)
 		return;
 
@@ -4107,7 +4122,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		return ret;
 
 	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
-		if (get_irq_table(devid, true))
+		if (alloc_irq_table(devid, true))
 			index = info->ioapic_pin;
 		else
 			ret = -ENOMEM;
@@ -4390,7 +4405,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 	if (!iommu)
 		return -ENODEV;
 
-	irt = get_irq_table(devid, false);
+	irt = get_irq_table(devid);
 	if (!irt)
 		return -ENODEV;
 
-- 
2.14.3
