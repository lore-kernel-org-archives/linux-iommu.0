From: Robert Richter <robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/3] Cavium ThunderX2 SMMUv3 errata workarounds
Date: Thu, 27 Apr 2017 15:39:10 +0200
Message-ID: <20170427133910.GB31368@rric.localdomain>
References: <1493293584-20287-1-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1493293584-20287-1-git-send-email-gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
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
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, Geetha <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 27.04.17 17:16:21, Geetha sowjanya wrote:
> From: Geetha <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> 
> Cavium CN99xx SMMUv3 implementation has two Silicon Erratas.
> 1. Errata ID #74
>    SMMU register alias Page 1 is not implemented
> 2. Errata ID #126
>    SMMU doesnt support unique IRQ lines for gerror, eventq and cmdq-sync
> 
> The following patchset does software workaround for these two erratas.
> 
> This series is based on RFC patch.  
> https://www.spinics.net/lists/arm-kernel/msg575739.html
> 
> As suggested by Will Deacon, code is modified to use silicon id to
> enable errata#74 workaround.

Can we go with the previous series [1] and:

 * drop the iort model numbering part,

 * add an enablement function that enables flags (smmu->options)
   depending on midr values (which replaces the macro code)?

E.g.:

static void acpi_smmu_enable_cavium(struct arm_smmu_device *smmu)
{
	u32 cpu_model;

	if (!IS_ENABLED(CONFIG_ARM64))
		return;

	cpu_model = read_cpuid_id() & MIDR_CPU_MODEL_MASK;
	switch (cpu_model) {
	case ...:
	case ...:
		break;
	default:
		/* No Cavium CN99xx SMMU v3 */
		return;
	}

	smmu->options |= (ARM_SMMU_OPT_PAGE0_REGS_ONLY |
		      	 ARM_SMMU_OPT_USE_SHARED_IRQS);
}

-Robert


[1] [RFC PATCH 0/7] Cavium CN99xx SMMUv3 Errata workarounds
    https://marc.info/?l=linux-acpi&m=149192179623708&w=2

> 
> Linu Cherian (1):
>   iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #74
> 
> Geetha (2):
>   arm64: Add MIDR values for Cavium cn99xx SoCs
>   iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #126
> 
>  Documentation/arm64/silicon-errata.txt |  2 ++
>  arch/arm64/include/asm/cputype.h       |  3 ++
>  drivers/acpi/arm64/iort.c              | 14 +++++++-
>  drivers/iommu/arm-smmu-v3.c            | 64 +++++++++++++++++++++++++++++-----
>  4 files changed, 73 insertions(+), 10 deletions(-)
> 
> -- 
> 1.9.1
> 
