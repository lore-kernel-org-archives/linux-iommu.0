From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1 4/9] iommu/vt-d: Add bounce buffer API for domain
 map/unmap
Date: Tue, 19 Mar 2019 11:21:35 +0000
Message-ID: <04703ea4-58e5-f833-5b39-1b68df2839ca@arm.com>
References: <20190312060005.12189-1-baolu.lu@linux.intel.com>
 <20190312060005.12189-5-baolu.lu@linux.intel.com>
 <20190312163845.GA13141@infradead.org>
 <e653341d-e001-7262-740b-2262842be06d@linux.intel.com>
 <c9fe7879-569e-b4f4-d6ec-47ab7e6fd443@linux.intel.com>
 <20190313161029.GA23513@infradead.org>
 <c1ffee0a-24d2-df53-0689-23b0d8ef065d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c1ffee0a-24d2-df53-0689-23b0d8ef065d@linux.intel.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>, Christoph Hellwig <hch@infradead.org>
Cc: kevin.tian@intel.com, mika.westerberg@linux.intel.com, ashok.raj@intel.com, alan.cox@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, pengfei.xu@intel.com, jacob.jun.pan@intel.com, David Woodhouse <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

On 19/03/2019 07:59, Lu Baolu wrote:
> Hi Christoph,
> 
> On 3/14/19 12:10 AM, Christoph Hellwig wrote:
>> On Wed, Mar 13, 2019 at 10:31:52AM +0800, Lu Baolu wrote:
>>> Hi again,
>>>
>>> On 3/13/19 10:04 AM, Lu Baolu wrote:
>>>> Hi,
>>>>
>>>> On 3/13/19 12:38 AM, Christoph Hellwig wrote:
>>>>> On Tue, Mar 12, 2019 at 02:00:00PM +0800, Lu Baolu wrote:
>>>>>> This adds the APIs for bounce buffer specified domain
>>>>>> map() and unmap(). The start and end partial pages will
>>>>>> be mapped with bounce buffered pages instead. This will
>>>>>> enhance the security of DMA buffer by isolating the DMA
>>>>>> attacks from malicious devices.
>>>>>
>>>>> Please reuse the swiotlb code instead of reinventing it.
>>>>>
>>>
>>> Just looked into the code again. At least we could reuse below
>>> functions:
>>>
>>> swiotlb_tbl_map_single()
>>> swiotlb_tbl_unmap_single()
>>> swiotlb_tbl_sync_single()
>>>
>>> Anything else?
>>
>> Yes, that is probably about the level you want to reuse, given that the
>> next higher layer already has hooks into the direct mapping code.
>>
> 
> I am trying to change my code to reuse swiotlb. But I found that swiotlb
> might not be suitable for my case.
> 
> Below is what I got with swiotlb_map():
> 
> phy_addr        size    tlb_addr
> --------------------------------
> 0x167eec330     0x8     0x85dc6000
> 0x167eef5c0     0x40    0x85dc6800
> 0x167eec330     0x8     0x85dc7000
> 0x167eef5c0     0x40    0x85dc7800
> 
> But what I expected to get is:
> 
> phy_addr        size    tlb_addr
> --------------------------------
> 0x167eec330     0x8     0xAAAAA330
> 0x167eef5c0     0x40    0xBBBBB5c0
> 0x167eec330     0x8     0xCCCCC330
> 0x167eef5c0     0x40    0xDDDDD5c0
> 
> , where 0xXXXXXX000 is the physical address of a bounced page.
> 
> Basically, I want a bounce page to replace a leaf page in the vt-d page
> table, which maps a buffer with size less than a PAGE_SIZE.

I'd imagine the thing to do would be to factor out the slot allocation 
in swiotlb_tbl_map_single() so that an IOMMU page pool/allocator can be 
hooked in as an alternative.

However we implement it, though, this should absolutely be a common 
IOMMU thing that all relevant DMA backends can opt into, and not 
specific to VT-d. I mean, it's already more or less the same concept as 
the PowerPC secure VM thing.

Robin.
