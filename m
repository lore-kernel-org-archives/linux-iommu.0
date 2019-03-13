From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 4/9] iommu/vt-d: Add bounce buffer API for domain
 map/unmap
Date: Wed, 13 Mar 2019 10:04:41 +0800
Message-ID: <e653341d-e001-7262-740b-2262842be06d@linux.intel.com>
References: <20190312060005.12189-1-baolu.lu@linux.intel.com>
 <20190312060005.12189-5-baolu.lu@linux.intel.com>
 <20190312163845.GA13141@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312163845.GA13141@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 3/13/19 12:38 AM, Christoph Hellwig wrote:
> On Tue, Mar 12, 2019 at 02:00:00PM +0800, Lu Baolu wrote:
>> This adds the APIs for bounce buffer specified domain
>> map() and unmap(). The start and end partial pages will
>> be mapped with bounce buffered pages instead. This will
>> enhance the security of DMA buffer by isolating the DMA
>> attacks from malicious devices.
> 
> Please reuse the swiotlb code instead of reinventing it.
> 

I don't think we are doing the same thing as swiotlb here. But it's
always a good thing to reuse code if possible. I considered this when
writing this code, but I found it's hard to do. Do you mind pointing
me to the code which I could reuse?

Best regards,
Lu Baolu
