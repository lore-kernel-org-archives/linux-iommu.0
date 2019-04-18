From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
Date: Thu, 18 Apr 2019 18:48:28 -0500
Message-ID: <20190418234828.GG126710@google.com>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Scott Branden <sbranden@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

[+cc Scott]

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

To make progress on this, I think we need an ack from Joerg for the
dma-iommu.c part, an ack from Ray or Scott for the pcie-iproc.c part,
and an ack from Robin for the thing as a whole.

Then I would say Lorenzo should take a look and merge if he approves, since
pcie-iproc.c contains the most changes.

Bjorn
