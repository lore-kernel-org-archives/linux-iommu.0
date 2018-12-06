From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 02/12] iommu/vt-d: Manage scalalble mode PASID tables
Date: Thu, 6 Dec 2018 09:13:50 +0800
Message-ID: <bbaabe2a-8525-e73c-1b62-8cc8eaafe005@linux.intel.com>
References: <20181128035449.10226-1-baolu.lu@linux.intel.com>
 <20181128035449.10226-3-baolu.lu@linux.intel.com>
 <20181203134411.lejlkbnagxml54ro@8bytes.org>
 <A2975661238FB949B60364EF0F2C257439D838B9@SHSMSX104.ccr.corp.intel.com>
 <5c81008b-30e8-177d-0182-db366608562f@linux.intel.com>
 <20181205155012.GC16835@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205155012.GC16835@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>, David Woodhouse <dwmw2@infradead.org>, "Raj, Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 12/5/18 11:50 PM, Joerg Roedel wrote:
> On Tue, Dec 04, 2018 at 01:58:06PM +0800, Lu Baolu wrote:
>> This function is called in an unsleepable context.
>>
>> spin_lock(&lock)
>> [...]
>> if (pasid_table_is_necessary)
>> 	allocate_pasid_table(dev)
>> [...]
>> spin_unlock(&lock)
>>
>> We can move it out of the lock range.
>>
>> How about
>>
>> if (pasid_table_is_necessary)
>> 	pasid_table = allocate_pasid_table(dev)
>>
>> spin_lock(&lock)
>> [...]
>> if (pasid_table_is_necessary)
>> 	set_up_pasid_table(pasid_table)
>> [...]
>> spin_unlock(&lock)
> 
> Hmm, so when the IOMMU is configured in scalable mode we can just
> allocate a pasid-table for the device when we set it up, right?
> 
> Scalable mode is a boot-time decision, so we know for sure whether we
> need a pasid-table on device-setup time. And the device-setup code it
> preemptable, so I think it this allocation should be outside of any
> spin-locked section.

Fair enough. I will fix this up in the next version.

Thank you for pointing this out.

Best regards,
Lu Baolu
