From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC 1/3] iommu/arm-smmu: Add support to opt-in to stalling
Date: Thu, 12 Jan 2017 15:17:18 +0000
Message-ID: <20170112151717.GB13843@arm.com>
References: <1483479056-15202-1-git-send-email-robdclark@gmail.com>
 <1483479056-15202-2-git-send-email-robdclark@gmail.com>
 <20170105115528.GG679@arm.com>
 <CAF6AEGsUdZALAQTozmxPV8Os=3pG7ay=1Oqtctx99FV9_4SX7Q@mail.gmail.com>
 <20170105154950.GM679@arm.com>
 <CAF6AEGuUidGEONzh92SYg9V2gE812oq_0CoZt-Zv7=bzb3FN3A@mail.gmail.com>
 <20170110175219.GK527@arm.com>
 <CAF6AEGsCJ6L-wmBHFYy2jfQ1bfq_d2wmiWVUXno344US9ikLVA@mail.gmail.com>
 <20170111093606.GA12388@arm.com>
 <CAF6AEGvGWu+OMED52_Mphpd1K=2QAeeuPV8RaRzL9S+N4YOh2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAF6AEGvGWu+OMED52_Mphpd1K=2QAeeuPV8RaRzL9S+N4YOh2Q@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Sricharan R <sricharan@codeaurora.org>, Jordan Crouse <jcrouse@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 11, 2017 at 03:59:30PM -0500, Rob Clark wrote:
> On Wed, Jan 11, 2017 at 4:36 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Jan 10, 2017 at 02:20:13PM -0500, Rob Clark wrote:
> >> On Tue, Jan 10, 2017 at 12:52 PM, Will Deacon <will.deacon@arm.com> wrote:
> >> > On Fri, Jan 06, 2017 at 11:26:49AM -0500, Rob Clark wrote:
> >> >> Hmm, well we install the fault handler on the iommu_domain..  perhaps
> >> >> maybe a combo of dts property (or deciding based on more specific
> >> >> compat string), plus extra param passed in to
> >> >> iommu_set_fault_hander().  The dts property or compat string to
> >> >> indicate whether the iommu (and how it is wired up) can handle stalls,
> >> >> and enable_stall param when fault handler is registered to indicate
> >> >> whether the device itself can cope.. if either can't do stalling, then
> >> >> don't set CFCFG.
> >> >
> >> > I thought about this some more, and I think you're right. Having
> >> > iommu_set_fault_handler take a flags parameter indicating that, for example,
> >> > the fault handler can deal with paging, is all we need to implement the
> >> > per-master opt-in functionality for stalling faults. There's no real
> >> > requirement to standardise a generic firmware property for that (but
> >> > we still need *something* that says stalling is usable on the SMMU --
> >> > perhaps just the compatible string is ok).
> >>
> >> btw, it occurred to me that maybe it should be flags param to
> >> iommu_attach_device() (just in case fault handler not installed?)
> >> otoh stalling without a fault handler is silly, but I guess we need it
> >> to infer whether stalling can be supported by other devices on same
> >> iommu.. tbh I'm on a bit shaky ground when it comes to multiple
> >> devices per iommu since the SoC's I'm familiar with do it the other
> >> way around.  But I guess you have thought more about the multi-device
> >> case, so figured I should suggest it..
> >
> > I don't think it works at attach time, because the stalling property belongs
> > to the domain, rather than the individual devices within it. Similarly, I
> > don't think we should allow this property to be toggled once devices have
> > been attached.
> >
> 
> hmm, I was more thinking of cases where drivers for particular devices
> need some work (ie. like potentially disabling hw hang detect during
> faults).. I guess we could have three levels, that all have to be true
> in order to enable stall: smmu, domain (pass flags in to
> iommu_domain_alloc()??), and device (iommu_attach_device())?

Hooking iommu_set_fault_handler, as you originally suggested, is the best
way to set the flag on the domain. I think we just need to enforce that
iommu_set_fault_handler is called prior to attaching devices to a domain,
so that the IOMMU driver can configure the domain appropriately on the
first attach.

Will
