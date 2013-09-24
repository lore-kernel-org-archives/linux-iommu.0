From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/7] ARM: dma-mapping: Always pass proper prot flags to
	iommu_map()
Date: Tue, 24 Sep 2013 19:40:36 +0200
Message-ID: <20130924174036.GU4845@alberich>
References: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
	<1380035221-11576-4-git-send-email-andreas.herrmann@calxeda.com>
	<20130924153625.GD20774@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130924153625.GD20774-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 24, 2013 at 11:36:25AM -0400, Will Deacon wrote:
> On Tue, Sep 24, 2013 at 04:06:57PM +0100, Andreas Herrmann wrote:
> > ... otherwise it is impossible for the low level iommu driver to
> > figure out which pte flags should be used.
> > 
> > In __map_sg_chunk we can derive the flags from dma_data_direction.
> > 
> > In __iommu_create_mapping we should treat the memory like
> > DMA_BIDIRECTIONAL and pass both IOMMU_READ and IOMMU_WRITE to
> > iommu_map.
> > __iommu_create_mapping is used during dma_alloc_coherent (via
> > arm_iommu_alloc_attrs).  AFAIK dma_alloc_coherent is responsible for
> > allocation _and_ mapping.  I think this implies that access to the
> > mapped pages should be allowed.
> > 
> > Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  arch/arm/mm/dma-mapping.c |   20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index f5e1a84..95abed8 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -1232,7 +1232,8 @@ __iommu_create_mapping(struct device *dev, struct page **pages, size_t size)
> >  				break;
> >  
> >  		len = (j - i) << PAGE_SHIFT;
> > -		ret = iommu_map(mapping->domain, iova, phys, len, 0);
> > +		ret = iommu_map(mapping->domain, iova, phys, len,
> > +				IOMMU_READ|IOMMU_WRITE);
> >  		if (ret < 0)
> >  			goto fail;
> >  		iova += len;
> > @@ -1444,6 +1445,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
> >  	int ret = 0;
> >  	unsigned int count;
> >  	struct scatterlist *s;
> > +	int prot;
> >  
> >  	size = PAGE_ALIGN(size);
> >  	*handle = DMA_ERROR_CODE;
> > @@ -1460,7 +1462,21 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
> >  			!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
> >  			__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
> >  
> > -		ret = iommu_map(mapping->domain, iova, phys, len, 0);
> > +		switch (dir) {
> > +		case DMA_BIDIRECTIONAL:
> > +			prot = IOMMU_READ | IOMMU_WRITE;
> > +			break;
> > +		case DMA_TO_DEVICE:
> > +			prot = IOMMU_READ;
> > +			break;
> > +		case DMA_FROM_DEVICE:
> > +			prot = IOMMU_WRITE;
> > +			break;
> > +		default:
> > +			prot = 0;
> > +		}
> > +
> > +		ret = iommu_map(mapping->domain, iova, phys, len, prot);
> 
> I already added this code to arm_coherent_iommu_map_page but forgot to
> update the rest of the time. Could you shift the switch into a helper and
> call that instead of inlining it explicitly?

Yes, will do so.


Andreas
