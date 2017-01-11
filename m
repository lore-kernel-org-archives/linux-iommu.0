From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC 1/3] iommu/arm-smmu: Add support to opt-in to stalling
Date: Wed, 11 Jan 2017 09:36:07 +0000
Message-ID: <20170111093606.GA12388@arm.com>
References: <1483479056-15202-1-git-send-email-robdclark@gmail.com>
 <1483479056-15202-2-git-send-email-robdclark@gmail.com>
 <20170105115528.GG679@arm.com>
 <CAF6AEGsUdZALAQTozmxPV8Os=3pG7ay=1Oqtctx99FV9_4SX7Q@mail.gmail.com>
 <20170105154950.GM679@arm.com>
 <CAF6AEGuUidGEONzh92SYg9V2gE812oq_0CoZt-Zv7=bzb3FN3A@mail.gmail.com>
 <20170110175219.GK527@arm.com>
 <CAF6AEGsCJ6L-wmBHFYy2jfQ1bfq_d2wmiWVUXno344US9ikLVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAF6AEGsCJ6L-wmBHFYy2jfQ1bfq_d2wmiWVUXno344US9ikLVA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 10, 2017 at 02:20:13PM -0500, Rob Clark wrote:
> On Tue, Jan 10, 2017 at 12:52 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > On Fri, Jan 06, 2017 at 11:26:49AM -0500, Rob Clark wrote:
> >> Hmm, well we install the fault handler on the iommu_domain..  perhaps
> >> maybe a combo of dts property (or deciding based on more specific
> >> compat string), plus extra param passed in to
> >> iommu_set_fault_hander().  The dts property or compat string to
> >> indicate whether the iommu (and how it is wired up) can handle stalls,
> >> and enable_stall param when fault handler is registered to indicate
> >> whether the device itself can cope.. if either can't do stalling, then
> >> don't set CFCFG.
> >
> > I thought about this some more, and I think you're right. Having
> > iommu_set_fault_handler take a flags parameter indicating that, for example,
> > the fault handler can deal with paging, is all we need to implement the
> > per-master opt-in functionality for stalling faults. There's no real
> > requirement to standardise a generic firmware property for that (but
> > we still need *something* that says stalling is usable on the SMMU --
> > perhaps just the compatible string is ok).
> 
> btw, it occurred to me that maybe it should be flags param to
> iommu_attach_device() (just in case fault handler not installed?)
> otoh stalling without a fault handler is silly, but I guess we need it
> to infer whether stalling can be supported by other devices on same
> iommu.. tbh I'm on a bit shaky ground when it comes to multiple
> devices per iommu since the SoC's I'm familiar with do it the other
> way around.  But I guess you have thought more about the multi-device
> case, so figured I should suggest it..

I don't think it works at attach time, because the stalling property belongs
to the domain, rather than the individual devices within it. Similarly, I
don't think we should allow this property to be toggled once devices have
been attached.

Will
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
