From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
Date: Wed, 1 May 2019 12:30:38 +0100
Message-ID: <20190501113038.GA7961@e121166-lin.cambridge.arm.com>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinath Mannam <srinath.mannam@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, poza@codeaurora.org, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 12, 2019 at 08:43:32AM +0530, Srinath Mannam wrote:
> Few SOCs have limitation that their PCIe host can't allow few inbound
> address ranges. Allowed inbound address ranges are listed in dma-ranges
> DT property and this address ranges are required to do IOVA mapping.
> Remaining address ranges have to be reserved in IOVA mapping.
> 
> PCIe Host driver of those SOCs has to list resource entries of allowed
> address ranges given in dma-ranges DT property in sorted order. This
> sorted list of resources will be processed and reserve IOVA address for
> inaccessible address holes while initializing IOMMU domain.
> 
> This patch set is based on Linux-5.0-rc2.
> 
> Changes from v3:
>   - Addressed Robin Murphy review comments.
>     - pcie-iproc: parse dma-ranges and make sorted resource list.
>     - dma-iommu: process list and reserve gaps between entries
> 
> Changes from v2:
>   - Patch set rebased to Linux-5.0-rc2
> 
> Changes from v1:
>   - Addressed Oza review comments.
> 
> Srinath Mannam (3):
>   PCI: Add dma_ranges window list
>   iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
>   PCI: iproc: Add sorted dma ranges resource entries to host bridge
> 
>  drivers/iommu/dma-iommu.c           | 19 ++++++++++++++++
>  drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
>  drivers/pci/probe.c                 |  3 +++
>  include/linux/pci.h                 |  1 +
>  4 files changed, 66 insertions(+), 1 deletion(-)

Bjorn, Joerg,

this series should not affect anything in the mainline other than its
consumer (ie patch 3); if that's the case should we consider it for v5.2
and if yes how are we going to merge it ?

Thanks,
Lorenzo
