From: Jerome Glisse <j.glisse@gmail.com>
Subject: Re: [PATCH 1/3] mmu_notifier: Add mmu_notifier_invalidate_range()
Date: Fri, 25 Jul 2014 16:43:15 -0400
Message-ID: <20140725204314.GA5478@gmail.com>
References: <1406212541-25975-1-git-send-email-joro@8bytes.org>
 <1406212541-25975-2-git-send-email-joro@8bytes.org>
 <20140725131639.698f18ff@jbarnes-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20140725131639.698f18ff@jbarnes-desktop>
Sender: owner-linux-mm@kvack.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Joerg Roedel <joro@8bytes.org>, Andrew Morton <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Hugh Dickins <hughd@google.com>, Mel Gorman <mgorman@suse.de>, Johannes Weiner <jweiner@redhat.com>, Jerome Glisse <jglisse@redhat.com>, jroedel@suse.de, Jay.Cornwall@amd.com, Oded.Gabbay@amd.com, John.Bridgman@amd.com, Suravee.Suthikulpanit@amd.com, ben.sander@amd.com, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 25, 2014 at 01:16:39PM -0700, Jesse Barnes wrote:
> On Thu, 24 Jul 2014 16:35:39 +0200
> Joerg Roedel <joro@8bytes.org> wrote:
>=20
> > From: Joerg Roedel <jroedel@suse.de>
> >=20
> > This notifier closes an important gap with the current
> > invalidate_range_start()/end() notifiers. The _start() part
> > is called when all pages are still mapped while the _end()
> > notifier is called when all pages are potentially unmapped
> > and already freed.
> >=20
> > This does not allow to manage external (non-CPU) hardware
> > TLBs with MMU-notifiers because there is no way to prevent
> > that hardware will establish new TLB entries between the
> > calls of these two functions. But this is a requirement to
> > the subsytem that implements these existing notifiers.
> >=20
> > To allow managing external TLBs the MMU-notifiers need to
> > catch the moment when pages are unmapped but not yet freed.
> > This new notifier catches that moment and notifies the
> > interested subsytem when pages that were unmapped are about
> > to be freed. The new notifier will only be called between
> > invalidate_range_start()/end().
>=20
> So if we were actually sharing page tables, we should be able to make
> start/end no-ops and just use this new callback, assuming we didn't
> need to do any other serialization or debug stuff, right?
>=20
> Seems like a good addition, and saves us a bunch of trouble...

Pondering on that i think there is a missing call to mmu_notifier_invalid=
ate_range
inside move_huge_pmd which is call by move_page_tables.=20

But otherwise yes, you should not need to register range_start/end() call=
back. It
should be enought to only register the invalidate_range callback.

Note that on my side i will remain an user of range_start/end() but other=
 listener
like kvm or xen or sgi might want to revisit there code with this new cal=
lback.

Cheers,
J=E9r=F4me

>=20
> Thanks,
> --=20
> Jesse Barnes, Intel Open Source Technology Center
>=20
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
