From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v7 0/3] PCI/IOMMU: Reserve IOVAs for PCI inbound memory
Date: Mon, 22 May 2017 13:18:38 -0600
Message-ID: <20170522131838.71258483@w520.home>
References: <1495471182-12490-1-git-send-email-oza.oza@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1495471182-12490-1-git-send-email-oza.oza@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
To: Oza Pawandeep <oza.oza@broadcom.com>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Oza Pawandeep <oza.pawandeep@gmail.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, 22 May 2017 22:09:39 +0530
Oza Pawandeep <oza.oza@broadcom.com> wrote:

> iproc based PCI RC and Stingray SOC has limitaiton of addressing only 512GB
> memory at once.
> 
> IOVA allocation honors device's coherent_dma_mask/dma_mask.
> In PCI case, current code honors DMA mask set by EP, there is no
> concept of PCI host bridge dma-mask,  should be there and hence
> could truly reflect the limitation of PCI host bridge.
> 
> However assuming Linux takes care of largest possible dma_mask, still the
> limitation could exist, because of the way memory banks are implemented.
> 
> for e.g. memory banks:
> <0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
> <0x00000008 0x80000000 0x3 0x80000000>, /* 14G @ 34G */
> <0x00000090 0x00000000 0x4 0x00000000>, /* 16G @ 576G */
> <0x000000a0 0x00000000 0x4 0x00000000>; /* 16G @ 640G */
> 
> When run User space (SPDK) which internally uses vfio in order to access
> PCI EndPoint directly.
> 
> Vfio uses huge-pages which could come from 640G/0x000000a0. 
> And the way vfio maps the hugepage is to have phys addr as iova,
> and ends up calling VFIO_IOMMU_MAP_DMA ends up calling iommu_map,
> inturn arm_lpae_map mapping iovas out of range.
> 
> So the way kernel allocates IOVA (where it honours device dma_mask) and
> the way userspace gets IOVA is different.
> 
> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>; will not work.
> 
> Instead we have to go for scattered dma-ranges leaving holes.
> Hence, we have to reserve IOVA allocations for inbound memory.
> The patch-set caters to only addressing IOVA allocation problem.


The description here confuses me, with vfio the user owns the iova
allocation problem.  Mappings are only identity mapped if the user
chooses to do so.  The dma_mask of the device is set by the driver and
only relevant to the DMA-API.  vfio is a meta-driver and doesn't know
the dma_mask of any particular device, that's the user's job.  Is the
net result of what's happening here for the vfio case simply to expose
extra reserved regions in sysfs, which the user can then consume to
craft a compatible iova?  Thanks,

Alex

> 
> Changes since v7:
> - Robin's comment addressed
> where he wanted to remove depedency between IOMMU and OF layer.
> - Bjorn Helgaas's comments addressed.
> 
> Changes since v6:
> - Robin's comments addressed.
> 
> Changes since v5:
> Changes since v4:
> Changes since v3:
> Changes since v2:
> - minor changes, redudant checkes removed
> - removed internal review
> 
> Changes since v1:
> - address Rob's comments.
> - Add a get_dma_ranges() function to of_bus struct..
> - Convert existing contents of of_dma_get_range function to
>   of_bus_default_dma_get_ranges and adding that to the
>   default of_bus struct.
> - Make of_dma_get_range call of_bus_match() and then bus->get_dma_ranges.
> 
> 
> Oza Pawandeep (3):
>   OF/PCI: expose inbound memory interface to PCI RC drivers.
>   IOMMU/PCI: reserve IOVA for inbound memory for PCI masters
>   PCI: add support for inbound windows resources
> 
>  drivers/iommu/dma-iommu.c | 44 ++++++++++++++++++++--
>  drivers/of/of_pci.c       | 96 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c       | 30 +++++++++++++--
>  include/linux/of_pci.h    |  7 ++++
>  include/linux/pci.h       |  1 +
>  5 files changed, 170 insertions(+), 8 deletions(-)
> 
