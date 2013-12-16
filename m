From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 5/6] iommu/tegra124: smmu: {TLB,PTC} reset value per SoC
Date: Mon, 16 Dec 2013 13:41:28 -0700
Message-ID: <52AF6578.60209@wwwdotorg.org>
References: <1386246319-17851-1-git-send-email-hdoyu@nvidia.com>
	<1386246319-17851-6-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1386246319-17851-6-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 12/05/2013 05:25 AM, Hiroshi Doyu wrote:
> T124 has some new register bits in {TLB,PTC}_CONFIG:
> 
> - TLB_RR_ARB and PTC_REQ_LIMIT
> - TLB_ACTIVE_LINES 0x20 instead of 0x10
> 
> They are defined as platform data now.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

> @@ -239,6 +240,8 @@ struct smmu_device {
>  	struct page *avp_vector_page;	/* dummy page shared by all AS's */
>  
>  	int nr_xlats;		/* number of translation_enable registers */
> +	u32 tlb_reset;		/* TLB config reset value */
> +	u32 ptc_reset;		/* PTC config reset value */

> @@ -1320,6 +1327,10 @@ static int tegra_smmu_probe(struct platform_device *pdev)

> +	smmu->tlb_reset = (pdata && pdata->tlb_reset) ? pdata->tlb_reset :
> +		(SMMU_TLB_CONFIG_RESET_VAL | 0x10);
> +	smmu->ptc_reset = (pdata && pdata->ptc_reset) ? pdata->ptc_reset :
> +		(SMMU_PTC_CONFIG_RESET_VAL | SMMU_PTC_REQ_LIMIT);

These two parts of this patch could be removed, given my suggestions re:
patch 3/6.
