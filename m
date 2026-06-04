Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC2627FD4F
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537744; cv=none; b=Y1hhGMuSjW0C09IpQ9wXW5YRjbtgutgN3Z/n1SSQY6iXH/YWPM0+QUZVF7AB9YrCEbNzp40K4bSxiAu0hS5bqBrAFh0V8yNYdcA3MP3NQY2iAqfJbzsPbDD7voyg5dEe+USavZiLq0NiCVXMuBS0A2nisJ9dVpStAQtuo2IL5eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537744; c=relaxed/simple;
	bh=gamBR4h2rf1Imsoj8RobEGb1Bt2afo71z/VsoMkVocw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHsvBVzbIRzUZrQijVe/WVDxL0/QbCPTMfXZj7RWPPD0RNvfh8TL2uY/DlMPk/zhcTK7NAIoyNjCK2XcdYnb40hvA0pUOYv9toR6Xz5IFANT60ihLFOrsnMnoSfzhQwAhxc/+5SREG+RP+RnUlIbNmkQE8aYcYZ6XPhFLVhFTZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCEWfmnx; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCEWfmnx"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-842307473b5so113577b3a.2
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 18:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780537741; x=1781142541; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R9vTs/JHnHpc6BmzGsq91wlnVhg5cqc1lx/XeBVEZpQ=;
        b=YCEWfmnxtoldt9WwZZWFU1mk86ArLHOugPaqXDiVYMY2tjt0FPHlqVjc4ZO81mOikw
         TzqCNT5mpbx/0SVunQcY/luC58X8pQAXh84pVMnyvVd58nc8JpSMNKWZAbyRdQWj+4ho
         f792gSgBXt9sIz0RH4w1mFUPpCJ/xmNLoklLassuJiLGzJc5i9uuYb8JtotSfDQob1VT
         OVpJOMPw8FqD8aJDuS0vNSdLdp2aNx/hdqUGXSeczY5iEpiUAzk9pI/wXGfucSXFutHY
         Ke7PulJUnIrnHhY9LV/sEaRN044xrKDEs+JdOB76jOZjR2htROQFKuC+WxThfhhMHtR5
         sfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780537741; x=1781142541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R9vTs/JHnHpc6BmzGsq91wlnVhg5cqc1lx/XeBVEZpQ=;
        b=sFJrz1BWgVkJSN+XCjHv/96XqSeMlZmFN/gGuqMT8/EsIuQa1EMsbMxzgpln9vefP9
         QeCzm+QobSzS8Bp65F2d+pacYME8cHfFRVPluhux5pohHYs9dR6p2rppm7QaAMTWXnxV
         vU2HiZawE+sBbHLM8zYXR5CugFhEsgVHBVAzHk1v8Io9ouspWS89twbCCexZKFl3iQ62
         tPVwvyqcN+qWBiwRTyrh/tOiS4rZuVppjnfEF84x8A2ymXe6nNIFRJMv+3psoLKIhNAt
         B//0GldbWlLHHgBG4DLp5EaFxquUEhHfxzL74xTmPj+hiZnMNvH7HRmWK5HSlUILMidd
         CFIg==
X-Forwarded-Encrypted: i=1; AFNElJ8voabAQpKnZ0y+dmLwZwIyA/CtbV6+g7rv/gsXAcFjCpaHpiFHOEg1LxEXZGOtkCotVUy3sg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVUfQHR39S7y3RGPt1DZCDNQce5sq2EsbzndskLB/7BNUuGmeO
	7bKnc0VydJXyS9xeOa8pqOJt5NVXFB9ySZiDpzcxa/6HdpVw2f8i2wEV
X-Gm-Gg: Acq92OFfye8fVxtgQTQhxIT8xOfC3Egx/f+ymOoW+NgcKLzsr+4fT0f3+iCeAT+OKhp
	Tt46qVp8EswjnC1zR9L0p1FDXYCICV8eVhTuiwBG8BKT1p7uhlFOeaaXWJPq1BGyjbTtSItw6Nh
	kKgNVCAWKRz9NDSeWbQN00fyiUTCHlcYxm16LcnL+tZYlNRUSq4/0XAid2vmr4Y0agsySmCYl6V
	NumQOG2LNXv8ZjJI2SHmZ5F33Ec4eh2kLNpAzcLf+/B6qDwNGuZWRWGpXnPexru66AegA4J8Dq4
	VrLBH4cgijUWBkAtXRG1PDh/UQA6CDf8J7e9ByjjjAYyoSsI5ifLxUCMDsbo8kMeoN54dbtcqeJ
	mNTmx3W2mW1gpp62q80I4hs3u7u4gIZtNsZIVlgquUBhDXKfQn7um/JXYx936L8xkNJN0Faw0B1
	ksHu3/LuxRFcITl9ZakdyxEDAMxiZd4BbNCPOBzVQH8g==
X-Received: by 2002:aa7:8882:0:b0:842:38d2:a35f with SMTP id d2e1a72fcca58-84284e8dc75mr6032800b3a.31.1780537741272;
        Wed, 03 Jun 2026 18:49:01 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282350f8csm4439444b3a.14.2026.06.03.18.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 18:49:00 -0700 (PDT)
Message-ID: <8e088395-c22d-4bc8-9e58-84235af1e56b@gmail.com>
Date: Thu, 4 Jun 2026 09:48:44 +0800
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
 <79932afc-2e91-4a54-aff9-f550be784c36@gmail.com>
 <CAL_JsqJOC1ko1Len3Dyc5SNKrHmhQn9uiDAkFfVbYa2wAfFUTg@mail.gmail.com>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <CAL_JsqJOC1ko1Len3Dyc5SNKrHmhQn9uiDAkFfVbYa2wAfFUTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/4/26 01:44, Rob Herring wrote:
> On Wed, Jun 3, 2026 at 1:44 AM Wandun <chenwandun1@gmail.com> wrote:
>>
>>
>> On 6/3/26 00:24, Rob Herring wrote:
>>> On Wed, May 27, 2026 at 11:29:09AM +0800, Wandun Chen wrote:
>>>> From: Wandun Chen <chenwandun@lixiang.com>
>>>>
>>>> The global pointer 'reserved_mem' continues to reference the
>>>> reserved_mem_array which lives in __initdata if
>>>> alloc_reserved_mem_array() fails. of_reserved_mem_lookup() is
>>>> exported for post-init use, that would dereference freed memory
>>>> and trigger a use-after-free.
>>>>
>>>> So reset reserved_mem_count to 0 when alloc_reserved_mem_array()
>>>> fails.
>>>>
>>>> Fixes: 00c9a452a235 ("of: reserved_mem: Add code to dynamically allocate reserved_mem array")
>>> Fixes should come first in a series.
>> Understood, will do in future submissions.
>>>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>>>> ---
>>>>    drivers/of/of_reserved_mem.c | 20 ++++++++++++++------
>>>>    1 file changed, 14 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
>>>> index 313cbc57aa45..6d479381ff1f 100644
>>>> --- a/drivers/of/of_reserved_mem.c
>>>> +++ b/drivers/of/of_reserved_mem.c
>>>> @@ -69,29 +69,31 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
>>>>     * the initial static array is copied over to this new array and
>>>>     * the new array is used from this point on.
>>>>     */
>>>> -static void __init alloc_reserved_mem_array(void)
>>>> +static bool __init alloc_reserved_mem_array(void)
>>>>    {
>>>>       struct reserved_mem *new_array;
>>>>       size_t alloc_size, copy_size, memset_size;
>>>>
>>>> +    if (!total_reserved_mem_cnt)
>>>> +            return true;
>>>> +
>>>>       alloc_size = array_size(total_reserved_mem_cnt, sizeof(*new_array));
>>>>       if (alloc_size == SIZE_MAX) {
>>>>               pr_err("Failed to allocate memory for reserved_mem array with err: %d", -EOVERFLOW);
>>>> -            return;
>>>> +            goto fail;
>>>>       }
>>>>
>>>>       new_array = memblock_alloc(alloc_size, SMP_CACHE_BYTES);
>>>>       if (!new_array) {
>>>>               pr_err("Failed to allocate memory for reserved_mem array with err: %d", -ENOMEM);
>>>> -            return;
>>>> +            goto fail;
>>>>       }
>>>>
>>>>       copy_size = array_size(reserved_mem_count, sizeof(*new_array));
>>>>       if (copy_size == SIZE_MAX) {
>>>>               memblock_free(new_array, alloc_size);
>>>> -            total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
>>>>               pr_err("Failed to allocate memory for reserved_mem array with err: %d", -EOVERFLOW);
>>> These prints could be moved to 'fail'. Perhaps instead of just printing
>>> an error value, you can return the error value instead of boolean.
>> Will do, consolidating pr_err() under 'fail' and changing the return type
>> to int.
>>> If you respin just this patch, I can pick it up for 7.2.
>> Before I respin, I'd like to flag a dependency:
>> patch 05/07 in this series build on the signature change introduced by this
>> patch ("the void -> bool return type change of alloc_reserved_mem_array()")
>>
>> Could you let me know which of the following you'd prefer:
>> a) Take patch 03 alone via your tree as you suggested, after it lands, I'll
>>      respin the remaining patches of this series.
> I would go with this option. AIUI, this series isn't going to land in
> 7.2, so ultimately you will rebase on v7.2-rc1 which will have the
> fix.
OK, will send v4.

Best regards,
Wandun
>
>> b) Keep patch 03 in the v4 respin of the full series, reordered to the front
>>      per your earlier comment.
>
> Rob

