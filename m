Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115BC1DFF0
	for <iommu@lists.linux.dev>; Fri, 17 Oct 2025 01:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760664803; cv=none; b=tnVmC1gFfEL+n7CKW4rR6LR8yenedAAprNP+qa1MQBjKUPDUrviNtAGDNnvQJ211nxQRLnNUeIK6K0mdH0gvH0fWxYibXduBSo680hlOTWc6VOovXZsqNyXQaIQKG1qa/OEMWpbBX9chFVrCF8GrLeq5NwScpc0DL5hSHrCXnQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760664803; c=relaxed/simple;
	bh=InToWeKulfFCiasailhcft0AF/qT17xeW6w86HnWH7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBejAFZjkB8m3rUjx1/Ces4bZiOXZGYLNL3VawokZ86fGKMpCzVQpeJERAwiEKeEGkvTxtwkdRJWdxddGSCi/DLB6xoXUBi2aUkv9brB4xInCqksMKP1cNKZyAB3HV2C4gTZjmipTUvc0wdDRZ4ViaR5eKgX+AdkKD9Eb/XD2/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1RjOknR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1RjOknR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760664801; x=1792200801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=InToWeKulfFCiasailhcft0AF/qT17xeW6w86HnWH7M=;
  b=n1RjOknRsp+UZv6ClPA7BGrlsJU6Q1wT7dzfDzxMJi21oKgbCVLxjgNa
   H2ZeZi3JnYsFGBmAhVQeRsFflbjZyL9m5f7XCWajnNNAg8ypfJRcynI61
   cDeUdddiFWSrXE9wwQXEjtkDQVKF/mW3ABwbwDvJNKWnhZJU6jYsUfczH
   OicXYSVSALFY13e54fkFjpkFcIoz8esSPOQe0Ww6StA9K4PgyPEyWIBxB
   mhml5FzIzZdKhqXlYPySeYYpKcuJQLRWwaTvKHR+REpQX+eTozYD32QsI
   7vhvcpnVGga2sE+2jUJg1m4Se/G9qVZOxE1RX8LBC8+lKe4UwEP/EgdoW
   g==;
X-CSE-ConnectionGUID: PzrKqQmdTpuv+gZ/lQqy0w==
X-CSE-MsgGUID: YfHaQBjjQnCswGFaA9//0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="73541212"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="73541212"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 18:33:20 -0700
X-CSE-ConnectionGUID: 4hyF6p1zQ125ZX6UsPL5oA==
X-CSE-MsgGUID: ip+saoXoRX2OIkKrk46nPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="186627047"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 18:33:13 -0700
Message-ID: <ba9e0f6c-1d46-4447-a694-debacea44f48@linux.intel.com>
Date: Fri, 17 Oct 2025 09:29:30 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] mm: Introduce deferred freeing for kernel page
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
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
 <20251014130437.1090448-7-baolu.lu@linux.intel.com>
 <e62bad6a-bd49-48d9-aa2d-9e2022f829b3@redhat.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <e62bad6a-bd49-48d9-aa2d-9e2022f829b3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/17/25 03:35, David Hildenbrand wrote:
> On 14.10.25 15:04, Lu Baolu wrote:
>> From: Dave Hansen <dave.hansen@linux.intel.com>
>>
>> This introduces a conditional asynchronous mechanism, enabled by
>> CONFIG_ASYNC_KERNEL_PGTABLE_FREE. When enabled, this mechanism defers the
>> freeing of pages that are used as page tables for kernel address 
>> mappings.
>> These pages are now queued to a work struct instead of being freed
>> immediately.
>>
>> This deferred freeing allows for batch-freeing of page tables, providing
>> a safe context for performing a single expensive operation (TLB flush)
>> for a batch of kernel page tables instead of performing that expensive
>> operation for each page table.
>>
>> On x86, CONFIG_ASYNC_KERNEL_PGTABLE_FREE is selected if CONFIG_IOMMU_SVA
>> is enabled, because both Intel and AMD IOMMU architectures could
>> potentially cache kernel page table entries in their paging structure
>> cache, regardless of the permission.
> 
> See below, I assume this is patch #7 material.
> 
>>
>> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> ---
>>   arch/x86/Kconfig     |  1 +
>>   mm/Kconfig           |  3 +++
>>   include/linux/mm.h   | 16 +++++++++++++---
>>   mm/pgtable-generic.c | 37 +++++++++++++++++++++++++++++++++++++
>>   4 files changed, 54 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index fa3b616af03a..ded29ee848fd 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -279,6 +279,7 @@ config X86
>>       select HAVE_PCI
>>       select HAVE_PERF_REGS
>>       select HAVE_PERF_USER_STACK_DUMP
>> +    select ASYNC_KERNEL_PGTABLE_FREE     if IOMMU_SVA
> 
> That should belong into patch #7, no?

Yes. Done.

Thanks,
baolu
