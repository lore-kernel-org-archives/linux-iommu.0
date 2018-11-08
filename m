From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 04/12] iommu/vt-d: Add 256-bit invalidation descriptor
 support
Date: Thu, 8 Nov 2018 14:15:26 +0800
Message-ID: <bcc65c15-b76b-7af1-ca9f-e8818374a329@linux.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-5-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D5FAA2@SHSMSX104.ccr.corp.intel.com>
 <a6e43ddd-0889-4a4a-b908-993db28c6d87@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D604DF@SHSMSX104.ccr.corp.intel.com>
 <915876cd-6a1f-097b-b9be-9cb3df18a1df@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D60599@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439D60599@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org



On 11/8/18 1:48 PM, Liu, Yi L wrote:
>> From: Liu, Yi L
>> Sent: Thursday, November 8, 2018 1:45 PM
>>>>>>> +			memcpy(desc, qi->desc + (wait_index << shift),
>>>>>>
>>>>>> Would "memcpy(desc, (unsigned long long) (qi->desc +  (wait_index
>>>>>> << shift)," be more safe?
>>>>>
>>>>> Can that be compiled? memcpy() requires a "const void *" for the
>>>>> second
>>> parameter.
>>>>> By the way, why it's safer with this casting?
>>>>
>>>> This is just an example. My point is the possibility that "qi->desc
>>>> + (wait_index <<
>>> shift)"
>>>> would be treated as "qi->desc plus (wait_index <<
>>>> shift)*sizeof(*qi->desc)". Is it possible for kernel build?
>>>
>>> qi->desc is of type of "void *".
>>
>> no, I don’t think so... Refer to the code below. Even it has no correctness issue her,
>> It's not due to qi->desc is "void *" type...
>>
>> struct qi_desc {
>> -	u64 low, high;
>> +	u64 qw0;
>> +	u64 qw1;
>> +	u64 qw2;
>> +	u64 qw3;
>> };
> 
> Oops, just see you modified it to be "void *" in this patch. Ok, then this is fair enough.

Yes. :-)

Best regards,
Lu Baolu
