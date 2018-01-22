From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: limit reporting of MSI allocation
	failures
Date: Mon, 22 Jan 2018 11:45:14 +0000
Message-ID: <39eee30e-1298-24d5-926b-9cd7fe532e59@arm.com>
References: <1516471684-25052-1-git-send-email-nwatters@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1516471684-25052-1-git-send-email-nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
To: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 20/01/18 18:08, Nate Watterson wrote:
> Currently, the arm-smmu-v3 driver expects to allocate MSIs for all SMMUs
> with FEAT_MSI set. This results in unwarranted "failed to allocate MSIs"
> warnings being printed on systems where FW was either deliberately
> configured to force the use of SMMU wired interrupts -or- is altogether
> incapable of describing SMMU MSI topology (ACPI IORT prior to rev.C).
> 
> Remedy this by checking msi_domain before attempting to allocate SMMU
> MSIs.
> 
> Signed-off-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 744592d..00de028 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2328,10 +2328,15 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>  	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
>  		return;
>  
> +	if (!dev->msi_domain) {
> +		dev_info(smmu->dev, "msi_domain absent - falling back to wired irqs\n");
> +		return;
> +	}
> +
>  	/* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
>  	ret = platform_msi_domain_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
>  	if (ret) {
> -		dev_warn(dev, "failed to allocate MSIs\n");
> +		dev_warn(dev, "failed to allocate MSIs - falling back to wired irqs\n");
>  		return;
>  	}
>  
> 

Acked-by: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>

	M.
-- 
Jazz is not dead. It just smells funny...
