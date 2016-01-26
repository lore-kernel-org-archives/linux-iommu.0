From: Eric Auger <eric.auger@linaro.org>
Subject: [PATCH 04/10] vfio: introduce VFIO_IOVA_RESERVED vfio_dma type
Date: Tue, 26 Jan 2016 13:12:42 +0000
Message-ID: <1453813968-2024-5-git-send-email-eric.auger@linaro.org>
References: <1453813968-2024-1-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <1453813968-2024-1-git-send-email-eric.auger@linaro.org>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: eric.auger@st.com, eric.auger@linaro.org, alex.williamson@redhat.com, will.deacon@arm.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
Cc: patches@linaro.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

We introduce a vfio_dma type since we will need to discriminate
legacy vfio_dma's from new reserved ones. Since those latter are
not mapped at registration, some handlings must be unplugged:
removal, replay. They will be enhanced later on.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/vfio/vfio_iommu_type1.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 32438d9..33a9ce4 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -53,6 +53,15 @@ module_param_named(disable_hugepages,
 MODULE_PARM_DESC(disable_hugepages,
 		 "Disable VFIO IOMMU support for IOMMU hugepages.");
 
+enum vfio_iova_type {
+	VFIO_IOVA_USER = 0, /* standard IOVA used to map user vaddr */
+	/*
+	 * IOVA reserved to map special host physical addresses,
+	 * MSI frames for instance
+	 */
+	VFIO_IOVA_RESERVED,
+};
+
 struct vfio_iommu {
 	struct list_head	domain_list;
 	struct mutex		lock;
@@ -78,6 +87,7 @@ struct vfio_dma {
 	unsigned long		vaddr;		/* Process virtual addr */
 	size_t			size;		/* Map size (bytes) */
 	int			prot;		/* IOMMU_READ/WRITE */
+	enum vfio_iova_type	type;		/* type of IOVA */
 };
 
 struct vfio_reserved_binding {
@@ -480,7 +490,8 @@ static void vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma)
 
 static void vfio_remove_dma(struct vfio_iommu *iommu, struct vfio_dma *dma)
 {
-	vfio_unmap_unpin(iommu, dma);
+	if (likely(dma->type != VFIO_IOVA_RESERVED))
+		vfio_unmap_unpin(iommu, dma);
 	vfio_unlink_dma(iommu, dma);
 	kfree(dma);
 }
@@ -756,6 +767,10 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
 		dma_addr_t iova;
 
 		dma = rb_entry(n, struct vfio_dma, node);
+
+		if (unlikely(dma->type == VFIO_IOVA_RESERVED))
+			continue;
+
 		iova = dma->iova;
 
 		while (iova < dma->iova + dma->size) {
-- 
1.9.1
