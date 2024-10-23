Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A1885947
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729653184; cv=none; b=c34m1UkB2jLL8wRTkoSAIK8FsbpFKbO8TcHqW5ylsuTFvSg2zcVSyPUHKp8OvtWIgyqCRpgWpPUvXrm+6vA1xzTFMpiGkgypkUHkIU5CgERbeHOAj315VwvcTSDVW9IwfEI+mz0LmzqW06uA1GWjKRNZErInUT4PqRbaIJGtYwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729653184; c=relaxed/simple;
	bh=ovOUeYGD+9xfQijHXUxKSMebMEDWnSXXiNZVdcVnk3k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N+SPNfquqP7B0rEr9/DKChDhlGZ60ijEv/uVM1BdEYav6YVBmPWwqHa/9Z2TEzFi67IvIJoFY7OJyK2xYDbyGXjWu7nPfZCnfX9+gBrF0NkkyVrtWJsGk5XIh8gI6D+sm+kA8AyIDxXjRuVe7v+hR+L+ll3qlOA2rH2aQO9s784=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxvbV0Mj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxvbV0Mj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729653183; x=1761189183;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ovOUeYGD+9xfQijHXUxKSMebMEDWnSXXiNZVdcVnk3k=;
  b=RxvbV0MjBLWEDucW3JxPJuvtTm/JObNrMi8JzRNdynurG8f473RXm1x/
   puDSJIWP34Q2+gs1TB25upVlPutrK9RjHyKaaW1HiiVy+MFpmjQhDaff6
   hSAm16ycnpltUIACHisc0hdy7LccbDdZ1J1JM7mQ1FHgQOnzJ0dD+8boL
   OGMk1+FRWzGjR7h7Iw4EN++48dqMDCgugpS1rVUUkvTDe8z06dXf9NQDc
   mH476AI5zArEgDSknM/zMcELitJsXbuVAZtL/MZydInt8LEWpdNUwjTuU
   5qxH3V90dPBtSHT8qRfA6W7vhXjrWvk/ax8xModzUMhCseT0eCm2LvMIk
   Q==;
X-CSE-ConnectionGUID: q6M5KLEBRXSm60OU4Xt5SA==
X-CSE-MsgGUID: NR6fCEYLTgW/vHzEzDVBCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="32077452"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="32077452"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 20:13:02 -0700
X-CSE-ConnectionGUID: Jh4nGejGTLSRPInxziSPtw==
X-CSE-MsgGUID: xk/nBIi6T2K29186cBBFiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80249089"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 20:13:00 -0700
Message-ID: <b524d09e-62ea-41ca-904c-e9c94aef2b76@linux.intel.com>
Date: Wed, 23 Oct 2024 11:12:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, dwmw2@infradead.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, chao.p.peng@intel.com
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix checks in dmar_fault_dump_ptes()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241022095017.479081-1-zhenzhong.duan@intel.com>
 <20241022095017.479081-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241022095017.479081-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/22 17:50, Zhenzhong Duan wrote:
> In dmar_fault_dump_ptes(), return value of phys_to_virt() is used for
> checking if an entry is present. It's never NULL on x86 platform at least.
> This makes some zero entries are dumped like below:
> 
> [  442.240357] DMAR: pasid dir entry: 0x000000012c83e001
> [  442.246661] DMAR: pasid table entry[0]: 0x0000000000000000
> [  442.253429] DMAR: pasid table entry[1]: 0x0000000000000000
> [  442.260203] DMAR: pasid table entry[2]: 0x0000000000000000
> [  442.266969] DMAR: pasid table entry[3]: 0x0000000000000000
> [  442.273733] DMAR: pasid table entry[4]: 0x0000000000000000
> [  442.280479] DMAR: pasid table entry[5]: 0x0000000000000000
> [  442.287234] DMAR: pasid table entry[6]: 0x0000000000000000
> [  442.293989] DMAR: pasid table entry[7]: 0x0000000000000000
> [  442.300742] DMAR: PTE not present at level 2
> 
> Fix it by checking present bit in all entries.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

It seems that we still need a Fixes tag here.

> ---
>   drivers/iommu/intel/iommu.c | 31 ++++++++++++++++++++-----------
>   1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index a564eeaf2375..8288b0ee7a61 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -733,12 +733,17 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
>   	u8 devfn = source_id & 0xff;
>   	u8 bus = source_id >> 8;
>   	struct dma_pte *pgtable;
> +	u64 entry;
>   
>   	pr_info("Dump %s table entries for IOVA 0x%llx\n", iommu->name, addr);
>   
>   	/* root entry dump */
>   	rt_entry = &iommu->root_entry[bus];
> -	if (!rt_entry) {
> +	entry = rt_entry->lo;
> +	if (sm_supported(iommu) && devfn >= 0x80)
> +		entry = rt_entry->hi;
> +
> +	if (!(entry & 1)) {
>   		pr_info("root table entry is not present\n");
>   		return;
>   	}
> @@ -766,28 +771,32 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
>   		goto pgtable_walk;
>   	}
>   
> +	/* For request-without-pasid, get the pasid from context entry */
> +	if (pasid == IOMMU_PASID_INVALID)
> +		pasid = IOMMU_NO_PASID;
> +
>   	/* get the pointer to pasid directory entry */
>   	dir = phys_to_virt(ctx_entry->lo & VTD_PAGE_MASK);

Is above code correct in the scalable mode?

> -	if (!dir) {
> +	dir_index = pasid >> PASID_PDE_SHIFT;
> +	pde = &dir[dir_index];
> +
> +	if (!pasid_pde_is_present(pde)) {
>   		pr_info("pasid directory entry is not present\n");
>   		return;
>   	}
> -	/* For request-without-pasid, get the pasid from context entry */
> -	if (intel_iommu_sm && pasid == IOMMU_PASID_INVALID)
> -		pasid = IOMMU_NO_PASID;
>   
> -	dir_index = pasid >> PASID_PDE_SHIFT;
> -	pde = &dir[dir_index];
>   	pr_info("pasid dir entry: 0x%016llx\n", pde->val);
>   
>   	/* get the pointer to the pasid table entry */
> -	entries = get_pasid_table_from_pde(pde);
> -	if (!entries) {
> +	entries = phys_to_virt(READ_ONCE(pde->val) & PDE_PFN_MASK);
> +	index = pasid & PASID_PTE_MASK;
> +	pte = &entries[index];
> +
> +	if (!pasid_pte_is_present(pte)) {
>   		pr_info("pasid table entry is not present\n");
>   		return;
>   	}
> -	index = pasid & PASID_PTE_MASK;
> -	pte = &entries[index];
> +
>   	for (i = 0; i < ARRAY_SIZE(pte->val); i++)
>   		pr_info("pasid table entry[%d]: 0x%016llx\n", i, pte->val[i]);
>   

Thanks,
baolu
