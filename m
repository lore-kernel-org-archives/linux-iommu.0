From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] [v2] dma-mapping: work around clang bug
Date: Thu, 7 Mar 2019 09:17:08 +0000
Message-ID: <86b7f396-c525-ae7e-b51c-cb2442d8d507@arm.com>
References: <20190307085246.1477426-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190307085246.1477426-1-arnd-r2nGTMty4D4@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Nick Desaulniers <ndesaulniers-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Jesper Dangaard Brouer <brouer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Arnd,

On 2019-03-07 8:52 am, Arnd Bergmann wrote:
> Clang has a rather annoying behavior of checking for integer
> arithmetic problems in code paths that are discarded by gcc
> before that perfoms the same checks.
> 
> For DMA_BIT_MASK(64), this leads to a warning despite the
> result of the macro being completely sensible:
> 
> arch/arm/plat-iop/adma.c:146:24: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
>                  .coherent_dma_mask = DMA_BIT_MASK(64),
> 
> The best workaround I could come up with is to shift the
> value twice, which makes the macro way less readable but
> always has the same result.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=38789
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> ---
> v2: fix off-by-one error
> ---
>   include/linux/dma-mapping.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 75e60be91e5f..9e438fe6b130 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -138,7 +138,8 @@ struct dma_map_ops {
>   extern const struct dma_map_ops dma_virt_ops;
>   extern const struct dma_map_ops dma_dummy_ops;
>   
> -#define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> +/* double shift to work around https://bugs.llvm.org/show_bug.cgi?id=38789 */
> +#define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<((n)-1))<<1)-1)

I think that now makes DMA_BIT_MASK(0) undefined - that shouldn't matter 
in most cases, but it could potentially happen at runtime where callers 
use a non-constant argument. However, it also means we don't need to 
special-case 64 any more (since that's there to avoid the same thing 
anyway), so we could simply flip that to handle 0 instead.

FWIW I'd be very tempted to fold in the second shift as "2ULL<<((n)-1)", 
but that may not be to everyone's taste.

Robin.

>   
>   #define DMA_MASK_NONE	0x0ULL
>   
> 
