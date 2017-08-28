From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 2/3] iommu: mtk: constify iommu_ops
Date: Mon, 28 Aug 2017 17:42:26 +0530
Message-ID: <1503922346-25947-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: m.szyprowski@samsung.com, joro@8bytes.org, kgene@kernel.org, krzk@kernel.org, matthias.bgg@gmail.com, gerald.schaefer@de.ibm.com
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

iommu_ops are not supposed to change at runtime.
Functions 'iommu_device_set_ops' and 'bus_set_iommu' working with
const iommu_ops provided by <linux/iommu.h>. So mark the non-const
structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/iommu/mtk_iommu.c    | 4 ++--
 drivers/iommu/mtk_iommu_v1.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 91c6d36..eac99a3 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -102,7 +102,7 @@ struct mtk_iommu_domain {
 	struct iommu_domain		domain;
 };
 
-static struct iommu_ops mtk_iommu_ops;
+static const struct iommu_ops mtk_iommu_ops;
 
 static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
 {
@@ -437,7 +437,7 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
-static struct iommu_ops mtk_iommu_ops = {
+static const struct iommu_ops mtk_iommu_ops = {
 	.domain_alloc	= mtk_iommu_domain_alloc,
 	.domain_free	= mtk_iommu_domain_free,
 	.attach_dev	= mtk_iommu_attach_device,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index bc1efbf..40b231f 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -363,7 +363,7 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 	return pa;
 }
 
-static struct iommu_ops mtk_iommu_ops;
+static const struct iommu_ops mtk_iommu_ops;
 
 /*
  * MTK generation one iommu HW only support one iommu domain, and all the client
@@ -536,7 +536,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	return 0;
 }
 
-static struct iommu_ops mtk_iommu_ops = {
+static const struct iommu_ops mtk_iommu_ops = {
 	.domain_alloc	= mtk_iommu_domain_alloc,
 	.domain_free	= mtk_iommu_domain_free,
 	.attach_dev	= mtk_iommu_attach_device,
-- 
1.9.1
