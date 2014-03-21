From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 33/33] iommu/vt-d: Include ACPI devices in iommu=pt
Date: Fri, 21 Mar 2014 17:19:14 +0000
Message-ID: <1395422354-19762-34-git-send-email-David.Woodhouse@intel.com>
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
 drivers/iommu/intel-iommu.c | 61 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0f065bc..53996d9 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2595,30 +2595,65 @@ static int iommu_should_identity_map(struct device *dev, int startup)
 	return 1;
 }
 
+static int __init dev_prepare_static_identity_mapping(struct device *dev, int hw)
+{
+	int ret;
+
+	if (!iommu_should_identity_map(dev, 1))
+		return 0;
+
+	ret = domain_add_dev_info(si_domain, dev,
+				  hw ? CONTEXT_TT_PASS_THROUGH :
+				       CONTEXT_TT_MULTI_LEVEL);
+	if (!ret)
+		pr_info("IOMMU: %s identity mapping for device %s\n",
+			hw ? "hardware" : "software", dev_name(dev));
+	else if (ret == -ENODEV)
+		/* device not associated with an iommu */
+		ret = 0;
+
+	return ret;
+}
+
+
 static int __init iommu_prepare_static_identity_mapping(int hw)
 {
 	struct pci_dev *pdev = NULL;
-	int ret;
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	struct device *dev;
+	int i;
+	int ret = 0;
 
 	ret = si_domain_init(hw);
 	if (ret)
 		return -EFAULT;
 
 	for_each_pci_dev(pdev) {
-		if (iommu_should_identity_map(&pdev->dev, 1)) {
-			ret = domain_add_dev_info(si_domain, &pdev->dev,
-					     hw ? CONTEXT_TT_PASS_THROUGH :
-						  CONTEXT_TT_MULTI_LEVEL);
-			if (ret) {
-				/* device not associated with an iommu */
-				if (ret == -ENODEV)
-					continue;
-				return ret;
+		ret = dev_prepare_static_identity_mapping(&pdev->dev, hw);
+		if (ret)
+			return ret;
+	}
+
+	for_each_active_iommu(iommu, drhd)
+		for_each_active_dev_scope(drhd->devices, drhd->devices_cnt, i, dev) {
+			struct acpi_device_physical_node *pn;
+			struct acpi_device *adev;
+
+			if (dev->bus != &acpi_bus_type)
+				continue;
+				
+			adev= to_acpi_device(dev);
+			mutex_lock(&adev->physical_node_lock);
+			list_for_each_entry(pn, &adev->physical_node_list, node) {
+				ret = dev_prepare_static_identity_mapping(pn->dev, hw);
+				if (ret)
+					break;
 			}
-			pr_info("IOMMU: %s identity mapping for device %s\n",
-				hw ? "hardware" : "software", pci_name(pdev));
+			mutex_unlock(&adev->physical_node_lock);
+			if (ret)
+				return ret;
 		}
-	}
 
 	return 0;
 }
-- 
1.8.5.3
