From: Bharat Bhushan <r65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 5/9 v2] pci/msi: interface to set an iova for a msi region
Date: Tue, 19 Nov 2013 10:47:09 +0530
Message-ID: <1384838233-24847-6-git-send-email-Bharat.Bhushan@freescale.com>
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

This patch defines an interface by which a msi page
can be mapped to a specific iova page.

This is a requirement in aperture type of IOMMUs (like Freescale PAMU),
where we map msi iova page just after guest memory iova address.

Signed-off-by: Bharat Bhushan <bharat.bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
v2
 - new patch

 drivers/pci/msi.c   |   13 +++++++++++++
 include/linux/pci.h |    8 ++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 2643a29..040609f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -77,6 +77,19 @@ int __weak arch_msi_get_region(int region_num, struct msi_region *region)
 	return 0;
 }
 
+int __weak arch_msi_set_iova(struct pci_dev *pdev, int region_num,
+			     dma_addr_t iova, bool set)
+{
+	return 0;
+}
+
+int msi_set_iova(struct pci_dev *pdev, int region_num,
+		 dma_addr_t iova, bool set)
+{
+	return arch_msi_set_iova(pdev, region_num, iova, set);
+}
+EXPORT_SYMBOL(msi_set_iova);
+
 int msi_get_region_count(void)
 {
 	return arch_msi_get_region_count();
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c587034..c6d3e58 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1195,6 +1195,12 @@ static inline int msi_get_region(int region_num, struct msi_region *region)
 {
 	return 0;
 }
+
+static inline int msi_set_iova(struct pci_dev *pdev, int region_num,
+			       dma_addr_t iova, bool set)
+{
+	return 0;
+}
 #else
 int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec);
 int pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int *maxvec);
@@ -1209,6 +1215,8 @@ void pci_restore_msi_state(struct pci_dev *dev);
 int pci_msi_enabled(void);
 int msi_get_region_count(void);
 int msi_get_region(int region_num, struct msi_region *region);
+int msi_set_iova(struct pci_dev *pdev, int region_num,
+		 dma_addr_t iova, bool set);
 #endif
 
 #ifdef CONFIG_PCIEPORTBUS
-- 
1.7.0.4
