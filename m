From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 02/10] swiotlb: Factor out slot allocation and free
Date: Mon, 29 Apr 2019 13:10:17 +0800
Message-ID: <93b3d627-782d-cae0-2175-77a5a8b3fe6e@linux.intel.com>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
 <20190421011719.14909-3-baolu.lu@linux.intel.com>
 <20190422164555.GA31181@lst.de>
 <0c6e5983-312b-0d6b-92f5-64861cd6804d@linux.intel.com>
 <20190423061232.GB12762@lst.de>
 <dff50b2c-5e31-8b4a-7fdf-99d17852746b@linux.intel.com>
 <20190424144532.GA21480@lst.de>
 <a189444b-15c9-8069-901d-8cdf9af7fc3c@linux.intel.com>
 <20190426150433.GA19930@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426150433.GA19930@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On 4/26/19 11:04 PM, Christoph Hellwig wrote:
> On Thu, Apr 25, 2019 at 10:07:19AM +0800, Lu Baolu wrote:
>> This is not VT-d specific. It's just how generic IOMMU works.
>>
>> Normally, IOMMU works in paging mode. So if a driver issues DMA with
>> IOVA  0xAAAA0123, IOMMU can remap it with a physical address 0xBBBB0123.
>> But we should never expect IOMMU to remap 0xAAAA0123 with physical
>> address of 0xBBBB0000. That's the reason why I said that IOMMU will not
>> work there.
> 
> Well, with the iommu it doesn't happen.  With swiotlb it obviosuly
> can happen, so drivers are fine with it.  Why would that suddenly
> become an issue when swiotlb is called from the iommu code?
> 

I would say IOMMU is DMA remapping, not DMA engine. :-)

Best regards,
Lu Baolu
