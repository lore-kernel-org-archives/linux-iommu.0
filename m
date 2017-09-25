From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm-v7s: Need dma-sync while there is no
	QUIRK_NO_DMA
Date: Mon, 25 Sep 2017 10:47:35 +0100
Message-ID: <cd5a5dc4-85c2-b923-1110-d69d7b0d7aea@arm.com>
References: <1506331727-25018-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1506331727-25018-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 25/09/17 10:28, Yong Wu wrote:
> Fix the commit 81b3c2521844 ("iommu/io-pgtable: Introduce explicit
> coherency"). If there is no IO_PGTABLE_QUIRK_NO_DMA, we should call
> dma_sync_single_for_device for cache synchronization.

Oops!

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Thanks,
Robin.

> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
> Rebased on v4.14-rc1.
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index d665d0d..6961fc3 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -245,7 +245,7 @@ static void __arm_v7s_free_table(void *table, int lvl,
>  static void __arm_v7s_pte_sync(arm_v7s_iopte *ptep, int num_entries,
>  			       struct io_pgtable_cfg *cfg)
>  {
> -	if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA))
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA)
>  		return;
>  
>  	dma_sync_single_for_device(cfg->iommu_dev, __arm_v7s_dma_addr(ptep),
> 
