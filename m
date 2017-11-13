From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 08/16] iommu: introduce device fault data
Date: Mon, 13 Nov 2017 13:19:50 +0000
Message-ID: <6ffb6485-669d-aecb-3088-9a5ef7563840@arm.com>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1507244624-39189-9-git-send-email-jacob.jun.pan@linux.intel.com>
 <439401c0-a9ff-a69a-dc10-12d72f7abbab@arm.com>
 <A2975661238FB949B60364EF0F2C257439AFC86D@SHSMSX104.ccr.corp.intel.com>
 <09d451dc-c0e9-1fa2-8f85-45a9b1185d48@arm.com>
 <A2975661238FB949B60364EF0F2C257439B06809@SHSMSX104.ccr.corp.intel.com>
 <e95ce88b-7e88-5b1c-3a68-9ac40773a8f6@arm.com>
 <20171109113629.6a9251a4@jacob-builder>
 <0ed3e52b-2ca7-e378-817b-34b517a392da@arm.com>
 <20171110160036.147d064e@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171110160036.147d064e@jacob-builder>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>
List-Id: iommu@lists.linux-foundation.org

On 11/11/17 00:00, Jacob Pan wrote:
> On Fri, 10 Nov 2017 13:54:59 +0000
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> /*
>>  * Note: I tried to synthesize what I believe would be useful to
>> device
>>  * drivers and guests, with regards to the kind of faults that the ARM
>>  * SMMU is capable of reporting. Other IOMMUs may report more or less
>>  * fault reasons, and I guess one should try to associate the faults
>>  * reason that matches best a generic one when reporting a fault.
>>  *
>>  * Finer reason granularity is probably not useful to anyone, and
>>  * coarser granularity would require more work from intermediate
>>  * components processing the fault to figure out what happened, whose
>>  * fault it actually is and where to route it (process vs. device
>> driver
>>  * vs. vIOMMU driver misprogamming tables).
>>  */
>> enum iommu_fault_reason {
>> 	IOMMU_FAULT_REASON_UNKNOWN = 0,
>>
> can we add one for iommu internal error, the specifics may not be
> useful for the device drivers, but it is good to know iommu is
> faulting, perhaps can take action that inform driver users.
> i.e.
> 	/* IOMMU internal error, no specific reason to report out */
> 	IOMMU_FAULT_REASON_INTERNAL,

Yes, and maybe it should replace IOMMU_FAULT_REASON_UNKNOWN, since the
device driver would probably handle it the same way. I guess the INTERNAL
fault is always fatal, meaning that the IOMMU is shutting down and there
is no hope to recover? I can't see a good reason to inform users of
non-fatal internal faults, the IOMMU driver will print those to dmesg and
keep going. For fatal faults we're telling users to stop issuing
transactions so the IOMMU driver doesn't get flooded by events, for example.

Thanks,
Jean
