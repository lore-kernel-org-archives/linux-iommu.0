From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/3 v4] mmu_notifier: Allow to manage CPU external TLBs
Date: Tue, 28 Oct 2014 18:13:57 +0100
Message-ID: <1414516440-910-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Hugh Dickins <hughd@google.com>, Mel Gorman <mgorman@suse.de>, Johannes Weiner <jweiner@redhat.com>
Cc: Jerome Glisse <jglisse@redhat.com>, Jay.Cornwall@amd.com, Oded.Gabbay@amd.com, John.Bridgman@amd.com, Suravee.Suthikulpanit@amd.com, ben.sander@amd.com, Jesse Barnes <jbarnes@virtuousgeek.org>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, jroedel@suse.de, joro@8bytes.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Changes V3->V4:

* Rebased to v3.18-rc2
* Updated patch description and some comments

Changes V2->V3:

* Rebased to v3.17-rc4
* Fixed compile error because pmdp_get_and_clear_notify was
  missing

Changes V1->V2:

* Rebase to v3.16-rc7
* Added call of ->invalidate_range to
  __mmu_notifier_invalidate_end() so that the subsystem
  doesn't need to register an ->invalidate_end() call-back,
  subsystems will likely either register
  invalidate_range_start/end or invalidate_range, so that
  should be fine.
* Re-orded declarations a bit to reflect that
  invalidate_range is not only called between
  invalidate_range_start/end
* Updated documentation to cover the case where
  invalidate_range is called outside of
  invalidate_range_start/end to flush page-table pages out
  of the TLB

Hi,

here is v4 of my patch-set which extends the mmu-notifiers
to allow managing CPU external TLBs. A more in-depth
description on the How and Why of this patch-set can be
found in the description of patch 1/3.

Any comments and review appreciated!

Thanks,

	Joerg

Joerg Roedel (3):
  mmu_notifier: Add mmu_notifier_invalidate_range()
  mmu_notifier: Call mmu_notifier_invalidate_range() from VMM
  mmu_notifier: Add the call-back for mmu_notifier_invalidate_range()

 include/linux/mmu_notifier.h | 88 ++++++++++++++++++++++++++++++++++++++=
+++---
 kernel/events/uprobes.c      |  2 +-
 mm/fremap.c                  |  2 +-
 mm/huge_memory.c             |  9 +++--
 mm/hugetlb.c                 |  7 +++-
 mm/ksm.c                     |  4 +-
 mm/memory.c                  |  3 +-
 mm/migrate.c                 |  3 +-
 mm/mmu_notifier.c            | 25 +++++++++++++
 mm/rmap.c                    |  2 +-
 10 files changed, 128 insertions(+), 17 deletions(-)

--=20
1.8.4.5

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
