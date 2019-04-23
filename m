From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 07/10] iommu/vt-d: Keep swiotlb on if bounce page is
 necessary
Date: Tue, 23 Apr 2019 10:00:32 +0800
Message-ID: <68192a07-4eac-4b2e-5c23-075defde9f34@linux.intel.com>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
 <20190421011719.14909-8-baolu.lu@linux.intel.com>
 <20190422164720.GB31181@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422164720.GB31181@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Mika Westerberg <mika.westerberg@intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 4/23/19 12:47 AM, Christoph Hellwig wrote:
> On Sun, Apr 21, 2019 at 09:17:16AM +0800, Lu Baolu wrote:
>> +static inline bool platform_has_untrusted_device(void)
>>   {
>> +	bool has_untrusted_device = false;
>>   	struct pci_dev *pdev = NULL;
>>   
>>   	for_each_pci_dev(pdev) {
>>   		if (pdev->untrusted) {
>> +			has_untrusted_device = true;
>>   			break;
>>   		}
>>   	}
>>   
>> +	return has_untrusted_device;
> 
> This shouldn't really be in the intel-iommu driver, should it?
> This probably should be something like pci_has_untrusted_devices
> and be moved to the PCI code.
> 

Fair enough.

Best regards,
Lu Baolu
