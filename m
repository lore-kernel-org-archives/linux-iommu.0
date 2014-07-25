From: Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>
Subject: Re: [PATCH 1/3] mmu_notifier: Add mmu_notifier_invalidate_range()
Date: Fri, 25 Jul 2014 14:42:13 -0700
Message-ID: <20140725144213.773474e4@jbarnes-desktop>
References: <1406212541-25975-1-git-send-email-joro@8bytes.org>
	<1406212541-25975-2-git-send-email-joro@8bytes.org>
	<20140725131639.698f18ff@jbarnes-desktop>
	<20140725213806.GN14017@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140725213806.GN14017-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Andrea Arcangeli <aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rik van Riel <riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, John.Bridgman-5C7GfCeVMHo@public.gmane.org, Hugh Dickins <hughd-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben.sander-5C7GfCeVMHo@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jay.Cornwall-5C7GfCeVMHo@public.gmane.org, Mel Gorman <mgorman-l3A5Bk7waGM@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Johannes Weiner <jweiner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 25 Jul 2014 23:38:06 +0200
Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> On Fri, Jul 25, 2014 at 01:16:39PM -0700, Jesse Barnes wrote:
> > > To allow managing external TLBs the MMU-notifiers need to
> > > catch the moment when pages are unmapped but not yet freed.
> > > This new notifier catches that moment and notifies the
> > > interested subsytem when pages that were unmapped are about
> > > to be freed. The new notifier will only be called between
> > > invalidate_range_start()/end().
> > 
> > So if we were actually sharing page tables, we should be able to make
> > start/end no-ops and just use this new callback, assuming we didn't
> > need to do any other serialization or debug stuff, right?
> 
> Well, not completly. What you need with this patch-set is a
> invalidate_range and an invalidate_end call-back. There are call sites
> of the start/end functions where the TLB flush happens after the _end
> notifier (or at least can wait until _end is called). I did not add
> invalidate_range calls to these places (yet). But you can easily discard
> invalidate_range_start, any flush done in there is useless with shared
> page-tables.
> 
> I though about removing the need for invalidate_range_end too when
> writing the patches, and possible solutions are
> 
> 	1) Add mmu_notifier_invalidate_range() to all places where
> 	   start/end is called too. This might add some unnecessary
> 	   overhead.
> 
> 	2) Call the invalidate_range() call-back from the
> 	   mmu_notifier_invalidate_range_end too.
> 
> 	3) Just let the user register the same function for
> 	   invalidate_range and invalidate_range_end
> 
> I though that option 1) adds overhead that is not needed (but it might
> not be too bad, the overhead is an additional iteration over the
> mmu_notifer list when there are no call-backs registered).
> 
> Option 2) might also be overhead if a user registers different functions
> for invalidate_range() and invalidate_range_end(). In the end I came to
> the conclusion that option 3) is the best one from an overhead POV.
> 
> But probably targeting better usability with one of the other options is
> a better choice? I am open for thoughts and suggestions on that.

Making the _end callback just do another TLB flush is fine too, but it
would be nice to have the consistency of (1).  I can live with either
though, as long as the callbacks are well documented.

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
