Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492A432D44B
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 05:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768367681; cv=none; b=gxjJ4U5cfxoY/5q/jm40KdG4cu1Dkr8X1jAFvZqtdqIbc8JRj0HjZgvuEDVlDBRvDab/qMEmysurOJTX4ZZ/g9s/4NB3oTKyRaJDh7PGKCEBGmQHZK89ib2P+kP2BImsQ/iAcRI8Rid0Fpn6JZBUe2X+BVtxXPnX4kv2zfn5OR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768367681; c=relaxed/simple;
	bh=ZLyrbONB+3qaOwgvL7yX1aaPdLC+ySXSll3Um0jr+Is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpFBJ5yycjwC08QmSgPj+24yUH/6bSLjmhh8soTUe0K5IrSqZh9j7eYEBWbN4Qig+9vyi3CJe8eGEqotSB9T0w1fNPhthJQiU3KaX9q9tA/tfQcUgObd7M3c6hyobz3AsDm44twOSu/bnXN0yNsR0BE3moe1sw2opNBs8NkK3e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mb0gzr08; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mb0gzr08"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768367678; x=1799903678;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZLyrbONB+3qaOwgvL7yX1aaPdLC+ySXSll3Um0jr+Is=;
  b=Mb0gzr08VapDLPUD1rjkyIiCUv8BGBR9B2daj8zHWJGniQQEIEPThOJS
   6so+jbGzZ3wbWjtlyIaPTxupo4zloMwJRRMZviVSnDI4goWQhfnUTw0ha
   hGW8H1iKX84V46vE4KtQNxv7CM4yl3H8agRi9wdaxcVbn9sThQ6brHH+K
   UA2q0LPsjP+hdejiuEn2Dsdjsq/+YbsMWTQDlFcbBCdvZIVGovTJqbs6d
   B0ZQAiEGk0hw84JqbVGvhq2CEJUrqP17CMR8TRZlu4QR4gAV2wVrjFp8I
   Z0UI28fhqfwmNgCh9cLVZl5VcUVIoSnpWvFVsxj+1gU9wHGWEEPUjDxmk
   w==;
X-CSE-ConnectionGUID: DV8kzXNgRMykVCUyFFRKbQ==
X-CSE-MsgGUID: NMgFNUf4RlqhzCDT68E6RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69570986"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="69570986"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:14:33 -0800
X-CSE-ConnectionGUID: ZOhZDQu/Qe+0XU0SqT4thQ==
X-CSE-MsgGUID: OrZpxMbwR52tG3ZnseLJVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="209039629"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:14:30 -0800
Message-ID: <1e967054-d2bd-4c3d-99eb-315a40bac9de@linux.intel.com>
Date: Wed, 14 Jan 2026 13:14:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iommu/vt-d: Use 128-bit atomic updates for context
 entries
To: Dmytro Maluka <dmaluka@chromium.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Aashish Sharma <aashish@aashishsharma.net>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-2-baolu.lu@linux.intel.com>
 <aWacsq9gDrAgPxli@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aWacsq9gDrAgPxli@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/14/26 03:27, Dmytro Maluka wrote:
> On Tue, Jan 13, 2026 at 11:00:46AM +0800, Lu Baolu wrote:
>> On Intel IOMMU, device context entries are accessed by hardware in
>> 128-bit chunks. Currently, the driver updates these entries by
>> programming the 'lo' and 'hi' 64-bit fields individually.
>>
>> This creates a potential race condition where the IOMMU hardware may fetch
>> a context entry while the CPU has only completed one of the two 64-bit
>> writes. This "torn" entry — consisting of half-old and half-new data —
>> could lead to unpredictable hardware behavior, especially when
>> transitioning the 'Present' bit or changing translation types.
>>
>> To ensure the IOMMU hardware always observes a consistent state, use
>> 128-bit atomic updates for context entries. This is achieved by building
>> context entries on the stack and write them to the table in a single
>> operation.
>>
>> As this relies on arch_cmpxchg128_local(), restrict INTEL_IOMMU
>> dependencies to X86_64.
>>
>> Fixes: ba39592764ed2 ("Intel IOMMU: Intel IOMMU driver")
>> Reported-by: Dmytro Maluka<dmaluka@chromium.org>
> FWIW, Jason and Kevin contributed to this discovery more than I did. 🙂

Thanks to all you guys.

> 
>> Closes:https://lore.kernel.org/all/aTG7gc7I5wExai3S@google.com/
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/Kconfig |  2 +-
>>   drivers/iommu/intel/iommu.h | 22 ++++++++++++++++++----
>>   drivers/iommu/intel/iommu.c | 30 +++++++++++++++---------------
>>   drivers/iommu/intel/pasid.c | 18 +++++++++---------
>>   4 files changed, 43 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>> index 5471f814e073..efda19820f95 100644
>> --- a/drivers/iommu/intel/Kconfig
>> +++ b/drivers/iommu/intel/Kconfig
>> @@ -11,7 +11,7 @@ config DMAR_DEBUG
>>   
>>   config INTEL_IOMMU
>>   	bool "Support for Intel IOMMU using DMA Remapping Devices"
>> -	depends on PCI_MSI && ACPI && X86
>> +	depends on PCI_MSI && ACPI && X86_64
>>   	select IOMMU_API
>>   	select GENERIC_PT
>>   	select IOMMU_PT
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index 25c5e22096d4..b8999802f401 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -546,6 +546,16 @@ struct pasid_entry;
>>   struct pasid_state_entry;
>>   struct page_req_dsc;
>>   
>> +static __always_inline void intel_iommu_atomic128_set(u128 *ptr, u128 val)
>> +{
>> +	/*
>> +	 * Use the cmpxchg16b instruction for 128-bit atomicity. As updates
>> +	 * are serialized by a spinlock, we use the local (unlocked) variant
>> +	 * to avoid unnecessary bus locking overhead.
>> +	 */
>> +	arch_cmpxchg128_local(ptr, *ptr, val);
> Any reason why not cmpxchg128_local()? (except following the AMD driver)

Yes. This follows the AMD IOMMU driver. Both drivers use spin lock to
synchronize the update of table entries. They only need the atomicity of
the 128-bit instruction itself. So arch_cmpxchg128_local() works.

> 
> Otherwise,
> 
> Reviewed-by: Dmytro Maluka<dmaluka@chromium.org>

Thanks,
baolu
