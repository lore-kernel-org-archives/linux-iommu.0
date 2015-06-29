From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/8] iommu/arm-smmu: fix the index calculation of strtab
Date: Mon, 29 Jun 2015 18:17:55 +0100
Message-ID: <20150629171755.GI17474@arm.com>
References: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
	<1435307584-9812-3-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435307584-9812-3-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: "huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 26, 2015 at 09:32:58AM +0100, Zhen Lei wrote:
> The element size of cfg->strtab is just one DWORD, should use multiply
> operation.

Nice catch. Turns out all my emulated PCI devices sit on bus 0, so this
didn't show up in testing.

Will

> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index ba7fe2d..2a5f810 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1064,7 +1064,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
>  		return 0;
> 
>  	size = 1 << (STRTAB_SPLIT + ilog2(STRTAB_STE_DWORDS) + 3);
> -	strtab = &cfg->strtab[sid >> STRTAB_SPLIT << STRTAB_L1_DESC_DWORDS];
> +	strtab = &cfg->strtab[(sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS];
> 
>  	desc->span = STRTAB_SPLIT + 1;
>  	desc->l2ptr = dma_zalloc_coherent(smmu->dev, size, &desc->l2ptr_dma,
> --
> 1.8.0
> 
> 
