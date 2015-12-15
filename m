From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] IOMMU: arm-smmu-v3: fix broken S2PS and AARCH64 in
	Broadcom Vulcan
Date: Tue, 15 Dec 2015 13:40:10 +0000
Message-ID: <20151215134010.GH9452@arm.com>
References: <1450110687-32207-1-git-send-email-pmallapp@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1450110687-32207-1-git-send-email-pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Prem Mallappa <pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Prem,

On Mon, Dec 14, 2015 at 10:01:27PM +0530, Prem Mallappa wrote:
> Vulcan SMMUv3 looks for AARCH64 and S2PS inroder to validate the STE entry,

'inroder' ?

> which is a overkill, but when proper encoding not found; the SMMU stops
> processing PCIe read/write requests. Giving the h/w what it wants.
> 
> Signed-off-by: Prem Mallappa <pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index d4af50d..dfda564 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -260,6 +260,7 @@
>  #define STRTAB_STE_2_S2VMID_MASK	0xffffUL
>  #define STRTAB_STE_2_VTCR_SHIFT		32
>  #define STRTAB_STE_2_VTCR_MASK		0x7ffffUL
> +#define STRTAB_STE_2_S2PS_SHIFT        48
>  #define STRTAB_STE_2_S2AA64		(1UL << 51)
>  #define STRTAB_STE_2_S2ENDI		(1UL << 52)
>  #define STRTAB_STE_2_S2PTW		(1UL << 54)
> @@ -577,6 +578,7 @@ struct arm_smmu_device {
>  	u32				features;
>  
>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> +#define ARM_SMMU_OPT_BROKEN_STE_VALID	(1 << 1)
>  	u32				options;
>  
>  	struct arm_smmu_cmdq		cmdq;
> @@ -641,6 +643,7 @@ struct arm_smmu_option_prop {
>  
>  static struct arm_smmu_option_prop arm_smmu_options[] = {
>  	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
> +	{ ARM_SMMU_OPT_BROKEN_STE_VALID, "broadcom,broken-ste-valid-check" },

This looks like a more specific problem than "broken ste valid check".
Maybe we could call the prop ARM_SMMU_OPT_BCOM_BROKEN_STE_VALID?

You also need to update the devicetree binding in
Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt.

>  	{ 0, NULL},
>  };
>  
> @@ -1046,6 +1049,15 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
>  				      : STRTAB_STE_0_CFG_BYPASS;
>  		dst[0] = cpu_to_le64(val);
>  		dst[2] = 0; /* Nuke the VMID */
> +
> +		if (smmu && (smmu->options & ARM_SMMU_OPT_BROKEN_STE_VALID)) {
> +#define SMMU_STE_OAS_44_BITS 0x4UL

Please don't add a #define here. Can we instead use the oas field that
we've extracted from IDR5? I think we need to be doing that anyway when
we're using stage-2 translation, looking at the spec...

> +			WARN_ON(smmu->oas != 44);
> +			dst[1] = STRTAB_STE_1_EATS_TRANS << STRTAB_STE_1_EATS_SHIFT;

Why are you enabling ATS?

> +			dst[2] |= cpu_to_le64((SMMU_STE_OAS_44_BITS << STRTAB_STE_2_S2PS_SHIFT) |
> +					STRTAB_STE_2_S2AA64);
> +		}

Will
