From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] iommu: exynos: pointers are nto physical addresses
Date: Mon, 29 Feb 2016 10:33:59 +0100
Message-ID: <56D41087.60506@samsung.com>
References: <1456735568-3886545-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1456735568-3886545-1-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Arnd,

On 2016-02-29 09:45, Arnd Bergmann wrote:
> The exynos iommu driver changed an incorrect cast from pointer
> to 'unsigned int' to an equally incorrect cast to a 'phys_addr_t',
> which results in an obvious compile-time error when phys_addr_t
> is wider than pointers are:
>
> drivers/iommu/exynos-iommu.c: In function 'alloc_lv2entry':
> drivers/iommu/exynos-iommu.c:918:32: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>
> The code does not actually want the physical address (which would
> involve using virt_to_phys()), but just checks the alignment,
> so we can change it to use a cast to uintptr_t instead.
>
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Fixes: 740a01eee9ad ("iommu/exynos: Add support for v5 SYSMMU")

Thanks for this fix.

> ---
> I also see that some incorrect __raw_writel() calls have crept in
> around the same time, which breaks running big-endian kernels when
> this driver is loaded.
>
> Please fix and that that as well.

Okay, so in the driver code all __raw_writel should be replaced by
writel(), right?

Those __raw_writel() calls were there from the beginning and I didn't
know that they should not be used in the driver code.

>   drivers/iommu/exynos-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index b0665042bf29..484b3b37631f 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -915,7 +915,7 @@ static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *domain,
>   		bool need_flush_flpd_cache = lv1ent_zero(sent);
>   
>   		pent = kmem_cache_zalloc(lv2table_kmem_cache, GFP_ATOMIC);
> -		BUG_ON((phys_addr_t)pent & (LV2TABLE_SIZE - 1));
> +		BUG_ON((uintptr_t)pent & (LV2TABLE_SIZE - 1));
>   		if (!pent)
>   			return ERR_PTR(-ENOMEM);
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
