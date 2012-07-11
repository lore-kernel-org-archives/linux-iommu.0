From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 21/27] iommu/amd: Implement MSI routines for interrupt
	remapping
Date: Wed, 11 Jul 2012 15:39:06 +0200
Message-ID: <1342013952-10174-22-git-send-email-joerg.roedel@amd.com>
References: <1342013952-10174-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1342013952-10174-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
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

Add routines to setup interrupt remapping for MSI
interrupts.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c |   74 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 713f84c..9a24a1b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -4054,4 +4054,78 @@ static int free_irq(int irq)
 	return 0;
 }
 
+static void compose_msi_msg(struct pci_dev *pdev,
+			    unsigned int irq, unsigned int dest,
+			    struct msi_msg *msg, u8 hpet_id)
+{
+	struct irq_2_irte *irte_info;
+	struct irq_cfg *cfg;
+	union irte irte;
+
+	cfg = irq_get_chip_data(irq);
+	if (!cfg)
+		return;
+
+	irte_info = &cfg->irq_remap_info.irq_2_irte;
+
+	irte.val		= 0;
+	irte.fields.vector	= cfg->vector;
+	irte.fields.int_type    = apic->irq_delivery_mode;
+	irte.fields.destination	= dest;
+	irte.fields.dm		= apic->irq_dest_mode;
+	irte.fields.valid	= 1;
+
+	modify_irte(irte_info->devid, irte_info->index, irte);
+
+	msg->address_hi = MSI_ADDR_BASE_HI;
+	msg->address_lo = MSI_ADDR_BASE_LO;
+	msg->data       = irte_info->index;
+}
+
+static int msi_alloc_irq(struct pci_dev *pdev, int irq, int nvec)
+{
+	struct irq_cfg *cfg;
+	int index;
+	u16 devid;
+
+	if (!pdev)
+		return -EINVAL;
+
+	cfg = irq_get_chip_data(irq);
+	if (!cfg)
+		return -EINVAL;
+
+	devid = get_device_id(&pdev->dev);
+	index = alloc_irq_index(cfg, devid, nvec);
+
+	return index < 0 ? MAX_IRQS_PER_TABLE : index;
+}
+
+static int msi_setup_irq(struct pci_dev *pdev, unsigned int irq,
+			 int index, int offset)
+{
+	struct irq_2_irte *irte_info;
+	struct irq_cfg *cfg;
+	u16 devid;
+
+	if (!pdev)
+		return -EINVAL;
+
+	cfg = irq_get_chip_data(irq);
+	if (!cfg)
+		return -EINVAL;
+
+	if (index >= MAX_IRQS_PER_TABLE)
+		return 0;
+
+	devid		= get_device_id(&pdev->dev);
+	irte_info	= &cfg->irq_remap_info.irq_2_irte;
+
+	irte_info->devid = devid;
+	irte_info->index = index + offset;
+	cfg->remapped    = true;
+
+	return 0;
+}
+
 #endif
-- 
1.7.9.5
