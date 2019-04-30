From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 5/8] iommu/vt-d: Implement def_domain_type iommu ops
 entry
Date: Tue, 30 Apr 2019 10:11:42 +0800
Message-ID: <9c1d1e16-fdab-0494-8720-97ff20013da4@linux.intel.com>
References: <20190429020925.18136-1-baolu.lu@linux.intel.com>
 <20190429020925.18136-6-baolu.lu@linux.intel.com>
 <20190429200338.GA8412@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429200338.GA8412@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, kevin.tian@intel.com, ashok.raj@intel.com, dima@arista.com, tmurphy@arista.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On 4/30/19 4:03 AM, Christoph Hellwig wrote:
>> @@ -3631,35 +3607,30 @@ static int iommu_no_mapping(struct device *dev)
>>   	if (iommu_dummy(dev))
>>   		return 1;
>>   
>> -	if (!iommu_identity_mapping)
>> -		return 0;
>> -
> 
> FYI, iommu_no_mapping has been refactored in for-next:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?h=x86/vt-d&id=48b2c937ea37a3bece0094b46450ed5267525289

Oh, yes! Thanks for letting me know this. Will rebase the code.

> 
>>   	found = identity_mapping(dev);
>>   	if (found) {
>> +		/*
>> +		 * If the device's dma_mask is less than the system's memory
>> +		 * size then this is not a candidate for identity mapping.
>> +		 */
>> +		u64 dma_mask = *dev->dma_mask;
>> +
>> +		if (dev->coherent_dma_mask &&
>> +		    dev->coherent_dma_mask < dma_mask)
>> +			dma_mask = dev->coherent_dma_mask;
>> +
>> +		if (dma_mask < dma_get_required_mask(dev)) {
> 
> I know this is mostly existing code moved around, but it really needs
> some fixing.  For one dma_get_required_mask is supposed to return the
> required to not bounce mask for the given device.  E.g. for a device
> behind an iommu it should always just return 32-bit.  If you really
> want to check vs system memory please call dma_direct_get_required_mask
> without the dma_ops indirection.
> 
> Second I don't even think we need to check the coherent_dma_mask,
> dma_direct is pretty good at always finding memory even without
> an iommu.
> 
> Third this doesn't take take the bus_dma_mask into account.
> 
> This probably should just be:
> 
> 		if (min(*dev->dma_mask, dev->bus_dma_mask) <
> 		    dma_direct_get_required_mask(dev)) {

Agreed and will add this in the next version.

Best regards,
Lu Baolu
