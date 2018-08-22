From: Ganapatrao Kulkarni <gklkml16@gmail.com>
Subject: Re: [PATCH 0/4] numa, iommu/smmu: IOMMU/SMMU driver optimization for
 NUMA systems
Date: Wed, 22 Aug 2018 10:57:07 -0700
Message-ID: <CAKTKpr7XbZAZ8XRJ2r97N+AQP_DM8_OrqYC=4Pstf-vRW85rng@mail.gmail.com>
References: <20170921085922.11659-1-ganapatrao.kulkarni@cavium.com>
 <452f1665-eb3a-5e8c-f671-099ef4a15d84@huawei.com> <a7fc1e43-3652-562a-1e59-499be80b567c@arm.com>
 <ec57224a-7673-97d8-bb0c-c612080625bc@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ec57224a-7673-97d8-bb0c-c612080625bc@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, Will Deacon <Will.Deacon@arm.com>, Tomasz.Nowicki@cavium.com, Robert Richter <Robert.Richter@cavium.com>, mhocko@suse.com, akpm@linux-foundation.org, vbabka@suse.cz, jnair@caviumnetworks.com, Marek Szyprowski <m.szyprowski@samsung.com>, "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, Linuxarm <linuxarm@huawei.com>, Christoph Hellwig <hch@lst.de>
List-Id: iommu@lists.linux-foundation.org

On Wed, Aug 22, 2018 at 9:08 AM John Garry <john.garry@huawei.com> wrote:
>
> On 22/08/2018 15:56, Robin Murphy wrote:
> > Hi John,
> >
> > On 22/08/18 14:44, John Garry wrote:
> >> On 21/09/2017 09:59, Ganapatrao Kulkarni wrote:
> >>> Adding numa aware memory allocations used for iommu dma allocation and
> >>> memory allocated for SMMU stream tables, page walk tables and command
> >>> queues.
> >>>
> >>> With this patch, iperf testing on ThunderX2, with 40G NIC card on
> >>> NODE 1 PCI shown same performance(around 30% improvement) as NODE 0.
> >>>
> >>> Ganapatrao Kulkarni (4):
> >>>   mm: move function alloc_pages_exact_nid out of __meminit
> >>>   numa, iommu/io-pgtable-arm: Use NUMA aware memory allocation for smmu
> >>>     translation tables
> >>>   iommu/arm-smmu-v3: Use NUMA memory allocations for stream tables and
> >>>     comamnd queues
> >>>   iommu/dma, numa: Use NUMA aware memory allocations in
> >>>     __iommu_dma_alloc_pages
> >>>
> >>>  drivers/iommu/arm-smmu-v3.c    | 57
> >>> +++++++++++++++++++++++++++++++++++++-----
> >>>  drivers/iommu/dma-iommu.c      | 17 +++++++------
> >>>  drivers/iommu/io-pgtable-arm.c |  4 ++-
> >>>  include/linux/gfp.h            |  2 +-
> >>>  mm/page_alloc.c                |  3 ++-
> >>>  5 files changed, 67 insertions(+), 16 deletions(-)
> >>>
> >>
> >> Hi Ganapatrao,
> >>
> >> Have you any plans for further work on this patchset? I have not seen
> >> anything since this v1 was posted+discussed.
> >
>
> Hi Robin,
>
> Thanks for the info. I thought I remembered 4b12 but couldn't put my
> finger on it.
>
> > Looks like I ended up doing the version of the io-pgtable change that I
> > suggested here, which was merged recently (4b123757eeaa). Patch #3
> > should also be effectively obsolete now since the SWIOTLB/dma-direct
> > rework (21f237e4d085). Apparently I also started reworking patch #4 in
> > my tree at some point but sidelined it - I think that was at least
> > partly due to another thread[1] which made it seem less clear-cut
> > whether this is always the right thing to do.
>
> Right, so #4 seems less straightforward and not directly related to
> IOMMU driver anyway.
>

thanks Robin for pulling up the patch. I couldn't followup with this
due to other tasks.

> Cheers,
> John
>
> >
> > Robin.
> >
> > [1]
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1693026.html
> >
> > .
> >
>
>
thanks,
Ganapat
