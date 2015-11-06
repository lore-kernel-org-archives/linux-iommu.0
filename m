From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [Patch v2 4/9] iommu/amd: add copy_irq_table function
Date: Fri,  6 Nov 2015 20:10:46 +0800
Message-ID: <1446811851-20623-5-git-send-email-bhe@redhat.com>
References: <1446811851-20623-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1446811851-20623-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Here old irq tables are ioremapped and not iounmapped for now. Maybe it
can be adjusted later to use a better way. 

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c  | 30 ++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_types.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 6ef86b1..e84817e 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -673,6 +673,36 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
 	iommu_feature_enable(iommu, CONTROL_GT_EN);
 }
 
+static void copy_irq_table(u16 devid)
+{
+	struct irq_remap_table *table = NULL;
+	u16 alias;
+	u64 dte;
+	u64 old_intr_virt;
+
+	alias = amd_iommu_alias_table[devid];
+	table = irq_lookup_table[alias];
+	if (table) {
+	        irq_lookup_table[devid] = table;
+	        return;
+	}
+	dte     = amd_iommu_dev_table[devid].data[2];
+	dte &= DTE_IRQ_PHYS_ADDR_MASK;
+	if(!dte)
+	        return;
+
+	table = kzalloc(sizeof(*table), GFP_ATOMIC);
+	if (!table){
+	        pr_warn("AMD-Vi: amd irq table allocation failed\n");
+	        return;   
+	}
+	dte &= DTE_IRQ_PHYS_ADDR_MASK;
+	old_intr_virt = ioremap_cache(dte, MAX_IRQS_PER_TABLE * sizeof(u32));
+	table->table = old_intr_virt;
+	//table->table = dte;
+	irq_lookup_table[devid] = table;
+}
+
 /* sets a specific bit in the device table entry. */
 static void set_dev_entry_bit(u16 devid, u8 bit)
 {
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 6a0bf1a..80ccc28 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -129,6 +129,7 @@
 #define EVENT_DOMID_SHIFT	0
 #define EVENT_FLAGS_MASK	0xfff
 #define EVENT_FLAGS_SHIFT	0x10
+#define DTE_IRQ_PHYS_ADDR_MASK (((1ULL << 45)-1) << 6)
 
 /* feature control bits */
 #define CONTROL_IOMMU_EN        0x00ULL
-- 
2.4.0
