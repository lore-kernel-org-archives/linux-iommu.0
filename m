Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655109;
	b=qDpjj24RKCb1dMor3OaTRHLLfo2N8tKvto7ODZVyYjsQaV2WBjHgWUEn+trjooTFsbc/
	 IC2GTGL7P6x8B1vW+gsy4TPWO0bpwJuCBnkc/klbF5R0qbNB5nADCOanBFkTkZlCc07v2
	 9Y5YxV/S5X0SWtR5Gvzi74BzTyIRP4/3GIkC61Btxktw962BHbJ4ZrdWT4tYC5R/gsTES
	 kUmqoE5mHyNDf64NLguPPbRUckPvB0NSdFQuL1bhkoyVJrAq9zFdPKzG/nTgyXslT1KGM
	 CBABWO6fhli/a0k8rECHqawEDnshwYmw+IaluCoYrzVp/KmGvDIX5cMRBwxaz0lHDzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655109;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HDXHwat4zLpbZennBEg7uZauJYVMECCPqpPno/TLnRE=;
	b=4frQDXLB8EfUTUoFU0gFbbQvuGp59WJazW+OmdObyG6eH1P3u9Kd+teCOjE8pzH0i4ah
	 HyUATxtvU62Lan+6XE/IflStfLLxQ9qKDp2g5dL47M2hAxfnkqGugUJo4le5nZ2KydW8I
	 vxboCYw1afmfs/c3s8SXjHXfVPfOeSWdacO8Kzvkzc5BUdUrBL7e+WnQbhrr1/A87u4/S
	 baY16bC63LegZVf42riK5eKS6HBsDaGt+rJknMyleLGcrYriM4KncYnoXcz3dfnD5ndMT
	 RXIWvEFqxUzaMAD5LAdvubIPlOTBATp4p60KmhF61REsnZYxBD0ksfimyxe8NTliYhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rk25qGEr;
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97B5606A31E
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 07:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A97B5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rk25qGEr
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964e7720afso933626a91.1
        for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 00:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792655108; x=1793259908; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HDXHwat4zLpbZennBEg7uZauJYVMECCPqpPno/TLnRE=;
        b=rk25qGEr/mTVyStsgBtqsLniSoLzdvMNydpDTzZOO+QRVoQvy1Vc9UbICzdhK5FlOK
         RcHVNLlP6F/hdXPassNhSlfjycQ/3YGhWoRHpQLCyKpdQ6ET1eQjvi6KaGFps6KITwSr
         4EQikr03yMhv84uGDBLpOb+PwXbplBEuEC2EalWoUmYJN2KBxtgizBtQlSZQ+r823Av9
         2iysbajYAOY4NaIM7PMz+xm4uJ52+9s0kjs4OLIaZESCn9w5SRwmDEcN6q0QhOspzt1C
         guTvA1mqt08cwTI3lbjEdckDsBCnYbjeN5rUAK3NTNizCmSv/kjzPPmXnl4i+2uMZjX6
         HWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792655108; x=1793259908;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HDXHwat4zLpbZennBEg7uZauJYVMECCPqpPno/TLnRE=;
        b=WLC8WnEes1UelLGgQHhdLymDSVXhX1/oC5bO41AZEeSpdHQnq0xws8KfMV0rJStght
         Af4jxwZyQAzacg1cJfvwWP08+3r7X9KdynzeBChYCzMGLb5bb8EEbrmtYNUgTlPM0UqS
         6rISdt2DB14J3l0MnWCg4hzSHPfSeAT+QaXnifIDa908exNtX/2s8YDnsCGl2a9LJQ2l
         XjBoqOl5axb1H/W2p28HFHrH4Fqpx/ZY7s/K+HBcIAT3UAZKb4fJQJb7RPKJsem5ibk/
         +7p/fqJQvOMNbUYe1G9WIZqD1OJ3fi8gLE+MgGcIaRIldwaH7+KnqxDtd6BZlXHGMpQo
         e76w==
X-Forwarded-Encrypted: i=1; AKwUvBx2YTMptqWR6omAY9HiidTq1kqoJ4yWlOPEPHNkcRdpROjoK6VLzigHPSI72urup53J9luflQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKKWF60Zm74+VO4oqPt5SPi9InUvyoxqRYTwkDWcq55IPYFZPEW
	4jMcy6iloOaPOBEuwQxWh52FEY12v6w/G7PPj4id6T35p8aw3Gs/heLO
X-Gm-Gg: AYBFou0Rr3U+xR3uLy4aGse2oqtQ0LINbAuNXSwZvNQj9yDNXO5rXy63gtkx/A7nQTO
	eHF+iT4WYbFoUPc5TCWg86lE6igWNIRcnQBPff8P04vPro9Do7a3kedOJqTWuW4iSBIxJ/NpZKP
	aksCCp+FA+IIDH9iyXu5fH1cQ/S3NkzA51P7Ac4lMaZRYpAqWdg9QAibYE94ihlzP0kz7k0Ll1d
	QJ5WemENCMKfyBp3wOyTvdmvfmi4DOhU9PMS+3/fi5saSJIwaiCH5jhPGuTrBzmO+dHjWbImKa6
	fYbey3QG2R6fOdflNBA4eCOs/3SYaZUl//oviliqWjHex87biYXj9BFTWEBNaVe4WsSyzK7ZQIY
	TpQHRYtqqEGyBKEsZsMyYK7cC0CI/PWDakFPAse7GRl0hV0h/j2T6aAWSI8o0rykTLNPT/DQ47S
	XnVHHgouxBSmXQ+2N65fZKv+mOGkewmaQw2a77xi6oxu8rsbqcOLHN0AZunCsJRICtSKVdGfVDB
	CvFFluLUT/LymBS23KHenyvim/74J2fYnGRPqO2lxopHQxbZmJor+/1iacR6u4=
X-Received: by 2002:a17:90b:5870:b0:3ab:5758:3766 with SMTP id 98e67ed59e1d1-3ad8707700dmr3724932a91.51.1792655107849;
        Thu, 22 Oct 2026 00:45:07 -0700 (PDT)
Received: from [10.125.112.22] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada49366fdsm2945920a91.14.2026.10.22.00.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 00:45:06 -0700 (PDT)
Message-ID: <098ff899-81b9-4ccc-a143-1e324446258f@gmail.com>
Date: Thu, 22 Oct 2026 15:44:48 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/8] crash_core: serialize crash header preparation
 against hotplug
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
 chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 kexec@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev,
 robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org,
 m.szyprowski@samsung.com
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
 <20261021083011.2170525-4-chenwandun1@gmail.com>
 <12e4e687-1ff0-41b2-bdf8-7f48b29e1f2f@huawei.com>
 <a1665f9e-3116-47bc-974e-98dce408fa37@gmail.com>
 <31d63208-3ef2-420f-a0c2-d9d6d49c5e21@huawei.com>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <31d63208-3ef2-420f-a0c2-d9d6d49c5e21@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/22/26 10:00, Jinjie Ruan wrote:
> 
> 
> 在 2026/10/21 17:48, Wandun 写道:
>>
>>
>> On 10/21/26 17:13, Jinjie Ruan wrote:
>>>
>>>
>>> 在 2026/10/21 16:30, Wandun Chen 写道:
>>>> From: Wandun Chen <chenwandun@lixiang.com>
>>>>
>>>> crash_prepare_headers() counts memory ranges before populating the
>>>> allocated crash_mem array. The weak implementation used by ARM64,
>>>> RISC-V and LoongArch walks memblock.memory, while x86 performs the same
>>>> two-pass operation over system RAM resources. Concurrent memory hotplug
>>>> can change range source between the two walks and make the populate
>>>> pass overflow cmem->ranges.
>>>>
>>>> Take device_hotplug_lock when preparing crash headers during
>>>> kexec_file_load(). The x86/riscv memory hotplug path already takes
>>>> device_hotplug_lock, so call __crash_prepare_headers() directly
>>>> to avoid recursive locking.
>>>>
>>>> Sashiko reported this issue in [1].
>>>>
>>>> Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
>>>> Fixes: 1bcca8620a91 ("LoongArch: Add crash dump support for kexec_file")
>>>> Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
>>>> Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system call")
>>>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>>>> Link: https://sashiko.dev/#/message/20260806101002.1F84E1F000E9@smtp.kernel.org [1]
>>>> Acked-by: Baoquan He <baoquan.he@linux.dev>
>>>> ---
>>>>  arch/riscv/kernel/crash.c  |  2 +-
>>>>  arch/x86/kernel/crash.c    |  2 +-
>>>>  include/linux/crash_core.h |  2 ++
>>>>  kernel/crash_core.c        | 17 +++++++++++++++--
>>>>  4 files changed, 19 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/kernel/crash.c b/arch/riscv/kernel/crash.c
>>>> index fe5a4b306aae..ac8df2edf2a7 100644
>>>> --- a/arch/riscv/kernel/crash.c
>>>> +++ b/arch/riscv/kernel/crash.c
>>>> @@ -70,7 +70,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>>>>  	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>>>>  	 * memory resources.
>>>>  	 */
>>>> -	if (crash_prepare_headers(true, &elfbuf, &elfsz, NULL)) {
>>>> +	if (__crash_prepare_headers(true, &elfbuf, &elfsz, NULL)) {
>>>>  		pr_err("unable to create new elfcorehdr");
>>>>  		goto out;
>>>>  	}
>>>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>>>> index e6f23933a6df..bef008a0cb22 100644
>>>> --- a/arch/x86/kernel/crash.c
>>>> +++ b/arch/x86/kernel/crash.c
>>>> @@ -465,7 +465,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>>>>  	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>>>>  	 * memory resources.
>>>>  	 */
>>>> -	if (crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz, NULL)) {
>>>> +	if (__crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz, NULL)) {
>>>>  		pr_err("unable to create new elfcorehdr");
>>>>  		goto out;
>>>>  	}
>>>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>>>> index bc087124cd78..28e7a81cf263 100644
>>>> --- a/include/linux/crash_core.h
>>>> +++ b/include/linux/crash_core.h
>>>> @@ -61,6 +61,8 @@ extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_ma
>>>>  				       void **addr, unsigned long *sz);
>>>>  extern int crash_prepare_headers(int need_kernel_map, void **addr,
>>>>  				 unsigned long *sz, unsigned long *nr_mem_ranges);
>>>> +int __crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>>>> +			    unsigned long *nr_mem_ranges);
>>>>  extern int crash_exclude_core_ranges(struct crash_mem **cmem);
>>>>  
>>>>  struct kimage;
>>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>>> index faa0f22dbb41..8a861a946e26 100644
>>>> --- a/kernel/crash_core.c
>>>> +++ b/kernel/crash_core.c
>>>> @@ -16,6 +16,7 @@
>>>>  #include <linux/mm.h>
>>>>  #include <linux/cpuhotplug.h>
>>>>  #include <linux/memblock.h>
>>>> +#include <linux/device.h>
>>>>  #include <linux/kmemleak.h>
>>>>  #include <linux/crash_core.h>
>>>>  #include <linux/reboot.h>
>>>> @@ -344,8 +345,8 @@ int crash_exclude_core_ranges(struct crash_mem **cmem)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>>>> -			  unsigned long *nr_mem_ranges)
>>>> +int __crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>>>> +			    unsigned long *nr_mem_ranges)
>>>>  {
>>>>  	unsigned int max_nr_ranges;
>>>>  	struct crash_mem *cmem;
>>>> @@ -382,6 +383,18 @@ int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>>>>  	return ret;
>>>>  }
>>>>  
>>>> +int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>>>> +			  unsigned long *nr_mem_ranges)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	lock_device_hotplug();
>>>> +	ret = __crash_prepare_headers(need_kernel_map, addr, sz, nr_mem_ranges);
>>>> +	unlock_device_hotplug();
>>>
>>> I think this patch conflicts with my changes and would also conflict
>>> with the implementation of arm64 crash hotplug.
>>>
>>> https://lore.kernel.org/all/20260921090450.807575-15-ruanjinjie@huawei.com/
>>>
>> Have these patches already been merged? My current work is based on the latest
>> linux-next. If they have already been merged into the maintainer's branch,
>> please let me know, I will update my tree and rebase/re-adapt my changes accordingly.
>>
>>
>> Also, regarding the changes in kernel/crash_core.c: it looks like we modified
>> the same spot, the change is not wrong, is that right?
> 
> Hi Wandun,
> 
> However, I think someone should have informed me in advance; otherwise,
> doing duplicate fix work is pointless.
> 
> I see that part of your patch series modifies code I previously changed,
> but I was not CC'd.

Hi Jinjie,

Sorry for not CC'ing you. I keep the per-patch Cc lists short because
large recipient sets have caused my sends to be cut off midway before,
(I'm still trying to track down exactly where the problem is) you should
have been on the list that's my miss. You'll be on the Cc of every future
version.
> 
>>
>>> arm64 crash hotplug:
>>> https://lore.kernel.org/all/20260918100442.3841135-18-ruanjinjie@huawei.com/
>>
>> In addition, if arm64 gains crash hotplug support, the code there would indeed
>> need to be modified (to avoid a deadlock). As of now, arm64 crash hotplug
>> support has not been merged yet either, has it? I just want to make sure I
>> haven't missed anything.
> 
> Yes, you are right. If your patch series will be merged soon, I will
> develop based on it.

Also thanks for your reminder, otherwise I might later overlook the case
where arm64 has already gained crash hotplug support, and introduce bugs
as a result.


Best regards,
Wandun>
>>
>>>
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>>  /**
>>>>   * crash_exclude_mem_range - exclude a mem range for existing ranges
>>>>   * @mem: mem->range contains an array of ranges sorted in ascending order
>>>
>>
> 

