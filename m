From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 04/12] iommu/vt-d: Add 256-bit invalidation descriptor
 support
Date: Thu, 8 Nov 2018 14:14:21 +0800
Message-ID: <ad4f7e5b-9af1-7134-a573-6e78184de0ee@linux.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-5-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D5FAA2@SHSMSX104.ccr.corp.intel.com>
 <a6e43ddd-0889-4a4a-b908-993db28c6d87@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D604DF@SHSMSX104.ccr.corp.intel.com>
 <915876cd-6a1f-097b-b9be-9cb3df18a1df@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D60581@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439D60581@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 11/8/18 1:45 PM, Liu, Yi L wrote:
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: Thursday, November 8, 2018 1:25 PM
>> Subject: Re: [PATCH v4 04/12] iommu/vt-d: Add 256-bit invalidation descriptor
>> support
>>
>> Hi,
>>
>> On 11/8/18 11:49 AM, Liu, Yi L wrote:
>>> Hi,
>>>
>>>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>>>> Sent: Thursday, November 8, 2018 10:17 AM
>>>> Subject: Re: [PATCH v4 04/12] iommu/vt-d: Add 256-bit invalidation
>>>> descriptor support
>>>>
>>>> Hi Yi,
>>>>
>>>> On 11/7/18 2:07 PM, Liu, Yi L wrote:
>>>>> Hi Baolu,
>>>>>
>>>>>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>>>>>> Sent: Monday, November 5, 2018 1:32 PM
>>>>> [...]
>>>>>
>>>>>> ---
>>>>>>     drivers/iommu/dmar.c                | 83 +++++++++++++++++++----------
>>>>>>     drivers/iommu/intel-svm.c           | 76 ++++++++++++++++----------
>>>>>>     drivers/iommu/intel_irq_remapping.c |  6 ++-
>>>>>>     include/linux/intel-iommu.h         |  9 +++-
>>>>>>     4 files changed, 115 insertions(+), 59 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c index
>>>>>> d9c748b6f9e4..ec10427b98ac 100644
>>>>>> --- a/drivers/iommu/dmar.c
>>>>>> +++ b/drivers/iommu/dmar.c
>>>>>> @@ -1160,6 +1160,7 @@ static int qi_check_fault(struct intel_iommu
>>>>>> *iommu, int
>>>>>> index)
>>>>>>     	int head, tail;
>>>>>>     	struct q_inval *qi = iommu->qi;
>>>>>>     	int wait_index = (index + 1) % QI_LENGTH;
>>>>>> +	int shift = qi_shift(iommu);
>>>>>>
>>>>>>     	if (qi->desc_status[wait_index] == QI_ABORT)
>>>>>>     		return -EAGAIN;
>>>>>> @@ -1173,13 +1174,15 @@ static int qi_check_fault(struct
>>>>>> intel_iommu *iommu, int index)
>>>>>>     	 */
>>>>>>     	if (fault & DMA_FSTS_IQE) {
>>>>>>     		head = readl(iommu->reg + DMAR_IQH_REG);
>>>>>> -		if ((head >> DMAR_IQ_SHIFT) == index) {
>>>>>> +		if ((head >> shift) == index) {
>>>>>> +			struct qi_desc *desc = qi->desc + head;
>>>>>> +
>>>>>>     			pr_err("VT-d detected invalid descriptor: "
>>>>>>     				"low=%llx, high=%llx\n",
>>>>>> -				(unsigned long long)qi->desc[index].low,
>>>>>> -				(unsigned long long)qi->desc[index].high);
>>>>>> -			memcpy(&qi->desc[index], &qi->desc[wait_index],
>>>>>> -					sizeof(struct qi_desc));
>>>>>> +				(unsigned long long)desc->qw0,
>>>>>> +				(unsigned long long)desc->qw1);
>>>>> Still missing qw2 and qw3. May make the print differ based on if smts is configed.
>>>> qw2 and qw3 are reserved from software point of view. We don't need
>>>> to print it for information.
>>> But for Scalable mode, it should be valid?
>> No. It's reserved for software.
> No, I don’t think so. PRQ response would also be queued to hardware by QI. For such
> QI descriptors, the high bits are not reserved.
> 

Do you mean the private data fields of a page request descriptor or
a page group response descriptor? Those fields contains software defined
private data (might a kernel pointer?). We should avoid leaking such
information in the generic kernel message for security consideration.
Or anything I missed?

Best regards,
Lu Baolu
