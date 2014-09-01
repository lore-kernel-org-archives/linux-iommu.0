From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 2/7] dma-mapping: replace set_arch_dma_coherent_ops
	with arch_setup_dma_ops
Date: Mon, 1 Sep 2014 17:20:46 +0100
Message-ID: <20140901162046.GJ24594@arm.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
	<1409327670-3495-3-git-send-email-will.deacon@arm.com>
	<3185781.KdfsMO5OZS@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3185781.KdfsMO5OZS@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 01, 2014 at 03:27:30PM +0100, Arnd Bergmann wrote:
> On Friday 29 August 2014 16:54:25 Will Deacon wrote:
> > set_arch_dma_coherent_ops is called from of_dma_configure in order to
> > swizzle the architectural dma-mapping functions over to a cache-coherent
> > implementation. This is currently implemented only for ARM.
> > 
> > In anticipation of re-using this mechanism for IOMMU-backed dma-mapping
> > ops too, this patch replaces the function with a broader
> > arch_setup_dma_ops callback which is also responsible for setting the
> > DMA mask and offset as well as selecting the correct mapping functions.
> > 
> > A further advantage of this split is that it nicely isolates the
> > of-specific code from the dma-mapping code, allowing potential reuse by
> > other buses (e.g. PCI) in the future.
> > 
> > Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> 
> Looks good, just one tiny comment
> 
> > ---
> >  arch/arm/include/asm/dma-mapping.h | 20 ++++++++++++++----
> >  drivers/of/platform.c              | 42 ++++++++++----------------------------
> >  include/linux/dma-mapping.h        |  8 +++-----
> >  3 files changed, 30 insertions(+), 40 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> > index c45b61a4b4a5..936125ef3f3f 100644
> > --- a/arch/arm/include/asm/dma-mapping.h
> > +++ b/arch/arm/include/asm/dma-mapping.h
> > @@ -121,12 +121,24 @@ static inline unsigned long dma_max_pfn(struct device *dev)
> >  }
> >  #define dma_max_pfn(dev) dma_max_pfn(dev)
> >  
> > -static inline int set_arch_dma_coherent_ops(struct device *dev)
> > +static inline void arch_setup_dma_ops(struct device *dev, u64 mask,
> > +                                     unsigned long offset, bool coherent)
> >  {
> > -       set_dma_ops(dev, &arm_coherent_dma_ops);
> > -       return 0;
> > +       dev->coherent_dma_mask = mask;
> > +
> > +       /*
> > +        * Set dma_mask to coherent_dma_mask by default if the architecture
> > +        * code has not set it.
> > +        */
> > +       if (!dev->dma_mask)
> > +               dev->dma_mask = &dev->coherent_dma_mask;
> > +
> 
> We are in architecture specific code here, and we know that this
> architecture has not set up the dev->dma_mask pointer, so we can
> remove the 'if (!dev->dma_mask)'

Good point; I'll fix it.

Thanks,

Will
