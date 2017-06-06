From: Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/2] acpi/iort: numa: Add numa node mapping for smmuv3
	devices
Date: Tue,  6 Jun 2017 16:17:45 +0530
Message-ID: <1496746065-11082-3-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1496746065-11082-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1496746065-11082-1-git-send-email-ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Will.Deacon-5wv7dgnIgG8@public.gmane.org, jnair-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add code to parse proximity domain in SMMUv3 IORT table to
set numa node mapping for smmuv3 devices.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
---
 drivers/acpi/arm64/iort.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index bba2b59..b4f328f 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -882,6 +882,23 @@ static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
 	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
 }
 
+/*
+ * set numa proximity domain for smmv3 device
+ */
+static void  __init iort_set_proximity(struct acpi_iort_node *node,
+		struct device *dev)
+{
+	struct acpi_iort_smmu_v3 *smmu;
+
+	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
+	if (smmu->flags & ACPI_IORT_SMMU_V3_PXM_VALID) {
+		set_dev_node(dev, acpi_map_pxm_to_node(smmu->pxm));
+		pr_info("SMMUV3[%llx] Mapped to Proximity domain %d\n",
+			smmu->base_address,
+			smmu->pxm);
+	}
+}
+
 static int __init arm_smmu_count_resources(struct acpi_iort_node *node)
 {
 	struct acpi_iort_smmu *smmu;
@@ -1002,6 +1019,9 @@ static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
 	if (!pdev)
 		return -ENOMEM;
 
+	if (node->type == ACPI_IORT_NODE_SMMU_V3)
+		iort_set_proximity(node, &pdev->dev);
+
 	count = ops->iommu_count_resources(node);
 
 	r = kcalloc(count, sizeof(*r), GFP_KERNEL);
-- 
1.8.1.4
