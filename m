From: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3 v2] mmu_notifier: Allow to manage CPU external TLBs
Date: Thu, 31 Jul 2014 10:54:16 -0400
Message-ID: <20140731145414.GA1955@gmail.com>
References: <1406650693-23315-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406650693-23315-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Andrea Arcangeli <aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rik van Riel <riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, John.Bridgman-5C7GfCeVMHo@public.gmane.org, Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>, Hugh Dickins <hughd-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben.sander-5C7GfCeVMHo@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jay.Cornwall-5C7GfCeVMHo@public.gmane.org, Mel Gorman <mgorman-l3A5Bk7waGM@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Johannes Weiner <jweiner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 29, 2014 at 06:18:10PM +0200, Joerg Roedel wrote:
> Changes V1->V2:
> =

> * Rebase to v3.16-rc7
> * Added call of ->invalidate_range to
>   __mmu_notifier_invalidate_end() so that the subsystem
>   doesn't need to register an ->invalidate_end() call-back,
>   subsystems will likely either register
>   invalidate_range_start/end or invalidate_range, so that
>   should be fine.
> * Re-orded declarations a bit to reflect that
>   invalidate_range is not only called between
>   invalidate_range_start/end
> * Updated documentation to cover the case where
>   invalidate_range is called outside of
>   invalidate_range_start/end to flush page-table pages out
>   of the TLB
> =

> Hi,
> =

> here is a patch-set to extend the mmu_notifiers in the Linux
> kernel to allow managing CPU external TLBs. Those TLBs may
> be implemented in IOMMUs or any other external device, e.g.
> ATS/PRI capable PCI devices.
> =

> The problem with managing these TLBs are the semantics of
> the invalidate_range_start/end call-backs currently
> available. Currently the subsystem using mmu_notifiers has
> to guarantee that no new TLB entries are established between
> invalidate_range_start/end. Furthermore the
> invalidate_range_start() function is called when all pages
> are still mapped and invalidate_range_end() when the pages
> are unmapped an already freed.
> =

> So both call-backs can't be used to safely flush any non-CPU
> TLB because _start() is called too early and _end() too
> late.
> =

> In the AMD IOMMUv2 driver this is currently implemented by
> assigning an empty page-table to the external device between
> _start() and _end(). But as tests have shown this doesn't
> work as external devices don't re-fault infinitly but enter
> a failure state after some time.
> =

> Next problem with this solution is that it causes an
> interrupt storm for IO page faults to be handled when an
> empty page-table is assigned.
> =

> Furthermore the _start()/end() notifiers only catch the
> moment when page mappings are released, but not page-table
> pages. But this is necessary for managing external TLBs when
> the page-table is shared with the CPU.
> =

> To solve this situation I wrote a patch-set to introduce a
> new notifier call-back: mmu_notifer_invalidate_range(). This
> notifier lifts the strict requirements that no new
> references are taken in the range between _start() and
> _end(). When the subsystem can't guarantee that any new
> references are taken is has to provide the
> invalidate_range() call-back to clear any new references in
> there.
> =

> It is called between invalidate_range_start() and _end()
> every time the VMM has to wipe out any references to a
> couple of pages. This are usually the places where the CPU
> TLBs are flushed too and where its important that this
> happens before invalidate_range_end() is called.
> =

> Any comments and review appreciated!

For the series :

Reviewed-by: J=E9r=F4me Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

> =

> Thanks,
> =

> 	Joerg
> =

> Joerg Roedel (3):
>   mmu_notifier: Add mmu_notifier_invalidate_range()
>   mmu_notifier: Call mmu_notifier_invalidate_range() from VMM
>   mmu_notifier: Add the call-back for mmu_notifier_invalidate_range()
> =

>  include/linux/mmu_notifier.h | 75 ++++++++++++++++++++++++++++++++++++++=
+++---
>  kernel/events/uprobes.c      |  2 +-
>  mm/fremap.c                  |  2 +-
>  mm/huge_memory.c             |  9 +++---
>  mm/hugetlb.c                 |  7 ++++-
>  mm/ksm.c                     |  4 +--
>  mm/memory.c                  |  3 +-
>  mm/migrate.c                 |  3 +-
>  mm/mmu_notifier.c            | 25 +++++++++++++++
>  mm/rmap.c                    |  2 +-
>  10 files changed, 115 insertions(+), 17 deletions(-)
> =

> -- =

> 1.9.1
> =

> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo-Bw31MaZKKs0EbZ0PF+XxCw@public.gmane.org  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=3Dmailto:"dont-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org"> email-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org </a>
