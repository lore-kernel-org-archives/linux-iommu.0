From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC 2/2] iommu/dma: Identity-map non-RAM regions
Date: Tue, 28 Jun 2016 17:18:58 +0100
Message-ID: <98eb098314f4f29532e571fa4ff94ead5ec39a25.1467129314.git.robin.murphy@arm.com>
References: <cover.1467123945.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1467123945.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

There is a fundamental assumption baked into many drivers and subsystems
that resources outside of RAM (e.g. MSI controllers, target peripherals
for DMA engines, etc.) can be accessed directly by physical address.
Whilst work is ongoing to add the necessary APIs and abstractions to
make everything more IOMMU-friendly, the time and effort involved is
proving to be not insignificant, and in the meantime unconditionally
enabling IOMMU translation for DMA leaves many things unworkably broken.

By swinging the big hammer of identity-mapping every potential I/O
region, we can at least enable IOMMU remapping for regular DMA to/from
RAM areas without regressing existing behaviour, and continue developing
incrementally from there.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

And this is even more horrible, but again, there are platforms that want
32-bit peripherals to be able to access all of (or any of) RAM, but at
the same time won't appreciate currently-working MSIs and whatever else
being borked.

 drivers/iommu/dma-iommu.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2385fab382d8..3b07a8424ac5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -92,6 +92,29 @@ static void iova_match_mem(struct iova_domain *iovad)
 		reserve_iova(iovad, base, blk);
 }
 
+static void domain_idmap_mmio(struct iommu_domain *domain)
+{
+	struct iova_domain *iovad = domain->iova_cookie;
+	struct rb_node *node;
+	unsigned long shift = iova_shift(iovad);
+
+	spin_lock(&iovad->iova_rbtree_lock);
+	for (node = rb_first(&iovad->rbroot); node; node = rb_next(node)) {
+		struct iova *iova = container_of(node, struct iova, node);
+		phys_addr_t phys = iova->pfn_lo << shift;
+		size_t size = (iova->pfn_hi - iova->pfn_lo) << shift;
+
+		size = min_t(phys_addr_t, size,
+				domain->geometry.aperture_end - phys + 1);
+		if (!size)
+			break;
+
+		iommu_map(domain, phys, phys, size,
+				IOMMU_READ | IOMMU_WRITE | IOMMU_MMIO);
+	}
+	spin_unlock(&iovad->iova_rbtree_lock);
+}
+
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
@@ -142,6 +165,8 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base, u64 size
 	} else {
 		init_iova_domain(iovad, 1UL << order, base_pfn, end_pfn);
 		iova_match_mem(iovad);
+		if (domain->geometry.force_aperture)
+			domain_idmap_mmio(domain);
 	}
 	return 0;
 }
-- 
2.8.1.dirty
