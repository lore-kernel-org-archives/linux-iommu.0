From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
Date: Thu, 13 Dec 2018 12:50:22 +0900
Message-ID: <CAAFQd5C+BygjdBhBOsiBW=4kOgC0a=V8s9om6jqa6yzmn0TEWw@mail.gmail.com>
References: <20181204110122.12434-1-vivek.gautam@codeaurora.org>
 <99682bd2-1ca6-406a-890c-b34c25a1b2b3@arm.com> <CAFp+6iE7U3HCJwHkeL9A4DXUVryt13YxDCYfBDxcSSM2Z_vqcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFp+6iE7U3HCJwHkeL9A4DXUVryt13YxDCYfBDxcSSM2Z_vqcg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Robin Murphy <robin.murphy@arm.com>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>"open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, pdaly@codeaurora.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pratikp@codeaurora.org, jcrouse@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 7, 2018 at 6:25 PM Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>
> Hi Robin,
>
> On Tue, Dec 4, 2018 at 8:51 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 04/12/2018 11:01, Vivek Gautam wrote:
> > > Qualcomm SoCs have an additional level of cache called as
> > > System cache, aka. Last level cache (LLC). This cache sits right
> > > before the DDR, and is tightly coupled with the memory controller.
> > > The cache is available to all the clients present in the SoC system.
> > > The clients request their slices from this system cache, make it
> > > active, and can then start using it.
> > > For these clients with smmu, to start using the system cache for
> > > buffers and, related page tables [1], memory attributes need to be
> > > set accordingly.
> > > This change updates the MAIR and TCR configurations with correct
> > > attributes to use this system cache.
> > >
> > > To explain a little about memory attribute requirements here:
> > >
> > > Non-coherent I/O devices can't look-up into inner caches. However,
> > > coherent I/O devices can. But both can allocate in the system cache
> > > based on system policy and configured memory attributes in page
> > > tables.
> > > CPUs can access both inner and outer caches (including system cache,
> > > aka. Last level cache), and can allocate into system cache too
> > > based on memory attributes, and system policy.
> > >
> > > Further looking at memory types, we have following -
> > > a) Normal uncached :- MAIR 0x44, inner non-cacheable,
> > >                        outer non-cacheable;
> > > b) Normal cached :-   MAIR 0xff, inner read write-back non-transient,
> > >                        outer read write-back non-transient;
> > >                        attribute setting for coherenet I/O devices.
> > >
> > > and, for non-coherent i/o devices that can allocate in system cache
> > > another type gets added -
> > > c) Normal sys-cached/non-inner-cached :-
> > >                        MAIR 0xf4, inner non-cacheable,
> > >                        outer read write-back non-transient
> > >
> > > So, CPU will automatically use the system cache for memory marked as
> > > normal cached. The normal sys-cached is downgraded to normal non-cached
> > > memory for CPUs.
> > > Coherent I/O devices can use system cache by marking the memory as
> > > normal cached.
> > > Non-coherent I/O devices, to use system cache, should mark the memory as
> > > normal sys-cached in page tables.
> > >
> > > This change is a realisation of following changes
> > > from downstream msm-4.9:
> > > iommu: io-pgtable-arm: Support DOMAIN_ATTRIBUTE_USE_UPSTREAM_HINT[2]
> > > iommu: io-pgtable-arm: Implement IOMMU_USE_UPSTREAM_HINT[3]
> > >
> > > [1] https://patchwork.kernel.org/patch/10302791/
> > > [2] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=bf762276796e79ca90014992f4d9da5593fa7d51
> > > [3] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=d4c72c413ea27c43f60825193d4de9cb8ffd9602
> > >
> > > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > > ---
> > >
> > > Changes since v1:
> > >   - Addressed Tomasz's comments for basing the change on
> > >     "NO_INNER_CACHE" concept for non-coherent I/O devices
> > >     rather than capturing "SYS_CACHE". This is to indicate
> > >     clearly the intent of non-coherent I/O devices that
> > >     can't access inner caches.
> >
> > That seems backwards to me - there is already a fundamental assumption
> > that non-coherent devices can't access caches. What we're adding here is
> > a weird exception where they *can* use some level of cache despite still
> > being non-coherent overall.
> >
> > In other words, it's not a case of downgrading coherent devices'
> > accesses to bypass inner caches, it's upgrading non-coherent devices'
> > accesses to hit the outer cache. That's certainly the understanding I
> > got from talking with Pratik at Plumbers, and it does appear to fit with
> > your explanation above despite the final conclusion you draw being
> > different.
>
> Thanks for the thorough review of the change.
> Right, I guess it's rather an upgrade for non-coherent devices to use
> an outer cache than a downgrade for coherent devices.
>

Note that it was not my suggestion to use "NO_INNER_CACHE" for
enabling the system cache, sorry for not being clear. What I was
asking for in my comment was regarding the previous patch disabling
inner cache if system cache is requested, which may not make for
coherent devices, which could benefit from using both inner and system
cache.

So note that there are several cases here:
 - coherent, IC, system cache alloc,
 - coherent. non-IC, system cache alloc,
 - coherent, IC, system cache look-up,
 - noncoherent device, non-IC, system cache alloc,
 - noncoherent device, non-IC, system cache look-up.

Given the presence or lack of coherency for the device, which of the
2/3 options is the best depends on the use case, e.g. DMA/CPU access
pattern, sharing memory between multiple devices, etc.

Best regards,
Tomasz
