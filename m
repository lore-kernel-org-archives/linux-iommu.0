Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17C61EDA1E
	for <iommu@lists.linux.dev>; Sat, 11 Oct 2025 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760164474; cv=none; b=jL9/fu04Da6mnBJ2q+6X24KEJkYM4qD5zubftlaJ+gdYoWsfl3YLs4TGkOQbfSXVZ1YEYNVX9rugoQXgmeGej34JFs2n+DkIXjY9HvUVIfsY9SX35nDkqCxbtzWLTGCLw2NXh4zqP/8H5PG1rF8au7vXLq6QmXV8u0iGh18hLp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760164474; c=relaxed/simple;
	bh=ZHoGBUbqzplr1SqOVtjjpzhNhjDVkJ8UthME/KpzTy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eub0Nv6PRKQay5YJ2KdV1w5pg2EbBZK0ggiq3gAW+G6y0yPOIU4WGNHb5nFi3Wc5JjdvpZRLlqStS1YsY+Us5J97hnYEafdqkQNqeK/5/3Gnrt7ukIUVCBNpO9V5cdqBHCiNRhvVM4FFbA0yGiWt+tO8yH/fywGwFZMaTJnEqAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpuRKwpb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpuRKwpb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760164473; x=1791700473;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZHoGBUbqzplr1SqOVtjjpzhNhjDVkJ8UthME/KpzTy8=;
  b=GpuRKwpb5feBKRsoFo8CU4lzGAf7o8B9JPDmBlq9vLjFtgUypJexDd1M
   hP3B/qb2ceBE8JOjPmKX+MRPrJbQbbas848jPnsT+KmUmeMmLqu41d6sj
   0P0BwT+l2KCIdLBGhxfS1rk3QjQJkONSDWjIKra7Vi+0fmswPvLySsD9t
   A/nTZm81q84KG0pjJun6n7uoGo22kLG+gM4smZ0BuZYsPaYgyqHDo15K9
   pi8DbCMIghrTQ5+NrQHF1Jyaly3IGLw5BwIWu8EUj69jvCVYF+VBZMe9F
   PIzOTYfkqdQ6Q5LxHcR5GARz9shDOFFV6ok0j2ATeOHVV7hlFh4UFuvXA
   Q==;
X-CSE-ConnectionGUID: uMn0P3IaTuK8oJaU6yARAw==
X-CSE-MsgGUID: MmOWUrc5SiqepJR/vvvABA==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="87838069"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="87838069"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 23:34:32 -0700
X-CSE-ConnectionGUID: VcSPh3W0SuyKVz7g68oZuw==
X-CSE-MsgGUID: hnXs8JcbTyOib7kc4CEhjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="204824426"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 23:34:27 -0700
Message-ID: <7a001cb9-fb09-487c-bfa9-e2d329b0f6a8@linux.intel.com>
Date: Sat, 11 Oct 2025 14:30:54 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] mm: Introduce deferred freeing for kernel page
 tables
To: David Hildenbrand <david@redhat.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20250919054007.472493-1-baolu.lu@linux.intel.com>
 <20250919054007.472493-7-baolu.lu@linux.intel.com>
 <5b494700-a3af-4feb-8c5f-1ca424ad9841@redhat.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5b494700-a3af-4feb-8c5f-1ca424ad9841@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/25 23:47, David Hildenbrand wrote:
> On 19.09.25 07:40, Lu Baolu wrote:
>> From: Dave Hansen <dave.hansen@linux.intel.com>
>>
>> This introduces a conditional asynchronous mechanism, enabled by
>> CONFIG_ASYNC_PGTABLE_FREE. When enabled, this mechanism defers the 
>> freeing
>> of pages that are used as page tables for kernel address mappings. These
>> pages are now queued to a work struct instead of being freed immediately.
>>
> 
> Okay, I now looked at patch #8 and I think the whole reason of this 
> patch is "batch-free page tables to minimize the impact of an expensive 
> cross-page table operation" which is a single TLB flush.
> 
>> This deferred freeing provides a safe context for a future patch to add
> 
> So I would claridy here instead something like
> 
> "This deferred freeing allows for batch-freeing of page tables, 
> providing a safe context for performing a single expensive operation 
> (TLB flush) for a batch of kernel page tables instead of performing that 
> expensive operation for each page table."

The commit message has been updated, and CONFIG_ASYNC_PGTABLE_FREE has
been replaced with CONFIG_ASYNC_KERNEL_PGTABLE_FREE. Thank you for the
comments.

Thanks,
baolu
