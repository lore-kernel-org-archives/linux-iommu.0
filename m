From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 28/33] iommu/vt-d: Make domain_add_dev_info() take struct
	device
Date: Fri, 21 Mar 2014 17:19:09 +0000
Message-ID: <1395422354-19762-29-git-send-email-David.Woodhouse@intel.com>
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
 drivers/iommu/intel-iommu.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 270a25b..3e15050 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2470,25 +2470,24 @@ static int identity_mapping(struct device *dev)
 }
 
 static int domain_add_dev_info(struct dmar_domain *domain,
-			       struct pci_dev *pdev,
-			       int translation)
+			       struct device *dev, int translation)
 {
 	struct dmar_domain *ndomain;
 	struct intel_iommu *iommu;
 	u8 bus, devfn;
 	int ret;
 
-	iommu = device_to_iommu(&pdev->dev, &bus, &devfn);
+	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
 		return -ENODEV;
 
-	ndomain = dmar_insert_dev_info(iommu, bus, devfn, &pdev->dev, domain);
+	ndomain = dmar_insert_dev_info(iommu, bus, devfn, dev, domain);
 	if (ndomain != domain)
 		return -EBUSY;
 
-	ret = domain_context_mapping(domain, &pdev->dev, translation);
+	ret = domain_context_mapping(domain, dev, translation);
 	if (ret) {
-		domain_remove_one_dev_info(domain, &pdev->dev);
+		domain_remove_one_dev_info(domain, dev);
 		return ret;
 	}
 
@@ -2607,7 +2606,7 @@ static int __init iommu_prepare_static_identity_mapping(int hw)
 
 	for_each_pci_dev(pdev) {
 		if (iommu_should_identity_map(&pdev->dev, 1)) {
-			ret = domain_add_dev_info(si_domain, pdev,
+			ret = domain_add_dev_info(si_domain, &pdev->dev,
 					     hw ? CONTEXT_TT_PASS_THROUGH :
 						  CONTEXT_TT_MULTI_LEVEL);
 			if (ret) {
@@ -2940,7 +2939,7 @@ static int iommu_no_mapping(struct device *dev)
 		 */
 		if (iommu_should_identity_map(&pdev->dev, 0)) {
 			int ret;
-			ret = domain_add_dev_info(si_domain, pdev,
+			ret = domain_add_dev_info(si_domain, dev,
 						  hw_pass_through ?
 						  CONTEXT_TT_PASS_THROUGH :
 						  CONTEXT_TT_MULTI_LEVEL);
@@ -4201,7 +4200,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 		dmar_domain->agaw--;
 	}
 
-	return domain_add_dev_info(dmar_domain, pdev, CONTEXT_TT_MULTI_LEVEL);
+	return domain_add_dev_info(dmar_domain, dev, CONTEXT_TT_MULTI_LEVEL);
 }
 
 static void intel_iommu_detach_device(struct iommu_domain *domain,
-- 
1.8.5.3
