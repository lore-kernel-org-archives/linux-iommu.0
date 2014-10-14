From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [RFC PATCH v3 5/7] dma-mapping: detect and configure IOMMU in
	of_dma_configure
Date: Tue, 14 Oct 2014 15:53:59 +0300
Message-ID: <4572757.M4IDlCz5Vc@avalon>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<20140922092909.GJ1470@ulmo> <20140922175027.GK7936@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140922175027.GK7936-5wv7dgnIgG8@public.gmane.org>
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
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Monday 22 September 2014 18:50:27 Will Deacon wrote:
> On Mon, Sep 22, 2014 at 10:29:10AM +0100, Thierry Reding wrote:
> > On Thu, Sep 18, 2014 at 02:17:33PM +0300, Laurent Pinchart wrote:
> >> On Friday 12 September 2014 17:34:53 Will Deacon wrote:
> >>> This patch extends of_dma_configure so that it sets up the IOMMU for a
> >>> device, as well as the coherent/non-coherent DMA mapping ops.
> >>> 
> >>> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> >>> ---
> >>> 
> >>>  arch/arm/include/asm/dma-mapping.h |  4 +++-
> >>>  drivers/of/platform.c              | 24 +++++++++++++++++-------
> >>>  include/linux/dma-mapping.h        |  8 +++++++-
> >>>  3 files changed, 27 insertions(+), 9 deletions(-)
> >>> 
> >>> diff --git a/arch/arm/include/asm/dma-mapping.h
> >>> b/arch/arm/include/asm/dma-mapping.h index 7e9ac4f604c3..a8bb0c494bb3
> >>> 100644
> >>> --- a/arch/arm/include/asm/dma-mapping.h
> >>> +++ b/arch/arm/include/asm/dma-mapping.h
> >>> @@ -121,7 +121,9 @@ static inline unsigned long dma_max_pfn(struct
> >>> device *dev)
> >>>  }
> >>>  #define dma_max_pfn(dev) dma_max_pfn(dev)
> >>> 
> >>> -static inline void arch_setup_dma_ops(struct device *dev, bool
> >>> coherent)
> >>> +static inline void arch_setup_dma_ops(struct device *dev, u64
> >>> dma_base,
> >>> +				      u64 size, struct iommu_dma_mapping *iommu,
> >>> +				      bool coherent)
> >>>  {
> >>>  	if (coherent)
> >>>  		set_dma_ops(dev, &arm_coherent_dma_ops);
> >>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> >>> index 946dd7ae0394..95ebd38db545 100644
> >>> --- a/drivers/of/platform.c
> >>> +++ b/drivers/of/platform.c
> >>> @@ -19,6 +19,7 @@
> >>>  #include <linux/slab.h>
> >>>  #include <linux/of_address.h>
> >>>  #include <linux/of_device.h>
> >>> +#include <linux/of_iommu.h>
> >>>  #include <linux/of_irq.h>
> >>>  #include <linux/of_platform.h>
> >>>  #include <linux/platform_device.h>
> >>> @@ -166,6 +167,7 @@ static void of_dma_configure(struct
> >>> platform_device *pdev)
> >>>  	int ret;
> >>>  	bool coherent;
> >>>  	unsigned long offset;
> >>> +	struct iommu_dma_mapping *iommu;
> >>>  	struct device *dev = &pdev->dev;
> >>>  	
> >>>  	/*
> >>> @@ -195,7 +197,19 @@ static void of_dma_configure(struct
> >>> platform_device *pdev)
> >>>  	dev_dbg(dev, "device is%sdma coherent\n",
> >>>  		coherent ? " " : " not ");
> >>> 
> >>> -	arch_setup_dma_ops(dev, coherent);
> >>> +	iommu = of_iommu_configure(dev);
> >>> +	dev_dbg(dev, "device is%sbehind an iommu\n",
> >>> +		iommu ? " " : " not ");
> >>> +
> >>> +	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
> >>> +
> >>> +	if (iommu)
> >>> +		kref_put(&iommu->kref, of_iommu_deconfigure);
> >> 
> >> What's the expected life cycle of the iommu_dma_mapping structure ? It
> >> gets created by of_iommu_configure() and the initial reference gets
> >> dropped here. I suppose you expect arch code to need to keep a reference
> >> to the structure, but your implementation in patch 7/7 doesn't. As far as
> >> I can see, you don't even use the contents of the structure in the ARM
> >> arch_setup_dma_ops() implementation. Do you expect that to change later,
> >> or other architectures to need it ?
> >> 
> >> By the way, now that I think about it, I find struct iommu_dma_mapping
> >> and struct dma_iommu_mapping very confusing.
> > 
> > Agreed. I wonder how useful it is to know the set of IOMMU instances
> > that each device can master through. Wouldn't it be more useful to keep
> > a list of master interfaces for each device? The set of IOMMU instances
> > can trivially be derived from that.
> 
> I'm struggling to think how that would look. What do you mean by `master
> interfaces' in terms of the code we have in Linux? At the end of the day,
> the list of IOMMU instances (i.e. iommu_dma_mapping) exists because you
> and Laurent have use-cases involving devices mastering through multiple
> IOMMUs. If it doesn't work for you, it might be best for you to send me
> the patch ;)

Just for the record, I've brought up the topic of masters being served by 
multiple IOMMUs, but don't have a use case for it (yet at least). I do have 
masters served through multiple streams with separate stream IDs, but all by 
the same IOMMU.

-- 
Regards,

Laurent Pinchart
