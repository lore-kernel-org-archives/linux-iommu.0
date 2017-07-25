From: Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4] acpi/iort: numa: Add numa node mapping for smmuv3 devices
Date: Tue, 25 Jul 2017 10:32:37 +0530
Message-ID: <20170725050237.11033-1-ganapatrao.kulkarni@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, Will.Deacon-5wv7dgnIgG8@public.gmane.org, gklkml16-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jnair-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

ARM IORT specification(rev. C) has added  provision to define proximity
domain in SMMUv3 IORT table. Adding required code to parse Proximity
domain and set numa_node of smmv3 platform devices.

Add code to parse proximity domain in SMMUv3 IORT table to
set numa node mapping for smmuv3 devices.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
---

This patch has dependency on header file patch [1], which is
already merged to linux-pm.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=c944230064eb65e4fa018d86779b4fd200b1d7e7

v4:
  - Fix compilation issue in !CONFIG_NUMA

v3:
  - Addressed Lorenzo Pieralisi comment.

v2:
  - Changed as per Lorenzo Pieralisi and Hanjun Guo suggestions.

v1:
  - Initial patch

 drivers/acpi/arm64/iort.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index a3215ee..c5c82c3 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -908,6 +908,28 @@ static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
 	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
 }
 
+#if defined(CONFIG_ACPI_NUMA) && (ACPI_CA_VERSION >= 0x20170629)
+/*
+ * set numa proximity domain for smmuv3 device
+ */
+static void  __init arm_smmu_v3_set_proximity(struct acpi_iort_node *node,
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
+#else
+static void  __init arm_smmu_v3_set_proximity(struct acpi_iort_node *node,
+		struct device *dev) { }
+#endif
+
 static int __init arm_smmu_count_resources(struct acpi_iort_node *node)
 {
 	struct acpi_iort_smmu *smmu;
@@ -977,20 +999,24 @@ struct iort_iommu_config {
 	int (*iommu_count_resources)(struct acpi_iort_node *node);
 	void (*iommu_init_resources)(struct resource *res,
 				     struct acpi_iort_node *node);
+	void (*iommu_set_proximity)(struct acpi_iort_node *node,
+				     struct device *dev);
 };
 
 static const struct iort_iommu_config iort_arm_smmu_v3_cfg __initconst = {
 	.name = "arm-smmu-v3",
 	.iommu_is_coherent = arm_smmu_v3_is_coherent,
 	.iommu_count_resources = arm_smmu_v3_count_resources,
-	.iommu_init_resources = arm_smmu_v3_init_resources
+	.iommu_init_resources = arm_smmu_v3_init_resources,
+	.iommu_set_proximity = arm_smmu_v3_set_proximity
 };
 
 static const struct iort_iommu_config iort_arm_smmu_cfg __initconst = {
 	.name = "arm-smmu",
 	.iommu_is_coherent = arm_smmu_is_coherent,
 	.iommu_count_resources = arm_smmu_count_resources,
-	.iommu_init_resources = arm_smmu_init_resources
+	.iommu_init_resources = arm_smmu_init_resources,
+	.iommu_set_proximity = NULL
 };
 
 static __init
@@ -1028,6 +1054,9 @@ static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
 	if (!pdev)
 		return -ENOMEM;
 
+	if (ops->iommu_set_proximity)
+		ops->iommu_set_proximity(node, &pdev->dev);
+
 	count = ops->iommu_count_resources(node);
 
 	r = kcalloc(count, sizeof(*r), GFP_KERNEL);
-- 
2.9.4
