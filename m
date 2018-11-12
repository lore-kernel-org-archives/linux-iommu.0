From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 1/1] iommu/vtd: Cleanup dma_remapping.h header
Date: Mon, 12 Nov 2018 15:32:27 +0800
Message-ID: <164d65da-f879-7a5f-2833-03b750b89f29@linux.intel.com>
References: <20181112064008.2102-1-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D6242F@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439D6242F@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 11/12/18 3:20 PM, Liu, Yi L wrote:
>> bounces@lists.linux-foundation.org] On Behalf Of Lu Baolu
>> Sent: Monday, November 12, 2018 2:40 PM
>> Subject: [PATCH v2 1/1] iommu/vtd: Cleanup dma_remapping.h header
>>
>> Commit e61d98d8dad00 ("x64, x2apic/intr-remap: Intel vt-d, IOMMU
>> code reorganization") moved dma_remapping.h from drivers/pci/ to
>> current place. It is entirely VT-d specific, but uses a generic
>> name. This merges dma_remapping.h with include/linux/intel-iommu.h
>> and removes dma_remapping.h as the result.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Sohil Mehta <sohil.mehta@intel.com>
>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
> 
> Reviewed-by: Liu, Yi L <yi.l.liu@intel.com>
> 
> Just out of curious, did you considered to modify the original file
> name to be an intel specific file name? What makes you believe
> merging the file content to intel-iommu.h is better?

I don't think we need multiple headers for VT-d specific things.

Best regards,
Lu Baolu
