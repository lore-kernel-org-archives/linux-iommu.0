From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 4/9] iommu/vt-d: Add bounce buffer API for domain
 map/unmap
Date: Tue, 19 Mar 2019 15:59:48 +0800
Message-ID: <c1ffee0a-24d2-df53-0689-23b0d8ef065d@linux.intel.com>
References: <20190312060005.12189-1-baolu.lu@linux.intel.com>
 <20190312060005.12189-5-baolu.lu@linux.intel.com>
 <20190312163845.GA13141@infradead.org>
 <e653341d-e001-7262-740b-2262842be06d@linux.intel.com>
 <c9fe7879-569e-b4f4-d6ec-47ab7e6fd443@linux.intel.com>
 <20190313161029.GA23513@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190313161029.GA23513@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On 3/14/19 12:10 AM, Christoph Hellwig wrote:
> On Wed, Mar 13, 2019 at 10:31:52AM +0800, Lu Baolu wrote:
>> Hi again,
>>
>> On 3/13/19 10:04 AM, Lu Baolu wrote:
>>> Hi,
>>>
>>> On 3/13/19 12:38 AM, Christoph Hellwig wrote:
>>>> On Tue, Mar 12, 2019 at 02:00:00PM +0800, Lu Baolu wrote:
>>>>> This adds the APIs for bounce buffer specified domain
>>>>> map() and unmap(). The start and end partial pages will
>>>>> be mapped with bounce buffered pages instead. This will
>>>>> enhance the security of DMA buffer by isolating the DMA
>>>>> attacks from malicious devices.
>>>>
>>>> Please reuse the swiotlb code instead of reinventing it.
>>>>
>>
>> Just looked into the code again. At least we could reuse below
>> functions:
>>
>> swiotlb_tbl_map_single()
>> swiotlb_tbl_unmap_single()
>> swiotlb_tbl_sync_single()
>>
>> Anything else?
> 
> Yes, that is probably about the level you want to reuse, given that the
> next higher layer already has hooks into the direct mapping code.
> 

I am trying to change my code to reuse swiotlb. But I found that swiotlb
might not be suitable for my case.

Below is what I got with swiotlb_map():

phy_addr        size    tlb_addr
--------------------------------
0x167eec330     0x8     0x85dc6000
0x167eef5c0     0x40    0x85dc6800
0x167eec330     0x8     0x85dc7000
0x167eef5c0     0x40    0x85dc7800

But what I expected to get is:

phy_addr        size    tlb_addr
--------------------------------
0x167eec330     0x8     0xAAAAA330
0x167eef5c0     0x40    0xBBBBB5c0
0x167eec330     0x8     0xCCCCC330
0x167eef5c0     0x40    0xDDDDD5c0

, where 0xXXXXXX000 is the physical address of a bounced page.

Basically, I want a bounce page to replace a leaf page in the vt-d page
table, which maps a buffer with size less than a PAGE_SIZE.

Best regards,
Lu Baolu
