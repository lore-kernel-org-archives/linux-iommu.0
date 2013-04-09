From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/9] iommu/amd: Use AMD specific data structure for irq
	remapping
Date: Tue,  9 Apr 2013 22:12:57 +0200
Message-ID: <1365538384-12426-3-git-send-email-joro@8bytes.org>
References: <1365538384-12426-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1365538384-12426-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

For compatibility reasons the irq remapping code for the AMD
IOMMU used the same per-irq data structure as the Intel
implementation. Now that support for the AMD specific data
structure is upstream we can use this one instead.

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/amd_iommu.c |   54 ++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 3b2aff0..72fa570 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3987,7 +3987,7 @@ static int alloc_irq_index(struct irq_cfg *cfg, u16 devid, int count)
 			c = 0;
 
 		if (c == count)	{
-			struct irq_2_iommu *irte_info;
+			struct irq_2_irte *irte_info;
 
 			for (; c != 0; --c)
 				table->table[index - c + 1] = IRTE_ALLOCATED;
@@ -3995,9 +3995,9 @@ static int alloc_irq_index(struct irq_cfg *cfg, u16 devid, int count)
 			index -= count - 1;
 
 			cfg->remapped	      = 1;
-			irte_info             = &cfg->irq_2_iommu;
-			irte_info->sub_handle = devid;
-			irte_info->irte_index = index;
+			irte_info             = &cfg->irq_2_irte;
+			irte_info->devid      = devid;
+			irte_info->index      = index;
 
 			goto out;
 		}
@@ -4078,7 +4078,7 @@ static int setup_ioapic_entry(int irq, struct IO_APIC_route_entry *entry,
 			      struct io_apic_irq_attr *attr)
 {
 	struct irq_remap_table *table;
-	struct irq_2_iommu *irte_info;
+	struct irq_2_irte *irte_info;
 	struct irq_cfg *cfg;
 	union irte irte;
 	int ioapic_id;
@@ -4090,7 +4090,7 @@ static int setup_ioapic_entry(int irq, struct IO_APIC_route_entry *entry,
 	if (!cfg)
 		return -EINVAL;
 
-	irte_info = &cfg->irq_2_iommu;
+	irte_info = &cfg->irq_2_irte;
 	ioapic_id = mpc_ioapic_id(attr->ioapic);
 	devid     = get_ioapic_devid(ioapic_id);
 
@@ -4105,8 +4105,8 @@ static int setup_ioapic_entry(int irq, struct IO_APIC_route_entry *entry,
 
 	/* Setup IRQ remapping info */
 	cfg->remapped	      = 1;
-	irte_info->sub_handle = devid;
-	irte_info->irte_index = index;
+	irte_info->devid      = devid;
+	irte_info->index      = index;
 
 	/* Setup IRTE for IOMMU */
 	irte.val		= 0;
@@ -4140,7 +4140,7 @@ static int setup_ioapic_entry(int irq, struct IO_APIC_route_entry *entry,
 static int set_affinity(struct irq_data *data, const struct cpumask *mask,
 			bool force)
 {
-	struct irq_2_iommu *irte_info;
+	struct irq_2_irte *irte_info;
 	unsigned int dest, irq;
 	struct irq_cfg *cfg;
 	union irte irte;
@@ -4151,12 +4151,12 @@ static int set_affinity(struct irq_data *data, const struct cpumask *mask,
 
 	cfg       = data->chip_data;
 	irq       = data->irq;
-	irte_info = &cfg->irq_2_iommu;
+	irte_info = &cfg->irq_2_irte;
 
 	if (!cpumask_intersects(mask, cpu_online_mask))
 		return -EINVAL;
 
-	if (get_irte(irte_info->sub_handle, irte_info->irte_index, &irte))
+	if (get_irte(irte_info->devid, irte_info->index, &irte))
 		return -EBUSY;
 
 	if (assign_irq_vector(irq, cfg, mask))
@@ -4172,7 +4172,7 @@ static int set_affinity(struct irq_data *data, const struct cpumask *mask,
 	irte.fields.vector      = cfg->vector;
 	irte.fields.destination = dest;
 
-	modify_irte(irte_info->sub_handle, irte_info->irte_index, irte);
+	modify_irte(irte_info->devid, irte_info->index, irte);
 
 	if (cfg->move_in_progress)
 		send_cleanup_vector(cfg);
@@ -4184,16 +4184,16 @@ static int set_affinity(struct irq_data *data, const struct cpumask *mask,
 
 static int free_irq(int irq)
 {
-	struct irq_2_iommu *irte_info;
+	struct irq_2_irte *irte_info;
 	struct irq_cfg *cfg;
 
 	cfg = irq_get_chip_data(irq);
 	if (!cfg)
 		return -EINVAL;
 
-	irte_info = &cfg->irq_2_iommu;
+	irte_info = &cfg->irq_2_irte;
 
-	free_irte(irte_info->sub_handle, irte_info->irte_index);
+	free_irte(irte_info->devid, irte_info->index);
 
 	return 0;
 }
@@ -4202,7 +4202,7 @@ static void compose_msi_msg(struct pci_dev *pdev,
 			    unsigned int irq, unsigned int dest,
 			    struct msi_msg *msg, u8 hpet_id)
 {
-	struct irq_2_iommu *irte_info;
+	struct irq_2_irte *irte_info;
 	struct irq_cfg *cfg;
 	union irte irte;
 
@@ -4210,7 +4210,7 @@ static void compose_msi_msg(struct pci_dev *pdev,
 	if (!cfg)
 		return;
 
-	irte_info = &cfg->irq_2_iommu;
+	irte_info = &cfg->irq_2_irte;
 
 	irte.val		= 0;
 	irte.fields.vector	= cfg->vector;
@@ -4219,11 +4219,11 @@ static void compose_msi_msg(struct pci_dev *pdev,
 	irte.fields.dm		= apic->irq_dest_mode;
 	irte.fields.valid	= 1;
 
-	modify_irte(irte_info->sub_handle, irte_info->irte_index, irte);
+	modify_irte(irte_info->devid, irte_info->index, irte);
 
 	msg->address_hi = MSI_ADDR_BASE_HI;
 	msg->address_lo = MSI_ADDR_BASE_LO;
-	msg->data       = irte_info->irte_index;
+	msg->data       = irte_info->index;
 }
 
 static int msi_alloc_irq(struct pci_dev *pdev, int irq, int nvec)
@@ -4248,7 +4248,7 @@ static int msi_alloc_irq(struct pci_dev *pdev, int irq, int nvec)
 static int msi_setup_irq(struct pci_dev *pdev, unsigned int irq,
 			 int index, int offset)
 {
-	struct irq_2_iommu *irte_info;
+	struct irq_2_irte *irte_info;
 	struct irq_cfg *cfg;
 	u16 devid;
 
@@ -4263,18 +4263,18 @@ static int msi_setup_irq(struct pci_dev *pdev, unsigned int irq,
 		return 0;
 
 	devid		= get_device_id(&pdev->dev);
-	irte_info	= &cfg->irq_2_iommu;
+	irte_info	= &cfg->irq_2_irte;
 
 	cfg->remapped	      = 1;
-	irte_info->sub_handle = devid;
-	irte_info->irte_index = index + offset;
+	irte_info->devid      = devid;
+	irte_info->index      = index + offset;
 
 	return 0;
 }
 
 static int setup_hpet_msi(unsigned int irq, unsigned int id)
 {
-	struct irq_2_iommu *irte_info;
+	struct irq_2_irte *irte_info;
 	struct irq_cfg *cfg;
 	int index, devid;
 
@@ -4282,7 +4282,7 @@ static int setup_hpet_msi(unsigned int irq, unsigned int id)
 	if (!cfg)
 		return -EINVAL;
 
-	irte_info = &cfg->irq_2_iommu;
+	irte_info = &cfg->irq_2_irte;
 	devid     = get_hpet_devid(id);
 	if (devid < 0)
 		return devid;
@@ -4292,8 +4292,8 @@ static int setup_hpet_msi(unsigned int irq, unsigned int id)
 		return index;
 
 	cfg->remapped	      = 1;
-	irte_info->sub_handle = devid;
-	irte_info->irte_index = index;
+	irte_info->devid      = devid;
+	irte_info->index      = index;
 
 	return 0;
 }
-- 
1.7.9.5
