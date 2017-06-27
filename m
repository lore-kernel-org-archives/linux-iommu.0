From: Will Deacon <will.deacon@arm.com>
Subject: Re: [Devel] [RESEND PATCH v9 3/3] iommu/arm-smmu-v3: Add workaround
 for Cavium ThunderX2 erratum #126
Date: Tue, 27 Jun 2017 15:06:00 +0100
Message-ID: <20170627140559.GK14041@arm.com>
References: <1498224876-5200-1-git-send-email-gakula@caviumnetworks.com>
 <20170627135610.GX658@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170627135610.GX658@rric.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Robert Richter <robert.richter@cavium.com>
Cc: Geetha sowjanya <gakula@caviumnetworks.com>, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, iommu@lists.linux-foundation.org, robh@kernel.org, Charles.Garcia-Tobin@arm.com, Geetha Sowjanya <geethasowjanya.akula@cavium.com>, geethasowjanya.akula@gmail.com, jcm@redhat.com, linu.cherian@cavium.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, catalin.marinas@arm.com, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org, devel@acpica.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 27, 2017 at 03:56:10PM +0200, Robert Richter wrote:
> On 23.06.17 19:04:36, Geetha sowjanya wrote:
> > From: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
> > 
> > Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique irq
> > lines for gerror, eventq and cmdq-sync.
> > 
> > New named irq "combined" is set as a errata workaround, which allows to
> > share the irq line by register single irq handler for all the interrupts.
> > 
> > Signed-off-by: Geetha sowjanya <gakula@caviumnetworks.com>
> > ---
> >  Documentation/arm64/silicon-errata.txt             |    1 +
> >  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    6 +
> >  drivers/acpi/arm64/iort.c                          |   57 ++++++++---
> >  drivers/iommu/arm-smmu-v3.c                        |  100 ++++++++++++++-----
> >  4 files changed, 121 insertions(+), 43 deletions(-)
> 
> > +static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> > +{
> > +	int ret, irq;
> > +	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
> > +
> > +	/* Disable IRQs first */
> > +	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
> > +				      ARM_SMMU_IRQ_CTRLACK);
> > +	if (ret) {
> > +		dev_err(smmu->dev, "failed to disable irqs\n");
> > +		return ret;
> > +	}
> > +
> > +	irq = smmu->combined_irq;
> > +	if (irq) {
> > +		/*
> > +		 * Cavium ThunderX2 implementation doesn't not support unique
> > +		 * irq lines. Use single irq line for all the SMMUv3 interrupts.
> > +		 */
> > +		ret = devm_request_threaded_irq(smmu->dev, irq,
> > +					arm_smmu_combined_irq_handler,
> > +					arm_smmu_combined_irq_thread,
> > +					IRQF_ONESHOT,
> 
> Without the IRQF_SHARED flag set I see the following on a dual node
> system now:

We asked about that before:

https://marc.info/?l=linux-arm-kernel&m=149803613513068&w=2
https://marc.info/?l=linux-acpi&m=149803744713475&w=2

and Geetha didn't reply, but the next version of the patch dropped the flag.
Is it just that firmware is misprogramming something here, or something
more fundamental?

Will
