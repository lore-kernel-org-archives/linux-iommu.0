From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/5] Introduce device_iommu_maped() function
Date: Wed, 5 Dec 2018 17:17:29 +0000
Message-ID: <e34dcbe8-2f1b-31bb-2093-542361635cf5@arm.com>
References: <20181204172504.19708-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204172504.19708-1-joro@8bytes.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 04/12/2018 17:24, Joerg Roedel wrote:
> Hi,
> 
> here is a patch-set to replace the dev->iommu_group checks
> in the source tree by a proper function call. The pointer
> checks mostly happen to check whether a device is managed my
> an IOMMU. For that purpose a pointer check is not very
> descriptable, so replace it by a function call that make its
> purpose readable.

Nice, we can also clean up a whole load of vague iommu_present() usage 
and even one or two odd iommu_get_domain_for_dev() calls once we have this.

> This also starts to remove direct access to the
> dev->iommu_group pointer outside of iommu-code. This is
> another move towards consolidating the various
> iommu-related pointers in 'struct device' into one pointer
> only.
> 
> Please review.
> 
> Thanks,
> 
> 	Joerg
> 
> Joerg Roedel (5):
>    driver core: Introduce device_iommu_mapped() function
>    iommu/of: Use device_iommu_mapped()
>    ACPI/IORT: Use device_iommu_mapped()
>    powerpc/iommu: Use device_iommu_mapped()
>    xhci: Use device_iommu_mapped()
> 
>   arch/powerpc/kernel/eeh.c   |  2 +-
>   arch/powerpc/kernel/iommu.c |  6 +++---
>   drivers/acpi/arm64/iort.c   |  2 +-
>   drivers/iommu/of_iommu.c    |  2 +-
>   drivers/usb/host/xhci.c     |  2 +-
>   include/linux/device.h      | 10 ++++++++++
>   6 files changed, 17 insertions(+), 7 deletions(-)

There looks to be one more here:

drivers/dma/sh/rcar-dmac.c: rcar_dmac_probe()

Other than that and a minor comment on the OF/IORT part, though, for the 
whole series:

Acked-by: Robin Murphy <robin.murphy@arm.com>
