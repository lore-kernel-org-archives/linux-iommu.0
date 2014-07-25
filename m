From: Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>
Subject: Re: [PATCH 1/3] mmu_notifier: Add mmu_notifier_invalidate_range()
Date: Fri, 25 Jul 2014 13:16:39 -0700
Message-ID: <20140725131639.698f18ff@jbarnes-desktop>
References: <1406212541-25975-1-git-send-email-joro@8bytes.org>
	<1406212541-25975-2-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1406212541-25975-2-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

On Thu, 24 Jul 2014 16:35:39 +0200
Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> This notifier closes an important gap with the current
> invalidate_range_start()/end() notifiers. The _start() part
> is called when all pages are still mapped while the _end()
> notifier is called when all pages are potentially unmapped
> and already freed.
> 
> This does not allow to manage external (non-CPU) hardware
> TLBs with MMU-notifiers because there is no way to prevent
> that hardware will establish new TLB entries between the
> calls of these two functions. But this is a requirement to
> the subsytem that implements these existing notifiers.
> 
> To allow managing external TLBs the MMU-notifiers need to
> catch the moment when pages are unmapped but not yet freed.
> This new notifier catches that moment and notifies the
> interested subsytem when pages that were unmapped are about
> to be freed. The new notifier will only be called between
> invalidate_range_start()/end().

So if we were actually sharing page tables, we should be able to make
start/end no-ops and just use this new callback, assuming we didn't
need to do any other serialization or debug stuff, right?

Seems like a good addition, and saves us a bunch of trouble...

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
