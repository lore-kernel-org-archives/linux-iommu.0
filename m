From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 0/7] iommu/vt-d: Fix-up device-domain relationship by
 refactoring to use iommu group default domain.
Date: Fri, 15 Mar 2019 11:13:22 +0800
Message-ID: <0e74cc54-bb90-a620-5763-466cb11aaef7@linux.intel.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: James Sewart <jamessewart@arista.com>, iommu@lists.linux-foundation.org
Cc: baolu.lu@linux.intel.com, Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi James,

On 3/14/19 7:56 PM, James Sewart wrote:
> Patches 1 and 2 are the same as v1.
> 
> v1-v2:
>    Refactored ISA direct mappings to be returned by iommu_get_resv_regions.
>    Integrated patch by Lu to defer turning on DMAR until iommu.c has mapped
> reserved regions.
>    Integrated patches by Lu to remove more unused code in cleanup.
> 
> Lu: I didn't integrate your patch to set the default domain type as it
> isn't directly related to the aim of this patchset. Instead patch 4

Without those patches, user experience will be affected and some devices
will not work on Intel platforms anymore.

For a long time, Intel IOMMU driver has its own logic to determine
whether a device requires an identity domain. For example, when user
specifies "iommu=pt" in kernel parameter, all device will be attached
with the identity domain. Further more, some quirky devices require
an identity domain to be used before enabling DMA remapping, otherwise,
it will not work. This was done by adding quirk bits in Intel IOMMU
driver.

So from my point of view, one way is porting all those quirks and kernel
parameters into IOMMU generic layer, or opening a door for vendor IOMMU
driver to determine the default domain type by their own. I prefer the
latter option since it will not impact any behaviors on other
architectures.

> addresses the issue of a device requiring an identity domain by ignoring
> the domain param in attach_device and printing a warning.

This will not work as I commented in that thread.

> 
> I booted some of our devices with this patchset and haven't seen any
> issues. It doesn't look like we have any devices with RMRR's though so
> those codepaths aren't tested.
> 
> James Sewart (7):
>    iommu: Move iommu_group_create_direct_mappings to after device_attach
>    iommu/vt-d: Implement apply_resv_region for reserving IOVA ranges
>    iommu/vt-d: Expose ISA direct mapping region via
>      iommu_get_resv_regions
>    iommu/vt-d: Ignore domain parameter in attach_device if device
>      requires identity map
>    iommu/vt-d: Allow IOMMU_DOMAIN_DMA to be allocated by iommu_ops
>    iommu/vt-d: Remove lazy allocation of domains
> 
> Lu Baolu (1):
>    iommu/vt-d: Enable DMA remapping after rmrr mapped
> 
>   drivers/iommu/intel-iommu.c | 444 +++++++++++-------------------------
>   drivers/iommu/iommu.c       |   4 +-
>   2 files changed, 131 insertions(+), 317 deletions(-)
> 

Best regards,
Lu Baolu
