From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v5 01/23] iommu: introduce bind_pasid_table API function
Date: Fri, 24 Aug 2018 15:20:08 +0200
Message-ID: <4adc15a2-111b-e4e3-525e-0091fcb1ec5c@redhat.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <e9ddb745-9cfb-1d40-05e0-7bd75292a41f@redhat.com>
 <A2975661238FB949B60364EF0F2C257439CCE9CC@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439CCE9CC@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Liu, Yi L" <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "Liu@mail.linuxfoundation.org" <Liu@mail.linuxfoundation.org>, Yi L <yi.l.liu@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Yi Liu,

On 08/24/2018 02:47 PM, Liu, Yi L wrote:
> Hi Eric,
> 
>> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
>> bounces@lists.linux-foundation.org] On Behalf Of Auger Eric
>> Sent: Friday, August 24, 2018 12:35 AM
>>
>> Hi Jacob,
>>
>> On 05/11/2018 10:53 PM, Jacob Pan wrote:
>>> Virtual IOMMU was proposed to support Shared Virtual Memory (SVM)
>>> use in the guest:
>>> https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05311.html
>>>
>>> As part of the proposed architecture, when an SVM capable PCI
>>> device is assigned to a guest, nested mode is turned on. Guest owns the
>>> first level page tables (request with PASID) which performs GVA->GPA
>>> translation. Second level page tables are owned by the host for GPA->HPA
>>> translation for both request with and without PASID.
>>>
>>> A new IOMMU driver interface is therefore needed to perform tasks as
>>> follows:
>>> * Enable nested translation and appropriate translation type
>>> * Assign guest PASID table pointer (in GPA) and size to host IOMMU
>>>
>>> This patch introduces new API functions to perform bind/unbind guest PASID
>>> tables. Based on common data, model specific IOMMU drivers can be extended
>>> to perform the specific steps for binding pasid table of assigned devices.
>>>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>>> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
>>> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> ---
> 
> [...]
> 
>>> +#ifndef _UAPI_IOMMU_H
>>> +#define _UAPI_IOMMU_H
>>> +
>>> +#include <linux/types.h>
>>> +
>>> +/**
>>> + * PASID table data used to bind guest PASID table to the host IOMMU. This will
>>> + * enable guest managed first level page tables.
>>> + * @version: for future extensions and identification of the data format
>>> + * @bytes: size of this structure
>>> + * @base_ptr:	PASID table pointer
>>> + * @pasid_bits:	number of bits supported in the guest PASID table, must be
>> less
>>> + *		or equal than the host supported PASID size.
>>> + */
>>> +struct pasid_table_config {
>>> +	__u32 version;
>>> +#define PASID_TABLE_CFG_VERSION_1 1
>>> +	__u32 bytes;
>>> +	__u64 base_ptr;
>>> +	__u8 pasid_bits;
>>
>> As reported in "[RFC 00/13] SMMUv3 Nested Stage Setup" thread, this API
>> could be used for ARM SMMUv3 nested stage enablement without many
>> changes. Assuming SMMUv3 nested stage is confirmed to be interesting for
>> vendors and maintainers, we could try to unify the APIs.
> 
> Just a quick question on nested stage on SMMUv3. If virtualizer wants to
> enable nested stage on SMMUv3, does it link the whole guest CD table to
> host or do it in other manner?
Yes that's correct. On ARM SMMUv3 you have Stream Table Entries (STEs,
indexed by ReqID=streamid). If stage 1 is used, the STE points to 1 or
more contiguous Context Descriptors (CDs).
So STE looks like the VTD Context-Entry and CD table looks like the VTD
PASID table as far as I understand.
> 
>> As far as I understand the VTD PASID table is equivalent to the ARM
>> SMMUv3 context descriptor table (CD). This corresponds to the stage 1
>> context table with one or more entries, each corresponding to one PASID.
> 
> PASID table is index by PASID, and have multiple entries. A PASID table
> would have 2^PASID_BITS entries.
On ARM SMMUv3 the  number of CDs is 2 ^STE.S1CDMax.
> 
>> maybe using the s1ctx_table_config terminology instead of
>> pasid_table_config would be more generic, the pasid table being Intel
>> naming.
>>
>> on top of pasid_bits, I think an "asid_bits" field may be needed too.
>> The guest IOMMU might support a different number of asid bits from the
>> host one.
> 
> Maybe needed for SMMUv3. I've noticed you've placed it in
> struct iommu_smmu_s1_config.
> 
>>
>> Although without having skimmed through the whole series yet, I wonder
>> how you handle the case where stage1 is bypassed or disabled? The guest
>> may define the S1 context entries but bypass or abort stage 1
>> translations globally. Looks something missing to me at first sight.
> 
> Sorry, I didn't quite follow here. What usage is case such for? like stage 1 is
> bypassed or disabled. IOVA or SVA?
Each STE entry has a config field which tells how S1 and S2 behave

Options are no traffic at all or any combination of the following:

S1        S2
bypass    bypass
transl    bypass
bypass    transl
transl    transl

host manages S2 info. guest sets S1 related fields.

To me the guest SET.Config should be passed to the host so that this
latter writes the correct global Config field value in the STE,
including S1 + S2 info.

Thanks

Eric
> 
> Thanks,
> Yi Liu
> 
