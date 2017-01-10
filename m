From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC 1/3] iommu/arm-smmu: Add support to opt-in to stalling
Date: Tue, 10 Jan 2017 17:52:19 +0000
Message-ID: <20170110175219.GK527@arm.com>
References: <1483479056-15202-1-git-send-email-robdclark@gmail.com>
 <1483479056-15202-2-git-send-email-robdclark@gmail.com>
 <20170105115528.GG679@arm.com>
 <CAF6AEGsUdZALAQTozmxPV8Os=3pG7ay=1Oqtctx99FV9_4SX7Q@mail.gmail.com>
 <20170105154950.GM679@arm.com>
 <CAF6AEGuUidGEONzh92SYg9V2gE812oq_0CoZt-Zv7=bzb3FN3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAF6AEGuUidGEONzh92SYg9V2gE812oq_0CoZt-Zv7=bzb3FN3A@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Sricharan R <sricharan@codeaurora.org>, Jordan Crouse <jcrouse@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Rob,

On Fri, Jan 06, 2017 at 11:26:49AM -0500, Rob Clark wrote:
> On Thu, Jan 5, 2017 at 10:49 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Jan 05, 2017 at 10:27:27AM -0500, Rob Clark wrote:
> >> I'm not sure if the better solution then would be to have two fault
> >> callbacks, one immediately from the IRQ and a later one from wq.  Or
> >> let the driver handle the wq business and give it a way to tell the
> >> IOMMU when to resume.
> >>
> >> I kinda think we should punt on the worker thread for now until we are
> >> ready to resume faulting transactions, because I guess a strong chance
> >> that whatever way we do it now will be wrong ;-)
> >
> > I guess what I'm after is for you to change the interrupt handlers to be
> > threaded, like they are for SMMUv3. I *think* you can do that with a NULL
> > thread_fn for now, and just call report_iommu_fault from the handler.
> > The return value of that could, in theory, be used to queued the paging
> > request and wake the paging thread in future.
> 
> If we only pass in the non-threaded irq fxn, I'm not really sure how
> that changes anything.. or maybe I'm not understanding what you mean.
> 
> But yeah, I guess we could use request_threaded_irq() to get both IRQ
> context notification and a later thread context notification rather
> than doing the wq thing.  Either way the iommu API has to change
> slightly.
> 
> >> > I wonder if this should also be predicated on the compatible string, so
> >> > that the "arm,smmu-enable-stall" property is ignored (with a warning) if
> >> > the compatible string isn't specific enough to identify an implementation
> >> > with the required SS behaviour? On the other hand, it feels pretty
> >> > redundant and a single "stalling works" property is all we need.
> >>
> >> We could also drop the property and key the behavior on specific
> >> compat strings I guess.  Having both seems a bit odd.  Anyways, I'll
> >> defer to DT folks about what the cleaner approach is.
> >
> > As Robin pointed out, we do need to be able to distinguish the integration
> > of the device from the device itself. For example, MMU-9000 might be capable
> > of stalling, but if it's bolted to a PCI RC, it's not safe to do so.
> 
> Hmm, well we install the fault handler on the iommu_domain..  perhaps
> maybe a combo of dts property (or deciding based on more specific
> compat string), plus extra param passed in to
> iommu_set_fault_hander().  The dts property or compat string to
> indicate whether the iommu (and how it is wired up) can handle stalls,
> and enable_stall param when fault handler is registered to indicate
> whether the device itself can cope.. if either can't do stalling, then
> don't set CFCFG.

I thought about this some more, and I think you're right. Having
iommu_set_fault_handler take a flags parameter indicating that, for example,
the fault handler can deal with paging, is all we need to implement the
per-master opt-in functionality for stalling faults. There's no real
requirement to standardise a generic firmware property for that (but
we still need *something* that says stalling is usable on the SMMU --
perhaps just the compatible string is ok).

Taking this further, there's then no need for the threaded IRQ function
in the SMMUv2 driver after all. Instead, we pass a continuation function
pointer and opaque token from the SMMU driver to the fault handler in
IRQ context (this will be in thread context for SMMUv3, but that should
be fine). The fault handler can then stash these someplace, and signal
a wakeup for its own threaded handler, which ultimately calls the SMMU
continuation function with the opaque token as a parameter when it's done
with the fault. I think that's enough to get things rolling without adding
lots of infrastructure to the SMMU driver initially. If a pattern emerges
amongst users of the interface, then we could consolidate some of the work
handling back into IOMMU core.

What do you think? It should all be pretty straightforward for what you
want to do.

Will
