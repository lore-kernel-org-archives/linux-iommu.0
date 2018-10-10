From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Remove unnecessary wrapper function
Date: Wed, 10 Oct 2018 11:42:30 +0100
Message-ID: <0ec6edcf-1ac6-7dfd-c494-a006ab9538b1@arm.com>
References: <1539167367-20471-1-git-send-email-andrew.murray@arm.com>
	<1539167367-20471-3-git-send-email-andrew.murray@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1539167367-20471-3-git-send-email-andrew.murray-5wv7dgnIgG8@public.gmane.org>
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
To: Andrew Murray <andrew.murray-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 10/10/18 11:29, Andrew Murray wrote:
> Simplify the code by removing an unnecessary wrapper function.
> 
> This was left behind by commit 2f657add07a8
> ("iommu/arm-smmu-v3: Specialise CMD_SYNC handling")

Oops, sorry about that ;)

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

> Signed-off-by: Andrew Murray <andrew.murray-5wv7dgnIgG8@public.gmane.org>
> ---
>   drivers/iommu/arm-smmu-v3.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index c7bd18e..6947ccf 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1371,15 +1371,11 @@ static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
>   }
>   
>   /* IO_PGTABLE API */
> -static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
> -{
> -	arm_smmu_cmdq_issue_sync(smmu);
> -}
> -
>   static void arm_smmu_tlb_sync(void *cookie)
>   {
>   	struct arm_smmu_domain *smmu_domain = cookie;
> -	__arm_smmu_tlb_sync(smmu_domain->smmu);
> +
> +	arm_smmu_cmdq_issue_sync(smmu_domain->smmu);
>   }
>   
>   static void arm_smmu_tlb_inv_context(void *cookie)
> @@ -1404,7 +1400,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>   	 * to guarantee those are observed before the TLBI. Do be careful, 007.
>   	 */
>   	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
> -	__arm_smmu_tlb_sync(smmu);
> +	arm_smmu_cmdq_issue_sync(smmu);
>   }
>   
>   static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
> @@ -1793,7 +1789,7 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
>   	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
>   
>   	if (smmu)
> -		__arm_smmu_tlb_sync(smmu);
> +		arm_smmu_cmdq_issue_sync(smmu);
>   }
>   
>   static phys_addr_t
> 
