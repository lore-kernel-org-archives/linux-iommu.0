From: Robert Richter <robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: Re: [Devel] [RESEND PATCH v9 3/3] iommu/arm-smmu-v3: Add workaround
	for Cavium ThunderX2 erratum #126
Date: Tue, 27 Jun 2017 17:18:01 +0200
Message-ID: <20170627151801.GT31368@rric.localdomain>
References: <1498224876-5200-1-git-send-email-gakula@caviumnetworks.com>
	<20170627135610.GX658@rric.localdomain>
	<20170627140559.GK14041@arm.com>
	<CANHdaibSGtbdQfZ2kv1E9t4eE+JY2wtsDP7=rEw-mj059yhyHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CANHdaibSGtbdQfZ2kv1E9t4eE+JY2wtsDP7=rEw-mj059yhyHA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geetha Akula <geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Sunil Goutham <sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Charles Garcia-Tobin <Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 27.06.17 20:28:14, Geetha Akula wrote:
> On Tue, Jun 27, 2017 at 7:36 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > On Tue, Jun 27, 2017 at 03:56:10PM +0200, Robert Richter wrote:
> >> On 23.06.17 19:04:36, Geetha sowjanya wrote:
> >> > From: Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> >> >
> >> > Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique irq
> >> > lines for gerror, eventq and cmdq-sync.
> >> >
> >> > New named irq "combined" is set as a errata workaround, which allows to
> >> > share the irq line by register single irq handler for all the interrupts.
> >> >
> >> > Signed-off-by: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
> >> > ---
> >> >  Documentation/arm64/silicon-errata.txt             |    1 +
> >> >  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    6 +
> >> >  drivers/acpi/arm64/iort.c                          |   57 ++++++++---
> >> >  drivers/iommu/arm-smmu-v3.c                        |  100 ++++++++++++++-----
> >> >  4 files changed, 121 insertions(+), 43 deletions(-)
> >>
> >> > +static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> >> > +{
> >> > +   int ret, irq;
> >> > +   u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
> >> > +
> >> > +   /* Disable IRQs first */
> >> > +   ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
> >> > +                                 ARM_SMMU_IRQ_CTRLACK);
> >> > +   if (ret) {
> >> > +           dev_err(smmu->dev, "failed to disable irqs\n");
> >> > +           return ret;
> >> > +   }
> >> > +
> >> > +   irq = smmu->combined_irq;
> >> > +   if (irq) {
> >> > +           /*
> >> > +            * Cavium ThunderX2 implementation doesn't not support unique
> >> > +            * irq lines. Use single irq line for all the SMMUv3 interrupts.
> >> > +            */
> >> > +           ret = devm_request_threaded_irq(smmu->dev, irq,
> >> > +                                   arm_smmu_combined_irq_handler,
> >> > +                                   arm_smmu_combined_irq_thread,
> >> > +                                   IRQF_ONESHOT,
> >>
> >> Without the IRQF_SHARED flag set I see the following on a dual node
> >> system now:
> Node1 SMMU interrupts are programmed wrong in the firmware.
> Node 0 and Node1 SMMU do not share interrupts.
> I have verified the patch on dual node with correct interrupt numbers
> programmed in firmware.

Ah, ok, will update to latest fw.

Thanks,

-Robert
