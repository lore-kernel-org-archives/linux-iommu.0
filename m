From: Wan Zongshun <vw@iommu.org>
Subject: Re: [PATCH 00/20] iommu/amd: Use generic IOVA allocator
Date: Tue, 12 Jul 2016 17:03:08 +0800
Message-ID: <5784B24C.60305@iommu.org>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc: Vincent.Wan@amd.com, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org



On 2016=E5=B9=B407=E6=9C=8808=E6=97=A5 19:44, Joerg Roedel wrote:
> Hi,
>
> here is a patch-set to make the AMD IOMMU driver use the
> generic IOVA allocator, which is already used in the Intel
> VT-d driver and a few other places.
>
> The main reason for the conversion is to make the driver
> benefit from the recent scalability improvements to the IOVA
> code. Some of these improvements happened in the Intel VT-d
> driver, these are not re-used but, for now, re-implemented.
>
> This leaves more room for merging things together into
> common code for the future.
>
> The allocator that was previously used will be removed with
> these patches.
>
> Please review.

Joerg,

Currently, those patches can not work at my eCarrizo board.
When I merged your patches, boot failed, and no any info print to me.
I set iommu=3Dpt, it also does not work; set iommu=3Dsoft, boot ok.

When I removed those patches, kernel boot ok.

This eCarrizo board uart doesnot work, so I can not get useful=20
information from kernel by uart console, I also set 'text' in boot=20
option, but still cannot print any log.


Vincent.

>
> Thanks,
>
> 	Joerg
>
> Joerg Roedel (20):
>    iommu: Add apply_dm_region call-back to iommu-ops
>    iommu/amd: Select IOMMU_IOVA for AMD IOMMU
>    iommu/amd: Allocate iova_domain for dma_ops_domain
>    iommu/amd: Create a list of reserved iova addresses
>    iommu/amd: Implement apply_dm_region call-back
>    iommu/amd: Pass gfp-flags to iommu_map_page()
>    iommu/amd: Remove special mapping code for dma_ops path
>    iommu/amd: Make use of the generic IOVA allocator
>    iommu/amd: Remove other remains of old address allocator
>    iommu/amd: Remove align-parameter from __map_single()
>    iommu/amd: Set up data structures for flush queue
>    iommu/amd: Allow NULL pointer parameter for domain_flush_complete(=
)
>    iommu/amd: Implement flush queue
>    iommu/amd: Implement timeout to flush unmap queues
>    iommu/amd: Introduce dir2prot() helper
>    iommu/amd: Optimize map_sg and unmap_sg
>    iommu/amd: Use dev_data->domain in get_domain()
>    iommu/amd: Handle IOMMU_DOMAIN_DMA in ops->domain_free call-back
>    iommu/amd: Flush iova queue before releasing dma_ops_domain
>    iommu/amd: Use container_of to get dma_ops_domain
>
>   drivers/iommu/Kconfig           |   1 +
>   drivers/iommu/amd_iommu.c       | 976 ++++++++++++++++-------------=
-----------
>   drivers/iommu/amd_iommu_types.h |   1 -
>   drivers/iommu/iommu.c           |   3 +
>   include/linux/iommu.h           |   3 +
>   5 files changed, 387 insertions(+), 597 deletions(-)
>
