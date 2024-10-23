Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FE7154BFB
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669075; cv=none; b=dQ/oLc/dnnw5tFcfXU9oKMAXC+3A+C/qdWwrJNI+dn9r0yoioaZqWe83Qk9f6Y3FR6WYX619Lx/ZJXhbzvF7iSKz2u7cncGoc8YTNZ3N+rCccFCyxi/XT4J1CjrDBxN839OmRjL3ze2sEX6ZGHBwFfoy94+BNx8i8v8Bmt5lDyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669075; c=relaxed/simple;
	bh=WkechSRigs3kThh4ayvpZax/ykNfZGExgsnVGHO0i1Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qCGfCUwtB2oYfeqhfWNuEAoutD++WwPNHBiynjeqgu9jYD44+iJFGQ31ShVzfkcqJQJvu2dzmpHKyxdXYXbnGgfNJeLoHjbF+tU0kC3phYKMpzA+JK9hMocJilbHiTC7OF/6f5ni6f96lgUOZY1JE8xD/xuEgtkp9W/0gJKg8Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWnKSrQK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWnKSrQK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729669074; x=1761205074;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WkechSRigs3kThh4ayvpZax/ykNfZGExgsnVGHO0i1Y=;
  b=FWnKSrQKMd/N3cw8URtsHZBolnzD+IBeK31eExU6P2OIsA1/YDN7Pdl4
   7xzEiZyOV7P4wEuRVzNSpb2kngoxNc3z0QNkKzEyQwNYoZwTKLVDQd7en
   HkH0jRqSk0eReXYDOVho/GIfgAgJpfNdZVNgvIlPiNjwI2+ZpUsAaluAI
   gAXq+JEZ0/n3JgBd9SxdLY36mTQvR1SO5i1EZLDRgkd/kSn8H0LS4nXJl
   GFdprpZyzJfrw+Scxf2LoqNej6uIPs8Usr57wdWhsv8UDhb96XeiEBGSl
   TTATsr9UNSYIkDTjvl2REgU6T/2tTtJthqei7NDYWo15de5sS7UgMMPti
   A==;
X-CSE-ConnectionGUID: RVOezsP3R2utcDMFQi6Ffw==
X-CSE-MsgGUID: BxM+HLgPQG6yYI7Y9RV41A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39785747"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39785747"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 00:37:54 -0700
X-CSE-ConnectionGUID: Puz/BTOZQReTPHHyZjhgLA==
X-CSE-MsgGUID: b8qv1tNlQwiDOlvnjaLNWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="79785507"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 00:37:51 -0700
Message-ID: <39228f3c-6137-4a00-941d-8c445ffb1a19@linux.intel.com>
Date: Wed, 23 Oct 2024 15:37:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix checks in dmar_fault_dump_ptes()
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241022095017.479081-1-zhenzhong.duan@intel.com>
 <20241022095017.479081-2-zhenzhong.duan@intel.com>
 <b524d09e-62ea-41ca-904c-e9c94aef2b76@linux.intel.com>
 <SJ0PR11MB6744E47FF944D4C576B6B973924D2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <SJ0PR11MB6744E47FF944D4C576B6B973924D2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/23 13:09, Duan, Zhenzhong wrote:
>>> ---
>>>    drivers/iommu/intel/iommu.c | 31 ++++++++++++++++++++-----------
>>>    1 file changed, 20 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index a564eeaf2375..8288b0ee7a61 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -733,12 +733,17 @@ void dmar_fault_dump_ptes(struct intel_iommu
>> *iommu, u16 source_id,
>>>    	u8 devfn = source_id & 0xff;
>>>    	u8 bus = source_id >> 8;
>>>    	struct dma_pte *pgtable;
>>> +	u64 entry;
>>>
>>>    	pr_info("Dump %s table entries for IOVA 0x%llx\n", iommu->name, addr);
>>>
>>>    	/* root entry dump */
>>>    	rt_entry = &iommu->root_entry[bus];
>>> -	if (!rt_entry) {
>>> +	entry = rt_entry->lo;
>>> +	if (sm_supported(iommu) && devfn >= 0x80)
>>> +		entry = rt_entry->hi;
>>> +
>>> +	if (!(entry & 1)) {
>>>    		pr_info("root table entry is not present\n");
>>>    		return;
>>>    	}
>>> @@ -766,28 +771,32 @@ void dmar_fault_dump_ptes(struct intel_iommu
>> *iommu, u16 source_id,
>>>    		goto pgtable_walk;
>>>    	}
>>>
>>> +	/* For request-without-pasid, get the pasid from context entry */
>>> +	if (pasid == IOMMU_PASID_INVALID)
>>> +		pasid = IOMMU_NO_PASID;
>>> +
>>>    	/* get the pointer to pasid directory entry */
>>>    	dir = phys_to_virt(ctx_entry->lo & VTD_PAGE_MASK);
>> Is above code correct in the scalable mode?
> I didn't find issue, could you show some light?

It's fine. I just mixed it with the root entry.

Thanks,
baolu
