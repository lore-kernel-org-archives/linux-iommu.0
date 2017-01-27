From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH/RFC] iommu/dma: Per-domain flag to control size-alignment
Date: Fri, 27 Jan 2017 15:24:25 +0900
Message-ID: <148549826507.23190.1460689571069015835.sendpatchset@little-apple>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, robin.murphy@arm.com, joro@8bytes.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Introduce the flag "no_size_align" to allow disabling size-alignment
on a per-domain basis. This follows the suggestion by the comment
in the code, however a per-device control may be preferred?

Needed to make virtual space contiguous for certain devices.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/iommu/dma-iommu.c |    6 +++++-
 include/linux/iommu.h     |    1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

--- 0001/drivers/iommu/dma-iommu.c
+++ work/drivers/iommu/dma-iommu.c	2017-01-27 15:17:50.280607110 +0900
@@ -209,14 +209,18 @@ static struct iova *__alloc_iova(struct
 	struct iova_domain *iovad = cookie_iovad(domain);
 	unsigned long shift = iova_shift(iovad);
 	unsigned long length = iova_align(iovad, size) >> shift;
+	bool size_aligned = true;
 
 	if (domain->geometry.force_aperture)
 		dma_limit = min(dma_limit, domain->geometry.aperture_end);
+
+	if (domain->no_size_align)
+		size_aligned = false;
 	/*
 	 * Enforce size-alignment to be safe - there could perhaps be an
 	 * attribute to control this per-device, or at least per-domain...
 	 */
-	return alloc_iova(iovad, length, dma_limit >> shift, true);
+	return alloc_iova(iovad, length, dma_limit >> shift, size_aligned);
 }
 
 /* The IOVA allocator knows what we mapped, so just unmap whatever that was */
--- 0001/include/linux/iommu.h
+++ work/include/linux/iommu.h	2017-01-27 15:16:37.630607110 +0900
@@ -83,6 +83,7 @@ struct iommu_domain {
 	iommu_fault_handler_t handler;
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
+	bool no_size_align;
 	void *iova_cookie;
 };
 
