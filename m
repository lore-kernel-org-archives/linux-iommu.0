From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC PATCH v2 2/3] arm64: add IOMMU dma_ops
Date: Sat, 14 Feb 2015 16:03:31 +0800
Message-ID: <1423901011.27922.7.camel@mhfsdcap03>
References: <cover.1423226542.git.robin.murphy@arm.com>
	<058e038009ac708a40197c80e07410914c2a162e.1423226542.git.robin.murphy@arm.com>
	<1423543151.18280.2.camel@mtksdaap41> <54D9F486.10501@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54D9F486.10501-5wv7dgnIgG8@public.gmane.org>
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
Cc: "lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org" <stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2015-02-10 at 12:07 +0000, Robin Murphy wrote:
> On 10/02/15 04:39, Yingjoe Chen wrote:
> > On Fri, 2015-02-06 at 14:55 +0000, Robin Murphy wrote
> > <...>
> >> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> >> index 6932bb5..c1b271f 100644
> >> --- a/arch/arm64/include/asm/dma-mapping.h
> >> +++ b/arch/arm64/include/asm/dma-mapping.h
> >> @@ -62,13 +62,30 @@ static inline bool is_device_dma_coherent(struct device *dev)
> >>
> >>   #include <asm-generic/dma-mapping-common.h>
> >>
> >> +#ifdef CONFIG_IOMMU_DMA
> >> +static inline struct iommu_dma_domain *get_dma_domain(struct device *dev)
> >> +{
> >> +	return dev->archdata.dma_domain;
> >> +}
> >> +
> >> +static inline void set_dma_domain(struct device *dev,
> >> +				  struct iommu_dma_domain *dma_domain)
> >> +{
> >> +	dev->archdata.dma_domain = dma_domain;
> >> +}
> >> +#endif
> >> +
> >>   static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
> >>   {
> >> +	if (WARN_ON(dev && get_dma_domain(dev)))
> >> +		return DMA_ERROR_CODE;
> >>   	return (dma_addr_t)paddr;
> >>   }
> >
> >
> > Hi Robin,
> >
> > Build fail if CONFIG_IOMMU_DMA is not enabled.
> >
> > In file included from ../include/linux/dma-mapping.h:82:0,
> >                   from ../arch/arm64/kernel/asm-offsets.c:23:
> > ../arch/arm64/include/asm/dma-mapping.h: In function 'phys_to_dma':
> > ../arch/arm64/include/asm/dma-mapping.h:81:2: error: implicit declaration of function 'get_dma_domain' [-Werror=implicit-function-declaration]
> >    if (WARN_ON(dev && get_dma_domain(dev)))
> >    ^
> >
> > Joe.C
> 
> Bah, how did I manage to make such a half-finished mess of the includes? 
> Current fixup diff below.
> 
> Thanks,
> Robin.
> 
Dear Robin,
     We have test this patch on our mt8173, it also could work well.
Tested-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

     And I have 2 questiones about how to use this iommu.
     1)if We call "arch_setup_dma_ops" to create a iommu domain, then is
this function "bus_set_iommu" who also need "struct iommu_ops *"
necessary to be called or not in your design?
     2)int (*domain_init)(struct iommu_domain *domain);
       About this function, it will alloc pagetable for the iommu
domain. And We expect the pagetable memory is uncacheable, so try to
call "dma_alloc_coherent", unfortunately the "struct device *" can't be
passed into this function. so is it possible if adding a parameter in
this function.

 Thanks.
