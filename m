From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: userspace emulated smmu/vfio integration: how to trap updates to
 the table structures?
Date: Tue, 2 May 2017 18:22:23 +0300
Message-ID: <20170502181234-mutt-send-email-mst@kernel.org>
References: <52559520-f311-71de-a849-cac83d0c0e81@redhat.com>
 <CAMJs5B_LjRzvGrHGGUVtdGurjKPgg7_KOrvYAwmgpYXh2Qab8w@mail.gmail.com>
 <04a1dd2e-737c-3cb0-6cd8-71a783f463c8@redhat.com>
 <CAMJs5B-jdS+pWO+BEBAoprB+yRuRiWJWDewA96caniXXVK22kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMJs5B-jdS+pWO+BEBAoprB+yRuRiWJWDewA96caniXXVK22kQ@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Christoffer Dall <cdall@linaro.org>
Cc: Auger Eric <eric.auger@redhat.com>, Will Deacon <Will.Deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>, Andrew Jones <drjones@redhat.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, May 02, 2017 at 10:17:26AM +0200, Christoffer Dall wrote:
> On Tue, May 2, 2017 at 10:13 AM, Auger Eric <eric.auger@redhat.com> wrote:
> > Hi Christoffer,
> >
> > On 02/05/2017 09:53, Christoffer Dall wrote:
> >> On Tue, May 2, 2017 at 9:30 AM, Auger Eric <eric.auger@redhat.com> wrote:
> >>> Hi Will, Robin, Jean-Philippe,
> >>>
> >>> I have been working on the integration between user-space emulated
> >>> SMMU-v3 and VFIO in QEMU. At the moment I fail identifying a proper easy
> >>> way to trap page table updates. This is requested to keep the host
> >>> translation structures consistent to guest translation structures.
> >>>
> >>> On Intel VTD there is a so-called "caching mode" (CM, see VTD spec
> >>> paragraph 6.1) that forces the OS to explicitly invalidate caches
> >>> whenever it updates any remapping structure (updates to not-present or
> >>> present entries). Those invalidation commands are used to trap and
> >>> update host structures. This mode was devised for virtualization. I was
> >>> not able to find such "caching mode" on ARM SMMU. Is there any?
> >>>
> >>> If not, do you have any other suggestion, I mean, besides the
> >>> virtio-based solution.
> >>>
> >>>
> >> Worst case, can you make the guest page tables read-only and catch the
> >> faults and propagate changes to SMMU translations?
> >
> > The issue I foresee is there are up to 4 level of page tables to trap.
> > This would lead to plenty of regions to "translate" on qemu side. Also,
> > besides the 1st level pointed by TTBR found in stage 1 context
> > descriptor, other page regions would be discovered dynamically as
> > mapping are built. To me this is the last resort solution if confirmed
> > feasible.
> >
> Completely agree, it would be a terrible solution.
> 
> Thanks,
> -Christoffer

All "caching mode" is is simple a bit that the IOMMU device uses to tell
the OS "I might cache non-present/invalid entries, please use
invalidation even if you make non-present entries present".

So all we need from ARM is bit somewhere in one of MMU registers
and a promise not to use it for any other purpose preferably
by documenting it as caching mode bit in the next manual version.

Any chance of this happening?

-- 
MST
