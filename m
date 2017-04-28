From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] drivers/of_iommu: ignore SMMU DT nodes with status
 'disabled'
Date: Fri, 28 Apr 2017 14:11:33 +0100
Message-ID: <20170428131133.GJ13675@arm.com>
References: <20170414124315.2401-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170414124315.2401-1-ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Ard,

[+ devicetree@]

On Fri, Apr 14, 2017 at 01:43:15PM +0100, Ard Biesheuvel wrote:
> DT nodes may have a status property, and if they do, such nodes should
> only be considered present if the status property is set to 'okay'.
> 
> Currently, we call the init function of IOMMUs described by the device
> tree without taking this into account, which may result in the output
> below on systems where some SMMUs may be legally disabled.
> 
>  Failed to initialise IOMMU /smb/smmu@e0200000
>  Failed to initialise IOMMU /smb/smmu@e0c00000
>  arm-smmu e0a00000.smmu: probing hardware configuration...
>  arm-smmu e0a00000.smmu: SMMUv1 with:
>  arm-smmu e0a00000.smmu:  stage 2 translation
>  arm-smmu e0a00000.smmu:  coherent table walk
>  arm-smmu e0a00000.smmu:  stream matching with 32 register groups, mask 0x7fff
>  arm-smmu e0a00000.smmu:  8 context banks (8 stage-2 only)
>  arm-smmu e0a00000.smmu:  Supported page sizes: 0x60211000
>  arm-smmu e0a00000.smmu:  Stage-2: 40-bit IPA -> 40-bit PA
>  Failed to initialise IOMMU /smb/smmu@e0600000
>  Failed to initialise IOMMU /smb/smmu@e0800000
> 
> Since this is not an error condition, only call the init function if
> the device is enabled, which also inhibits the spurious error messages.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/iommu/of_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 2683e9fc0dcf..2dd1206e6c0d 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -183,7 +183,7 @@ static int __init of_iommu_init(void)
>  	for_each_matching_node_and_match(np, matches, &match) {
>  		const of_iommu_init_fn init_fn = match->data;
>  
> -		if (init_fn(np))
> +		if (of_device_is_available(np) && init_fn(np))
>  			pr_err("Failed to initialise IOMMU %s\n",
>  				of_node_full_name(np));
>  	}

Is there a definition of what status = "disabled" is supposed to mean for an
IOMMU? For example, that could mean that the firmware has pre-programmed the
SMMU with particular translations or memory attributes (a bit like the
CCA=1, CPM=1, DACS=0 case in ACPI IORT), or even disabled DMA traffic
altogether.

So I think we'd need an update to the generic IOMMU binding text to say
exactly what the semantics are supposed to be here.

Will
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
