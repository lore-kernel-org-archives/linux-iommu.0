From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/4] iommu/vt-d: Clean up unused variable in find_or_alloc_domain
Date: Fri,  4 May 2018 13:08:17 +0800
Message-ID: <1525410499-18632-3-git-send-email-baolu.lu@linux.intel.com>
References: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Remove it to make the code more concise.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 749d8f2..9064607 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2533,7 +2533,7 @@ static struct dmar_domain *find_or_alloc_domain(struct device *dev, int gaw)
 	struct device_domain_info *info = NULL;
 	struct dmar_domain *domain = NULL;
 	struct intel_iommu *iommu;
-	u16 req_id, dma_alias;
+	u16 dma_alias;
 	unsigned long flags;
 	u8 bus, devfn;
 
@@ -2541,8 +2541,6 @@ static struct dmar_domain *find_or_alloc_domain(struct device *dev, int gaw)
 	if (!iommu)
 		return NULL;
 
-	req_id = ((u16)bus << 8) | devfn;
-
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
 
-- 
2.7.4
