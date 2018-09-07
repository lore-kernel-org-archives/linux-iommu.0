From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 02/12] iommu/vt-d: Manage scalalble mode PASID tables
Date: Fri, 7 Sep 2018 09:57:38 +0800
Message-ID: <7e5faa39-376e-2c77-3891-9aac9092524a@linux.intel.com>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
 <20180830013524.28743-3-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912F2A85@SHSMSX101.ccr.corp.intel.com>
 <44298d5c-5720-a382-07d1-a90a072ff24b@linux.intel.com>
 <20180906164317.786bbdda@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906164317.786bbdda@jacob-builder>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@intel.com>
Cc: baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, "Raj, Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 09/07/2018 07:43 AM, Jacob Pan wrote:
> On Thu, 6 Sep 2018 10:46:03 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>>>> @@ -224,7 +271,14 @@ struct pasid_entry
>>>> *intel_pasid_get_entry(struct device *dev, int pasid)
>>>>     */
>>>>    static inline void pasid_clear_entry(struct pasid_entry *pe)
>>>>    {
>>>> -	WRITE_ONCE(pe->val, 0);
>>>> +	WRITE_ONCE(pe->val[0], 0);
>>>> +	WRITE_ONCE(pe->val[1], 0);
>>>> +	WRITE_ONCE(pe->val[2], 0);
>>>> +	WRITE_ONCE(pe->val[3], 0);
>>>> +	WRITE_ONCE(pe->val[4], 0);
>>>> +	WRITE_ONCE(pe->val[5], 0);
>>>> +	WRITE_ONCE(pe->val[6], 0);
>>>> +	WRITE_ONCE(pe->val[7], 0);
>>>
>>> memset?
>>
>> The order is important here. Otherwise, the PRESENT bit of this pasid
>> entry might still set while other fields contains invalid values.
> 
> WRITE_ONCE/READ_ONCE will switch to __builtin_memcpy() in if the size
> exceeds word size, ie. 64bit in this case. I don;t think compiler will
> reorder built-in function. Beside, we only need to clear present and
> FDP bit, right?

Clear present and FDP bit is enough for hardare. But from software point
of view, it's better to clear all bits with 0.

Best regards,
Lu Baolu
