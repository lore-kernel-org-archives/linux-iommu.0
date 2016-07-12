From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 16/20 v2] iommu/amd: Optimize map_sg and unmap_sg
Date: Tue, 12 Jul 2016 15:30:42 +0200
Message-ID: <20160712133042.GG12639@8bytes.org>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
	<1467978311-28322-17-git-send-email-joro@8bytes.org>
	<5784D597.4010703@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5784D597.4010703-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Vincent.Wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 12, 2016 at 12:33:43PM +0100, Robin Murphy wrote:
> > +	for_each_sg(sglist, s, nelems, i)
> > +		npages +=3D iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE);
> =

> This fails to account for the segment boundary mask[1]. Given a typical
> sglist from the block layer where the boundary mask is 64K, the first
> segment is 8k long, and subsequent segments are 64K long, those
> subsequent segments will end up with misaligned addresses which certain
> hardware may object to.

Yeah, right. It doesn't matter much on x86, as the smallest
boundary-mask I have seen is 4G, but to be correct it should be
accounted in. How does the attached patch look?

> =

> > +	address =3D dma_ops_alloc_iova(dev, dma_dom, npages, dma_mask);
> =

> Since a typical dma_map_sg() call is likely to involve >128K worth of
> data, I wonder if it's worth going directly to a slow-path IOVA
> allocation...

Well, the allocator is the bottle-neck, so I try not to call it for
every sg-element. The global locks have been removed, but more
allocations/deallocations also mean that the per-cpu free-lists fill up
quicker and that we have to flush the IOTLBs more often, which costs
performance.

> [1]:http://article.gmane.org/gmane.linux.kernel.iommu/10553 - almost the
> 1-year anniversary of you making much the same comment to me :D

Touch=E9 ;-)

Here is the updated patch:

>From 88e1cc6c8e854a2bf55f972ddc5082a44760abe2 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date: Wed, 6 Jul 2016 17:20:54 +0200
Subject: [PATCH 1/5] iommu/amd: Optimize map_sg and unmap_sg

Optimize these functions so that they need only one call
into the address alloctor. This also saves a couple of
io-tlb flushes in the unmap_sg path.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 112 +++++++++++++++++++++++++++++++++++-------=
----
 1 file changed, 86 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2cd382e..203c50c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2395,50 +2395,110 @@ static void unmap_page(struct device *dev, dma_add=
r_t dma_addr, size_t size,
 	__unmap_single(domain->priv, dma_addr, size, dir);
 }
 =

+static int sg_num_pages(struct device *dev,
+			struct scatterlist *sglist,
+			int nelems)
+{
+	unsigned long mask, boundary_size;
+	struct scatterlist *s;
+	int i, npages =3D 0;
+
+	mask          =3D dma_get_seg_boundary(dev);
+	boundary_size =3D mask + 1 ? ALIGN(mask + 1, PAGE_SIZE) >> PAGE_SHIFT :
+				   1UL << (BITS_PER_LONG - PAGE_SHIFT);
+
+	for_each_sg(sglist, s, nelems, i) {
+		int p, n;
+
+		s->dma_address =3D npages << PAGE_SHIFT;
+		p =3D npages % boundary_size;
+		n =3D iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE);
+		if (p + n > boundary_size)
+			npages +=3D boundary_size - p;
+		npages +=3D n;
+	}
+
+	return npages;
+}
+
 /*
  * The exported map_sg function for dma_ops (handles scatter-gather
  * lists).
  */
 static int map_sg(struct device *dev, struct scatterlist *sglist,
-		  int nelems, enum dma_data_direction dir,
+		  int nelems, enum dma_data_direction direction,
 		  struct dma_attrs *attrs)
 {
+	int mapped_pages =3D 0, npages =3D 0, prot =3D 0, i;
 	struct protection_domain *domain;
-	int i;
+	struct dma_ops_domain *dma_dom;
 	struct scatterlist *s;
-	phys_addr_t paddr;
-	int mapped_elems =3D 0;
+	unsigned long address;
 	u64 dma_mask;
 =

 	domain =3D get_domain(dev);
 	if (IS_ERR(domain))
 		return 0;
 =

+	dma_dom  =3D domain->priv;
 	dma_mask =3D *dev->dma_mask;
 =

+	npages =3D sg_num_pages(dev, sglist, nelems);
+
+	address =3D dma_ops_alloc_iova(dev, dma_dom, npages, dma_mask);
+	if (address =3D=3D DMA_ERROR_CODE)
+		goto out_err;
+
+	prot =3D dir2prot(direction);
+
+	/* Map all sg entries */
 	for_each_sg(sglist, s, nelems, i) {
-		paddr =3D sg_phys(s);
+		int j, pages =3D iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE);
+
+		for (j =3D 0; j < pages; ++j) {
+			unsigned long bus_addr, phys_addr;
+			int ret;
 =

-		s->dma_address =3D __map_single(dev, domain->priv,
-					      paddr, s->length, dir, dma_mask);
+			bus_addr  =3D address + s->dma_address + (j << PAGE_SHIFT);
+			phys_addr =3D (sg_phys(s) & PAGE_MASK) + (j << PAGE_SHIFT);
+			ret =3D iommu_map_page(domain, bus_addr, phys_addr, PAGE_SIZE, prot, GF=
P_ATOMIC);
+			if (ret)
+				goto out_unmap;
 =

-		if (s->dma_address) {
-			s->dma_length =3D s->length;
-			mapped_elems++;
-		} else
-			goto unmap;
+			mapped_pages +=3D 1;
+		}
 	}
 =

-	return mapped_elems;
+	/* Everything is mapped - write the right values into s->dma_address */
+	for_each_sg(sglist, s, nelems, i) {
+		s->dma_address +=3D address + s->offset;
+		s->dma_length   =3D s->length;
+	}
+
+	return nelems;
+
+out_unmap:
+	pr_err("%s: IOMMU mapping error in map_sg (io-pages: %d)\n",
+	       dev_name(dev), npages);
+
+	for_each_sg(sglist, s, nelems, i) {
+		int j, pages =3D iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE);
+
+		for (j =3D 0; j < pages; ++j) {
+			unsigned long bus_addr;
 =

-unmap:
-	for_each_sg(sglist, s, mapped_elems, i) {
-		if (s->dma_address)
-			__unmap_single(domain->priv, s->dma_address,
-				       s->dma_length, dir);
-		s->dma_address =3D s->dma_length =3D 0;
+			bus_addr  =3D address + s->dma_address + (j << PAGE_SHIFT);
+			iommu_unmap_page(domain, bus_addr, PAGE_SIZE);
+
+			if (--mapped_pages)
+				goto out_free_iova;
+		}
 	}
 =

+out_free_iova:
+	free_iova_fast(&dma_dom->iovad, address, npages);
+
+out_err:
 	return 0;
 }
 =

@@ -2451,18 +2511,18 @@ static void unmap_sg(struct device *dev, struct sca=
tterlist *sglist,
 		     struct dma_attrs *attrs)
 {
 	struct protection_domain *domain;
-	struct scatterlist *s;
-	int i;
+	unsigned long startaddr;
+	int npages =3D 2;
 =

 	domain =3D get_domain(dev);
 	if (IS_ERR(domain))
 		return;
 =

-	for_each_sg(sglist, s, nelems, i) {
-		__unmap_single(domain->priv, s->dma_address,
-			       s->dma_length, dir);
-		s->dma_address =3D s->dma_length =3D 0;
-	}
+	startaddr =3D sg_dma_address(sglist) & PAGE_MASK;
+	dma_dom   =3D domain->priv;
+	npages    =3D sg_num_pages(dev, sglist, nelems);
+
+	__unmap_single(domain->priv, startaddr, npages << PAGE_SHIFT, dir);
 }
 =

 /*
-- =

2.6.6
