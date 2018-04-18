From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v6 5/7] vfio/type1: check dma map request is within a valid iova range
Date: Wed, 18 Apr 2018 12:40:43 +0100
Message-ID: <20180418114045.7968-6-shameerali.kolothum.thodi@huawei.com>
References: <20180418114045.7968-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180418114045.7968-1-shameerali.kolothum.thodi@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alex.williamson@redhat.com, eric.auger@redhat.com, pmorel@linux.vnet.ibm.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linuxarm@huawei.com, john.garry@huawei.com, xuwei5@hisilicon.com, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
List-Id: iommu@lists.linux-foundation.org

This checks and rejects any dma map request outside valid iova
range.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/vfio/vfio_iommu_type1.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 6fd6841..bf33281 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1091,6 +1091,23 @@ static int vfio_pin_map_dma(struct vfio_iommu *iommu, struct vfio_dma *dma,
 	return ret;
 }
 
+/*
+ * Check dma map request is within a valid iova range
+ */
+static bool vfio_iommu_iova_dma_valid(struct vfio_iommu *iommu,
+				dma_addr_t start, dma_addr_t end)
+{
+	struct list_head *iova = &iommu->iova_list;
+	struct vfio_iova *node;
+
+	list_for_each_entry(node, iova, list) {
+		if ((start >= node->start) && (end <= node->end))
+			return true;
+	}
+
+	return false;
+}
+
 static int vfio_dma_do_map(struct vfio_iommu *iommu,
 			   struct vfio_iommu_type1_dma_map *map)
 {
@@ -1129,6 +1146,11 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 		goto out_unlock;
 	}
 
+	if (!vfio_iommu_iova_dma_valid(iommu, iova, iova + size - 1)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	dma = kzalloc(sizeof(*dma), GFP_KERNEL);
 	if (!dma) {
 		ret = -ENOMEM;
-- 
2.7.4
