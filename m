Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ED744AB8A
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719744; cv=none; b=fr1m2NierykLNiG5FMTZgchYliYdXqx3FOvpBJawTLnUARODn8Nlv9ubLHoqf+bjLGv9wMilhQWUwb37IWclmY5xXNsEWIhyCngi/FY0hLy1wcrNUwmz+RfES3NoQYyXiclDYJiAxk5DIZBIrZh/4nrjHxpSwxLRVNJyb4hJtVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719744; c=relaxed/simple;
	bh=b7SZRiTdPjaH75CaQCp3RCsjKZl29SheZjvophXkDdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=seId2t549pSzdd6Es/ORFlRb4yd/MpD+hfguIGbHtBMyvRv9NJuxu+MangSWpHjErJpX7TxjjXLr7QocWjBExRddJbWptyh1rHznqZu76MxHUNT9tJkNlbX1yRMEPNIe0iEP+qhZlJOOYx98KgEiBqPkay1qA86g5/uoV04P7+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6wlATQd; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6wlATQd"
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2db39df9c51so2172765ad.1
        for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 01:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789719742; x=1790324542; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CjigVRuOlpSLvwuFF0kw47lERwh/eIzaGM/o/mwNyVQ=;
        b=G6wlATQdPLVthtrFU35bxQtX1iBLG34+ombHSnIr96H604L2ngLzr/6RucqA3c7L3B
         YLMR1DzukvY5nlbna+aGOPKyM4E6mqVF+Ki2vpjCS1N+KwXTLXSermRjJLzC+XWRmNk2
         FQZLT0JJnS/qUhEZVRJyK5kMZ55Z0NNmgAY/1+mgkQuICkcsfJTrdKGHgc0MwJCjS/xa
         plz4NaYBEqseIPRGZfsQewuJVcj9g32zLh+M4Ct086htVAYxIBu2tDfg8eBVMQR+Hw4p
         A4BEbq6AQuJf/RqIqqPLAusKDZixMTGBGJv638PeZ8VfPHSjqhMsgXKThVpM0QQ1EcDv
         nJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789719742; x=1790324542;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CjigVRuOlpSLvwuFF0kw47lERwh/eIzaGM/o/mwNyVQ=;
        b=M8Ybd+OVzi+6m81vAzCb1Dea+IffcAhguF9OgJe5vhZ/Na2InFl8AgxPmBGTXWDyyZ
         aQDo/2OtVL00gmIpF00i/AwlhJG8YOK/bRjSO86+5+N63qZG+Im5tciVqzmGfAhETk3F
         5v4ox5I+1eRxT/1b7w1ZD3zAPB3LhWUSmGXkNuSG/jx/XcGMYqw5wlB6dAugY/lJhDzI
         X3xB+V6lcJnwzu9UPXeoXoki/dP26eOk0QrlKz483/Sh3hv928E7AShEhZCK/cIoZJC8
         WKjsNHuY7559kLgilP1LH8ymAdMQiiKzTCJXl1o6gwQgdTdLTRO94rbbfgNG4Rz85LZ/
         Av5Q==
X-Forwarded-Encrypted: i=1; AKwUvByF2Jsa1rcI1hacII7INJ9dUrjFj01HBAF5XZ1fbzJlxK1pScntNpLME19EVU0quGhmaLpiIA==@lists.linux.dev
X-Gm-Message-State: AFuF++kGyhS07LaNPRAXVbhxtD6QYwkF4ZsipM5n5xxiAviiJyPEd73x
	yUYD27Q8QCaLt6fr6mKESj1RuRjYf3M5/wlf8gF85Sl7hlZt7JQSHbCT
X-Gm-Gg: AYBFou1HHo1Otw9AnXgvT6Hn3s1wQj8dFLMHsUV3Zg5v4PBWSK8OZwRMizARRS97+mq
	fu1URHCy9EFe3BN4aOoajyYFnpJM1YP7M5GEY9ziMmepVFSTRikt7dW1cmEpPvoO4foi0NFl+qC
	EUHTl1c7AsiDmVE7rYTjv7Ppb54vUj23D28yjsQMjla0WXtKFvkfn2qkrlSgBcNqXxw/6gzAPzm
	E4WaOVogDz1R6feUl21u3HG8bVz3nUaRy1xpFOAWLkzemiI3J+Rq+IkX4u9UnasS3bVDsBwqZKb
	NCRaYHaa/OxtEgQQBnlWXOeJYtAe68n5OwpADnQ4A54SmvNQMHJain04Dv2y3Jp+gDumsliOOOB
	pcuqqzvwOemiVvMAcs590wXSXi+fqTXCCSvvz8mNiLNV0OlDGR1IsGlcec8lcuFnGBxuPAJ/zs9
	tEOQGStsHQNWyUk9ZDK/r6ySewFPDkbM4TNfOA3sm2egsE9CRKtXoPkBM3tGQ/lM6jUamFjIiQD
	40VuQ==
X-Received: by 2002:a05:6a00:4196:b0:874:708d:b637 with SMTP id d2e1a72fcca58-874df800839mr3426122b3a.35.1789719741686;
        Fri, 18 Sep 2026 01:22:21 -0700 (PDT)
Received: from [10.125.112.20] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc5c50e79f1sm541488a12.30.2026.09.18.01.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 01:22:20 -0700 (PDT)
Message-ID: <bc6cf467-84d1-40a0-b570-1b5256a6e2e2@gmail.com>
Date: Fri, 18 Sep 2026 16:22:03 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/10] memblock: introduce MEMBLOCK_NODUMP flag
To: Baoquan He <baoquan.he@linux.dev>
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org,
 rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
 m.szyprowski@samsung.com, mark.rutland@arm.com, kernel@xen0n.name,
 alex@ghiti.fr, hpa@zytor.com, ruirui.yang@linux.dev, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 iommu@lists.linux.dev
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-7-chenwandun1@gmail.com> <aqzxavL91icLw-Xv@fedora>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <aqzxavL91icLw-Xv@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/26 16:08, Baoquan He wrote:
> On 09/02/26 at 03:31pm, Wandun Chen wrote:
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
>> Add MEMBLOCK_NODUMP to mark regions that should be excluded from
>> kdump vmcores.
>>
>> The flag is meant for reserved memory that carries no data useful for
>> crash analysis. Reusable reserved regions such as CMA may hold useful
>> data, so these regions must not be marked MEMBLOCK_NODUMP. Subsequent
>> patches wire this up for /reserved-memory and /memreserve/ entries.
>>
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
>> ---
>>  include/linux/memblock.h |  9 +++++++++
>>  mm/memblock.c            | 16 ++++++++++++++++
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index d62db9e776cf..b2fcf11fba2b 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -52,6 +52,8 @@ extern unsigned long long max_possible_pfn;
>>   * kernel that we know is good to use. It is the only memory that
>>   * allocations may happen from in this phase.
>>   * @MEMBLOCK_RSRV_HUGETLB: memory is reserved for hugetlb pages
>> + * @MEMBLOCK_NODUMP: exclude from kdump vmcore. It carries no data useful
>> + * for crash analysis (e.g. firmware carveouts).
>>   */
>>  enum memblock_flags {
>>  	MEMBLOCK_NONE		= 0x0,	/* No special request */
>> @@ -63,6 +65,7 @@ enum memblock_flags {
>>  	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
>>  	MEMBLOCK_KHO_SCRATCH	= 0x40,	/* scratch memory for kexec handover */
>>  	MEMBLOCK_RSRV_HUGETLB	= 0x80, /* memory reserved for hugetlb pages */
>> +	MEMBLOCK_NODUMP		= 0x100,/* exclude from kdump vmcore */
>>  };
>>  
>>  /**
>> @@ -160,6 +163,7 @@ int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
>>  int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
>>  int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size);
>>  int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size);
>> +int memblock_mark_nodump(phys_addr_t base, phys_addr_t size);
>>  
>>  void memblock_free(void *ptr, size_t size);
>>  void reset_all_zones_managed_pages(void);
>> @@ -306,6 +310,11 @@ static inline bool memblock_is_kho_scratch(struct memblock_region *m)
>>  	return m->flags & MEMBLOCK_KHO_SCRATCH;
>>  }
>>  
>> +static inline bool memblock_is_nodump(struct memblock_region *m)
>> +{
>> +	return m->flags & MEMBLOCK_NODUMP;
>> +}
>> +
>>  int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
>>  			    unsigned long  *end_pfn);
>>  void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index f2952d725c10..2e87f39826dd 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1204,6 +1204,21 @@ __init int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size)
>>  				    MEMBLOCK_KHO_SCRATCH);
>>  }
>>  
>> +/**
>> + * memblock_mark_nodump - Mark a memory region with flag MEMBLOCK_NODUMP.
>> + * @base: the base phys addr of the region
>> + * @size: the size of the region
>> + *
>> + * Mark the region as not to be included in crash dumps.
>> + *
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +int __init_memblock memblock_mark_nodump(phys_addr_t base, phys_addr_t size)
>       ~~~~~~~~~~~~~~^
> Is it impossible to use at runtime even thought it claims to be generic?
It is currently only used during initialization, so I added __init_memblock.

If other modules need to use this function in the future, this annotation can
be removed.

Best regards,
Wandun>
> 
>> +{
>> +	return memblock_setclr_flag(&memblock.memory, base, size, 1,
>> +				    MEMBLOCK_NODUMP);
>> +}
>> +
>>  static bool should_skip_region(struct memblock_type *type,
>>  			       struct memblock_region *m,
>>  			       int nid, int flags)
>> @@ -2887,6 +2902,7 @@ static const char * const flagname[] = {
>>  	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
>>  	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
>>  	[ilog2(MEMBLOCK_RSRV_HUGETLB)] = "RSV_HUGETLB",
>> +	[ilog2(MEMBLOCK_NODUMP)] = "NODUMP",
>>  };
>>  
>>  static int memblock_debug_show(struct seq_file *m, void *private)
>> -- 
>> 2.43.0
>>

