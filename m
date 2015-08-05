From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 16/26] iommu/vt-d: Rename domain_remove_one_dev_info()
Date: Wed,  5 Aug 2015 17:18:47 +0200
Message-ID: <1438787937-7340-17-git-send-email-joro@8bytes.org>
References: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438787937-7340-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Rename the function to dmar_remove_one_dev_info to match is
name better with its dmar_insert_one_dev_info counterpart.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 8e87208..e033bb0 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -470,8 +470,8 @@ static long list_size;
 
 static void domain_exit(struct dmar_domain *domain);
 static void domain_remove_dev_info(struct dmar_domain *domain);
-static void domain_remove_one_dev_info(struct dmar_domain *domain,
-				       struct device *dev);
+static void dmar_remove_one_dev_info(struct dmar_domain *domain,
+				     struct device *dev);
 static void iommu_detach_dependent_devices(struct intel_iommu *iommu,
 					   struct device *dev);
 static int domain_detach_iommu(struct dmar_domain *domain,
@@ -1629,7 +1629,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 
 		domain = info->domain;
 
-		domain_remove_one_dev_info(domain, info->dev);
+		dmar_remove_one_dev_info(domain, info->dev);
 
 		if (!domain_type_is_vm_or_si(domain))
 			domain_exit(domain);
@@ -2253,7 +2253,7 @@ static void domain_remove_dev_info(struct dmar_domain *domain)
 	struct device_domain_info *info, *tmp;
 
 	list_for_each_entry_safe(info, tmp, &domain->devices, link)
-		domain_remove_one_dev_info(domain, info->dev);
+		dmar_remove_one_dev_info(domain, info->dev);
 }
 
 /*
@@ -2327,7 +2327,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 
 	if (dev && domain_context_mapping(domain, dev)) {
 		pr_err("Domain context map for %s failed\n", dev_name(dev));
-		domain_remove_one_dev_info(domain, dev);
+		dmar_remove_one_dev_info(domain, dev);
 		return NULL;
 	}
 
@@ -3298,7 +3298,7 @@ static int iommu_no_mapping(struct device *dev)
 			 * 32 bit DMA is removed from si_domain and fall back
 			 * to non-identity mapping.
 			 */
-			domain_remove_one_dev_info(si_domain, dev);
+			dmar_remove_one_dev_info(si_domain, dev);
 			pr_info("32bit %s uses non-identity mapping\n",
 				dev_name(dev));
 			return 0;
@@ -4305,7 +4305,7 @@ static int device_notifier(struct notifier_block *nb,
 		return 0;
 
 	down_read(&dmar_global_lock);
-	domain_remove_one_dev_info(domain, dev);
+	dmar_remove_one_dev_info(domain, dev);
 	if (!domain_type_is_vm_or_si(domain) && list_empty(&domain->devices))
 		domain_exit(domain);
 	up_read(&dmar_global_lock);
@@ -4551,8 +4551,8 @@ static void iommu_detach_dependent_devices(struct intel_iommu *iommu,
 	pci_for_each_dma_alias(to_pci_dev(dev), &iommu_detach_dev_cb, iommu);
 }
 
-static void domain_remove_one_dev_info(struct dmar_domain *domain,
-				       struct device *dev)
+static void dmar_remove_one_dev_info(struct dmar_domain *domain,
+				     struct device *dev)
 {
 	struct device_domain_info *info;
 	struct intel_iommu *iommu;
@@ -4663,7 +4663,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 		old_domain = find_domain(dev);
 		if (old_domain) {
 			if (domain_type_is_vm_or_si(dmar_domain))
-				domain_remove_one_dev_info(old_domain, dev);
+				dmar_remove_one_dev_info(old_domain, dev);
 			else
 				domain_remove_dev_info(old_domain);
 
@@ -4711,7 +4711,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 static void intel_iommu_detach_device(struct iommu_domain *domain,
 				      struct device *dev)
 {
-	domain_remove_one_dev_info(to_dmar_domain(domain), dev);
+	dmar_remove_one_dev_info(to_dmar_domain(domain), dev);
 }
 
 static int intel_iommu_map(struct iommu_domain *domain,
-- 
1.9.1
