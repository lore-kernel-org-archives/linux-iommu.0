From: Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: Re: [PATCH 2/4] iommu: Implement common IOMMU ops for DMA mapping
Date: Fri, 29 May 2015 14:35:01 +0800
Message-ID: <1432881301.26021.20.camel@mtksdaap41>
References: <cover.1432735420.git.robin.murphy@arm.com>
 <141cbb28b55e3d748c6426f56016c46e8cf93109.1432735420.git.robin.murphy@arm.com>
 <1432877219.721.237.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1432877219.721.237.camel@mhfsdcap03>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yong Wu <yong.wu@mediatek.com>, Robin Murphy <robin.murphy@arm.com>
Cc: laurent.pinchart+renesas@ideasonboard.com, arnd@arndb.de, catalin.marinas@arm.com, joro@8bytes.org, will.deacon@arm.com, tiffany.lin@mediatek.com, iommu@lists.linux-foundation.org, djkurtz@google.com, thunder.leizhen@huawei.com, treding@nvidia.com, linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org


Hi Robin,

More info, hope this make it clearer. We are calling dma_map_sg_attrs
with the following 2 sg. With IOMMU, we are expecting it got merged into
1 contiguous va range, but instead we get 2 va range.

sg0 dma_address 0xfeeddc00 size 0x400, offset 0xc00
sg1 dma_address 0xfeede000 size 0x1000, offset 0x0

Joe.C

On Fri, 2015-05-29 at 13:26 +0800, Yong Wu wrote:
> Hi Robin,
>     Thanks.
> 
>     While we test venc in v4l2, we get a problem:
>     When we enter the funtion[0], it will be break unexpectedly in the
> funcion[1] while the offset of sg table is not zero. It is ok if the
> offset is zero. Then I add more log in dma-iommu.c, please help check
> below.
>     All we tested it based on dma v2. and have not tested it on v3 yet.
> The code of iommu-map-sg seems the same. if it's fixed in v3, I'm very
> sorry. The map_sg in mtk-iommu use default_iommu_map_sg.
>     Any question please tell me, Thanks very much. 
> 
> [0]http://lxr.free-electrons.com/source/drivers/media/v4l2-core/videobuf2-dma-contig.c#L564	[1]http://lxr.free-electrons.com/source/drivers/media/v4l2-core/videobuf2-dma-contig.c#L70
> 
> 
> On Wed, 2015-05-27 at 15:09 +0100, Robin Murphy wrote:
> > Taking inspiration from the existing arch/arm code, break out some
> > generic functions to interface the DMA-API to the IOMMU-API. This will
> > do the bulk of the heavy lifting for IOMMU-backed dma-mapping.
> > 
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> >  drivers/iommu/Kconfig     |   7 +
> >  drivers/iommu/Makefile    |   1 +
> >  drivers/iommu/dma-iommu.c | 560 ++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/dma-iommu.h |  94 ++++++++
> >  4 files changed, 662 insertions(+)
> >  create mode 100644 drivers/iommu/dma-iommu.c
> >  create mode 100644 include/linux/dma-iommu.h
> > 
> [snip]
> > +static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
> > +		dma_addr_t dma_addr)
> > +{
> > +	struct scatterlist *s, *seg = sg;
> > +	unsigned long seg_mask = dma_get_seg_boundary(dev);
> > +	unsigned int max_len = dma_get_max_seg_size(dev);
> > +	unsigned int seg_len = 0, seg_dma = 0;
> > +	int i, count = 1;
> > +
> > +	for_each_sg(sg, s, nents, i) {
> > +		/* Un-swizzling the fields here, hence the naming mismatch */
> > +		unsigned int s_offset = sg_dma_address(s);
> > +		unsigned int s_length = sg_dma_len(s);
> > +		unsigned int s_dma_len = s->length;
> > +
> > +		s->offset = s_offset;
> > +		s->length = s_length;
> > +		sg_dma_address(s) = DMA_ERROR_CODE;
> > +		sg_dma_len(s) = 0;
> > +
> > +		if (seg_len && (seg_dma + seg_len == dma_addr + s_offset) &&
> > +		    (seg_len + s_dma_len <= max_len) &&
> > +		    ((seg_dma & seg_mask) <= seg_mask - (seg_len + s_length))
> > +		   ) {
> > +			sg_dma_len(seg) += s_dma_len;
> > +		} else {
> > +			if (seg_len) {
> > +				seg = sg_next(seg);
> > +				count++;
> > +			}
> > +			sg_dma_len(seg) = s_dma_len;
> > +			sg_dma_address(seg) = dma_addr + s_offset;
>    Here the value of sg_dma_address have added s_offset, but
> sg_dma_len(seg) still is s_dma_len.
>    In the first loop, s_dma_len is from s->length which is alignd by
> "s_length = iova_align(iovad, s_length + s_offset);" in
> the interface iommu_dma_map_sg.
> > +
> > +			seg_len = s_offset;
> > +			seg_dma = dma_addr + s_offset;
> > +		}
> > +		seg_len += s_length;
> > +		dma_addr += s_dma_len;
> > +	}
> > +	return count;
> > +}
> > +
> > +static void __invalidate_sg(struct scatterlist *sg, int nents)
> > +{
> > +	struct scatterlist *s;
> > +	int i;
> > +
> > +	for_each_sg(sg, s, nents, i) {
> > +		if (sg_dma_address(s) != DMA_ERROR_CODE)
> > +			s->offset = sg_dma_address(s);
> > +		if (sg_dma_len(s))
> > +			s->length = sg_dma_len(s);
> > +		sg_dma_address(s) = DMA_ERROR_CODE;
> > +		sg_dma_len(s) = 0;
> > +	}
> > +}
> > +
> > +int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> > +		int nents, int prot, bool coherent)
> > +{
> > +	struct iommu_dma_domain *dom = arch_get_dma_domain(dev);
> > +	struct iova_domain *iovad = dom->iovad;
> > +	struct iova *iova;
> > +	struct scatterlist *s;
> > +	dma_addr_t dma_addr;
> > +	size_t iova_len = 0;
> > +	int i;
> > +
> > +	/*
> > +	 * Work out how much IOVA space we need, and align the segments to
> > +	 * IOVA granules for the IOMMU driver to handle. With some clever
> > +	 * trickery we can modify the list in a reversible manner.
> > +	 */
> > +	for_each_sg(sg, s, nents, i) {
> > +		size_t s_offset = iova_offset(iovad, s->offset);
> > +		size_t s_length = s->length;
> > +
> > +		sg_dma_address(s) = s->offset;
> > +		sg_dma_len(s) = s_length;
> > +		s->offset -= s_offset;
> > +		s_length = iova_align(iovad, s_length + s_offset);
> > +		s->length = s_length;
> At the begging, s->length is the length of valid data. but it's aligned
> here.
> > +
> > +		iova_len += s_length;
> > +	}
> > +
> > +	iova = __alloc_iova(dev, iova_len, coherent);
> > +	if (!iova)
> > +		goto out_restore_sg;
> > +
> > +	/*
> > +	 * We'll leave any physical concatenation to the IOMMU driver's
> > +	 * implementation - it knows better than we do.
> > +	 */
> > +	dma_addr = iova_dma_addr(iovad, iova);
> > +	if (iommu_map_sg(dom->domain, dma_addr, sg, nents, prot) < iova_len)
> > +		goto out_free_iova;
> > +
> > +	return __finalise_sg(dev, sg, nents, dev_dma_addr(dev, dma_addr));
> > +
> > +out_free_iova:
> > +	__free_iova(iovad, iova);
> > +out_restore_sg:
> > +	__invalidate_sg(sg, nents);
> > +	return 0;
> > +}
> > +
> [snip]
> 
> 
