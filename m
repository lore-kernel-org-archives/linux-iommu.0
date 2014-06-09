From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 00/16] PCI/iommu: Fix DMA alias problems
Date: Mon, 09 Jun 2014 12:01:22 -0600
Message-ID: <1402336882.14174.107.camel@ul30vt.home>
References: <20140522230230.2856.40017.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140522230230.2856.40017.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2014-05-22 at 17:07 -0600, Alex Williamson wrote:
> Alex Williamson (16):
>       PCI: Add DMA alias iterator
>       PCI: define pci_dev_flags as bit shifts
>       PCI: quirk pci_for_each_dma_alias()
>       PCI: quirk dma_alias_devfn for Ricoh devices
>       PCI: quirk dma_alias_devfn for Marvell devices
>       PCI: Quirk pci_for_each_dma_alias() for bridges
>       PCI: Add quirks for ASMedia and Tundra bridges


Hi Joerg & David,

Bjorn has accepted the above patches for v3.16 and they currently live
in his pci/iommu branch.  This series has been shown by numerous users
to make devices with buggy DMA issues work in the presence of an IOMMU
and it would be really great if we could get an opinion on both the
common IOMMU changes as well as the changes for AMD-Vi and Intel VT-d.
Varun has already ack'd the changes for fsl.  Please let us know how
you'd like to proceed.  Can we get acks and allow Bjorn to shepherd the
whole series in?  Would you prefer to pull the changes via your
respective trees and let Bjorn follow-up with the code removal?  Do you
have any outstanding issues with the patches to your areas?  Thanks,

Alex

>       iommu: Create central IOMMU group lookup/creation interface
>       iommu/amd: Update to use PCI DMA aliases
>       iommu/amd: Use iommu_group_get_for_dev()
>       iommu/intel: Use iommu_group_get_for_dev()
>       iommu/intel: Update to use PCI DMA aliases
>       iommu/fsl: Use iommu_group_get_for_dev() for IOMMU groups
>       iommu: Remove pci.h
>       PCI: Remove pci_find_upstream_pcie_bridge()
>       PCI: Remove pci_get_dma_source()
> 
> 
>  drivers/iommu/amd_iommu.c           |  214 +++++++-----------------
>  drivers/iommu/amd_iommu_types.h     |    1 
>  drivers/iommu/fsl_pamu_domain.c     |   66 --------
>  drivers/iommu/intel-iommu.c         |  307 +++++++++++++----------------------
>  drivers/iommu/intel_irq_remapping.c |   55 ++++--
>  drivers/iommu/iommu.c               |  181 +++++++++++++++++++++
>  drivers/iommu/pci.h                 |   29 ---
>  drivers/pci/quirks.c                |  116 ++++++++-----
>  drivers/pci/search.c                |  104 +++++++++---
>  include/linux/iommu.h               |    1 
>  include/linux/pci.h                 |   31 +---
>  11 files changed, 557 insertions(+), 548 deletions(-)
>  delete mode 100644 drivers/iommu/pci.h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
