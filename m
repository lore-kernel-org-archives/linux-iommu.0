From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 27/33] iommu/vt-d: Make domain_remove_one_dev_info() take
	struct device
Date: Fri, 21 Mar 2014 17:19:08 +0000
Message-ID: <1395422354-19762-28-git-send-email-David.Woodhouse@intel.com>
References: <1395422354-19762-1-git-send-email-David.Woodhouse@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1395422354-19762-1-git-send-email-David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f3c1624..270a25b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -425,7 +425,7 @@ static long list_size;
 static void domain_exit(struct dmar_domain *domain);
 static void domain_remove_dev_info(struct dmar_domain *domain);
 static void domain_remove_one_dev_info(struct dmar_domain *domain,
-				       struct pci_dev *pdev);
+				       struct device *dev);
 static void iommu_detach_dependent_devices(struct intel_iommu *iommu,
 					   struct device *dev);
 
@@ -2488,7 +2488,7 @@ static int domain_add_dev_info(struct dmar_domain *domain,
 
 	ret = domain_context_mapping(domain, &pdev->dev, translation);
 	if (ret) {
-		domain_remove_one_dev_info(domain, pdev);
+		domain_remove_one_dev_info(domain, &pdev->dev);
 		return ret;
 	}
 
@@ -2928,7 +2928,7 @@ static int iommu_no_mapping(struct device *dev)
 			 * 32 bit DMA is removed from si_domain and fall back
 			 * to non-identity mapping.
 			 */
-			domain_remove_one_dev_info(si_domain, pdev);
+			domain_remove_one_dev_info(si_domain, dev);
 			printk(KERN_INFO "32bit %s uses non-identity mapping\n",
 			       pci_name(pdev));
 			return 0;
@@ -3810,7 +3810,6 @@ static int device_notifier(struct notifier_block *nb,
 				  unsigned long action, void *data)
 {
 	struct device *dev = data;
-	struct pci_dev *pdev = to_pci_dev(dev);
 	struct dmar_domain *domain;
 
 	if (iommu_dummy(dev))
@@ -3825,7 +3824,7 @@ static int device_notifier(struct notifier_block *nb,
 		return 0;
 
 	down_read(&dmar_global_lock);
-	domain_remove_one_dev_info(domain, pdev);
+	domain_remove_one_dev_info(domain, dev);
 	if (!(domain->flags & DOMAIN_FLAG_VIRTUAL_MACHINE) &&
 	    !(domain->flags & DOMAIN_FLAG_STATIC_IDENTITY) &&
 	    list_empty(&domain->devices))
@@ -4027,7 +4026,7 @@ static void iommu_detach_dependent_devices(struct intel_iommu *iommu,
 }
 
 static void domain_remove_one_dev_info(struct dmar_domain *domain,
-					  struct pci_dev *pdev)
+				       struct device *dev)
 {
 	struct device_domain_info *info, *tmp;
 	struct intel_iommu *iommu;
@@ -4035,21 +4034,20 @@ static void domain_remove_one_dev_info(struct dmar_domain *domain,
 	int found = 0;
 	u8 bus, devfn;
 
-	iommu = device_to_iommu(&pdev->dev, &bus, &devfn);
+	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
 		return;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	list_for_each_entry_safe(info, tmp, &domain->devices, link) {
-		if (info->iommu->segment == pci_domain_nr(pdev->bus) &&
-		    info->bus == pdev->bus->number &&
-		    info->devfn == pdev->devfn) {
+		if (info->iommu == iommu && info->bus == bus &&
+		    info->devfn == devfn) {
 			unlink_domain_info(info);
 			spin_unlock_irqrestore(&device_domain_lock, flags);
 
 			iommu_disable_dev_iotlb(info);
 			iommu_detach_dev(iommu, info->bus, info->devfn);
-			iommu_detach_dependent_devices(iommu, &pdev->dev);
+			iommu_detach_dependent_devices(iommu, dev);
 			free_devinfo_mem(info);
 
 			spin_lock_irqsave(&device_domain_lock, flags);
@@ -4165,7 +4163,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 		if (old_domain) {
 			if (dmar_domain->flags & DOMAIN_FLAG_VIRTUAL_MACHINE ||
 			    dmar_domain->flags & DOMAIN_FLAG_STATIC_IDENTITY)
-				domain_remove_one_dev_info(old_domain, pdev);
+				domain_remove_one_dev_info(old_domain, dev);
 			else
 				domain_remove_dev_info(old_domain);
 		}
@@ -4210,9 +4208,8 @@ static void intel_iommu_detach_device(struct iommu_domain *domain,
 				      struct device *dev)
 {
 	struct dmar_domain *dmar_domain = domain->priv;
-	struct pci_dev *pdev = to_pci_dev(dev);
 
-	domain_remove_one_dev_info(dmar_domain, pdev);
+	domain_remove_one_dev_info(dmar_domain, dev);
 }
 
 static int intel_iommu_map(struct iommu_domain *domain,
-- 
1.8.5.3
