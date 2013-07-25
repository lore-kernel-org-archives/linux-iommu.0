From: Antonios Motakis <a.motakis@virtualopensystems.com>
Subject: [PATCHv2 1/2] iommu/exynos: add devices attached to the System MMU to an IOMMU group
Date: Thu, 25 Jul 2013 17:34:59 +0200
Message-ID: <1374766502-14823-1-git-send-email-a.motakis@virtualopensystems.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: kvmarm@lists.cs.columbia.edu, Antonios Motakis <a.motakis@virtualopensystems.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Sachin Kamat <sachin.kamat@linaro.org>, Varun Sethi <Varun.Sethi@freescale.com>, open list <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

IOMMU groups are expected by certain users of the IOMMU API,
e.g. VFIO. Since each device is behind its own System MMU, we
can allocate a new IOMMU group for each device.

This patch depends on Cho KyongHo's patch series titled "[PATCH v7 00/12]
iommu/exynos: Fixes and Enhancements of System MMU driver with DT",
applied on a Linux 3.10.1 kernel. It has been tested on the Arndale board.

Changes since in v2:
- Removed possibility for minor memory leak in case of
  misbehaving platform drivers

Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
---
 drivers/iommu/exynos-iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 51d43bb..c7dd4b5 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1134,6 +1134,32 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *domain,
 	return phys;
 }
 
+static int exynos_iommu_add_device(struct device *dev)
+{
+	struct iommu_group *group;
+	int ret;
+
+	group = iommu_group_get(dev);
+
+	if (!group) {
+		group = iommu_group_alloc();
+		if (IS_ERR(group)) {
+			dev_err(dev, "Failed to allocate IOMMU group\n");
+			return PTR_ERR(group);
+		}
+	}
+
+	ret = iommu_group_add_device(group, dev);
+	iommu_group_put(group);
+
+	return ret;
+}
+
+static void exynos_iommu_remove_device(struct device *dev)
+{
+	iommu_group_remove_device(dev);
+}
+
 static struct iommu_ops exynos_iommu_ops = {
 	.domain_init = &exynos_iommu_domain_init,
 	.domain_destroy = &exynos_iommu_domain_destroy,
@@ -1142,6 +1168,8 @@ static struct iommu_ops exynos_iommu_ops = {
 	.map = &exynos_iommu_map,
 	.unmap = &exynos_iommu_unmap,
 	.iova_to_phys = &exynos_iommu_iova_to_phys,
+	.add_device	= exynos_iommu_add_device,
+	.remove_device	= exynos_iommu_remove_device,
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
 };
 
-- 
1.8.1.2
