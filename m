From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC/PATCH 2/9] arm: dma-mapping: Support IOMMU mappings spanning the full 32 bits range
Date: Mon, 25 May 2015 01:38:40 +0300
Message-ID: <3504657.zdfVEnYr60@avalon>
References: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1431644410-2997-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <555B0DBC.6090204@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <555B0DBC.6090204@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Laura Abbott <lauraa@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Mitchel Humpherys <mitchelh@codeaurora.org>, Joreg Roedel <joro@8bytes.org>, Will Deacon <Will.Deacon@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Tuesday 19 May 2015 11:17:32 Robin Murphy wrote:
> On 15/05/15 00:00, Laurent Pinchart wrote:
> > The arm_iommu_create_mapping() function takes the IOMMU mapping size as
> > a size_t, limiting the size to 4GB - 1 on 32 bit platforms while most
> > bus masters would support the full 32 bits range. Fix this by passing
> > the size as a 64 bits integer, and limiting it to 4GB for now.
> 
> FYI there's already an almost-identical patch in -rc3 from Marek fixing
> this: 1424532b2163 ("ARM: 8347/1: dma-mapping: fix off-by-one check in
> arm_setup_iommu_dma_ops").

Indeed, I should have rebased on top of -rc3. I suppose it's a good indication 
that I was on the right track :-) I'll drop this patch from my series.

> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >   arch/arm/include/asm/dma-iommu.h |  2 +-
> >   arch/arm/mm/dma-mapping.c        | 12 +++---------
> >   2 files changed, 4 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/dma-iommu.h
> > b/arch/arm/include/asm/dma-iommu.h index 8e3fcb924db6..2ef282f96651
> > 100644
> > --- a/arch/arm/include/asm/dma-iommu.h
> > +++ b/arch/arm/include/asm/dma-iommu.h
> > @@ -25,7 +25,7 @@ struct dma_iommu_mapping {
> >   };
> >   
> >   struct dma_iommu_mapping *
> > -arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t
> > size);
> > +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, u64
> > size);
> >   void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping);
> > 
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index 7aa5e339a596..c69e216a0cf9 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -1878,7 +1878,7 @@ struct dma_map_ops iommu_coherent_ops = {
> > 
> >    * arm_iommu_attach_device function.
> >    */
> >   
> >   struct dma_iommu_mapping *
> > 
> > -arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t
> > size) +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base,
> > u64 size)
> >   {
> >   	unsigned int bits = size >> PAGE_SHIFT;
> >   	unsigned int bitmap_size = BITS_TO_LONGS(bits) * sizeof(long);
> > @@ -1886,7 +1886,8 @@ arm_iommu_create_mapping(struct bus_type *bus,
> > dma_addr_t base, size_t size)
> >   	int extensions = 1;
> >   	int err = -ENOMEM;
> > 
> > -	if (!bitmap_size)
> > +	/* Limit the size to 4GB for now. */
> > +	if (!size || size > (1ULL << 32))
> >   		return ERR_PTR(-EINVAL);
> >   	
> >   	if (bitmap_size > PAGE_SIZE) {
> > @@ -2057,13 +2058,6 @@ static bool arm_setup_iommu_dma_ops(struct device
> > *dev, u64 dma_base, u64 size,
> >   	if (!iommu)
> >   		return false;
> > 
> > -	/*
> > -	 * currently arm_iommu_create_mapping() takes a max of size_t
> > -	 * for size param. So check this limit for now.
> > -	 */
> > -	if (size > SIZE_MAX)
> > -		return false;
> > -
> >   	mapping = arm_iommu_create_mapping(dev->bus, dma_base, size);
> >   	if (IS_ERR(mapping)) {
> >   		pr_warn("Failed to create %llu-byte IOMMU mapping for device 
%s\n",

-- 
Regards,

Laurent Pinchart
