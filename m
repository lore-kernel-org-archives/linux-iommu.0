Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EA9253355
	for <iommu@lists.linux.dev>; Wed, 27 Aug 2025 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756276650; cv=none; b=kTeIpP9j5hS6cN3gV82dw4Vv9dZvE4nSgGekXJm5XwaUNJum8rMMWmBSoFUmFOR4BG2bR/W05VGqDRuiCJWIO8/gAu8SkPawtK/5SgOQmi0qxl8UcLzshhG8TTPO5/9b8aR6ixUcgisfLA5CkHJaCFStRldPeopfxpzT1tWaDt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756276650; c=relaxed/simple;
	bh=g350CQcVdNLEmQXYiekatM/c2+9Sf2FEEF6OFijTMNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uo7M5VjH/h80OZt2AkHYKfszzg2wpc49AFYemMUrxoHvXNsqBqrPrw8NPHPiA9zKp/pR3huGx2h6FiO9EEM0eWZ31roWN3ZcIcVmZFXTZJ3RX69ncErQujOzU05RB1XEOT/21Hkq0BjxgMvv7gkbUkTo7JyXYFcC7CeeqBHtQJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BgjlS4tm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BgjlS4tm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756276649; x=1787812649;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g350CQcVdNLEmQXYiekatM/c2+9Sf2FEEF6OFijTMNQ=;
  b=BgjlS4tm8AQ5TECgwhivgHIf8lGXZ/KH/6I+hBQydFqB32qGyhN0RFV/
   v8J1obFa/PXtu0+kNk5nUsi2F8UTSyi7ecwJvRr9sxxCj7lrWWsyclRhL
   0TVAXchRnw4Y5o+VU+SF2zBp0u7PBm2OKm9glpjU3oIBHe6Mk0sUnFbJN
   Inp1L5HdYqQlzYfD2GPocnusJt5m2H3sBHUtHPXpcab42HmI0lK5B6ipc
   cwIuWsMI7DE7rx4wWd7zP8Lo6HP8jsO+FT3+ep2/k9rRgeCaOdNWiAS4T
   8WVMBhADrNEHVT2tOYCTu8hU2yVERoN9fCXryogcsAvZx8pjb/EsCwCuD
   g==;
X-CSE-ConnectionGUID: Yt4D4mVKRtWmnk8Z9qDjJw==
X-CSE-MsgGUID: +Mr7sV+kT9CbnNAHtyv0qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="75975401"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="75975401"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 23:37:28 -0700
X-CSE-ConnectionGUID: h11D7tNgTcGaiuNIxjgsEw==
X-CSE-MsgGUID: DVrAoGFlRamj9h0TPemA4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="170595511"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 23:37:24 -0700
Message-ID: <08e7cb79-d175-448e-9b6f-07e9f07ba042@linux.intel.com>
Date: Wed, 27 Aug 2025 14:34:56 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Dave Hansen <dave.hansen@intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "security@kernel.org" <security@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <20250807195154.GO184255@nvidia.com>
 <BN9PR11MB52762A47B347C99F0C0E4C288C2FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87bfc80e-258e-4193-a56c-3096608aec30@linux.intel.com>
 <BN9PR11MB52766165393F7DD8209DA45A8C32A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e321d374-38a7-4f60-b991-58458a2761b9@linux.intel.com>
 <9a649ff4-55fe-478a-bfd7-f3287534499a@intel.com>
 <b0f613ce-7aad-4b1d-b6a1-4acc1d6c489e@linux.intel.com>
 <dde6d861-daa3-49ed-ad4f-ff9dcaf1f2b8@linux.intel.com>
 <242057e5-10c0-4cf5-86d8-ace0f19e5760@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <242057e5-10c0-4cf5-86d8-ace0f19e5760@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/25 00:21, Dave Hansen wrote:
> On 8/25/25 19:49, Baolu Lu wrote:
>> What's strange is that order is almost always 0, except in the path of
>> remove_pmd_table() -> free_hugepage_table(), where order can be greater
>> than 0. However, in this context path, free_hugepage_table() isn't used
>> to free a page table page itself. Instead, it's used to free the actual
>> pages that a leaf PMD is pointing to.
> When I first read this, I thought you meant that remove_pmd_table() was
> trying to free a high-order page composed of multiple pte pages. I don't
> think it is doing that.
> 
> Just to be clear: remove_pmd_table() has two modes:
> 
> 	1. The pmd_leaf() code that calls free_hugepage_table(). It is
>             removing the memory pointed to by a PMD*entry*. It is*NOT*
> 	   removing page tables themselves.
> 	2. The !pmd_leaf() code that does remove the pointers to
> 	   individual pte pages and frees them via free_pte_table().
> 
> *Neither* of these is freeing high-order page tables pages. It either
> frees plain old kernel data pages or it frees an order-0 page table page.
> 
> In other words, the pmd_leaf() (mode #1) code is irrelevant to us. Those
> entries are all _PAGE_KERNEL so IOMMU accesses with user privilege can't
> do anything with them.

I have the same understanding, so case #3 (higher-order non-compound
page table pages) doesn't exist. Page table pages always have an order
equal to 0.

I will head in the direction you pointed out in your previous reply and
post the change later for further review. Thank you for the insights.

> 
> Or have I just horribly confused myself?

Thanks,
baolu
