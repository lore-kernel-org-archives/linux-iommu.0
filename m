Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DFA1E4A9
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947794; cv=none; b=LsbfRYBBGjOlgC1FVCXDsHllnDP3Dhq7muGXpjBwZ21/SQpxdhwrdzK+r2KunXm95S68i04EtkEeeCu44LnIE3P5OmycDQM1kVNfGaIIagiiGFBkmAISwzcAAz4vyCkhpcWjcg/ht1uP11SlCgC0CqBKMtvLYpiaqsH/ahOxocQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947794; c=relaxed/simple;
	bh=BjSntb7qfbMHPytS5kv/By5svjY/eI6sLCe7dXY5A1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqjztQENWUlDuI6ZPoCrMWEYfxAOGgXrhTGIivZ3OFw9k9uz6NxoMxJNh6nhgOQBqY6sWKS/vfpqeB2DSCJDpwvlPI49nLViTbwZwgN225r1S9XbqV35NWj/KoxMXakriKLCwe1lo/mkC6gzaODOmprp7/nePpjTNvNjkzVXYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C086D339;
	Wed, 24 Apr 2024 01:36:59 -0700 (PDT)
Received: from [10.57.74.127] (unknown [10.57.74.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B5863F64C;
	Wed, 24 Apr 2024 01:36:29 -0700 (PDT)
Message-ID: <8ba77f22-e214-4a50-ab1a-5cf49a5244a6@arm.com>
Date: Wed, 24 Apr 2024 09:36:28 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
Content-Language: en-GB
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "mshavit@google.com" <mshavit@google.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "will@kernel.org" <will@kernel.org>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 jiangkunkun <jiangkunkun@huawei.com>, zhukeqian <zhukeqian1@huawei.com>,
 Linuxarm <linuxarm@huawei.com>
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-3-shameerali.kolothum.thodi@huawei.com>
 <dd475ac8-ad0f-4aae-8032-1218cafc7590@arm.com>
 <6449dc6823944d58b8713683fcc88a0e@huawei.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <6449dc6823944d58b8713683fcc88a0e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/04/2024 09:01, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Ryan Roberts <ryan.roberts@arm.com>
>> Sent: Tuesday, April 23, 2024 4:56 PM
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> iommu@lists.linux.dev; linux-arm-kernel@lists.infradead.org
>> Cc: joro@8bytes.org; jgg@nvidia.com; kevin.tian@intel.com;
>> nicolinc@nvidia.com; mshavit@google.com; robin.murphy@arm.com;
>> will@kernel.org; joao.m.martins@oracle.com; jiangkunkun
>> <jiangkunkun@huawei.com>; zhukeqian <zhukeqian1@huawei.com>;
>> Linuxarm <linuxarm@huawei.com>
>> Subject: Re: [PATCH v2 2/4] iommu/io-pgtable-arm: Add
>> read_and_clear_dirty() support
>>
>> On 22/02/2024 09:49, Shameer Kolothum wrote:
>>> .read_and_clear_dirty() IOMMU domain op takes care of reading the
>>> dirty bits (i.e. PTE has both DBM and AP[2] set) and marshalling into
>>> a bitmap of
>>
>> Err... a PTE is HW-dirty if DBM is set and AP[2] is *clear*, right? (AP[2] is
>> "RDONLY" bit, and is initially set, then the HW clears it on first write. See
>> pte_hw_dirty() in linux/arch/arm64/include/asm/pgtable.h).
> 
> Oops..yes, the comment here is indeed wrong.
> 
> I will update and add something like below to make it clear: 
> 
>                                     DBM bit             AP[2]("RDONLY" bit)
> 1. writeable_clean         1                       1
> 2. writeable_dirty          1                       0
> 3. read-only                     0                      1

Yes, sounds good!

> 
>>
>>> a given page size.
>>>
>>> While reading the dirty bits we also clear the PTE AP[2] bit to mark
>>> it as writable-clean depending on read_and_clear_dirty() flags.
>>
>> You would need to *set* AP[2] to mark it clean.
>>
>>>
>>> Structure it in a way that the IOPTE walker is generic, and so we pass
>>> a function pointer over what to do on a per-PTE basis.
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>  drivers/iommu/io-pgtable-arm.c | 128
>>> ++++++++++++++++++++++++++++++++-
>>>  1 file changed, 127 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/io-pgtable-arm.c
>>> b/drivers/iommu/io-pgtable-arm.c index f7828a7aad41..1ce7b7a3c1e8
>>> 100644
>>> --- a/drivers/iommu/io-pgtable-arm.c
>>> +++ b/drivers/iommu/io-pgtable-arm.c
>>> @@ -75,6 +75,7 @@
>>>
>>>  #define ARM_LPAE_PTE_NSTABLE		(((arm_lpae_iopte)1) << 63)
>>>  #define ARM_LPAE_PTE_XN			(((arm_lpae_iopte)3) << 53)
>>> +#define ARM_LPAE_PTE_DBM		(((arm_lpae_iopte)1) << 51)
>>>  #define ARM_LPAE_PTE_AF			(((arm_lpae_iopte)1) << 10)
>>>  #define ARM_LPAE_PTE_SH_NS		(((arm_lpae_iopte)0) << 8)
>>>  #define ARM_LPAE_PTE_SH_OS		(((arm_lpae_iopte)2) << 8)
>>> @@ -84,7 +85,7 @@
>>>
>>>  #define ARM_LPAE_PTE_ATTR_LO_MASK	(((arm_lpae_iopte)0x3ff) <<
>> 2)
>>>  /* Ignore the contiguous bit for block splitting */
>>> -#define ARM_LPAE_PTE_ATTR_HI_MASK	(((arm_lpae_iopte)6) << 52)
>>> +#define ARM_LPAE_PTE_ATTR_HI_MASK	(((arm_lpae_iopte)0xd) <<
>> 51)
>>
>> Perhaps this is easier to understand:
>>
>> #define ARM_LPAE_PTE_ATTR_HI_MASK	(ARM_LPAE_PTE_XN |
>> ARM_LPAE_PTE_DBM)
> 
> Ok.
> 
>>
>>>  #define ARM_LPAE_PTE_ATTR_MASK
>> 	(ARM_LPAE_PTE_ATTR_LO_MASK |	\
>>>  					 ARM_LPAE_PTE_ATTR_HI_MASK)
>>>  /* Software bit for solving coherency races */ @@ -93,6 +94,9 @@
>>>  /* Stage-1 PTE */
>>>  #define ARM_LPAE_PTE_AP_UNPRIV		(((arm_lpae_iopte)1) << 6)
>>>  #define ARM_LPAE_PTE_AP_RDONLY		(((arm_lpae_iopte)2)
>> << 6)
>>> +#define ARM_LPAE_PTE_AP_RDONLY_BIT	7
>>
>> Perhaps:
>>
>> #define ARM_LPAE_PTE_AP_RDONLY_BIT	7
>> #define ARM_LPAE_PTE_AP_RDONLY		(((arm_lpae_iopte)1) <<
>> ARM_LPAE_PTE_AP_RDONLY_BIT)
> 
> Ok.
> 
>>
>>> +#define ARM_LPAE_PTE_AP_WRITABLE	(ARM_LPAE_PTE_AP_RDONLY
>> | \
>>> +					 ARM_LPAE_PTE_DBM)
>>
>> Perhaps: ARM_LPAE_PTE_AP_WRITABLE_CLEAN ?
> 
> Sure. That’s more clear.
> 
>  > 
>>>  #define ARM_LPAE_PTE_ATTRINDX_SHIFT	2
>>>  #define ARM_LPAE_PTE_nG			(((arm_lpae_iopte)1) << 11)
>>>
>>> @@ -729,6 +733,127 @@ static phys_addr_t
>> arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
>>>  	return iopte_to_paddr(pte, data) | iova;  }
>>>
>>> +struct arm_lpae_iopte_read_dirty {
>>> +	unsigned long flags;
>>> +	struct iommu_dirty_bitmap *dirty;
>>> +};
>>> +
>>> +typedef int (*io_pgtable_visit_fn_t)(unsigned long iova, size_t size,
>>> +				     arm_lpae_iopte *ptep, void *opaque);
>> struct
>>> +io_pgtable_walk_data {
>>> +	const io_pgtable_visit_fn_t	fn;
>>> +	void				*opaque;> +	u64
>> 		addr;
>>> +	const u64			end;
>>> +};
>>> +
>>> +static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
>>> +				 struct io_pgtable_walk_data *walk_data,
>>> +				 arm_lpae_iopte *ptep,
>>> +				 int lvl);
>>> +
>>> +static int __arm_lpae_read_and_clear_dirty(unsigned long iova, size_t
>> size,
>>> +					   arm_lpae_iopte *ptep, void
>> *opaque) {
>>> +	struct arm_lpae_iopte_read_dirty *arg = opaque;
>>> +	struct iommu_dirty_bitmap *dirty = arg->dirty;
>>> +	arm_lpae_iopte pte;
>>> +
>>> +	pte = READ_ONCE(*ptep);
>>> +	if (WARN_ON(!pte))
>>> +		return -EINVAL;
>>
>> You've already read and checked its not zero in io_pgtable_visit(). Either the
>> walker is considered generic and probably shouldn't care if the pte is 0, (so
>> just do check here). Or the walker is specific for this use case, in which case
>> there is no need for the function pointer callback inefficiencies (and you've
>> already READ_ONCE() the ptep so no need to repeat. (Multiple ptep_get()s
>> does make a meaningful performance impact in the core-mm).
> 
> Yes, that check is a duplication. Will remove that. I do have plans to support block
> page split/merge functionality during migration start. And with that in mind tried
> to make it generic with callback ptr. May be it is not worth at this time and I will
> revisit it when we add split/merge functionality.

Ahh ok. My preference would be to keep it simple while this is the only user,
then generalize it when you add a second user. But if you plan to add the second
user imminently, then feel free to leave it general.

> 
>  > > +
>>> +	if ((pte & ARM_LPAE_PTE_AP_WRITABLE) ==
>> ARM_LPAE_PTE_AP_WRITABLE)
>>> +		return 0;
>>
>> What about RO ptes? This check only checks that it is writable-clean. So you
>> have 2 remaining options; writable-dirty and read-only. Suggest:
> 
> Ok. Got it.
> 
>>
>> if (pte_hw_dirty(pte)) {
>> 	iommu_dirty_bitmap_record(dirty, iova, size);
>> 	if (!(arg->flags & IOMMU_DIRTY_NO_CLEAR))
>> 		set_bit(ARM_LPAE_PTE_AP_RDONLY_BIT, (unsigned long
>> *)ptep); }
>>
>>> +
>>> +	iommu_dirty_bitmap_record(dirty, iova, size);
>>> +	if (!(arg->flags & IOMMU_DIRTY_NO_CLEAR))
>>> +		set_bit(ARM_LPAE_PTE_AP_RDONLY_BIT, (unsigned long
>> *)ptep);
>>> +	return 0;
>>> +}
>>> +
>>> +static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
>>> +			    struct io_pgtable_walk_data *walk_data,
>>> +			    arm_lpae_iopte *ptep, int lvl) {
>>> +	struct io_pgtable *iop = &data->iop;
>>> +	arm_lpae_iopte pte = READ_ONCE(*ptep);
>>> +
>>> +	if (WARN_ON(!pte))
>>> +		return -EINVAL;
>>> +
>>> +	if (iopte_leaf(pte, lvl, iop->fmt)) {
>>> +		size_t size = ARM_LPAE_BLOCK_SIZE(lvl, data);
>>> +
>>> +		walk_data->fn(walk_data->addr, size, ptep, walk_data-
>>> opaque);
>>> +		walk_data->addr += size;
>>> +		return 0;
>>> +	}
>>> +
>>> +	ptep = iopte_deref(pte, data);
>>> +	return __arm_lpae_iopte_walk(data, walk_data, ptep, lvl + 1); }
>>> +
>>> +static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
>>> +				 struct io_pgtable_walk_data *walk_data,
>>> +				 arm_lpae_iopte *ptep,
>>> +				 int lvl)
>>> +{
>>> +	u32 idx;
>>> +	int max_entries, ret;
>>> +
>>> +	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
>>> +		return -EINVAL;
>>> +
>>> +	if (lvl == data->start_level)
>>> +		max_entries = ARM_LPAE_PGD_SIZE(data) /
>> sizeof(arm_lpae_iopte);
>>> +	else
>>> +		max_entries = ARM_LPAE_PTES_PER_TABLE(data);
>>> +
>>> +	for (idx = ARM_LPAE_LVL_IDX(walk_data->addr, lvl, data);
>>> +	     (idx < max_entries) && (walk_data->addr < walk_data->end);
>> ++idx) {
>>> +		arm_lpae_iopte *pteref = &ptep[idx];
>>
>> nit: Personally I would get rid of this and just pass `ptep + idx` to
>> io_pgtable_visit()
> 
> Ack.
> 
>>> +
>>> +		ret = io_pgtable_visit(data, walk_data, pteref, lvl);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
>>> +					 unsigned long iova, size_t size,
>>> +					 unsigned long flags,
>>> +					 struct iommu_dirty_bitmap *dirty) {
>>> +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
>>> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>>> +	struct arm_lpae_iopte_read_dirty arg = {
>>> +		.flags = flags, .dirty = dirty,
>>> +	};
>>> +	struct io_pgtable_walk_data walk_data = {
>>> +		.fn = __arm_lpae_read_and_clear_dirty,
>>> +		.opaque = &arg,
>>
>> Do you have plans to reuse the walker? If not, then I wonder if separating
>> the argument and callback function are valuable? It will certainly be more
>> efficient without the per-pte indirect call.
> 
> Ok. I will remove indirection for now and may revisit it when we add split/merge
> functionality.
> 
>>
>>> +		.addr = iova,
>>> +		.end = iova + size - 1,
>>
>> Bug?: You are initializing end to be inclusive (i.e. last valid address in range).
>> But __arm_lpae_iopte_walk() is using it as exclusive (i.e. first address after
>> range) - see "walk_data->addr < walk_data->end".
>>
>> mm code usually treats end as exclusive, so suggest removing the "- 1".
> 
> I will double check this.

Yes please do. It certainly looks like a bug, but I may be wrong!

> 
>>
>>> +	};
>>> +	arm_lpae_iopte *ptep = data->pgd;
>>> +	int lvl = data->start_level;
>>> +	long iaext = (s64)iova >> cfg->ias;
>>
>> Why cast this to signed? And why is the cast s64 and the result long? Suggest
>> they should both be consistent at least. But probably clearer to just do:
>>
>> WARN_ON((iova + size - 1) & (BIT(cfg->ias) - 1))
>>
>> in the below if()? That way you are checking the full range too.
> 
> Ok.
> 
> Thanks,
> Shameer
>  

