Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F3F132482
	for <iommu@lists.linux.dev>; Tue,  6 Feb 2024 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219144; cv=none; b=Q6D6L9cW9fp/gQETQVmbNsuOcXpNeYWPvMQVLwBtETcSexsGVM/s+Cn+Z8J8btXMsMPcbAK3vzUFNJrZZiBBmLI5Q6HABLp5Pg9RCmiQb/guVpEtcxh3OKrJ4eFAGbbPGIqhsIktMmDOKyFvx8je4KZUr1pwjKtOJ5qK+j41G9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219144; c=relaxed/simple;
	bh=/IMGTCxErD0wgwGqZAwjLejE+uSkhLispC8aFwiGNqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nel5vRH7Mtwa1VTvFxyS8Ps1TeuS5AKgDmznIR4Jj39aZhHco51sJjBfQSk6oa/Kve2ujMB1g+jvn2FadgzTyXn8bMg7ym+/Rz42kzuIsE9SZ7TBvY+LS7en2YNP3hpHrScOFRNH9Sk4/0ZISVtmT53/fpL/cGSeQ5JPMesag7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2CE51FB;
	Tue,  6 Feb 2024 03:33:02 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 306B03F762;
	Tue,  6 Feb 2024 03:32:19 -0800 (PST)
Message-ID: <0d1f81a8-999e-459d-9e5c-7efff665646e@arm.com>
Date: Tue, 6 Feb 2024 11:32:17 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] iommu/iova: use named kmem_cache for iova
 magazines
Content-Language: en-GB
To: John Garry <john.g.garry@oracle.com>, joro@8bytes.org
Cc: will@kernel.org, pasha.tatashin@soleen.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com,
 yosryahmed@google.com
References: <cover.1707144953.git.robin.murphy@arm.com>
 <dc5c51aaba50906a92b9ba1a5137ed462484a7be.1707144953.git.robin.murphy@arm.com>
 <83a0aafc-8a9c-48ce-a203-96b901489d41@oracle.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <83a0aafc-8a9c-48ce-a203-96b901489d41@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/02/2024 11:24 am, John Garry wrote:
> On 05/02/2024 15:32, Robin Murphy wrote:
>> From: Pasha Tatashin <pasha.tatashin@soleen.com>
>>
>> The magazine buffers can take gigabytes of kmem memory, dominating all
>> other allocations. For observability purpose create named slab cache so
>> the iova magazine memory overhead can be clearly observed.
>>
>> With this change:
>>
>>> slabtop -o | head
>>   Active / Total Objects (% used)    : 869731 / 952904 (91.3%)
>>   Active / Total Slabs (% used)      : 103411 / 103974 (99.5%)
>>   Active / Total Caches (% used)     : 135 / 211 (64.0%)
>>   Active / Total Size (% used)       : 395389.68K / 411430.20K (96.1%)
>>   Minimum / Average / Maximum Object : 0.02K / 0.43K / 8.00K
>>
>> OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
>> 244412 244239 99%    1.00K  61103       4    244412K iommu_iova_magazine
>>   91636  88343 96%    0.03K    739     124      2956K kmalloc-32
>>   75744  74844 98%    0.12K   2367      32      9468K kernfs_node_cache
>>
>> On this machine it is now clear that magazine use 242M of kmem memory.
> 
> Those caches could do with a trimming ...

See the discussion on v1 for more details:

https://lore.kernel.org/linux-iommu/20240201193014.2785570-1-tatashin@google.com/

but it seems this really is the idle baseline for lots of CPUs * lots of 
domains - if all those devices get going in anger it's likely that 
combined iova + iova_magazine usage truly will blow up into gigabytes.

Cheers,
Robin.

> 
>>
>> Acked-by: David Rientjes <rientjes@google.com>
>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> [ rm: adjust to rework of iova_cache_{get,put} ]
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
> 
> FWIW:
> Reviewed-by: John Garry <john.g.garry@oracle.com>
