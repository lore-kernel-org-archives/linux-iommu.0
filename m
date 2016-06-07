From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v10 3/8] vfio/type1: implement recursive vfio_find_dma_from_node
Date: Tue,  7 Jun 2016 16:03:48 +0000
Message-ID: <1465315433-5974-4-git-send-email-eric.auger@redhat.com>
References: <1465315433-5974-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465315433-5974-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, julien.grall@arm.com, yehuday@marvell.com
List-Id: iommu@lists.linux-foundation.org

This patch handles the case where a node is encountered, matching
@start and @size arguments but not matching the @type argument.
In that case, we need to skip that node and pursue the search in the
node's leaves. In case @start is inferior to the node's base, we
resume the search on the left leaf. If the recursive search on the left
leaves did not produce any match, we search the right leaves recursively.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v10: creation
---
 drivers/vfio/vfio_iommu_type1.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index cb7267a..65a4038 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -125,7 +125,17 @@ static struct vfio_dma *vfio_find_dma_from_node(struct rb_node *top,
 	if (type == VFIO_IOVA_ANY || dma->type == type)
 		return dma;
 
-	return NULL;
+	/* restart 2 searches skipping the current node */
+	if (start < dma->iova) {
+		dma = vfio_find_dma_from_node(node->rb_left, start,
+					      size, type);
+		if (dma)
+			return dma;
+	}
+	if (start + size > dma->iova + dma->size)
+		dma = vfio_find_dma_from_node(node->rb_right, start,
+					      size, type);
+	return dma;
 }
 
 /**
-- 
1.9.1
