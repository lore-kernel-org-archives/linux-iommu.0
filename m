From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 08/10] iommu/vt-d: Check whether device requires bounce
 buffer
Date: Tue, 23 Apr 2019 15:35:51 +0800
Message-ID: <e11489cf-87cc-a956-7c6c-ffdd26a4e3ec@linux.intel.com>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
 <20190421011719.14909-9-baolu.lu@linux.intel.com>
 <20190422164755.GC31181@lst.de>
 <76e35340-32c3-ee0d-5232-bd8800248402@linux.intel.com>
 <20190423060858.GA12762@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423060858.GA12762@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 4/23/19 2:08 PM, Christoph Hellwig wrote:
>>> Again, this and the option should not be in a specific iommu driver.
>>>
>>
>> The option of whether bounce is ignored should be in the specific iommu
>> driver.
> 
> Why?  As a user I could not care less which IOMMU driver my particular
> system uses.
> 

Looks reasonable to me. Let's listen to more opinions.

Best regards,
Lu Baolu
