From: Robert Richter <robert.richter@cavium.com>
Subject: Re: [PATCH v3 5/7] ACPI/IORT: Fixup SMMUv3 resource size for Cavium
 ThunderX2 SMMUv3 model
Date: Sat, 6 May 2017 00:19:34 +0200
Message-ID: <20170505221934.GX16981@rric.localdomain>
References: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
 <1493986091-30521-6-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493986091-30521-6-git-send-email-gakula@caviumnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Geetha sowjanya <gakula@caviumnetworks.com>
Cc: will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, iommu@lists.linux-foundation.org, jcm@redhat.com, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, geethasowjanya.akula@gmail.com, linu.cherian@cavium.com, Charles.Garcia-Tobin@arm.com, Geetha Sowjanya <geethasowjanya.akula@cavium.com>
List-Id: iommu@lists.linux-foundation.org

On 05.05.17 17:38:09, Geetha sowjanya wrote:
> From: Linu Cherian <linu.cherian@cavium.com>
> 
> Cavium ThunderX2 implementation doesn't support second page in SMMU
> register space. Hence, resource size is set as 64k for this model.
> 
> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
> ---
>  drivers/acpi/arm64/iort.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

The whole patch can be dropped. See my comment in #2.

-Robert

> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index c5fecf9..23c5350 100644
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
> +	if (smmu->model == ACPI_IORT_SMMU_V3_CAVIUM_CN99XX)
> +		size = SZ_64K;
> +
>  	res[num_res].start = smmu->base_address;
> -	res[num_res].end = smmu->base_address + SZ_128K - 1;
> +	res[num_res].end = smmu->base_address + size - 1;
>  	res[num_res].flags = IORESOURCE_MEM;
>  
>  	num_res++;
> -- 
> 1.8.3.1
> 
