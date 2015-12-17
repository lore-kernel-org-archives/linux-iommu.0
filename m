From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 1/2] IOMMU: arm-smmu-v3: Fix broken STE.VALID check in
	Broadcom Vulcan
Date: Thu, 17 Dec 2015 11:42:17 +0000
Message-ID: <20151217114216.GB11456@arm.com>
References: <1450346376-30920-1-git-send-email-pmallapp@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1450346376-30920-1-git-send-email-pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
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

Thanks for the update. I still have a few questions though.

On Thu, Dec 17, 2015 at 03:29:35PM +0530, Prem Mallappa wrote:
> Vulcan SMMUv3 looks into more bits than necessary to validate the STE
> entry (including EATS, S2PS, AARCH64), which is a overkill, but without
> the proper encoding; the SMMU stops processing PCIe read/write requests.
> Giving the h/w what it wants.
> 
> Signed-off-by: Prem Mallappa <pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 359190b..9886d2d 100644
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
> @@ -579,6 +580,7 @@ struct arm_smmu_device {
>  	u32				features;
>  
>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> +#define ARM_SMMU_OPT_BRCM_BROKEN_STE_VALID	(1 << 1)
>  	u32				options;
>  
>  	struct arm_smmu_cmdq		cmdq;
> @@ -643,6 +645,7 @@ struct arm_smmu_option_prop {
>  
>  static struct arm_smmu_option_prop arm_smmu_options[] = {
>  	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
> +	{ ARM_SMMU_OPT_BRCM_BROKEN_STE_VALID, "broadcom,broken-ste-valid-check" },
>  	{ 0, NULL},
>  };
>  
> @@ -1053,6 +1056,13 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
>  				      : STRTAB_STE_0_CFG_BYPASS;
>  		dst[0] = cpu_to_le64(val);
>  		dst[2] = 0; /* Nuke the VMID */
> +
> +		if (smmu && (smmu->options & ARM_SMMU_OPT_BRCM_BROKEN_STE_VALID)) {
> +			WARN_ON(smmu->oas != 44);

Do we really need this WARN_ON?

> +			dst[1] = STRTAB_STE_1_EATS_TRANS << STRTAB_STE_1_EATS_SHIFT;

cpu_to_le64 here too.

> +			dst[2] |= cpu_to_le64(STRTAB_STE_2_S2AA64);
> +		}
> +

Is this workaround only needed for bypass STEs? If not, we have a problem
when we install a stage-1 entry, because we'll clear the EATS bits as
it stands.

Will
