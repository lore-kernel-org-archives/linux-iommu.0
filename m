From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 24/26] iommu/vt-d: Pass device_domain_info to __dmar_remove_one_dev_info
Date: Wed,  5 Aug 2015 17:18:55 +0200
Message-ID: <1438787937-7340-25-git-send-email-joro@8bytes.org>
References: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

This struct contains all necessary information for the
function already. Also handle the info->dev == NULL case
while at it.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 624e0a2..31efb9c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -471,10 +471,9 @@ static void domain_exit(struct dmar_domain *domain);
 static void domain_remove_dev_info(struct dmar_domain *domain);
 static void dmar_remove_one_dev_info(struct dmar_domain *domain,
 				     struct device *dev);
+static void __dmar_remove_one_dev_info(struct device_domain_info *info);
 static void domain_context_clear(struct intel_iommu *iommu,
 				 struct device *dev);
-static void __dmar_remove_one_dev_info(struct dmar_domain *domain,
-				       struct device *dev);
 static int domain_detach_iommu(struct dmar_domain *domain,
 			       struct intel_iommu *iommu);
 
@@ -2215,7 +2214,7 @@ static void domain_remove_dev_info(struct dmar_domain *domain)
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	list_for_each_entry_safe(info, tmp, &domain->devices, link)
-		__dmar_remove_one_dev_info(domain, info->dev);
+		__dmar_remove_one_dev_info(info);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
@@ -4516,43 +4515,41 @@ static void domain_context_clear(struct intel_iommu *iommu, struct device *dev)
 	pci_for_each_dma_alias(to_pci_dev(dev), &domain_context_clear_one_cb, iommu);
 }
 
-static void __dmar_remove_one_dev_info(struct dmar_domain *domain,
-				       struct device *dev)
+static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 {
-	struct device_domain_info *info;
 	struct intel_iommu *iommu;
 	unsigned long flags;
-	u8 bus, devfn;
 
 	assert_spin_locked(&device_domain_lock);
 
-	iommu = device_to_iommu(dev, &bus, &devfn);
-	if (!iommu)
+	if (WARN_ON(!info))
 		return;
 
-	info = dev->archdata.iommu;
+	iommu = info->iommu;
 
-	if (WARN_ON(!info))
-		return;
+	if (info->dev) {
+		iommu_disable_dev_iotlb(info);
+		domain_context_clear(iommu, info->dev);
+	}
 
 	unlink_domain_info(info);
 
-	iommu_disable_dev_iotlb(info);
-	domain_context_clear(iommu, dev);
-	free_devinfo_mem(info);
-
 	spin_lock_irqsave(&iommu->lock, flags);
-	domain_detach_iommu(domain, iommu);
+	domain_detach_iommu(info->domain, iommu);
 	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	free_devinfo_mem(info);
 }
 
 static void dmar_remove_one_dev_info(struct dmar_domain *domain,
 				     struct device *dev)
 {
+	struct device_domain_info *info;
 	unsigned long flags;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
-	__dmar_remove_one_dev_info(domain, dev);
+	info = dev->archdata.iommu;
+	__dmar_remove_one_dev_info(info);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
-- 
1.9.1
