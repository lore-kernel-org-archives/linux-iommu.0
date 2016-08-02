From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v12 08/11] irqchip/gicv3-its: Register the MSI global doorbell
Date: Tue,  2 Aug 2016 17:23:34 +0000
Message-ID: <1470158617-7022-9-git-send-email-eric.auger@redhat.com>
References: <1470158617-7022-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1470158617-7022-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dennis.chen-5wv7dgnIgG8@public.gmane.org, robert.richter-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch adds the registration of the MSI global doorbell in
gicv3-its driver plus the implementation for irq_chip
irq_get_msi_doorbell_info ops.

This will allow the msi layer to iommu_map this doorbell when
requested.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---

v11 -> v12:
- use new irq_get_msi_doorbell_info name
- simplify error handling

v10 -> v11:
- adapt to new doorbell registration API and implement msi_doorbell_info
---
 drivers/irqchip/irq-gic-v3-its.c | 67 ++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5eb1f9e..9543aac 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -29,6 +29,8 @@
 #include <linux/of_platform.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
+#include <linux/iommu.h>
+#include <linux/msi-doorbell.h>
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-v3.h>
@@ -71,19 +73,20 @@ struct its_baser {
  * list of devices writing to it.
  */
 struct its_node {
-	raw_spinlock_t		lock;
-	struct list_head	entry;
-	void __iomem		*base;
-	unsigned long		phys_base;
-	struct its_cmd_block	*cmd_base;
-	struct its_cmd_block	*cmd_write;
-	struct its_baser	tables[GITS_BASER_NR_REGS];
-	struct its_collection	*collections;
-	struct list_head	its_device_list;
-	u64			flags;
-	u32			ite_size;
-	u32			device_ids;
-	int			numa_node;
+	raw_spinlock_t			lock;
+	struct list_head		entry;
+	void __iomem			*base;
+	unsigned long			phys_base;
+	struct its_cmd_block		*cmd_base;
+	struct its_cmd_block		*cmd_write;
+	struct its_baser		tables[GITS_BASER_NR_REGS];
+	struct its_collection		*collections;
+	struct list_head		its_device_list;
+	u64				flags;
+	u32				ite_size;
+	u32				device_ids;
+	int				numa_node;
+	struct msi_doorbell_info	*doorbell_info;
 };
 
 #define ITS_ITT_ALIGN		SZ_256
@@ -656,13 +659,24 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 	msg->data		= its_get_event_id(d);
 }
 
+static struct msi_doorbell_info *
+its_irq_get_msi_doorbell_info(struct irq_data *d)
+{
+	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+	struct its_node *its = its_dev->its;
+
+	return its->doorbell_info;
+}
+
+
 static struct irq_chip its_irq_chip = {
-	.name			= "ITS",
-	.irq_mask		= its_mask_irq,
-	.irq_unmask		= its_unmask_irq,
-	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_set_affinity	= its_set_affinity,
-	.irq_compose_msi_msg	= its_irq_compose_msi_msg,
+	.name				= "ITS",
+	.irq_mask			= its_mask_irq,
+	.irq_unmask			= its_unmask_irq,
+	.irq_eoi			= irq_chip_eoi_parent,
+	.irq_set_affinity		= its_set_affinity,
+	.irq_compose_msi_msg		= its_irq_compose_msi_msg,
+	.irq_get_msi_doorbell_info	= its_irq_get_msi_doorbell_info,
 };
 
 /*
@@ -1607,6 +1621,7 @@ static int __init its_probe(struct device_node *node,
 
 	if (of_property_read_bool(node, "msi-controller")) {
 		struct msi_domain_info *info;
+		phys_addr_t translater;
 
 		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info) {
@@ -1614,10 +1629,24 @@ static int __init its_probe(struct device_node *node,
 			goto out_free_tables;
 		}
 
+		translater = its->phys_base + GITS_TRANSLATER;
+		its->doorbell_info =
+			msi_doorbell_register_global(translater, sizeof(u32),
+						     IOMMU_WRITE | IOMMU_MMIO,
+						     true);
+
+		if (!its->doorbell_info)  {
+			err = -ENOMEM;
+			kfree(info);
+			goto out_free_tables;
+		}
+
+
 		inner_domain = irq_domain_add_tree(node, &its_domain_ops, its);
 		if (!inner_domain) {
 			err = -ENOMEM;
 			kfree(info);
+			msi_doorbell_unregister_global(its->doorbell_info);
 			goto out_free_tables;
 		}
 
-- 
1.9.1
