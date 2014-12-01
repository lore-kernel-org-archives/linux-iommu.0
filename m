From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 2/8] dma-mapping: replace set_arch_dma_coherent_ops
	with arch_setup_dma_ops
Date: Mon, 1 Dec 2014 16:58:09 -0600
Message-ID: <CAL_JsqLtN3euwXHM4BzYxkXsgE=Dmn05aXzL+kr_8x23voneZA@mail.gmail.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<1417453034-21379-3-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1417453034-21379-3-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 1, 2014 at 10:57 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> set_arch_dma_coherent_ops is called from of_dma_configure in order to
> swizzle the architectural dma-mapping functions over to a cache-coherent
> implementation. This is currently implemented only for ARM.
>
> In anticipation of re-using this mechanism for IOMMU-backed dma-mapping
> ops too, this patch replaces the function with a broader
> arch_setup_dma_ops callback which will be extended in future.
>
> Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Acked-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Tested-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

One comment below, but for the DT parts:

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> ---
>  arch/arm/include/asm/dma-mapping.h |  8 ++++----
>  drivers/of/platform.c              | 31 +++++++++++++------------------
>  include/linux/dma-mapping.h        |  7 ++-----
>  3 files changed, 19 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index 85738b200023..dc3420e77758 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -121,12 +121,12 @@ static inline unsigned long dma_max_pfn(struct device *dev)
>  }
>  #define dma_max_pfn(dev) dma_max_pfn(dev)
>
> -static inline int set_arch_dma_coherent_ops(struct device *dev)
> +static inline void arch_setup_dma_ops(struct device *dev, bool coherent)
>  {
> -       set_dma_ops(dev, &arm_coherent_dma_ops);
> -       return 0;
> +       if (coherent)
> +               set_dma_ops(dev, &arm_coherent_dma_ops);
>  }
> -#define set_arch_dma_coherent_ops(dev) set_arch_dma_coherent_ops(dev)
> +#define arch_setup_dma_ops arch_setup_dma_ops
>
>  static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>  {
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 3b64d0bf5bba..ff1f4e9afccb 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -164,6 +164,8 @@ static void of_dma_configure(struct device *dev)
>  {
>         u64 dma_addr, paddr, size;
>         int ret;
> +       bool coherent;
> +       unsigned long offset;
>
>         /*
>          * Set default dma-mask to 32 bit. Drivers are expected to setup
> @@ -178,28 +180,21 @@ static void of_dma_configure(struct device *dev)
>         if (!dev->dma_mask)
>                 dev->dma_mask = &dev->coherent_dma_mask;
>
> -       /*
> -        * if dma-coherent property exist, call arch hook to setup
> -        * dma coherent operations.
> -        */
> -       if (of_dma_is_coherent(dev->of_node)) {
> -               set_arch_dma_coherent_ops(dev);
> -               dev_dbg(dev, "device is dma coherent\n");
> -       }
> -
> -       /*
> -        * if dma-ranges property doesn't exist - just return else
> -        * setup the dma offset
> -        */
>         ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
>         if (ret < 0) {
> -               dev_dbg(dev, "no dma range information to setup\n");
> -               return;
> +               dma_addr = offset = 0;
> +               size = dev->coherent_dma_mask;

It looks like size is not used.

> +       } else {
> +               offset = PFN_DOWN(paddr - dma_addr);
> +               dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", dev->dma_pfn_offset);
>         }
> +       dev->dma_pfn_offset = offset;
> +
> +       coherent = of_dma_is_coherent(dev->of_node);
> +       dev_dbg(dev, "device is%sdma coherent\n",
> +               coherent ? " " : " not ");
>
> -       /* DMA ranges found. Calculate and set dma_pfn_offset */
> -       dev->dma_pfn_offset = PFN_DOWN(paddr - dma_addr);
> -       dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", dev->dma_pfn_offset);
> +       arch_setup_dma_ops(dev, coherent);
>  }
>
>  /**
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index d5d388160f42..8a1560f95d4a 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -129,11 +129,8 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
>
>  extern u64 dma_get_required_mask(struct device *dev);
>
> -#ifndef set_arch_dma_coherent_ops
> -static inline int set_arch_dma_coherent_ops(struct device *dev)
> -{
> -       return 0;
> -}
> +#ifndef arch_setup_dma_ops
> +static inline void arch_setup_dma_ops(struct device *dev, bool coherent) { }
>  #endif
>
>  static inline unsigned int dma_get_max_seg_size(struct device *dev)
> --
> 2.1.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
