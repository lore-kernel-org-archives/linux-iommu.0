From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 00/16] PCI/iommu: Fix DMA alias problems
Date: Mon, 16 Jun 2014 16:47:59 +0200
Message-ID: <20140616144759.GC18986@8bytes.org>
References: <20140522230230.2856.40017.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
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
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, eddy0596-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

On Thu, May 22, 2014 at 05:07:23PM -0600, Alex Williamson wrote:
> Alex Williamson (16):
>       PCI: Add DMA alias iterator
>       PCI: define pci_dev_flags as bit shifts
>       PCI: quirk pci_for_each_dma_alias()
>       PCI: quirk dma_alias_devfn for Ricoh devices
>       PCI: quirk dma_alias_devfn for Marvell devices
>       PCI: Quirk pci_for_each_dma_alias() for bridges
>       PCI: Add quirks for ASMedia and Tundra bridges
>       iommu: Create central IOMMU group lookup/creation interface
>       iommu/amd: Update to use PCI DMA aliases
>       iommu/amd: Use iommu_group_get_for_dev()
>       iommu/intel: Use iommu_group_get_for_dev()
>       iommu/intel: Update to use PCI DMA aliases
>       iommu/fsl: Use iommu_group_get_for_dev() for IOMMU groups
>       iommu: Remove pci.h
>       PCI: Remove pci_find_upstream_pcie_bridge()
>       PCI: Remove pci_get_dma_source()

Sorry for the delay, I had a look at the generic IOMMU and the AMD part
now. It looks good to me so far, but I still have to review the VT-d
changes and give it all some testing on my machines. I really like the
code simplification in the IOMMU drivers and also feel more comfortable
when the IVRS table is still taken into consideration for getting
aliases.


	Joerg
