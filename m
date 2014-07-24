From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/3] mmu_notifier: Allow to manage CPU external TLBs
Date: Thu, 24 Jul 2014 16:35:38 +0200
Message-ID: <1406212541-25975-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrea Arcangeli <aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, Rik van Riel <riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Hugh Dickins <hughd-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Mel Gorman <mgorman-l3A5Bk7waGM@public.gmane.org>, Johannes Weiner <jweiner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Jay.Cornwall-5C7GfCeVMHo@public.gmane.org, John.Bridgman-5C7GfCeVMHo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org, Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, ben.sander-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

here is a patch-set to extend the mmu_notifiers in the Linux
kernel to allow managing CPU external TLBs. Those TLBs may
be implemented in IOMMUs or any other external device, e.g.
ATS/PRI capable PCI devices.

The problem with managing these TLBs are the semantics of
the invalidate_range_start/end call-backs currently
available. Currently the subsystem using mmu_notifiers has
to guarantee that no new TLB entries are established between
invalidate_range_start/end. Furthermore the
invalidate_range_start() function is called when all pages
are still mapped and invalidate_range_end() when the pages
are unmapped an already freed.

So both call-backs can't be used to safely flush any non-CPU
TLB because _start() is called too early and _end() too
late.

In the AMD IOMMUv2 driver this is currently implemented by
assigning an empty page-table to the external device between
_start() and _end(). But as tests have shown this doesn't
work as external devices don't re-fault infinitly but enter
a failure state after some time.

Next problem with this solution is that it causes an
interrupt storm for IO page faults to be handled when an
empty page-table is assigned.

To solve this situation I wrote a patch-set to introduce a
new notifier call-back: mmu_notifer_invalidate_range(). This
notifier lifts the strict requirements that no new
references are taken in the range between _start() and
_end(). When the subsystem can't guarantee that any new
references are taken is has to provide the
invalidate_range() call-back to clear any new references in
there.

It is called between invalidate_range_start() and _end()
every time the VMM has to wipe out any references to a
couple of pages. This are usually the places where the CPU
TLBs are flushed too and where its important that this
happens before invalidate_range_end() is called.

Any comments and review appreciated!

Thanks,

	Joerg

Joerg Roedel (3):
  mmu_notifier: Add mmu_notifier_invalidate_range()
  mmu_notifier: Call mmu_notifier_invalidate_range() from VMM
  mmu_notifier: Add the call-back for mmu_notifier_invalidate_range()

 include/linux/mmu_notifier.h | 66 ++++++++++++++++++++++++++++++++++++++++----
 kernel/events/uprobes.c      |  2 +-
 mm/fremap.c                  |  2 +-
 mm/huge_memory.c             |  9 +++---
 mm/hugetlb.c                 |  7 ++++-
 mm/ksm.c                     |  4 +--
 mm/memory.c                  |  3 +-
 mm/migrate.c                 |  3 +-
 mm/mmu_notifier.c            | 15 ++++++++++
 mm/rmap.c                    |  2 +-
 10 files changed, 95 insertions(+), 18 deletions(-)

-- 
1.9.1
