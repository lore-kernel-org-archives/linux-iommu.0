From: Robert Richter <robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 1/3] ACPI/IORT: Fixup SMMUv3 resource size for Cavium
	ThunderX2 SMMUv3 model
Date: Tue, 20 Jun 2017 10:19:43 +0200
Message-ID: <20170620081943.GT658@rric.localdomain>
References: <1496145821-3411-1-git-send-email-gakula@caviumnetworks.com>
	<1496145821-3411-2-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1496145821-3411-2-git-send-email-gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, sudeep.holla-5wv7dgnIgG8@public.gmane.org, sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 30.05.17 17:33:39, Geetha sowjanya wrote:
> From: Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> 
> Cavium ThunderX2 implementation doesn't support second page in SMMU
> register space. Hence, resource size is set as 64k for this model.
> 
> Signed-off-by: Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/acpi/arm64/iort.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index c5fecf9..bba2b59 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -833,12 +833,20 @@ static void __init arm_smmu_v3_init_resources(struct resource *res,
>  {
>  	struct acpi_iort_smmu_v3 *smmu;
>  	int num_res = 0;
> +	unsigned long size = SZ_128K;
>  
>  	/* Retrieve SMMUv3 specific data */
>  	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>  
> +	/*
> +	 * Override the size, for Cavium ThunderX2 implementation
> +	 * which doesn't support the page 1 SMMU register space.
> +	 */
> +	if (smmu->model == ACPI_IORT_SMMU_CAVIUM_CN99XX)

Geetha,

please resubmit the series since the macro changed to
ACPI_IORT_SMMU_V3_CAVIUM_CN99XX:

 https://github.com/acpica/acpica/commit/d00a4eb86e64bb4fa70f57ab5e5ca0a4ca2ad8ef#diff-a572aac2ccc26fe4a901616d7fdba859R1053

-Robert

> +		size = SZ_64K;
> +
>  	res[num_res].start = smmu->base_address;
> -	res[num_res].end = smmu->base_address + SZ_128K - 1;
> +	res[num_res].end = smmu->base_address + size - 1;
>  	res[num_res].flags = IORESOURCE_MEM;
>  
>  	num_res++;
> -- 
> 1.7.1
> 
