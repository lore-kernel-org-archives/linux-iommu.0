From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 0/3 v3] mmu_notifier: Allow to manage CPU external TLBs
Date: Fri, 12 Sep 2014 20:47:39 +0200
Message-ID: <20140912184739.GF2519@suse.de>
References: <1410277434-3087-1-git-send-email-joro@8bytes.org>
	<20140910150125.31a7495c7d0fe814b85fd514@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140910150125.31a7495c7d0fe814b85fd514-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Andrea Arcangeli <aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rik van Riel <riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jay.Cornwall-5C7GfCeVMHo@public.gmane.org, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, John.Bridgman-5C7GfCeVMHo@public.gmane.org, Hugh Dickins <hughd-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben.sander-5C7GfCeVMHo@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>, Mel Gorman <mgorman-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Johannes Weiner <jweiner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Andrew,

thanks for your review, I tried to answer your questions below.

On Wed, Sep 10, 2014 at 03:01:25PM -0700, Andrew Morton wrote:
> On Tue,  9 Sep 2014 17:43:51 +0200 Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> > So both call-backs can't be used to safely flush any non-CPU
> > TLB because _start() is called too early and _end() too
> > late.
> 
> There's a lot of missing information here.  Why don't the existing
> callbacks suit non-CPU TLBs?  What is different about them?  Please
> update the changelog to contain all this context.

The existing call-backs are called too early or too late. Specifically,
invalidate_range_start() is called when all pages are still mapped and 
invalidate_range_end() when all pages are unmapped and potentially
freed.

This is fine when the users of the mmu_notifiers manage their own
SoftTLB, like KVM does. When the TLB is managed in software it is easy
to wipe out entries for a given range and prevent new entries to be
established until invalidate_range_end is called.

But when the user of mmu_notifiers has to manage a hardware TLB it can
still wipe out TLB entries in invalidate_range_start, but it can't make
sure that no new TLB entries in the given range are established between
invalidate_range_start and invalidate_range_end.

	[ Actually the current AMD IOMMUv2 code tries to do that with
	  setting the setting an empty page-table for the non-CPU TLB,
	  but this causes address translation errors which end up in
	  device failures. ]

But to avoid silent data corruption the TLB entries need to be flushed
out of the non-CPU hardware TLB when the pages are unmapped (at this
point in time no _new_ TLB entries can be established in the non-CPU
TLB) but not yet freed (as the non-CPU TLB may still have _existing_
entries pointing to the pages about to be freed).

So to fix this problem we need to catch the moment when the Linux VMM
flushes remote TLBs (as a non-CPU TLB is not very different in its
flushing requirements from any other remote CPU TLB), as this is the
point in time when the pages are unmapped but _not_ yet freed.

The mmu_notifier_invalidate_range() function aims to catch that moment.

> > In the AMD IOMMUv2 driver this is currently implemented by
> > assigning an empty page-table to the external device between
> > _start() and _end(). But as tests have shown this doesn't
> > work as external devices don't re-fault infinitly but enter
> > a failure state after some time.
> 
> More missing info.  Why are these faults occurring?  Is there some
> device activity which is trying to fault in pages, but the CPU is
> executing code between _start() and _end() so the driver must refuse to
> instantiate a page to satisfy the fault?  That's just a guess, and I
> shouldn't be guessing.  Please update the changelog to fully describe
> the dynamic activity which is causing this.

The device (usually a GPU) runs some process (for example a compute job)
that directly accesses a Linux process address space. Any access
to a process address space can cause a page-fault, whether the access
comes from the CPU or a remote device.

When the page-fault comes from a compute job running on a GPU, is is
reported to Linux by an IOMMU interrupt.

The current implementation of invalidate_range_start/end assigns an
empty page-table, which causes many page-faults from the GPU process,
resulting in an interrupt storm for the IOMMU.

The fault handler doesn't handle the fault if an
invalidate_range_start/end pair is active, but just reports back SUCESS
to the device to let it refault the page then (refaulting is the same strategy
KVM implements). But existing GPUs that make use of this feature don't
refault indefinitly, after a certain number of faults for the same
address the device enters a failure state and needs to be resetted.L

> > Next problem with this solution is that it causes an
> > interrupt storm for IO page faults to be handled when an
> > empty page-table is assigned.
> 
> Also too skimpy.  I *think* this is a variant of the problem in the
> preceding paragraph.  We get a fault storm (which is problem 2) and
> sometimes the faulting device gives up (which is problem 1).
> 
> Or something.  Please de-fog all of this.

Right, I will update the description to be more clear.

> > Furthermore the _start()/end() notifiers only catch the
> > moment when page mappings are released, but not page-table
> > pages. But this is necessary for managing external TLBs when
> > the page-table is shared with the CPU.
> 
> How come?

As mmu_notifiers are not used for managing TLBs that share the same
page-table as the CPU uses, there was not need to catch the page-table
freeing events, so it is not available yet.

> > Any comments and review appreciated!
> 
> The patchset looks decent, although I find it had to review because I
> just wasn't provided with enough of the thinking that went into it.  I
> have enough info to look at the C code, but not enough info to identify
> and evaluate alternative implementation approaches, to identify
> possible future extensions, etc.

Fair enough, I hope I clarified a few things with my explanations
above. I will also update the description of the patch-set when I
re-send.

> The patchset does appear to add significant additional overhead to hot
> code paths when mm_has_notifiers(mm).  Please let's update the
> changelog to address this rather important concern.  How significant is
> the impact on such mm's, how common are such mm's now and in the
> future, should we (for example) look at short-circuiting
> __mmu_notifier_invalidate_range() if none of the registered notifiers
> implement ->invalidate_range(), etc.

I think it adds the most overhead to single-CPU kernels. The
invalidate_range notifier is called in the paths that also do a remote
TLB flush, which is very expensive on its own. To those paths it adds
just another remote TLB that needs to be flushed.

Regards,

	Joerg
