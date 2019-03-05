From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 0/4] iommu/vt-d: Fix-up device-domain relationship by
 refactoring to use iommu group default domain.
Date: Tue, 5 Mar 2019 14:05:26 +0800
Message-ID: <dfad72a1-ce47-35bd-d965-27ef2e8bd504@linux.intel.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: James Sewart <jamessewart@arista.com>, iommu@lists.linux-foundation.org
Cc: baolu.lu@linux.intel.com, Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi James,

Very glad to see this. Thank you!

On 3/4/19 11:41 PM, James Sewart wrote:
> Hey,
> 
> This patchset moves IOMMU_DOMAIN_DMA iommu domain management to iommu.c.
> This avoids the use of find_or_alloc_domain whose domain assignment is
> inconsistent with the iommu grouping as determined by pci_device_group.

Is this a bug fix or an improvement? What's the real issue will it cause
if we go without this patch set?

Best regards,
Lu Baolu

> 
> Patch 3 permits domain type IOMMU_DOMAIN_DMA to be allocated via the
> iommu_ops api, allowing the default_domain of an iommu group to be set in
> iommu.c. This domain will be attached to every device that is brought up
> with an iommu group, and the devices reserved regions will be mapped using
> regions returned by get_resv_regions.
> 
> In intel_iommu_domain_alloc we don’t know the IOMMU this domain will be
> associated with so we defer full initialisation until
> intel_iommu_attach_device. Currently iommu.c:iommu_group_add_device will
> try to map a devices reserved regions before attaching the domain which
> would cause issue if the domain is not fully initialised. This is
> addressed in patch 1 by moving the mapping to after attaching.
> 
> Patch 2 implements function apply_resv_region, used in
> iommu_group_create_direct_mappings to mark the reserved regions as non
> mappable for the dma_map_ops api.
> 
> Patch 4 removes the domain lazy allocation logic. Before this patch the
> lazy allocation logic would not be used as any domain allocated using
> these paths would be replaced when attaching the group default domain.
> Default domain allocation has been tested with and without this patch on
> 4.19.
> 
> Cheers,
> James.
> 
> James Sewart (4):
>    iommu: Move iommu_group_create_direct_mappings to after device_attach
>    iommu/vt-d: Implement apply_resv_region for reserving IOVA ranges
>    iommu/vt-d: Allow IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_IDENTITY to be allocated
>    iommu/vt-d: Remove lazy allocation of domains
> 
>   drivers/iommu/intel-iommu.c | 329 ++++++++++++------------------------
>   drivers/iommu/iommu.c       |   4 +-
>   2 files changed, 108 insertions(+), 225 deletions(-)
> 
