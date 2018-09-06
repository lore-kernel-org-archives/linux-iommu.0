From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 03/12] iommu/vt-d: Move page table helpers into header
Date: Thu, 6 Sep 2018 10:52:00 +0800
Message-ID: <08966280-44db-a9a8-bc54-93f698c87823@linux.intel.com>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
 <20180830013524.28743-4-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912F2A9F@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1912F2A9F@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 09/06/2018 10:15 AM, Tian, Kevin wrote:
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: Thursday, August 30, 2018 9:35 AM
>>
>> So that they could also be used in other source files.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Thank you, Kevin.

Best regards,
Lu Baolu

> 
>> ---
>>   drivers/iommu/intel-iommu.c | 43 -------------------------------------
>>   include/linux/intel-iommu.h | 43
>> +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 43 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index b0da4f765274..93cde957adc7 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -315,49 +315,6 @@ static inline void context_clear_entry(struct
>> context_entry *context)
>>   	context->hi = 0;
>>   }
>>
>> -/*
>> - * 0: readable
>> - * 1: writable
>> - * 2-6: reserved
>> - * 7: super page
>> - * 8-10: available
>> - * 11: snoop behavior
>> - * 12-63: Host physcial address
>> - */
>> -struct dma_pte {
>> -	u64 val;
>> -};
>> -
>> -static inline void dma_clear_pte(struct dma_pte *pte)
>> -{
>> -	pte->val = 0;
>> -}
>> -
>> -static inline u64 dma_pte_addr(struct dma_pte *pte)
>> -{
>> -#ifdef CONFIG_64BIT
>> -	return pte->val & VTD_PAGE_MASK;
>> -#else
>> -	/* Must have a full atomic 64-bit read */
>> -	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
>> -#endif
>> -}
>> -
>> -static inline bool dma_pte_present(struct dma_pte *pte)
>> -{
>> -	return (pte->val & 3) != 0;
>> -}
>> -
>> -static inline bool dma_pte_superpage(struct dma_pte *pte)
>> -{
>> -	return (pte->val & DMA_PTE_LARGE_PAGE);
>> -}
>> -
>> -static inline int first_pte_in_page(struct dma_pte *pte)
>> -{
>> -	return !((unsigned long)pte & ~VTD_PAGE_MASK);
>> -}
>> -
>>   /*
>>    * This domain is a statically identity mapping domain.
>>    *	1. This domain creats a static 1:1 mapping to all usable memory.
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index 2173ae35f1dc..41791903a5e3 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -501,6 +501,49 @@ static inline void __iommu_flush_cache(
>>   		clflush_cache_range(addr, size);
>>   }
>>
>> +/*
>> + * 0: readable
>> + * 1: writable
>> + * 2-6: reserved
>> + * 7: super page
>> + * 8-10: available
>> + * 11: snoop behavior
>> + * 12-63: Host physcial address
>> + */
>> +struct dma_pte {
>> +	u64 val;
>> +};
>> +
>> +static inline void dma_clear_pte(struct dma_pte *pte)
>> +{
>> +	pte->val = 0;
>> +}
>> +
>> +static inline u64 dma_pte_addr(struct dma_pte *pte)
>> +{
>> +#ifdef CONFIG_64BIT
>> +	return pte->val & VTD_PAGE_MASK;
>> +#else
>> +	/* Must have a full atomic 64-bit read */
>> +	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
>> +#endif
>> +}
>> +
>> +static inline bool dma_pte_present(struct dma_pte *pte)
>> +{
>> +	return (pte->val & 3) != 0;
>> +}
>> +
>> +static inline bool dma_pte_superpage(struct dma_pte *pte)
>> +{
>> +	return (pte->val & DMA_PTE_LARGE_PAGE);
>> +}
>> +
>> +static inline int first_pte_in_page(struct dma_pte *pte)
>> +{
>> +	return !((unsigned long)pte & ~VTD_PAGE_MASK);
>> +}
>> +
>>   extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct
>> pci_dev *dev);
>>   extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
>>
>> --
>> 2.17.1
> 
> 
