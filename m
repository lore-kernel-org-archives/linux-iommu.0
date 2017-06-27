From: Robert Richter <robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: Re: [Devel] [RESEND PATCH v9 3/3] iommu/arm-smmu-v3: Add workaround
	for Cavium ThunderX2 erratum #126
Date: Tue, 27 Jun 2017 15:56:10 +0200
Message-ID: <20170627135610.GX658@rric.localdomain>
References: <1498224876-5200-1-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1498224876-5200-1-git-send-email-gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
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
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 23.06.17 19:04:36, Geetha sowjanya wrote:
> From: Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> 
> Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique irq
> lines for gerror, eventq and cmdq-sync.
> 
> New named irq "combined" is set as a errata workaround, which allows to
> share the irq line by register single irq handler for all the interrupts.
> 
> Signed-off-by: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
> ---
>  Documentation/arm64/silicon-errata.txt             |    1 +
>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    6 +
>  drivers/acpi/arm64/iort.c                          |   57 ++++++++---
>  drivers/iommu/arm-smmu-v3.c                        |  100 ++++++++++++++-----
>  4 files changed, 121 insertions(+), 43 deletions(-)

> +static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> +{
> +	int ret, irq;
> +	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
> +
> +	/* Disable IRQs first */
> +	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
> +				      ARM_SMMU_IRQ_CTRLACK);
> +	if (ret) {
> +		dev_err(smmu->dev, "failed to disable irqs\n");
> +		return ret;
> +	}
> +
> +	irq = smmu->combined_irq;
> +	if (irq) {
> +		/*
> +		 * Cavium ThunderX2 implementation doesn't not support unique
> +		 * irq lines. Use single irq line for all the SMMUv3 interrupts.
> +		 */
> +		ret = devm_request_threaded_irq(smmu->dev, irq,
> +					arm_smmu_combined_irq_handler,
> +					arm_smmu_combined_irq_thread,
> +					IRQF_ONESHOT,

Without the IRQF_SHARED flag set I see the following on a dual node
system now:

[   17.403260] arm-smmu-v3 arm-smmu-v3.0.auto: option mask 0x2
[   17.408853] arm-smmu-v3 arm-smmu-v3.0.auto: ias 44-bit, oas 44-bit (features 0x0000172d)
[   17.417259] arm-smmu-v3 arm-smmu-v3.1.auto: option mask 0x2
[   17.422856] arm-smmu-v3 arm-smmu-v3.1.auto: ias 44-bit, oas 44-bit (features 0x0000172d)
[   17.431193] arm-smmu-v3 arm-smmu-v3.2.auto: option mask 0x2
[   17.436787] arm-smmu-v3 arm-smmu-v3.2.auto: ias 44-bit, oas 44-bit (features 0x0000172d)
[   17.445123] arm-smmu-v3 arm-smmu-v3.3.auto: option mask 0x2
[   17.450697] arm-smmu-v3 arm-smmu-v3.3.auto: ias 44-bit, oas 44-bit (features 0x0000172d)
[   17.458984] genirq: Flags mismatch irq 5. 00002001 (arm-smmu-v3-combined-irq) vs. 00002001 (arm-smmu-v3-combined-irq)
[   17.610636] arm-smmu-v3 arm-smmu-v3.3.auto: failed to enable combined irq
[   17.617491] arm-smmu-v3 arm-smmu-v3.4.auto: option mask 0x2
[   17.623073] arm-smmu-v3 arm-smmu-v3.4.auto: ias 44-bit, oas 44-bit (features 0x0000172d)
[   17.631339] genirq: Flags mismatch irq 6. 00002001 (arm-smmu-v3-combined-irq) vs. 00002001 (arm-smmu-v3-combined-irq)
[   17.782944] arm-smmu-v3 arm-smmu-v3.4.auto: failed to enable combined irq
[   17.789780] arm-smmu-v3 arm-smmu-v3.5.auto: option mask 0x2
[   17.795367] arm-smmu-v3 arm-smmu-v3.5.auto: ias 44-bit, oas 44-bit (features 0x0000172d)
[   17.803640] genirq: Flags mismatch irq 7. 00002001 (arm-smmu-v3-combined-irq) vs. 00002001 (arm-smmu-v3-combined-irq)
[   17.955248] arm-smmu-v3 arm-smmu-v3.5.auto: failed to enable combined irq

In __setup_irq() in kernel/irq/manage.c there is a check if that flag
is set which causes the error is shown.

-Robert

> +					"arm-smmu-v3-combined-irq", smmu);
> +		if (ret < 0)
> +			dev_warn(smmu->dev, "failed to enable combined irq\n");
> +	} else
> +		arm_smmu_setup_unique_irqs(smmu);
> +
> +	if (smmu->features & ARM_SMMU_FEAT_PRI)
> +		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
>  
>  	/* Enable interrupt generation on the SMMU */
>  	ret = arm_smmu_write_reg_sync(smmu, irqen_flags,
