From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 2/2] arm64: Use gfpflags_allow_blocking()
Date: Fri, 16 Oct 2015 13:59:00 -0700
Message-ID: <20151016135900.bc1e10115a866a301dbb0cd8@linux-foundation.org>
References: <ecbbf6550654071f13d1bdc04b86dc4d69ad09b4.1445008695.git.robin.murphy@arm.com>
	<adf855c7692b1512ab7216579468ad1eef2f25a8.1445008695.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <adf855c7692b1512ab7216579468ad1eef2f25a8.1445008695.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, Mel Gorman <mgorman-3eNAlZScCAx27rWaFMvyedHuzzzSOjJt@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 16 Oct 2015 16:33:42 +0100 Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:

> __GFP_WAIT is going away to live its life under a new identity; convert
> __iommu_alloc_attrs() to the new helper function instead.
> 
> ...
>
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -566,7 +566,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>  	 */
>  	gfp |= __GFP_ZERO;
>  
> -	if (gfp & __GFP_WAIT) {
> +	if (gfpflags_allow_blocking(gfp)) {
>  		struct page **pages;
>  		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);

Seems unnecessarily elaborate.  What's wrong with

--- a/arch/arm64/mm/dma-mapping.c~mm-page_alloc-rename-__gfp_wait-to-__gfp_reclaim-arm-fix
+++ a/arch/arm64/mm/dma-mapping.c
@@ -562,7 +562,7 @@ static void *__iommu_alloc_attrs(struct
 	 */
 	gfp |= __GFP_ZERO;
 
-	if (gfp & __GFP_WAIT) {
+	if (gfp & __GFP_RECLAIM) {
 		struct page **pages;
 		pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);
 

?
