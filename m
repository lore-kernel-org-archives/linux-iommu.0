From: Bharat Bhushan <r65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 1/9 v2] pci:msi: add weak function for returning msi region
	info
Date: Tue, 19 Nov 2013 10:47:05 +0530
Message-ID: <1384838233-24847-2-git-send-email-Bharat.Bhushan@freescale.com>
References: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1384838233-24847-1-git-send-email-Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

In Aperture type of IOMMU (like FSL PAMU), VFIO-iommu system need to know
the MSI region to map its window in h/w. This patch just defines the
required weak functions only and will be used by followup patches.

Signed-off-by: Bharat Bhushan <bharat.bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
v1->v2
 - Added description on "struct msi_region" 

 drivers/pci/msi.c   |   22 ++++++++++++++++++++++
 include/linux/msi.h |   14 ++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d5f90d6..2643a29 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -67,6 +67,28 @@ int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
 	return chip->check_device(chip, dev, nvec, type);
 }
 
+int __weak arch_msi_get_region_count(void)
+{
+	return 0;
+}
+
+int __weak arch_msi_get_region(int region_num, struct msi_region *region)
+{
+	return 0;
+}
+
+int msi_get_region_count(void)
+{
+	return arch_msi_get_region_count();
+}
+EXPORT_SYMBOL(msi_get_region_count);
+
+int msi_get_region(int region_num, struct msi_region *region)
+{
+	return arch_msi_get_region(region_num, region);
+}
+EXPORT_SYMBOL(msi_get_region);
+
 int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	struct msi_desc *entry;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index b17ead8..ade1480 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -51,6 +51,18 @@ struct msi_desc {
 };
 
 /*
+ * This structure is used to get
+ * - physical address
+ * - size
+ * of a msi region
+ */
+struct msi_region {
+	int region_num; /* MSI region number */
+	dma_addr_t addr; /* Address of MSI region */
+	size_t size; /* Size of MSI region */
+};
+
+/*
  * The arch hooks to setup up msi irqs. Those functions are
  * implemented as weak symbols so that they /can/ be overriden by
  * architecture specific code if needed.
@@ -64,6 +76,8 @@ void arch_restore_msi_irqs(struct pci_dev *dev, int irq);
 
 void default_teardown_msi_irqs(struct pci_dev *dev);
 void default_restore_msi_irqs(struct pci_dev *dev, int irq);
+int arch_msi_get_region_count(void);
+int arch_msi_get_region(int region_num, struct msi_region *region);
 
 struct msi_chip {
 	struct module *owner;
-- 
1.7.0.4
