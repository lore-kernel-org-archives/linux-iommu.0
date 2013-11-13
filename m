From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv4 4/7] iommu/tegra: smmu: Calculate ASID register offset
	by ID
Date: Tue, 12 Nov 2013 17:02:28 -0700
Message-ID: <5282C194.6090001@wwwdotorg.org>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
	<1384158718-4756-5-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1384158718-4756-5-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/11/2013 01:31 AM, Hiroshi Doyu wrote:
> ASID register offset is caclulated by SWGROUP ID so that we can get
> rid of old SoC specific MACROs. This ID conversion is needed for the
> unified SMMU driver over Tegra SoCs. We use dt-bindings MACRO instead
> of SoC dependent MACROs. The formula is:
> 
>   MC_SMMU_<swgroup name>_ASID_0 = MC_SMMU_AFI_ASID_0 + ID * 4;
> 
> Now SWGROUP ID is the global HardWare Accelerator(HWA) identifier
> among all Tegra SoC except Tegra2.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

I would suggest deleting the following too, since they are presumably
specific to a single SoC:

> #define SMMU_AFI_ASID   0x238   /* PCIE */
> #define SMMU_AVPC_ASID  0x23c   /* AVP */
> #define SMMU_DC_ASID    0x240   /* Display controller */
> #define SMMU_DCB_ASID   0x244   /* Display controller B */
> #define SMMU_EPP_ASID   0x248   /* Encoder pre-processor */
> #define SMMU_G2_ASID    0x24c   /* 2D engine */
> #define SMMU_HC_ASID    0x250   /* Host1x */
> #define SMMU_HDA_ASID   0x254   /* High-def audio */
> #define SMMU_ISP_ASID   0x258   /* Image signal processor */
> #define SMMU_MPE_ASID   0x264   /* MPEG encoder */
> #define SMMU_NV_ASID    0x268   /* (3D) */
> #define SMMU_NV2_ASID   0x26c   /* (3D) */
> #define SMMU_PPCS_ASID  0x270   /* AHB */
> #define SMMU_SATA_ASID  0x278   /* SATA */
> #define SMMU_VDE_ASID   0x27c   /* Video decoder */
> #define SMMU_VI_ASID    0x280   /* Video input */

> +#define HWGRP_ASID_REG(x) ((x) * sizeof(u32) + SMMU_AFI_ASID)

Also, I would suggest renaming SMMU_AFI_ASID to something more like
SMMU_ASID_0 or SMMU_ASID_BASE so as not to call it the AFI register,
since presumably the whole point of this patch is that there's no
guarantee that register is the AFI ASId in all SoCs?
