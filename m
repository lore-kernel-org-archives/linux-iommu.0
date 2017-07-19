From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/5] iommu/arm-smmu-v3: add IOMMU_CAP_BYPASS to the ARM
 SMMUv3 driver
Date: Wed, 19 Jul 2017 12:00:54 +0100
Message-ID: <ace28bd1-2dd3-482c-d11b-539c055ee9b7@arm.com>
References: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
 <1500456838-18405-4-git-send-email-anup.patel@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500456838-18405-4-git-send-email-anup.patel@broadcom.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Anup Patel <anup.patel@broadcom.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
List-Id: iommu@lists.linux-foundation.org

On 19/07/17 10:33, Anup Patel wrote:
> The ARM SMMUv3 support bypassing transactions for which domain
> is not configured. The patch adds corresponding IOMMU capability
> to advertise this fact.
> 
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 568c400..a6c7f66 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1423,6 +1423,8 @@ static bool arm_smmu_capable(enum iommu_cap cap)
>  		return true;
>  	case IOMMU_CAP_NOEXEC:
>  		return true;
> +	case IOMMU_CAP_BYPASS:
> +		return true;

And this is never true. If Linux knows a device masters through the
SMMU, it will always have a default domain of some sort (either identity
or DMA ops). If Linux doesn't know, then it won't have been able to
initialise the stream table for the relevant stream IDs, thus any
'bypass' DMA is going to raise C_BAD_STE. SMMUv3 can effectively only
bypass unknown stream IDs if disabled entirely.

Robin.

>  	default:
>  		return false;
>  	}
> 
