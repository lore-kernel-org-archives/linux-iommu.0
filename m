Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F44A377558
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469069; cv=none; b=Qb8lJKNn8LmtBhwbfqKecNaNrFc43wyvKHICJRsENdupfEUvwC0xYbk7EyBqn7uj0K0DMDm1xkCi8AEBCp3XRW2uoQNE1IcyDfPgkYZOR+1RECQK+ao5ZLN1T2xZpRWJahC92hz2I1AauWORf8DGNEM9Zx8/UHa/LanlQDuV8oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469069; c=relaxed/simple;
	bh=F5zhvt/iAlg6umNegPP2+kFF2Mb4DKEuLqC3mOxwjAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LffdfKG48j8oyUonFjlD/8CnLffjpPtdHRBOhXYY1AL5hsVAGiYPBfSLNn00qmN5vsCe/OLMXYWTICkifs+Buo3P8oRyXhfWXZrkPU0VGbr1AAfM6vnmKffds+0/Ic7ODpGT8BgPPxPVp2zB8C/F70qJi5kWfM6k3VTpbTMRP90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNFC5mWY; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNFC5mWY"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2bf3781ca51so40562735ad.0
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 23:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780469066; x=1781073866; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sd7sOkllNO4XLGxbX/2aYhqo9JXcF7DuVUpDO/tIkqk=;
        b=JNFC5mWYdYDO8vwIDHGJpNBe6zYS3hEj6YcFgH2+yxJ81Kya47VTysin7tD6n00gBj
         slf6024x9lPRNBHtbJQtRYQQamzXT/ziwbQFyfinG9ZyQxC5kcN9nzpB/rB1mw57Izaq
         AtWObw44lC2BKBlEhBSRtl6CbNDeC95qFlkjf+0RdOsnEx+9JHV43zVGlOMg14kzkBXQ
         t+M2ZNdhfs7bruNWo/eHR8hPnLNLye0KfBShmHeQqY9AJkK/OaChA7jibSEl20dJbq1L
         Vxuns/Q7aive9KL7oh4Ypa1oqumxamTGwdPadga2XjSP5V112gRHvOgeWoRIaM8uobj3
         Td1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780469066; x=1781073866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sd7sOkllNO4XLGxbX/2aYhqo9JXcF7DuVUpDO/tIkqk=;
        b=k+FD6D4EbdNZVtZMTBg8QGoIvQNa15CQO65tkRgMT94x7vYSmIpIbUp0H3mHx+g1fT
         g1gcKW/Lde/bxt5XSDWuOCXsC0VeIiinlEvogEHH2cGyGUoqv8Jq35NXMoWXgj7XogwI
         p1X2ry1MDAWb7JxdNiLB5OwE40oHxbuCvLS2FZUK5IRqcqK0zMDUyFjqzDNATIr4hqx1
         AtwtoEnFZYz+93ZWIeaniEc6WzeDDk28eE33lyutrKjx7AMiushkRAf872MlV77Z9RZc
         BUBUGwYmGjuzAijQVMgARQ+6ThtmYKjiPGwfJKZJZjVjXHNYO2vk7BrEPbXUh6b6Kwu1
         lEEg==
X-Forwarded-Encrypted: i=1; AFNElJ9gs7IiBe6OXQ0DnNFbQNq0Bl8AdWHivuqCYuYCFEvWBK7ImlvwxqBhcjFb052kaXTyBGLO6w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw62I0a1RWhdgBuSVk5kLJshz1n8LJbY9AbU8qpGdHZzeoykGk8
	gmnByszwED/uO8TEB/GoOSCRcLuovkujFsA+/AlTSBMg3Rr/PVvj4hCF
X-Gm-Gg: Acq92OH8lLI72nFDNLD7Nq6Bw18dn9Lhwh7fq9VYQ7wQKmvrfWszWS218Ub8oHBHuhA
	yVc535o9fnRT2mh83oLds86gdSec35rWEjG6shFLPUWjYLbto0PNE3QSqc4hfmSFuDMgM68zy45
	wRDIsJzwpB3N5dmK1XkKqu4t38HCKZIIOr1qmAKXFrnbWiZrmE8F+5gKmnDpoYFxRH3I51mUXXR
	RvbN94LKJ0CSaS9XBzv1Gau9/K6fMaRXFoVnucvivYVxiaeqdMrjoKRYRN7+wSlG/lDBQ46uQCl
	w4ZbqkCBxQRy8M1B7BGf0wu1enI2QblibYwHhWx89c/2P8QRbGcT2Pi+dl32hCrsjfm5+Axph7o
	/QPbWBx7oWcDvlXRoJLjLp55L20EB9KtyVaXcyURRHlGLtXfC4t4541hxgEiRif600bMqtEbcV7
	8QVQXvHDqkHcQXjIt3P5KZkrOxcKvfKmD2/Rt4S4yACQ==
X-Received: by 2002:a17:903:298c:b0:2c1:4d9:c8db with SMTP id d9443c01a7336-2c1644dbfbamr22648805ad.37.1780469065484;
        Tue, 02 Jun 2026 23:44:25 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629cfb4sm13674395ad.59.2026.06.02.23.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 23:44:24 -0700 (PDT)
Message-ID: <79932afc-2e91-4a54-aff9-f550be784c36@gmail.com>
Date: Wed, 3 Jun 2026 14:44:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] of: reserved_mem: avoid post-init UAF when
 alloc_reserved_mem_array() fails
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org,
 iommu@lists.linux.dev, zhaomeijing@lixiang.com, catalin.marinas@arm.com,
 will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
 rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
 ruirui.yang@linux.dev, m.szyprowski@samsung.com, robin.murphy@arm.com,
 quic_obabatun@quicinc.com
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
 <20260527032917.3385849-4-chenwandun1@gmail.com>
 <20260602162450.GA442759-robh@kernel.org>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <20260602162450.GA442759-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/3/26 00:24, Rob Herring wrote:
> On Wed, May 27, 2026 at 11:29:09AM +0800, Wandun Chen wrote:
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
>> The global pointer 'reserved_mem' continues to reference the
>> reserved_mem_array which lives in __initdata if
>> alloc_reserved_mem_array() fails. of_reserved_mem_lookup() is
>> exported for post-init use, that would dereference freed memory
>> and trigger a use-after-free.
>>
>> So reset reserved_mem_count to 0 when alloc_reserved_mem_array()
>> fails.
>>
>> Fixes: 00c9a452a235 ("of: reserved_mem: Add code to dynamically allocate reserved_mem array")
> Fixes should come first in a series.
Understood, will do in future submissions.
>
>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>> ---
>>   drivers/of/of_reserved_mem.c | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
>> index 313cbc57aa45..6d479381ff1f 100644
>> --- a/drivers/of/of_reserved_mem.c
>> +++ b/drivers/of/of_reserved_mem.c
>> @@ -69,29 +69,31 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
>>    * the initial static array is copied over to this new array and
>>    * the new array is used from this point on.
>>    */
>> -static void __init alloc_reserved_mem_array(void)
>> +static bool __init alloc_reserved_mem_array(void)
>>   {
>>   	struct reserved_mem *new_array;
>>   	size_t alloc_size, copy_size, memset_size;
>>   
>> +	if (!total_reserved_mem_cnt)
>> +		return true;
>> +
>>   	alloc_size = array_size(total_reserved_mem_cnt, sizeof(*new_array));
>>   	if (alloc_size == SIZE_MAX) {
>>   		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -EOVERFLOW);
>> -		return;
>> +		goto fail;
>>   	}
>>   
>>   	new_array = memblock_alloc(alloc_size, SMP_CACHE_BYTES);
>>   	if (!new_array) {
>>   		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -ENOMEM);
>> -		return;
>> +		goto fail;
>>   	}
>>   
>>   	copy_size = array_size(reserved_mem_count, sizeof(*new_array));
>>   	if (copy_size == SIZE_MAX) {
>>   		memblock_free(new_array, alloc_size);
>> -		total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
>>   		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -EOVERFLOW);
> These prints could be moved to 'fail'. Perhaps instead of just printing
> an error value, you can return the error value instead of boolean.
Will do, consolidating pr_err() under 'fail' and changing the return type
to int.
>
> If you respin just this patch, I can pick it up for 7.2.
Before I respin, I'd like to flag a dependency:
patch 05/07 in this series build on the signature change introduced by this
patch ("the void -> bool return type change of alloc_reserved_mem_array()")

Could you let me know which of the following you'd prefer:
a) Take patch 03 alone via your tree as you suggested, after it lands, I'll
    respin the remaining patches of this series.

b) Keep patch 03 in the v4 respin of the full series, reordered to the front
    per your earlier comment.

Best regards,
Wandun
>
> Rob

