From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC 1/3] iommu/arm-smmu: Add support to opt-in to stalling
Date: Thu, 5 Jan 2017 15:49:51 +0000
Message-ID: <20170105154950.GM679@arm.com>
References: <1483479056-15202-1-git-send-email-robdclark@gmail.com>
	<1483479056-15202-2-git-send-email-robdclark@gmail.com>
	<20170105115528.GG679@arm.com>
	<CAF6AEGsUdZALAQTozmxPV8Os=3pG7ay=1Oqtctx99FV9_4SX7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAF6AEGsUdZALAQTozmxPV8Os=3pG7ay=1Oqtctx99FV9_4SX7Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 05, 2017 at 10:27:27AM -0500, Rob Clark wrote:
> On Thu, Jan 5, 2017 at 6:55 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > On Tue, Jan 03, 2017 at 04:30:54PM -0500, Rob Clark wrote:
> >> TODO maybe we want two options, one to enable stalling, and 2nd to punt
> >> handling to wq?  I haven't needed to use mm APIs from fault handler yet
> >> (although it is something that I think we'll want some day).  Perhaps
> >> stalling support is limited to just letting driver dump some extra
> >> debugging information otherwise.  Threaded handling probably only useful
> >> with stalling, but inverse may not always be true.
> >
> > I'd actually like to see this stuck on a worker thread, because I think
> > that's more generally useful and I don't want to have a situation where
> > sometimes the IOMMU fault notifier is run in IRQ context and sometimes it's
> > not.
> 
> So I was talking a bit w/ Jordan on IRC yesterday..  and we also have
> the GPU's hw hang-detect to contend with.  So I *suspect* that when we
> get to the point of using this to do things like page in things from
> swap and resume the faulting transaction, we probably want to get
> called immediately from the IRQ handler so we can disable the hw
> hang-detect.

Well, if you want to use an SMMU for paging, then the GPU driver would
need to request that explicitly when allocating its DMA buffers, to that
would be the time to either delay or disable the hang detection.

> I'm not sure if the better solution then would be to have two fault
> callbacks, one immediately from the IRQ and a later one from wq.  Or
> let the driver handle the wq business and give it a way to tell the
> IOMMU when to resume.
> 
> I kinda think we should punt on the worker thread for now until we are
> ready to resume faulting transactions, because I guess a strong chance
> that whatever way we do it now will be wrong ;-)

I guess what I'm after is for you to change the interrupt handlers to be
threaded, like they are for SMMUv3. I *think* you can do that with a NULL
thread_fn for now, and just call report_iommu_fault from the handler.
The return value of that could, in theory, be used to queued the paging
request and wake the paging thread in future.

> > I wonder if this should also be predicated on the compatible string, so
> > that the "arm,smmu-enable-stall" property is ignored (with a warning) if
> > the compatible string isn't specific enough to identify an implementation
> > with the required SS behaviour? On the other hand, it feels pretty
> > redundant and a single "stalling works" property is all we need.
> 
> We could also drop the property and key the behavior on specific
> compat strings I guess.  Having both seems a bit odd.  Anyways, I'll
> defer to DT folks about what the cleaner approach is.

As Robin pointed out, we do need to be able to distinguish the integration
of the device from the device itself. For example, MMU-9000 might be capable
of stalling, but if it's bolted to a PCI RC, it's not safe to do so.

Will
