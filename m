Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9E135DA41
	for <iommu@lists.linux.dev>; Sun, 12 Jul 2026 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783841748; cv=none; b=elfo8Xg66+IRjP27q2J46BM4gtyHgovOkRTBtaGphCnYu6ovx7fEGUFLbbEHTPQciHUUDtvmbcH6WqoXjt3M83JkGc/YoY66ETd5fzA68bxYRcAWnFSw/+WTqS4u3F/JKOQMxPI9khjqjzL9oAMijKWXH5UXRf3EwBAv540+24s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783841748; c=relaxed/simple;
	bh=TVY2k3wJ1V4yP0sBUwoa5yvD2vNBYAD47drSrdUMlk8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a6educiO/kxTjDNcHgL4IJWbONWS8fvzPVPon5cuOK5B6OXrH25V7URebh1QJ1UK+iUoHci30KN/G9rZWO2Mg3r2BWViWFMs7FPvPKlOafdzccpY7xsKXJ3wej4oYsuJ3tj/N3XVxu2Uj4n9jIpCg+LjV4GRuVcsBNwtaeQ/LzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=heQzE+BO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="heQzE+BO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783841747; x=1815377747;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TVY2k3wJ1V4yP0sBUwoa5yvD2vNBYAD47drSrdUMlk8=;
  b=heQzE+BOTckMM/BcgIZvr3E95dcFs0oQwwCAGLAe88buNbU8t6/CytS3
   hqcbbGEuD6om1VhYsIOxAqGUrB+4221hp8fX18lxP4hhEi6f0asxZ1yOh
   H85pmwBSXD2ZM38daF30xxVVIv1oT+dmgYEBZ2v3NKoQKxuI3oGi1dvX1
   yp/mDwtUOCg8JZoG6KoQR3GvDkzoyaRe1JCgfJZqspzDRn477RpFH+WCg
   0oecFGk+2XT7K7DD/pUDcyrCJKMsAbOkp6thxX7NERENyMAkOpvfpeH5s
   KIG7tuGxODv9W9WlJBvOFadamPSPqszYRPt/rtFO/+eXGl7AERK2M03Dn
   w==;
X-CSE-ConnectionGUID: dubfcS9PQeKC/Ortsxwlyg==
X-CSE-MsgGUID: 4J7NyimJQAijQ4xX6KaLLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84601000"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84601000"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 00:35:46 -0700
X-CSE-ConnectionGUID: CeBYo1PjSziYqtYyP/12Ig==
X-CSE-MsgGUID: kqZuOISuQ82Tb28pe5sNEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253518236"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.248.249]) ([10.124.248.249])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 00:35:42 -0700
Message-ID: <847f0e2e-abfa-4d6b-98a5-5e25ffe66d8f@linux.intel.com>
Date: Sun, 12 Jul 2026 15:35:39 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>,
 Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v3 07/18] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
To: Samiullah Khawaja <skhawaja@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-8-skhawaja@google.com>
 <f3e2fef9-4f8c-4032-8d7b-007f47b3fb61@linux.intel.com>
 <ajl7xfcoKsohfpPJ@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ajl7xfcoKsohfpPJ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/23/2026 3:19 AM, Samiullah Khawaja wrote:
> 
>>> +
>>> +static void unpreserve_context_table(struct intel_iommu *iommu,
>>> +                     struct iommu_hw_ser *ser,
>>> +                     u8 bus, u8 devfn)
>>> +{
>>> +    struct context_entry *context;
>>> +
>>> +    spin_lock(&iommu->lock);
>>> +    context = iommu_context_addr(iommu, bus, devfn, 0);
>>> +    spin_unlock(&iommu->lock);
>>
>> The spinlock is dropped immediately after reading the address pointer.
>> If this is guaranteed to be safe, please add a comment to explain why a
>> UAF or race is avoided here. Otherwise, the locking scope needs to be
>> extened to protect both the pointer lookup and use.
> 
> In the Intel VT-d driver, context tables are never freed once they are
> allocated during runtime, as they can be shared across multiple devices.
> So I took the lock here to protect against concurrent allocations inside
> iommu_context_addr(). Once the address is read, it is safe to use
> without holding the lock until the DMAR unit itself is torn down.
> 
> I will add a comment explaining this here.

As part of this series, I think this is acceptable. However, there
is room for further improvement in iommu_context_addr(). We could avoid
concurrent allocations by replacing the code below with try_cmpxchg64():

                 phy_addr = virt_to_phys((void *)context);
                 *entry = phy_addr | 1;

At the same time, we could also replace the spinlock with an rwsem to
eliminate the spinlock critical section. Consequently, the GFP_ATOMIC
allocation in iommu_alloc_pages_node_sz() could then be replaced with a
normal GFP_KERNEL.

Thanks,
baolu
