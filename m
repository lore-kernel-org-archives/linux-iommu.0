From: Shameer Kolothum <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v5 4/7] vfio/type1: check dma map request is within a valid
	iova range
Date: Thu, 15 Mar 2018 16:35:06 +0000
Message-ID: <20180315163509.17740-5-shameerali.kolothum.thodi@huawei.com>
References: <20180315163509.17740-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180315163509.17740-1-shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, pmorel-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This checks and rejects any dma map request outside valid iova
range.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/vfio/vfio_iommu_type1.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 25e6920..d59db31 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -982,6 +982,23 @@ static int vfio_pin_map_dma(struct vfio_iommu *iommu, struct vfio_dma *dma,
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
@@ -1020,6 +1037,11 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
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
