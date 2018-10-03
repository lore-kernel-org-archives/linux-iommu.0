From: Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal memory size
Date: Wed, 3 Oct 2018 16:10:42 -0700
Message-ID: <CAKgT0Ucii29i7S8eCj20D=a+=DeyKxREG0U2DBNRp3jFpgLu_A@mail.gmail.com>
References: <20180927223539.28449-1-hch@lst.de> <20180927223539.28449-6-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180927223539.28449-6-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>
Cc: "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 27, 2018 at 3:38 PM Christoph Hellwig <hch@lst.de> wrote:
>
> This way an architecture with less than 4G of RAM can support dma_mask
> smaller than 32-bit without a ZONE_DMA.  Apparently that is a common
> case on powerpc.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  kernel/dma/direct.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 60c433b880e0..170bd322a94a 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -284,21 +284,25 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>         return nents;
>  }
>
> +/*
> + * Because 32-bit DMA masks are so common we expect every architecture to be
> + * able to satisfy them - either by not supporting more physical memory, or by
> + * providing a ZONE_DMA32.  If neither is the case, the architecture needs to
> + * use an IOMMU instead of the direct mapping.
> + */
>  int dma_direct_supported(struct device *dev, u64 mask)
>  {
> -#ifdef CONFIG_ZONE_DMA
> -       if (mask < phys_to_dma(dev, DMA_BIT_MASK(ARCH_ZONE_DMA_BITS)))
> -               return 0;
> -#else
> -       /*
> -        * Because 32-bit DMA masks are so common we expect every architecture
> -        * to be able to satisfy them - either by not supporting more physical
> -        * memory, or by providing a ZONE_DMA32.  If neither is the case, the
> -        * architecture needs to use an IOMMU instead of the direct mapping.
> -        */
> -       if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
> +       u64 min_mask;
> +
> +       if (IS_ENABLED(CONFIG_ZONE_DMA))
> +               min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
> +       else
> +               min_mask = DMA_BIT_MASK(32);
> +
> +       min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
> +
> +       if (mask >= phys_to_dma(dev, min_mask))
>                 return 0;
> -#endif
>         return 1;
>  }

So I believe I have run into the same issue that Guenter reported. On
an x86_64 system w/ Intel IOMMU. I wasn't able to complete boot and
all probe attempts for various devices were failing with -EIO errors.

I believe the last mask check should be "if (mask < phys_to_dma(dev,
min_mask))" not a ">=" check.

- Alex
