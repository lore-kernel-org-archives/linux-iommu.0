From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vtd: Cleanup dma_remapping.h header
Date: Mon, 12 Nov 2018 09:17:44 +0800
Message-ID: <518f02b4-8c4f-9451-68f1-cb014c4cc6eb@linux.intel.com>
References: <20181110070844.28353-1-baolu.lu@linux.intel.com>
 <20181110083506.GB28614@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181110083506.GB28614@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Sohil Mehta <sohil.mehta@intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 11/10/18 4:35 PM, Christoph Hellwig wrote:
> On Sat, Nov 10, 2018 at 03:08:44PM +0800, Lu Baolu wrote:
>> Commit e61d98d8dad00 ("x64, x2apic/intr-remap: Intel vt-d, IOMMU
>> code reorganization") moved dma_remapping.h from drivers/pci/ to
>> current place. It is entirely VT-d specific, but uses a generic
>> name. This merges dma_remapping.h with include/linux/intel-iommu.h
>> and removes dma_remapping.h as the result.
> 
> This looks fine to me, thanks for doing the work.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thank you.

> 
>> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
>> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
>> @@ -34,7 +34,7 @@
>>   #include <drm/ttm/ttm_placement.h>
>>   #include <drm/ttm/ttm_bo_driver.h>
>>   #include <drm/ttm/ttm_module.h>
>> -#include <linux/dma_remapping.h>
>> +#include <linux/intel-iommu.h>
> 
> Btw, I don't think this driver has any business looking at Intel
> IOMMU driver internals, and the code doing so is more than gross.
> 
> Not really your job, but vmw_dma_select_mode really needs a rewrite with
> someone that has at least half a clue, and some taste.
> 
> Eventually we should also drop the intel_iommu_enabled export.
> 

Yes. Fair enough.

Best regards,
Lu Baolu
