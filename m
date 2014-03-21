From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 29/33] iommu/vt-d: Remove pdev from iommu_no_mapping()
Date: Fri, 21 Mar 2014 17:19:10 +0000
Message-ID: <1395422354-19762-30-git-send-email-David.Woodhouse@intel.com>
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
 drivers/iommu/intel-iommu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3e15050..7b73c42 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2902,10 +2902,9 @@ static int iommu_dummy(struct device *dev)
 	return dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO;
 }
 
-/* Check if the pdev needs to go through non-identity map and unmap process.*/
+/* Check if the dev needs to go through non-identity map and unmap process.*/
 static int iommu_no_mapping(struct device *dev)
 {
-	struct pci_dev *pdev;
 	int found;
 
 	if (unlikely(!dev_is_pci(dev)))
@@ -2917,10 +2916,9 @@ static int iommu_no_mapping(struct device *dev)
 	if (!iommu_identity_mapping)
 		return 0;
 
-	pdev = to_pci_dev(dev);
 	found = identity_mapping(dev);
 	if (found) {
-		if (iommu_should_identity_map(&pdev->dev, 0))
+		if (iommu_should_identity_map(dev, 0))
 			return 1;
 		else {
 			/*
@@ -2929,7 +2927,7 @@ static int iommu_no_mapping(struct device *dev)
 			 */
 			domain_remove_one_dev_info(si_domain, dev);
 			printk(KERN_INFO "32bit %s uses non-identity mapping\n",
-			       pci_name(pdev));
+			       dev_name(dev));
 			return 0;
 		}
 	} else {
@@ -2937,7 +2935,7 @@ static int iommu_no_mapping(struct device *dev)
 		 * In case of a detached 64 bit DMA device from vm, the device
 		 * is put into si_domain for identity mapping.
 		 */
-		if (iommu_should_identity_map(&pdev->dev, 0)) {
+		if (iommu_should_identity_map(dev, 0)) {
 			int ret;
 			ret = domain_add_dev_info(si_domain, dev,
 						  hw_pass_through ?
@@ -2945,7 +2943,7 @@ static int iommu_no_mapping(struct device *dev)
 						  CONTEXT_TT_MULTI_LEVEL);
 			if (!ret) {
 				printk(KERN_INFO "64bit %s uses identity mapping\n",
-				       pci_name(pdev));
+				       dev_name(dev));
 				return 1;
 			}
 		}
-- 
1.8.5.3
