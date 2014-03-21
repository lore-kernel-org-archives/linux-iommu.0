From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 22/33] iommu/vt-d: Handle RMRRs for non-PCI devices
Date: Fri, 21 Mar 2014 17:19:03 +0000
Message-ID: <1395422354-19762-23-git-send-email-David.Woodhouse@intel.com>
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

Should hopefully never happen (RMRRs are an abomination) but while we're
busy eliminating all the PCI assumptions, we might as well do it.

Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 05c5214..acb9268 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2311,14 +2311,14 @@ static int iommu_domain_identity_map(struct dmar_domain *domain,
 				  DMA_PTE_READ|DMA_PTE_WRITE);
 }
 
-static int iommu_prepare_identity_map(struct pci_dev *pdev,
+static int iommu_prepare_identity_map(struct device *dev,
 				      unsigned long long start,
 				      unsigned long long end)
 {
 	struct dmar_domain *domain;
 	int ret;
 
-	domain = get_domain_for_dev(&pdev->dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
+	domain = get_domain_for_dev(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
 	if (!domain)
 		return -ENOMEM;
 
@@ -2328,13 +2328,13 @@ static int iommu_prepare_identity_map(struct pci_dev *pdev,
 	   up to start with in si_domain */
 	if (domain == si_domain && hw_pass_through) {
 		printk("Ignoring identity map for HW passthrough device %s [0x%Lx - 0x%Lx]\n",
-		       pci_name(pdev), start, end);
+		       dev_name(dev), start, end);
 		return 0;
 	}
 
 	printk(KERN_INFO
 	       "IOMMU: Setting identity map for device %s [0x%Lx - 0x%Lx]\n",
-	       pci_name(pdev), start, end);
+	       dev_name(dev), start, end);
 	
 	if (end < start) {
 		WARN(1, "Your BIOS is broken; RMRR ends before it starts!\n"
@@ -2362,7 +2362,7 @@ static int iommu_prepare_identity_map(struct pci_dev *pdev,
 		goto error;
 
 	/* context entry init */
-	ret = domain_context_mapping(domain, &pdev->dev, CONTEXT_TT_MULTI_LEVEL);
+	ret = domain_context_mapping(domain, dev, CONTEXT_TT_MULTI_LEVEL);
 	if (ret)
 		goto error;
 
@@ -2374,12 +2374,12 @@ static int iommu_prepare_identity_map(struct pci_dev *pdev,
 }
 
 static inline int iommu_prepare_rmrr_dev(struct dmar_rmrr_unit *rmrr,
-	struct pci_dev *pdev)
+					 struct device *dev)
 {
-	if (pdev->dev.archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO)
+	if (dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO)
 		return 0;
-	return iommu_prepare_identity_map(pdev, rmrr->base_address,
-		rmrr->end_address);
+	return iommu_prepare_identity_map(dev, rmrr->base_address,
+					  rmrr->end_address);
 }
 
 #ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
@@ -2393,7 +2393,7 @@ static inline void iommu_prepare_isa(void)
 		return;
 
 	printk(KERN_INFO "IOMMU: Prepare 0-16MiB unity mapping for LPC\n");
-	ret = iommu_prepare_identity_map(pdev, 0, 16*1024*1024 - 1);
+	ret = iommu_prepare_identity_map(&pdev->dev, 0, 16*1024*1024 - 1);
 
 	if (ret)
 		printk(KERN_ERR "IOMMU: Failed to create 0-16MiB identity map; "
@@ -2495,7 +2495,7 @@ static int domain_add_dev_info(struct dmar_domain *domain,
 	return 0;
 }
 
-static bool device_has_rmrr(struct pci_dev *dev)
+static bool device_has_rmrr(struct device *dev)
 {
 	struct dmar_rmrr_unit *rmrr;
 	struct device *tmp;
@@ -2509,7 +2509,7 @@ static bool device_has_rmrr(struct pci_dev *dev)
 		 */
 		for_each_active_dev_scope(rmrr->devices,
 					  rmrr->devices_cnt, i, tmp)
-			if (tmp == &dev->dev) {
+			if (tmp == dev) {
 				rcu_read_unlock();
 				return true;
 			}
@@ -2529,7 +2529,7 @@ static int iommu_should_identity_map(struct pci_dev *pdev, int startup)
 	 * from this process due to their usage of RMRRs that are known
 	 * to not be needed after BIOS hand-off to OS.
 	 */
-	if (device_has_rmrr(pdev) &&
+	if (device_has_rmrr(&pdev->dev) &&
 	    (pdev->class >> 8) != PCI_CLASS_SERIAL_USB)
 		return 0;
 
@@ -2766,9 +2766,7 @@ static int __init init_dmars(void)
 		/* some BIOS lists non-exist devices in DMAR table. */
 		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
 					  i, dev) {
-			if (!dev_is_pci(dev))
-				continue;
-			ret = iommu_prepare_rmrr_dev(rmrr, to_pci_dev(dev));
+			ret = iommu_prepare_rmrr_dev(rmrr, dev);
 			if (ret)
 				printk(KERN_ERR
 				       "IOMMU: mapping reserved region failed\n");
-- 
1.8.5.3
