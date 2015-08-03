From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 13/13] iommu/arm-smmu: Treat unknown OAS as 48-bit
Date: Mon, 3 Aug 2015 21:23:14 +0300
Message-ID: <55BFB192.1040505@cogentembedded.com>
References: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
	<1438608355-7335-14-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438608355-7335-14-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: marc.zyngier-5wv7dgnIgG8@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello.

On 08/03/2015 04:25 PM, Will Deacon wrote:

> A late change to the SMMUv3 architecture ensures that the OAS field
> will be monotonically increasing, so we can assume that an unknown OAS
> is at least 48-bit and use that, rather than fail the device probe.

> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>   drivers/iommu/arm-smmu-v3.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 15fb669282b4..a435e706226a 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2528,12 +2528,11 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
>   	case IDR5_OAS_44_BIT:
>   		smmu->oas = 44;
>   		break;
> +	default:
> +		dev_info(smmu->dev,
> +			"unknown output address size. Truncating to 48-bit\n");

    Please add a comment like /* FALLTHRU */ here.

>   	case IDR5_OAS_48_BIT:
>   		smmu->oas = 48;
> -		break;
> -	default:
> -		dev_err(smmu->dev, "unknown output address size!\n");
> -		return -ENXIO;
>   	}
>
>   	/* Set the DMA mask for our table walker */

MBR, Sergei
