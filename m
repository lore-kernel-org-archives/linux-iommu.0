From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 04/12] iommu/vt-d: Add 256-bit invalidation descriptor
 support
Date: Thu, 6 Dec 2018 09:19:56 +0800
Message-ID: <a5b1e040-fbd8-1727-3707-0ac7337d6472@linux.intel.com>
References: <20181128035449.10226-1-baolu.lu@linux.intel.com>
 <20181128035449.10226-5-baolu.lu@linux.intel.com>
 <20181203134856.lui4us4ejm4d5avz@8bytes.org>
 <A2975661238FB949B60364EF0F2C257439D838AB@SHSMSX104.ccr.corp.intel.com>
 <3b0eadd2-b99f-98d6-594f-0419f0542789@linux.intel.com>
 <20181205155646.GD16835@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205155646.GD16835@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>, David Woodhouse <dwmw2@infradead.org>, "Raj, Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 12/5/18 11:56 PM, Joerg Roedel wrote:
> On Tue, Dec 04, 2018 at 02:13:31PM +0800, Lu Baolu wrote:
>> The existing code uses GFP_ATOMIC, this patch only changes the size of
>> the allocated desc_page.
>>
>> I don't think we really need GFP_ATOMIC here (and also for some other
>> places). I will clean up them in a separated patch.
> 
> Okay, thanks.
> 
>>> In this patch, there is some code like the code below. It calculates
>>> destination address of memcpy with qi->desc. If it's still struct qi_desc
>>> pointer, the calculation result would be wrong.
>>>
>>> +			memcpy(desc, qi->desc + (wait_index << shift),
>>> +			       1 << shift);
>>>
>>> The change of the calculation method is to support 128 bits invalidation
>>> descriptors and 256 invalidation descriptors in this unified code logic.
>>>
>>> Also, the conversation between Baolu and me may help.
>>>
>>> https://lore.kernel.org/patchwork/patch/1006756/
>>
>> Yes. We need to support different descriptor size.
> 
> Okay, pointer arithmetic on void* isn't well defined in the C standard,
> afaik. But it should work with GCC, so it's probably fine.
> 
> Unrelated to this patch-set, the whole qi management code needs some
> cleanups, it queues a sync after every command and has very tricky
> locking. This patch-set further complicates matters there, so it is
> probably time for a clean re-write of that part?

Sure. I will start the cleanups(including the unnecessary ATOMIC page
allocation) and submit them in a separated patch set after well tested.

Best regards,
Lu Baolu
