From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: suppress MSI allocation failure
 message
Date: Wed, 17 Jan 2018 18:54:02 +0000
Message-ID: <2f651cfe-e006-cf1d-b624-08e2ba5340fc@arm.com>
References: <1516214399-24012-1-git-send-email-nwatters@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516214399-24012-1-git-send-email-nwatters@codeaurora.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Nate Watterson <nwatters@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Sinan Kaya <okaya@codeaurora.org>, Marc Zyngier <marc.zyngier@arm.com>
List-Id: iommu@lists.linux-foundation.org

[ +Marc just in case ]

On 17/01/18 18:39, Nate Watterson wrote:
> From: Sinan Kaya <okaya@codeaurora.org>
> 
> Even though QDF2400 supports MSI interrupts with SMMUv3, it is not enabled
> in ACPI FW to preserve compatibility with older kernel versions. Code is
> emitting warning message during boot.
> 
> This is causing some test tools to record a false warning and is causing
> support issues.
> 
> Better reduce the message level.

Ugh, that's unfortunate, since there are also plenty of genuine error 
conditions encapsulated in there which we *would* want to report as such 
(but still then fall back to wired IRQs if possible). Is the return 
value sufficient to differentiate the "there is no MSI parent" and 
"there are MSIs but something went wrong" cases, or is it more 
complicated than that?

Robin.

> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
> ---
>   drivers/iommu/arm-smmu-v3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 744592d..2118fda 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2331,7 +2331,7 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>   	/* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
>   	ret = platform_msi_domain_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
>   	if (ret) {
> -		dev_warn(dev, "failed to allocate MSIs\n");
> +		dev_info(dev, "failed to allocate MSIs\n");
>   		return;
>   	}
>   
> 
