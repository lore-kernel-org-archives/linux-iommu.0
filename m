From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 06/33] iommu/vt-d: Make iommu_dummy() take struct device
	instead of struct pci_dev
Date: Fri, 21 Mar 2014 17:18:47 +0000
Message-ID: <1395422354-19762-7-git-send-email-David.Woodhouse@intel.com>
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
 drivers/iommu/intel-iommu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f38f482..db7e44b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2882,9 +2882,9 @@ static inline struct dmar_domain *get_valid_domain_for_dev(struct pci_dev *dev)
 	return __get_valid_domain_for_dev(dev);
 }
 
-static int iommu_dummy(struct pci_dev *pdev)
+static int iommu_dummy(struct device *dev)
 {
-	return pdev->dev.archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO;
+	return dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO;
 }
 
 /* Check if the pdev needs to go through non-identity map and unmap process.*/
@@ -2896,13 +2896,13 @@ static int iommu_no_mapping(struct device *dev)
 	if (unlikely(!dev_is_pci(dev)))
 		return 1;
 
-	pdev = to_pci_dev(dev);
-	if (iommu_dummy(pdev))
+	if (iommu_dummy(dev))
 		return 1;
 
 	if (!iommu_identity_mapping)
 		return 0;
 
+	pdev = to_pci_dev(dev);
 	found = identity_mapping(pdev);
 	if (found) {
 		if (iommu_should_identity_map(pdev, 0))
@@ -3801,7 +3801,7 @@ static int device_notifier(struct notifier_block *nb,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct dmar_domain *domain;
 
-	if (iommu_dummy(pdev))
+	if (iommu_dummy(dev))
 		return 0;
 
 	if (action != BUS_NOTIFY_UNBOUND_DRIVER &&
-- 
1.8.5.3
