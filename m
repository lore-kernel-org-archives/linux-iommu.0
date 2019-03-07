From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] dma-mapping: work around clang bug
Date: Thu, 7 Mar 2019 09:28:32 +0100
Message-ID: <CAMuHMdVBBaV8UPqUZUZXy3c9E3zUmVUEZyEEbDs4LaJ9OHncDA@mail.gmail.com>
References: <20190307080038.3727426-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307080038.3727426-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Nick Desaulniers <ndesaulniers@google.com>, Robin Murphy <robin.murphy@arm.com>, Jesper Dangaard Brouer <brouer@redhat.com>, Paul Burton <paul.burton@mips.com>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Arnd,

On Thu, Mar 7, 2019 at 9:01 AM Arnd Bergmann <arnd@arndb.de> wrote:
> Clang has a rather annoying behavior of checking for integer
> arithmetic problems in code paths that are discarded by gcc
> before that perfoms the same checks.
>
> For DMA_BIT_MASK(64), this leads to a warning despite the
> result of the macro being completely sensible:
>
> arch/arm/plat-iop/adma.c:146:24: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
>                 .coherent_dma_mask = DMA_BIT_MASK(64),
>
> The best workaround I could come up with is to shift the
> value twice, which makes the macro way less readable but
> always has the same result.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=38789
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/dma-mapping.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 75e60be91e5f..380d3a95d02e 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -138,7 +138,8 @@ struct dma_map_ops {
>  extern const struct dma_map_ops dma_virt_ops;
>  extern const struct dma_map_ops dma_dummy_ops;
>
> -#define DMA_BIT_MASK(n)        (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> +/* double shift to work around https://bugs.llvm.org/show_bug.cgi?id=38789 */
> +#define DMA_BIT_MASK(n)        (((n) == 64) ? ~0ULL : (((1ULL<<((n)-1))-1) << 1))

The second "-1" should be done on the final result, not on the
intermediate value.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
