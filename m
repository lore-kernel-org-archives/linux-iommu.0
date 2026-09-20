Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B8346AF1
	for <iommu@lists.linux.dev>; Sun, 20 Sep 2026 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789891254; cv=none; b=XQcWp/b+VI2FWhe2OeKa8ZdgI2ruJgY36k70ReBrjhfdCZ+wK0vWcttujfRmRxEO/3VIrl+QBqakUCJ1im4301J1XiC8quDX17cGgJdb65+4hFbWqFVXufne+LzFVJP/AAhnxHSHOAyCrFthGEPg62RuRhQvfNQpQ+EHff/4HtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789891254; c=relaxed/simple;
	bh=PYjoRnzoFTLZF653qo+HDOrzFXvuX00dh48RUmFUdyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQOjLubiNRFS1K5Zgblh2Yqq3MLJ03GlgjdKDwlGXaR3JURVOn/+N2j7Fb8oGmaxTIy4lVLpNiOA6GKsV2gYaiuK7bVDBgD/OqYRsldjSU5Pl26+RPNFCRrBCmvtqI7+r1DUWlGy2xWbAsCoxIXR4vbQ73TchXnwMmlM+33mAZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zt0LLrxj; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt0LLrxj"
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2d6f230d1easo2132215ad.1
        for <iommu@lists.linux.dev>; Sun, 20 Sep 2026 01:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789891251; x=1790496051; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t8CTYyRXY2aAud9otm1AgJf6WMdrU7YgSbJhEbsEEJg=;
        b=Zt0LLrxjPKgPepUASLpYwPLS+5ohZyz+N/gET/MAG/uRSy1u/qT3V4bBWurBrl2Zw4
         nlWMbkJCy2dkBjrTrkmsyn3HdDNi2TCLtNODDRDkLnLiemC41qWjqSyFpjwv6Ho95e3l
         WTwUeK9n4qXbGsVPXzmYQuXZs/yeUB3jX/Nuw4Ly3zFWPGkLhVA1GmmLHxXBkzrinjsq
         wckmfSyzDUtZ/KzKxLbNWLAny/x9FcX5UVRt4Lut1HmSvz8T8HwX5yPwfk7dskbHVp7Q
         i5ecwTZysfimhNHXDxyJ0TWkxvBkK5erCeke+jO0ywYYRJJxApvW4uU0POfNaacS9ydb
         zlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789891251; x=1790496051;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t8CTYyRXY2aAud9otm1AgJf6WMdrU7YgSbJhEbsEEJg=;
        b=nlyaRNEEIyeoP2ntSYnteOcp6E0Z+2SFf5e38sCRNsmUjHGFD5O6wUBPhvSsbanhdb
         hWg9Nv8Gcm8vvj/mHF9ZBXhXqU76ZEkx6ZYAhXd8mDseMa5QfWZNYgKp6RD/e2nAOMcw
         IRcSMIqwjUhr1J6a480OLpb3M1x6ylDRpcCnXk5qxBalf1WiXg3CkwN+UrAeQDz5wMFU
         wjESySacN9TIb2VLdP8DzzPu8a1Nb6irq86fFUl2p5Ua0AUosRzWicsxg6+ZBaAbcMpW
         YfSoeH3T+I1a21ot2+gKSuVFOD/DfplYMptxeXQ7LA+YalgMrot8A3VAMd/i2OOrEfrH
         iLxA==
X-Forwarded-Encrypted: i=1; AKwUvBzYlwnMzNCvFgtv6ABnkdOTYPvWGbLsi8+NviU1thtNXC20ssBATr+VCFc24yEGfW3cG0cd1A==@lists.linux.dev
X-Gm-Message-State: AFuF++nTcb4/hmSq5tyEoviP0YqKz/QCAo4eoE088IZ1wydw1l8HALQV
	9uYfCbtqczVfCMPXkhS+HdgN3C4qR8xc0KpZGvyX9biiEhNJVv7flK8/
X-Gm-Gg: AYBFou08/EK++VBTzRHt66ga1pzoEX+RyFp9P97Eo8qd9T3PEmMOFZVEhLIuoztOhix
	dYfZBqBDZfU168+ICIIV5W9INBWn4BtyGkCpstbCW6JVrWtRfjIxLcSazNxNqY1lhi9ZnNXTFao
	JC70JTSu1cHHSGE0DhDJ9J2Xum1FEwk0TP21O6iwlAB9CEt8Kc8XxJzIvXTeuP2oC+v7be7/SoZ
	nWVu+OECxtlmTRalU/lhiQNg0uhDvM29ehwk+T7c74APrQvjt8twFj8Df6D6vjDGdck95FnW4vJ
	052lljyXLWn260Jry+213xPuUKEbp+KnWp5QlP3gw1eokxnqVWJ4EQPR5YfJGScdWeSMIZ8vuhs
	uH18TqVFp65Wjp2gMpCUpDNTZlmJ7sk39F8jJI+xgvRUK24q2GAlQYUyEK+ykmFkn/x6aDRmlxj
	P41EXVDcmOhfDvn7nJUsXrc/uSs+pylYJy46Z2ETOuHWKXpNBgAJaAebYWGY+aAC5S4T03wyVNm
	7hXSg==
X-Received: by 2002:a17:90a:fc4b:b0:3a0:2900:f55e with SMTP id 98e67ed59e1d1-3a02900f85dmr2402815a91.29.1789891251509;
        Sun, 20 Sep 2026 01:00:51 -0700 (PDT)
Received: from [10.125.112.20] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cae997csm7876986a91.11.2026.09.20.01.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 01:00:49 -0700 (PDT)
Message-ID: <32b00102-0961-49e3-b780-74d6db182809@gmail.com>
Date: Sun, 20 Sep 2026 16:00:30 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/10] memblock: introduce MEMBLOCK_NODUMP flag
To: Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, m.szyprowski@samsung.com,
 mark.rutland@arm.com, kernel@xen0n.name, alex@ghiti.fr, hpa@zytor.com,
 ruirui.yang@linux.dev, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 iommu@lists.linux.dev
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-7-chenwandun1@gmail.com> <aqzxavL91icLw-Xv@fedora>
 <aq41nFRPtRWTQ7cK@kernel.org> <aq9UGXeqmCfuPHdD@fedora>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <aq9UGXeqmCfuPHdD@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/20/26 11:33, Baoquan He wrote:
> On 09/19/26 at 10:11am, Mike Rapoport wrote:
>> On Fri, Sep 18, 2026 at 04:08:10PM +0800, Baoquan He wrote:
>>> On 09/02/26 at 03:31pm, Wandun Chen wrote:
> ...snip... 
>>>> +/**
>>>> + * memblock_mark_nodump - Mark a memory region with flag MEMBLOCK_NODUMP.
>>>> + * @base: the base phys addr of the region
>>>> + * @size: the size of the region
>>>> + *
>>>> + * Mark the region as not to be included in crash dumps.
>>>> + *
>>>> + * Return: 0 on success, -errno on failure.
>>>> + */
>>>> +int __init_memblock memblock_mark_nodump(phys_addr_t base, phys_addr_t size)
>>>       ~~~~~~~~~~~~~~^
>>> Is it impossible to use at runtime even thought it claims to be generic?
>>
>> This should only happen at boot.
>>
>> Allowing modifications of memblock properties in runtime is a can of worms
>> I don't want to open.
> 
> Thank you. This is why I said this can't be claimed as a generic way to
> mark memory region as no dump. The generic way I'd like to see is
> at any time of system we can mark any unwanted memory region as no dump.
> And it won't impact the behaviour of the current system.

Thanks Mike for the explanation and Baoquan for the suggestion.
I'll drop the "generic" related description in the next version.


Baoquan, by the way, patch 2 is still awaiting review. It rewrites
the riscv side of the code that patch 3 (which you've acked) then
folds into the weak defaults, if you could take a look at it too,
that would be very helpful.

Best regards,
Wandun


> 
>>  
>>>> +{
>>>> +	return memblock_setclr_flag(&memblock.memory, base, size, 1,
>>>> +				    MEMBLOCK_NODUMP);
>>>> +}
>>>> +
>>>>  static bool should_skip_region(struct memblock_type *type,
>>>>  			       struct memblock_region *m,
>>>>  			       int nid, int flags)
>>>> @@ -2887,6 +2902,7 @@ static const char * const flagname[] = {
>>>>  	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
>>>>  	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
>>>>  	[ilog2(MEMBLOCK_RSRV_HUGETLB)] = "RSV_HUGETLB",
>>>> +	[ilog2(MEMBLOCK_NODUMP)] = "NODUMP",
>>>>  };
>>>>  
>>>>  static int memblock_debug_show(struct seq_file *m, void *private)
>>>> -- 
>>>> 2.43.0
>>>>
>>
>> -- 
>> Sincerely yours,
>> Mike.

