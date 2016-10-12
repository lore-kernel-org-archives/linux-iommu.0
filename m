From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v14 12/16] vfio/type1: Handle unmap/unpin and replay for
	VFIO_IOVA_RESERVED slots
Date: Wed, 12 Oct 2016 13:22:20 +0000
Message-ID: <1476278544-3397-13-git-send-email-eric.auger@redhat.com>
References: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1476278544-3397-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Before allowing the end-user to create VFIO_IOVA_RESERVED dma slots,
let's implement the expected behavior for removal and replay.

As opposed to user dma slots, reserved IOVAs are not systematically bound
to PAs and PAs are not pinned. VFIO just initializes the IOVA "aperture".
IOVAs are allocated outside of the VFIO framework, by the MSI layer which
is responsible to free and unmap them. The MSI mapping resources are freed
by the IOMMU driver on domain destruction.

On the creation of a new domain, the "replay" of a reserved slot simply
needs to set the MSI aperture on the new domain.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
v13 -> v14:
- make iommu_get_dma_msi_region_cookie's failure not passable
- remove useless "select IOMMU_DMA" causing cyclic dependency
- set the MSI region only if needed

v12 -> v13:
- use dma-iommu iommu_get_dma_msi_region_cookie

v9 -> v10:
- replay of a reserved slot sets the MSI aperture on the new domain
- use VFIO_IOVA_RESERVED_MSI enum value instead of VFIO_IOVA_RESERVED

v7 -> v8:
- do no destroy anything anymore, just bypass unmap/unpin and iommu_map
  on replay
---
 drivers/vfio/vfio_iommu_type1.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 1f120f9..2108e2e 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -36,6 +36,7 @@
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
 #include <linux/workqueue.h>
+#include <linux/dma-iommu.h>
 
 #define DRIVER_VERSION  "0.2"
 #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>"
@@ -386,7 +387,7 @@ static void vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma)
 	struct vfio_domain *domain, *d;
 	long unlocked = 0;
 
-	if (!dma->size)
+	if (!dma->size || dma->type != VFIO_IOVA_USER)
 		return;
 	/*
 	 * We use the IOMMU to track the physical addresses, otherwise we'd
@@ -717,12 +718,24 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
 		return -EINVAL;
 
 	for (; n; n = rb_next(n)) {
+		struct iommu_domain_msi_resv msi_resv;
 		struct vfio_dma *dma;
 		dma_addr_t iova;
 
 		dma = rb_entry(n, struct vfio_dma, node);
 		iova = dma->iova;
 
+		if ((dma->type == VFIO_IOVA_RESERVED_MSI) &&
+			(!iommu_domain_get_attr(domain->domain,
+						DOMAIN_ATTR_MSI_RESV,
+						&msi_resv))) {
+			ret = iommu_get_dma_msi_region_cookie(domain->domain,
+							      dma->iova,
+							      dma->size);
+			if (ret)
+				return ret;
+		}
+
 		while (iova < dma->iova + dma->size) {
 			phys_addr_t phys = iommu_iova_to_phys(d->domain, iova);
 			size_t size;
-- 
1.9.1
