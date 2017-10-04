From: Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] mm/mmu_notifier: avoid double notification when it is
 useless
Date: Tue, 3 Oct 2017 17:43:47 -0700
Message-ID: <0D64494B-AB3D-4091-B75A-883EA37BE098@gmail.com>
References: <20170901173011.10745-1-jglisse@redhat.com>
 <20171003234215.GA5231@redhat.com> <20171004001559.GD20644@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20171004001559.GD20644@redhat.com>
Sender: linux-next-owner@vger.kernel.org
To: Jerome Glisse <jglisse@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Joerg Roedel <jroedel@suse.de>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, David Woodhouse <dwmw2@infradead.org>, Alistair Popple <alistair@popple.id.au>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stephen Rothwell <sfr@canb.auug.org.au>, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Jerome Glisse <jglisse@redhat.com> wrote:

> On Wed, Oct 04, 2017 at 01:42:15AM +0200, Andrea Arcangeli wrote:
>=20
>> I'd like some more explanation about the inner working of "that new
>> user" as per comment above.
>>=20
>> It would be enough to drop mmu_notifier_invalidate_range from above
>> without adding it to the filebacked case. The above gives higher prio
>> to the hypothetical and uncertain future case, than to the current
>> real filebacked case that doesn't need ->invalidate_range inside the
>> PT lock, or do you see something that might already need such
>> ->invalidate_range?
>=20
> No i don't see any new user today that might need such invalidate but
> i was trying to be extra cautious as i have a tendency to assume that
> someone might do a patch that use try_to_unmap() without going through
> all the comments in the function and thus possibly using it in a an
> unexpected way from mmu_notifier callback point of view. I am fine
> with putting the burden on new user to get it right and adding an
> extra warning in the function description to try to warn people in a
> sensible way.

I must be missing something. After the PTE is changed, but before the
secondary TLB notification/invalidation - What prevents another thread =
from
changing the mappings (e.g., using munmap/mmap), and setting a new page
at that PTE?

Wouldn=E2=80=99t it end with the page being mapped without a secondary =
TLB flush in
between?

Nadav
