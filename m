From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] iommu-common: fix return type of iommu_tbl_range_alloc()
Date: Wed, 21 Oct 2015 21:12:54 +0200
Message-ID: <CAMuHMdXGM0ynDSv-_MdZptXeqJ=sU7=LChmihSCoqanVTUpWXQ@mail.gmail.com>
References: <55FBD36C.5070301@arm.com>
	<1442567375-6963-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <1442567375-6963-1-git-send-email-andre.przywara@arm.com>
Sender: sparclinux-owner@vger.kernel.org
To: Andre Przywara <andre.przywara@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Parisc List <linux-parisc@vger.kernel.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Hi Andre, J=C3=B6rg,

On Fri, Sep 18, 2015 at 11:09 AM, Andre Przywara <andre.przywara@arm.co=
m> wrote:
> Though iommu_tbl_range_alloc() is only used by Sparc code, the
> function itself lives in lib/iommu-common.c and is thus included in
> other architecture's code as well.
> When compiled on a 32-bit architecture using 64-bit DMA addresses
> (ARM with LPAE), there is a compiler warning about a type mismatch
> between dma_addr_t and the return type of this function:
>
> In file included from /src/linux/include/linux/dma-mapping.h:86:0,
>                  from /src/linux/lib/iommu-common.c:11:
> /src/linux/lib/iommu-common.c: In function 'iommu_tbl_range_alloc':
> /src/linux/arch/arm/include/asm/dma-mapping.h:16:24: warning: large i=
nteger implicitly truncated to unsigned type [-Woverflow]
>  #define DMA_ERROR_CODE (~(dma_addr_t)0x0)
>                         ^
> /src/linux/lib/iommu-common.c:127:10: note: in expansion of macro
> 'DMA_ERROR_CODE'
>    return DMA_ERROR_CODE;

While I welcome a fix for this annoying warning on arm...

> --- a/lib/iommu-common.c
> +++ b/lib/iommu-common.c
> @@ -99,15 +99,16 @@ void iommu_tbl_pool_init(struct iommu_map_table *=
iommu,
>  }
>  EXPORT_SYMBOL(iommu_tbl_pool_init);
>
> -unsigned long iommu_tbl_range_alloc(struct device *dev,
> -                               struct iommu_map_table *iommu,
> -                               unsigned long npages,
> -                               unsigned long *handle,
> -                               unsigned long mask,
> -                               unsigned int align_order)
> +dma_addr_t iommu_tbl_range_alloc(struct device *dev,
> +                                struct iommu_map_table *iommu,
> +                                unsigned long npages,
> +                                unsigned long *handle,
> +                                unsigned long mask,
> +                                unsigned int align_order)
>  {
>         unsigned int pool_hash =3D __this_cpu_read(iommu_hash_common)=
;
> -       unsigned long n, end, start, limit, boundary_size;
> +       dma_addr_t n;
> +       unsigned long end, start, limit, boundary_size;

=2E.. this doesn't look like the right fix.

Apparently 64-bit parisc doesn't set ARCH_DMA_ADDR_T_64BIT, hence assig=
ning
(64-bit) "unsigned long" to (32-bit) dma_addr_t will truncate the addre=
ss.

Does this function really need to return DMA_ERROR_CODE in case of
failure?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe sparclinux" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
