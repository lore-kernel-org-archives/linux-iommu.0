From: Benjamin Serebrin via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH 3/7] iommu: correct flush_unmaps pfn usage
Date: Mon, 11 Apr 2016 13:11:43 -0700
Message-ID: <CAN+hb0UhRG-6sqk9JE6wb5xPE5XbOn1GP0NtuoXG_zVzm=aaHw@mail.gmail.com>
References: <20151228161621.GA27872@cs.technion.ac.il>
Reply-To: Benjamin Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151228161621.GA27872-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Cc: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Dan Tsafrir <dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Reviewed-by: Ben Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>

Looks good.

On Mon, Dec 28, 2015 at 8:16 AM, Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org> wrote:
> From: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
>
> Change flush_unmaps() to correctly pass iommu_flush_iotlb_psi()
> dma addresses.  (Intel mm and dma have the same size for pages
> at the moment, but this usage improves consistency.)
>
> Signed-off-by: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
> [mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org: rebased and reworded the commit message]
> Signed-off-by: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 5b3530c..6d6229e 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3463,7 +3463,8 @@ static void flush_unmaps(struct deferred_flush_data *flush_data)
>                         /* On real hardware multiple invalidations are expensive */
>                         if (cap_caching_mode(iommu->cap))
>                                 iommu_flush_iotlb_psi(iommu, domain,
> -                                       iova->pfn_lo, iova_size(iova),
> +                                       mm_to_dma_pfn(iova->pfn_lo),
> +                                       mm_to_dma_pfn(iova_size(iova)),
>                                         !freelist, 0);
>                         else {
>                                 mask = ilog2(mm_to_dma_pfn(iova_size(iova)));
> --
> 1.9.1
>
