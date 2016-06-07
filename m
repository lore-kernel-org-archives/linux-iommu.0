From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v10 4/8] vfio/type1: handle unmap/unpin and replay for VFIO_IOVA_RESERVED slots
Date: Tue,  7 Jun 2016 16:03:49 +0000
Message-ID: <1465315433-5974-5-git-send-email-eric.auger@redhat.com>
References: <1465315433-5974-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465315433-5974-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, julien.grall@arm.com, yehuday@marvell.com
List-Id: iommu@lists.linux-foundation.org

Before allowing the end-user to create VFIO_IOVA_RESERVED dma slots,
let's implement the expected behavior for removal and replay.

As opposed to user dma slots, reserved IOVAs are not systematically bound
to PAs and PAs are not pinned. VFIO just initializes the IOVA "aperture".
IOVAs are allocated outside of the VFIO framework, by the MSI layer which
is responsible to free and unmap them. The MSI mapping resources are freeed
by the IOMMU driver on domain destruction.

On the creation of a new domain, the "replay" of a reserved slot simply
needs to set the MSI aperture on the new domain.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v9 -> v10:
- replay of a reserved slot sets the MSI aperture on the new domain
- use VFIO_IOVA_RESERVED_MSI enum value instead of VFIO_IOVA_RESERVED

v7 -> v8:
- do no destroy anything anymore, just bypass unmap/unpin and iommu_map
  on replay
---
 drivers/vfio/vfio_iommu_type1.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 65a4038..69c775e 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -36,6 +36,7 @@
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
 #include <linux/workqueue.h>
+#include <linux/msi-iommu.h>
 
 #define DRIVER_VERSION  "0.2"
 #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
@@ -387,7 +388,7 @@ static void vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma)
 	struct vfio_domain *domain, *d;
 	long unlocked = 0;
 
-	if (!dma->size)
+	if (!dma->size || dma->type != VFIO_IOVA_USER)
 		return;
 	/*
 	 * We use the IOMMU to track the physical addresses, otherwise we'd
@@ -724,6 +725,14 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
 		dma = rb_entry(n, struct vfio_dma, node);
 		iova = dma->iova;
 
+		if (dma->type == VFIO_IOVA_RESERVED_MSI) {
+			ret = iommu_msi_set_aperture(domain->domain,
+						     dma->iova,
+						     iova + dma->size - 1);
+			WARN_ON(ret);
+			continue;
+		}
+
 		while (iova < dma->iova + dma->size) {
 			phys_addr_t phys = iommu_iova_to_phys(d->domain, iova);
 			size_t size;
-- 
1.9.1
