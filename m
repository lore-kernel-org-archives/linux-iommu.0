From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v8 3/3] iommu/arm-smmu-v3: Add workaround for Cavium
	ThunderX2 erratum #126
Date: Wed, 21 Jun 2017 10:08:35 +0100
Message-ID: <20170621090835.GD3768@arm.com>
References: <1497968259-16390-1-git-send-email-gakula@caviumnetworks.com>
	<1497968259-16390-4-git-send-email-gakula@caviumnetworks.com>
	<20170620180038.GC28035@arm.com>
	<CANHdaiYb8gG5+OjiSBkSGfyNnt4=WDze08qW1JXA9-F66HE9ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CANHdaiYb8gG5+OjiSBkSGfyNnt4=WDze08qW1JXA9-F66HE9ZA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Robert Richter <robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sunil Goutham <sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org>, marc.zyngier-5wv7dgnIgG8@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Geetha,

On Wed, Jun 21, 2017 at 12:09:45PM +0530, Geetha Akula wrote:
> On Tue, Jun 20, 2017 at 11:30 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > On Tue, Jun 20, 2017 at 07:47:39PM +0530, Geetha sowjanya wrote:
> >> From: Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> >>
> >> Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique irq
> >> lines for gerror, eventq and cmdq-sync.
> >>
> >> SHARED_IRQ option is set as a errata workaround, which allows to share the irq
> >> line by register single irq handler for all the interrupts.
> >>
> >> Signed-off-by: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
> >> ---
> >>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    5 ++
> >>  drivers/iommu/arm-smmu-v3.c                        |   73 ++++++++++++++++----
> >>  2 files changed, 64 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> >> index 6ecc48c..44b40e0 100644
> >> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> >> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> >> @@ -55,6 +55,11 @@ the PCIe specification.
> >>                     Set for Caviun ThunderX2 silicon that doesn't support
> >>                     SMMU page1 register space.
> >>
> >> +- cavium,cn9900-broken-unique-irqline
> >> +                    : Use single irq line for all the SMMUv3 interrupts.
> >> +                   Set for Caviun ThunderX2 silicon that doesn't support
> >> +                   MSI and also doesn't have unique irq lines for gerror,
> >> +                   eventq and cmdq-sync.
> >
> > I think we're better off just supporting a new (optional) named interrupt
> > as "combined", and then allowing that to be used instead of the others.
> 
> Are you suggesting to have new name irq "combined" like gerror ?
> If yes, then this won't be possible with apci. We need to update iort spec to
> add new name irq.

I'm mainly talking about the DT binding here, but I don't see why you
can't hack drivers/acpi/arm64/iort.c like you did for the other erratum and
have it register a single interrupt called "combined" based on the model
number.

> >> +                                     arm_smmu_shared_irq_thread,
> >> +                                     IRQF_ONESHOT | IRQF_SHARED,
> >
> > Why do you need IRQF_SHARED here?
> 
> 
> +devm_request_threaded_irq(smmu->dev, irq,
> +                                       arm_smmu_combined_irq_handler,
> +                                       arm_smmu_combined_irq_thread,
> +                                       IRQF_SHARED,
> +                                       "arm-smmu-v3-combined-irq", smmu);
> 
> On multi-node system, node1 SMMU's share irq lines with node0 SMMU's.

How does that work? Are these really MSIs under the hood? If so, why didn't
you just build them as... MSIs?

I sincerely hope that you never want to support paging of DMA memory on this
platform. It will run like a dog.

Will
