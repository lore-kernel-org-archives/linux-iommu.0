Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8E288D2
	for <iommu@lists.linux.dev>; Mon, 15 Sep 2025 01:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757899181; cv=none; b=bF1DlcGzd0l/7rjVDNHEaqCFVF6W4LKb08ULFp7cf4/8Z6zmEdIzX9dVULUYDY7lB4s+BzLG8KCGufHd4kFVCf+4X9ypZLc4ZOYb1s6AJ0fxkCZiIdstBL4sRWg5LylVhMGHmtZkzBzgSM3koblZafD5RJDK5r7RrJ4LEaWaN4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757899181; c=relaxed/simple;
	bh=1rWC6VqFILYK9MJ0YDNl3z4StVZA+meGWpJE2IncvSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ON+ilTA9HnyI+2owlFlLep1/IJoBWhdqCGof+RPEDii7TbXfENYT41RmKaK4xTcD8TvgndMErca42BGKE2uTyoTKacZWMYVPo45O4IlC1mQO+W9HotLjgaH6gXR2hgxloRuh/M4CyAOuT70qNdthZkopufqOW0DlhaNEDExG3CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lP3sIri7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lP3sIri7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757899179; x=1789435179;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1rWC6VqFILYK9MJ0YDNl3z4StVZA+meGWpJE2IncvSQ=;
  b=lP3sIri7SSpFuFz4CT/7uNUDc1HhuB5g85Gt0tHj82RXEb5rSgyi3d1r
   Cm4SN5nXLggcYq3kTL3E75AsMXHu2VlZcyURlecp8HIkVCBbLq3mTdMxk
   FrJBxqtrrF548ax8EH5MhY3D4WYGcfBpLEb+ZxNLMyfUnrc6h5v/KuoCp
   Bv+DA/XYm7O3sa4ytI9HAfhgx9IkKwBdR6OkFqRHNCxHoRAbhsEnCgxiy
   e6qRaiAh0cnbRBANtthTdZyNT7iNFjg8n76uDxexOjV5i1oFWW5dd3Nvy
   opZ6yMGYfE4LjDoWS2DC3v1rvT/3234mu7Z7ny4LglIjIXm9KbnaY3uXK
   A==;
X-CSE-ConnectionGUID: c6o9fCtwQR6cvlSmq0k2ow==
X-CSE-MsgGUID: v+IU5j47RXWstSO3fLG/eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="71245197"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="71245197"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 18:19:39 -0700
X-CSE-ConnectionGUID: MN3CxUpxTDWR8thRQ5DDlA==
X-CSE-MsgGUID: qmiVCJrXS/ydFzdW2TEGVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="174929200"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 18:19:34 -0700
Message-ID: <0c97eb75-731a-49bf-a247-cd5be8835843@linux.intel.com>
Date: Mon, 15 Sep 2025 09:16:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] mm: Introduce deferred freeing for kernel page
 tables
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, "Hansen, Dave" <dave.hansen@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "security@kernel.org" <security@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
 <20250905055103.3821518-7-baolu.lu@linux.intel.com>
 <BL1PR11MB52719E654E5AE227FE29B75F8C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB52719E654E5AE227FE29B75F8C08A@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 16:14, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Friday, September 5, 2025 1:51 PM
>>
>> From: Dave Hansen <dave.hansen@linux.intel.com>
>>
>> On x86 and other architectures that map the kernel's virtual address space
>> into the upper portion of every process's page table, the IOMMU's paging
>> structure caches can become stale when the CPU page table is shared with
>> IOMMU in the Shared Virtual Address (SVA) context. This occurs when a page
>> used for the kernel's page tables is freed and reused without the IOMMU
>> being notified.
>>
>> While the IOMMU driver is notified of changes to user virtual address
>> mappings, there is no similar notification mechanism for kernel page
>> table changes. This can lead to data corruption or system instability
>> when Shared Virtual Address (SVA) is enabled, as the IOMMU's internal
>> caches may retain stale entries for kernel virtual addresses.
> 
> above could be saved to the last patch.

Yes.

> 
>>
>> This introduces a conditional asynchronous mechanism, enabled by
>> CONFIG_ASYNC_PGTABLE_FREE. When enabled, this mechanism defers the
>> freeing
>> of pages that are used as page tables for kernel address mappings. These
>> pages are now queued to a work struct instead of being freed immediately.
>>
>> This deferred freeing provides a safe context for a future patch to add
>> an IOMMU-specific callback, which might be expensive on large-scale
>> systems. This ensures the necessary IOMMU cache invalidation is performed
>> before the page is finally returned to the page allocator outside of any
>> critical, non-sleepable path.
>>
>> In the current kernel, some page table pages are allocated with an
>> associated struct ptdesc, while others are not. Those without a ptdesc are
>> freed using free_pages() and its variants, which bypasses the destructor
>> that pagetable_dtor_free() would run. While the long-term plan is to
>> convert all page table pages to use struct ptdesc, this uses a temporary
>> flag within ptdesc to indicate whether a page needs a destructor,
>> considering that this aims to fix a potential security issue in IOMMU SVA.
>> The flag and its associated logic can be removed once the conversion is
>> complete.
> 
> stale comment?

Yes. Fixed.

> 
>>
>> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Thanks,
baolu
