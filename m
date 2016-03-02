From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v2: Workaround for ThunderX errata#27704
Date: Wed, 2 Mar 2016 03:07:56 +0000
Message-ID: <20160302030756.GC7637@arm.com>
References: <1456348433-3337-1-git-send-email-tchalamarla@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456348433-3337-1-git-send-email-tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, Geethasowjanya.Akula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 24, 2016 at 01:13:53PM -0800, Tirumalesh Chalamarla wrote:
> Due to Errata#27704 CN88xx SMMUv2,supports  only shared ASID and VMID
> namespaces; specifically within a given node SMMU0 and SMMU1 share,
> as does SMMU2 and SMMU3.
> 
> This patch address these issuee by supplying asid and vmid
> while calculating ASID and VMID for Thunder SMMUv2.
> 
> NOTE: resending with commit message fix.
> 
> changes from V2:
> 	- removed *_base from DT, and replaced with compatible string
> 
> changes from V1:
> 	- rebased on top of 16 bit VMID patch
> 	- removed redundent options from DT
> 	- insted of transform, DT now supplies starting ASID/VMID
> 
> Signed-off-by: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
> Signed-off-by: Akula Geethasowjanya <Geethasowjanya.Akula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.txt         |  1 +
>  drivers/iommu/arm-smmu.c                           | 48 +++++++++++++++++-----
>  2 files changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 7180745..19fe6f2 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -16,6 +16,7 @@ conditions.
>                          "arm,mmu-400"
>                          "arm,mmu-401"
>                          "arm,mmu-500"
> +                        "cavium,smmu-v2"
>  
>                    depending on the particular implementation and/or the
>                    version of the architecture implemented.
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 247a469..c704f88 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -326,6 +326,12 @@ struct arm_smmu_device {
>  
>  	struct list_head		list;
>  	struct rb_root			masters;
> +	/*
> +	 *The following fields are specific to Cavium, Thunder
> +	 */
> +	u32				cavium_smmu_id;

Why do you need this field as well as the base?

> +	u32				cavium_id_base;
> +
>  };
>  
>  struct arm_smmu_cfg {
> @@ -335,8 +341,8 @@ struct arm_smmu_cfg {
>  };
>  #define INVALID_IRPTNDX			0xff
>  
> -#define ARM_SMMU_CB_ASID(cfg)		((cfg)->cbndx)
> -#define ARM_SMMU_CB_VMID(cfg)		((cfg)->cbndx + 1)
> +#define ARM_SMMU_CB_ASID(smmu, cfg) ((u16)(smmu)->cavium_id_base + (cfg)->cbndx)
> +#define ARM_SMMU_CB_VMID(smmu, cfg) ((u16)(smmu)->cavium_id_base + (cfg)->cbndx + 1)
>  
>  enum arm_smmu_domain_stage {
>  	ARM_SMMU_DOMAIN_S1 = 0,
> @@ -364,6 +370,8 @@ struct arm_smmu_option_prop {
>  	const char *prop;
>  };
>  
> +static int cavium_smmu_count;

I'd be more comfortable if this was an atomic_t.

> +	/*
> +	 * Due to Errata#27704 CN88xx SMMUv2,supports  only shared ASID and VMID
> +	 * namespaces; specifically within a given node SMMU0 and SMMU1 share,
> +	 * as does SMMU2 and SMMU3. see if this is a Cavium SMMU, if so
> +	 * set asid and vmid base such that each SMMU gets unique
> +	 * asid/vmid space.
> +	 */
> +	if (!strcasecmp(of_id->compatible, "cavium,smmu-v2")) {

of_device_is_compatible

> +		/* VMID16 must be present on Cavium SMMUv2*/
> +		if (!(smmu->features & ARM_SMMU_FEAT_VMID16))
> +			goto out_free_irqs;

This check seems a bit overkill. I think you can remove it.

> +		smmu->cavium_smmu_id = cavium_smmu_count;
> +		cavium_smmu_count++;
> +		smmu->cavium_id_base =
> +			(smmu->cavium_smmu_id * ARM_SMMU_MAX_CBS);

Can you not use num_context_banks here, instead of the constant?

Will
