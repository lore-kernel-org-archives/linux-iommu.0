From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 2/2] iommu/fsl: Enable default DMA window for PCIe devices
	once detached
Date: Wed, 9 Oct 2013 23:56:34 +0530
Message-ID: <1381343194-24059-2-git-send-email-Varun.Sethi@freescale.com>
References: <1381343194-24059-1-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1381343194-24059-1-git-send-email-Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlbs2ve5o0e2fw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Once the PCIe device assigned to a guest VM (via VFIO) gets detached from the iommu domain
(when guest terminates), its PAMU table entry is disabled. So, this would prevent the device
from being used once it's assigned back to the host.

This patch allows for creation of a default DMA window corresponding to the device
and subsequently enabling the PAMU table entry. Before we enable the entry, we ensure that
the device's bus master capability is disabled (device quiesced).  

Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/fsl_pamu.c        |   43 +++++++++++++++++++++++++++++++--------
 drivers/iommu/fsl_pamu.h        |    1 +
 drivers/iommu/fsl_pamu_domain.c |   35 +++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index cba0498..fb4a031 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -225,6 +225,21 @@ static struct paace *pamu_get_spaace(struct paace *paace, u32 wnum)
 	return spaace;
 }
 
+/*
+ * Defaul PPAACE settings for an LIODN.
+ */
+static void setup_default_ppaace(struct paace *ppaace)
+{
+	pamu_init_ppaace(ppaace);
+	/* window size is 2^(WSE+1) bytes */
+	set_bf(ppaace->addr_bitfields, PPAACE_AF_WSE, 35);
+	ppaace->wbah = 0;
+	set_bf(ppaace->addr_bitfields, PPAACE_AF_WBAL, 0);
+	set_bf(ppaace->impl_attr, PAACE_IA_ATM,
+		PAACE_ATM_NO_XLATE);
+	set_bf(ppaace->addr_bitfields, PAACE_AF_AP,
+		PAACE_AP_PERMS_ALL);
+}
 /**
  * pamu_get_fspi_and_allocate() - Allocates fspi index and reserves subwindows
  *                                required for primary PAACE in the secondary
@@ -253,6 +268,24 @@ static unsigned long pamu_get_fspi_and_allocate(u32 subwin_cnt)
 	return (spaace_addr - (unsigned long)spaact) / (sizeof(struct paace));
 }
 
+/* Reset the PAACE entry to the default state */
+void enable_default_dma_window(int liodn)
+{
+	struct paace *ppaace;
+
+	ppaace = pamu_get_ppaace(liodn);
+	if (!ppaace) {
+		pr_debug("Invalid liodn entry\n");
+		return;
+	}
+
+	memset(ppaace, 0, sizeof(struct paace));
+
+	setup_default_ppaace(ppaace);
+	mb();
+	pamu_enable_liodn(liodn);
+}
+
 /* Release the subwindows reserved for a particular LIODN */
 void pamu_free_subwins(int liodn)
 {
@@ -752,15 +785,7 @@ static void __init setup_liodns(void)
 				continue;
 			}
 			ppaace = pamu_get_ppaace(liodn);
-			pamu_init_ppaace(ppaace);
-			/* window size is 2^(WSE+1) bytes */
-			set_bf(ppaace->addr_bitfields, PPAACE_AF_WSE, 35);
-			ppaace->wbah = 0;
-			set_bf(ppaace->addr_bitfields, PPAACE_AF_WBAL, 0);
-			set_bf(ppaace->impl_attr, PAACE_IA_ATM,
-				PAACE_ATM_NO_XLATE);
-			set_bf(ppaace->addr_bitfields, PAACE_AF_AP,
-				PAACE_AP_PERMS_ALL);
+			setup_default_ppaace(ppaace);
 			if (of_device_is_compatible(node, "fsl,qman-portal"))
 				setup_qbman_paace(ppaace, QMAN_PORTAL_PAACE);
 			if (of_device_is_compatible(node, "fsl,qman"))
diff --git a/drivers/iommu/fsl_pamu.h b/drivers/iommu/fsl_pamu.h
index 8fc1a12..0edcbbbb 100644
--- a/drivers/iommu/fsl_pamu.h
+++ b/drivers/iommu/fsl_pamu.h
@@ -406,5 +406,6 @@ void get_ome_index(u32 *omi_index, struct device *dev);
 int  pamu_update_paace_stash(int liodn, u32 subwin, u32 value);
 int pamu_disable_spaace(int liodn, u32 subwin);
 u32 pamu_get_max_subwin_cnt(void);
+void enable_default_dma_window(int liodn);
 
 #endif  /* __FSL_PAMU_H */
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index e02e1de..553ef3c 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -340,6 +340,40 @@ static inline struct device_domain_info *find_domain(struct device *dev)
 	return dev->archdata.iommu_domain;
 }
 
+/* Disable device DMA capability and enable default DMA window */
+static void disable_device_dma(struct device_domain_info *info)
+{
+	struct device_domain_info *tmp;
+	int enable_dma_window = 1;
+
+#ifdef CONFIG_PCI
+	if (info->dev->bus == &pci_bus_type) {
+		struct pci_dev *pdev = NULL;
+		pdev = to_pci_dev(info->dev);
+		if (pci_is_enabled(pdev))
+			pci_disable_device(pdev);
+	}
+#endif
+	/*
+	 * Sanity check, to ensure that this is not a
+	 * shared LIODN. In case of a PCIe controller
+	 * it's possible that all PCIe devices share
+	 * the same LIODN. We can't enable the default
+	 * DMA window till all the devices have been
+	 * quiesced (for PCIe devices, we explicitly
+	 * disable the bus master capability).
+	 */
+	list_for_each_entry(tmp, &info->domain->devices, link) {
+		if (info->dev->iommu_group == tmp->dev->iommu_group) {
+			enable_dma_window = 0;
+			break;
+		}
+	}
+
+	if (enable_dma_window)
+		enable_default_dma_window(info->liodn);
+}
+
 static void remove_device_ref(struct device_domain_info *info, u32 win_cnt)
 {
 	unsigned long flags;
@@ -351,6 +385,7 @@ static void remove_device_ref(struct device_domain_info *info, u32 win_cnt)
 	pamu_disable_liodn(info->liodn);
 	spin_unlock_irqrestore(&iommu_lock, flags);
 	spin_lock_irqsave(&device_domain_lock, flags);
+	disable_device_dma(info);
 	info->dev->archdata.iommu_domain = NULL;
 	kmem_cache_free(iommu_devinfo_cache, info);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
-- 
1.7.9.5
