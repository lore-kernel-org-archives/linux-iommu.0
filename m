From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v1 5/7] iommu/vt-d: Remove unused dmar_remove_one_dev_info()
 argument
Date: Fri, 08 Feb 2019 16:06:15 -0600
Message-ID: <154966357527.132359.18243836332587849601.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Bjorn Helgaas <bhelgaas@google.com>

domain_remove_dev_info() takes a struct dmar_domain * argument, but doesn't
use it.  Remove it.  No functional change intended.

The last use of this argument was removed by 127c761598f7 ("iommu/vt-d:
Pass device_domain_info to __dmar_remove_one_dev_info").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/intel-iommu.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2acd08c82cdc..6e9f277bfd6d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -343,8 +343,7 @@ static int g_num_of_iommus;
 
 static void domain_exit(struct dmar_domain *domain);
 static void domain_remove_dev_info(struct dmar_domain *domain);
-static void dmar_remove_one_dev_info(struct dmar_domain *domain,
-				     struct device *dev);
+static void dmar_remove_one_dev_info(struct device *dev);
 static void __dmar_remove_one_dev_info(struct device_domain_info *info);
 static void domain_context_clear(struct intel_iommu *iommu,
 				 struct device *dev);
@@ -2546,7 +2545,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		ret = intel_pasid_alloc_table(dev);
 		if (ret) {
 			dev_err(dev, "PASID table allocation failed\n");
-			dmar_remove_one_dev_info(domain, dev);
+			dmar_remove_one_dev_info(dev);
 			return NULL;
 		}
 
@@ -2561,14 +2560,14 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		spin_unlock(&iommu->lock);
 		if (ret) {
 			dev_err(dev, "Setup RID2PASID failed\n");
-			dmar_remove_one_dev_info(domain, dev);
+			dmar_remove_one_dev_info(dev);
 			return NULL;
 		}
 	}
 
 	if (dev && domain_context_mapping(domain, dev)) {
 		dev_err(dev, "Domain context map failed\n");
-		dmar_remove_one_dev_info(domain, dev);
+		dmar_remove_one_dev_info(dev);
 		return NULL;
 	}
 
@@ -3621,7 +3620,7 @@ static int iommu_no_mapping(struct device *dev)
 			 * 32 bit DMA is removed from si_domain and fall back
 			 * to non-identity mapping.
 			 */
-			dmar_remove_one_dev_info(si_domain, dev);
+			dmar_remove_one_dev_info(dev);
 			dev_info(dev, "32bit DMA uses non-identity mapping\n");
 			return 0;
 		}
@@ -4567,7 +4566,7 @@ static int device_notifier(struct notifier_block *nb,
 	if (!domain)
 		return 0;
 
-	dmar_remove_one_dev_info(domain, dev);
+	dmar_remove_one_dev_info(dev);
 	if (!domain_type_is_vm_or_si(domain) && list_empty(&domain->devices))
 		domain_exit(domain);
 
@@ -4980,8 +4979,7 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	free_devinfo_mem(info);
 }
 
-static void dmar_remove_one_dev_info(struct dmar_domain *domain,
-				     struct device *dev)
+static void dmar_remove_one_dev_info(struct device *dev)
 {
 	struct device_domain_info *info;
 	unsigned long flags;
@@ -5070,7 +5068,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 		old_domain = find_domain(dev);
 		if (old_domain) {
 			rcu_read_lock();
-			dmar_remove_one_dev_info(old_domain, dev);
+			dmar_remove_one_dev_info(dev);
 			rcu_read_unlock();
 
 			if (!domain_type_is_vm_or_si(old_domain) &&
@@ -5117,7 +5115,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 static void intel_iommu_detach_device(struct iommu_domain *domain,
 				      struct device *dev)
 {
-	dmar_remove_one_dev_info(to_dmar_domain(domain), dev);
+	dmar_remove_one_dev_info(dev);
 }
 
 static int intel_iommu_map(struct iommu_domain *domain,
