From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v8 1/3] ACPI/IORT: Fixup SMMUv3 resource size for Cavium
	ThunderX2 SMMUv3 model
Date: Tue, 20 Jun 2017 20:27:47 +0100
Message-ID: <20170620192747.GA30990@red-moon>
References: <1497968259-16390-1-git-send-email-gakula@caviumnetworks.com>
	<1497968259-16390-2-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1497968259-16390-2-git-send-email-gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
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
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, sudeep.holla-5wv7dgnIgG8@public.gmane.org, sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 20, 2017 at 07:47:37PM +0530, Geetha sowjanya wrote:
> From: Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> 
> Cavium ThunderX2 implementation doesn't support second page in SMMU
> register space. Hence, resource size is set as 64k for this model.
> 
> Signed-off-by: Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/acpi/arm64/iort.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletions(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index c5fecf9..c166f3e 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -828,6 +828,18 @@ static int __init arm_smmu_v3_count_resources(struct acpi_iort_node *node)
>  	return num_res;
>  }
>  
> +static unsigned long arm_smmu_v3_resource_size(struct acpi_iort_smmu_v3 *smmu)
> +{
> +	/*
> +	 * Override the size, for Cavium ThunderX2 implementation
> +	 * which doesn't support the page 1 SMMU register space.
> +	 */
> +	if (smmu->model == ACPI_IORT_SMMU_V3_CAVIUM_CN99XX)
> +		return SZ_64K;
> +
> +	return SZ_128K;
> +}
> +
>  static void __init arm_smmu_v3_init_resources(struct resource *res,
>  					      struct acpi_iort_node *node)
>  {
> @@ -838,7 +850,8 @@ static void __init arm_smmu_v3_init_resources(struct resource *res,
>  	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>  
>  	res[num_res].start = smmu->base_address;
> -	res[num_res].end = smmu->base_address + SZ_128K - 1;
> +	res[num_res].end = smmu->base_address +
> +				arm_smmu_v3_resource_size(smmu) - 1;
>  	res[num_res].flags = IORESOURCE_MEM;
>  
>  	num_res++;
> -- 
> 1.7.1
> 
