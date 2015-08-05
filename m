From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 25/26] iommu/vt-d: Only insert alias dev_info if there is an alias
Date: Wed,  5 Aug 2015 17:18:56 +0200
Message-ID: <1438787937-7340-26-git-send-email-joro@8bytes.org>
References: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

For devices without an PCI alias there will be two
device_domain_info structures added. Prevent that by
checking if the alias is different from the device.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 31efb9c..3882072 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2318,8 +2318,8 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	struct device_domain_info *info = NULL;
 	struct dmar_domain *domain, *tmp;
 	struct intel_iommu *iommu;
+	u16 req_id, dma_alias;
 	unsigned long flags;
-	u16 dma_alias;
 	u8 bus, devfn;
 
 	domain = find_domain(dev);
@@ -2330,6 +2330,8 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	if (!iommu)
 		return NULL;
 
+	req_id = ((u16)bus << 8) | devfn;
+
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
 
@@ -2360,7 +2362,7 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	}
 
 	/* register PCI DMA alias device */
-	if (dev_is_pci(dev)) {
+	if (req_id != dma_alias && dev_is_pci(dev)) {
 		tmp = dmar_insert_one_dev_info(iommu, PCI_BUS_NUM(dma_alias),
 					       dma_alias & 0xff, NULL, domain);
 
-- 
1.9.1
