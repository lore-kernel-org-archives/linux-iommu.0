From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
Date: Thu, 18 Apr 2019 18:42:41 -0500
Message-ID: <20190418234241.GF126710@google.com>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
 <20190412223409.GB126710@google.com>
 <CABe79T7h9t_Obmo3+B0MHgLZ4ff9GxpBBBLGtSf0C=zmLrWVBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABe79T7h9t_Obmo3+B0MHgLZ4ff9GxpBBBLGtSf0C=zmLrWVBQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org, Ray Jui <rjui@broadcom.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 16, 2019 at 05:28:36PM +0530, Srinath Mannam wrote:
> On Sat, Apr 13, 2019 at 4:04 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Apr 12, 2019 at 08:43:32AM +0530, Srinath Mannam wrote:
> > > Few SOCs have limitation that their PCIe host can't allow few inbound
> > > address ranges. Allowed inbound address ranges are listed in dma-ranges
> > > DT property and this address ranges are required to do IOVA mapping.
> > > Remaining address ranges have to be reserved in IOVA mapping.
>
> > If I understand correctly, devices below these PCIe host bridges can
> > DMA only to the listed address ranges, and you prevent devices from
> > doing DMA to the holes between the listed ranges by reserving the
> > holes in dma-iommu.
>
> Yes, devices below these PCIe host bridges can DMA only to the listed
> address ranges,
> and this patch prevents to allocate DMA(IOVA) addresses in the holes
> of listed ranges.
>
> > Apparently there's something that makes sure driver dma_map_*() always
> > goes through dma-iommu?  I traced as far as seeing that dma-iommu
> > depends on CONFIG_IOMMU_DMA, and that arm64 selects CONFIG_IOMMU_DMA
> > if CONFIG_IOMMU_SUPPORT, but then the trail got cold.  I didn't see
> > what selects CONFIG_IOMMU_SUPPORT.
>
> IOMMU_SUPPORT depends on MMU.

Yes, I see that IOMMU_SUPPORT depends on MMU (in
drivers/iommu/Kconfig).  But that doesn't *select* IOMMU_SUPPORT; it
only means you *can't* select it unless MMU has already been selected.

I think you only get dma-iommu if you choose to select IOMMU_SUPPORT
via menuconfig or whatever, and the current config rules allow you to
turn that off.  Maybe that's OK, I dunno.  If you do turn it off, I
guess we'll ignore the holes in "dma-ranges" and devices will be able
to DMA to the holes.

> > This does look like what Robin suggested, as far as I can tell.
> > Hopefully he'll take a look and give his reviewed-by.  Thanks for
> > persevering!
> Thank you.
> 
> Regards,
> Srinath.
> >
> > > PCIe Host driver of those SOCs has to list resource entries of allowed
> > > address ranges given in dma-ranges DT property in sorted order. This
> > > sorted list of resources will be processed and reserve IOVA address for
> > > inaccessible address holes while initializing IOMMU domain.
> > >
> > > This patch set is based on Linux-5.0-rc2.
> > >
> > > Changes from v3:
> > >   - Addressed Robin Murphy review comments.
> > >     - pcie-iproc: parse dma-ranges and make sorted resource list.
> > >     - dma-iommu: process list and reserve gaps between entries
> > >
> > > Changes from v2:
> > >   - Patch set rebased to Linux-5.0-rc2
> > >
> > > Changes from v1:
> > >   - Addressed Oza review comments.
> > >
> > > Srinath Mannam (3):
> > >   PCI: Add dma_ranges window list
> > >   iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
> > >   PCI: iproc: Add sorted dma ranges resource entries to host bridge
> > >
> > >  drivers/iommu/dma-iommu.c           | 19 ++++++++++++++++
> > >  drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
> > >  drivers/pci/probe.c                 |  3 +++
> > >  include/linux/pci.h                 |  1 +
> > >  4 files changed, 66 insertions(+), 1 deletion(-)
> > >
> > > --
> > > 2.7.4
> > >
