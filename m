Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634468;
	b=ZN1mHr2kelDQtKf8mUGhn5BQjcOpvLxkPntmjuo8Btm76ebQwQnqhmFDeYDn6wWCFZFe
	 vOF66/gm39BD4dIJ2Si+MPsRTfwVOtVPW11J3eIVNqvycncpjG75O8FlUlV4a52kIndBE
	 I5MdPWlah6ml3o9L6hxSV654NUYmZg/uzpBqATESJOFLEfRwa5r5NlMTEmkZOgBl4RIlm
	 3EEG9KDKWJYwJV95VkKVLqEmzMoW5KgLqdKJAHqgHVJUL7WHuICQ5nYsMkAWqf3ECVmhF
	 UQ3uXa3FWmXU8xmuIxBVP2Lg/NuwUSTIgxUNXvooKoggasm87JkjXdabYyVT9Zcpwiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634468;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=loBgwUbLOnAAak0q9uGjIQKEwQ4a4j4TVh8P+20MXEg=;
	b=DE6i01kpyva77RiwPGjpl3KEpNF6ti9HSSH1TSVL6OgvlX3QvvKg4LfADzmodSx9LYlu
	 UsrzuDgHusezuGDmhJaERvNMZ0giYXWqNrTxDzKgk/nO+YWUBmKXNvDhQnjaLiRK4z8dP
	 5IufmpYh4gRPa/gpPIUDrou5noe7RgNSWjS2ep+hnBlFXi/95+9UzlHWfJEnVGGdAtZln
	 M3mSzr1JXrv+pvYEV0imBG/vtL+0dh0O8cqv2xMugboxW80KQOJ5JPzdCaof/z44sxKGT
	 b6vrkl7gHIDZxcgdUJt1rbp3aHHxPG7KXM0Xn/zTeYHzHxjwSPIxZVY0vqOYRGQbVLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Q+4ivRAN;
	arc=none smtp.remote-ip=113.46.200.225
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83687606A319;
	Thu, 22 Oct 2026 02:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83687606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Q+4ivRAN
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=loBgwUbLOnAAak0q9uGjIQKEwQ4a4j4TVh8P+20MXEg=;
	b=Q+4ivRANcgbbFZT+RuqnOmzfQRgx/LVfmZmJnBznw3aijzTfLqiAXmQFPpHZ4wQr5N/a+UnSk
	9QkwZygXGFsy6k2d0kw287r6cGCOPL2MK5xfPM3ACXVTWwq6O1+K0stbkZqxhIDb9q0MkhN+DRw
	UTGHL86gM/CDOpMtrrbG38U=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4j98WL5Vhfz1K972;
	Thu, 22 Oct 2026 10:00:46 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FEAB40563;
	Thu, 22 Oct 2026 10:00:51 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 22 Oct
 2026 10:00:49 +0800
Message-ID: <31d63208-3ef2-420f-a0c2-d9d6d49c5e21@huawei.com>
Date: Thu, 22 Oct 2026 10:00:49 +0800
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
To: Wandun <chenwandun1@gmail.com>, <robh@kernel.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <m.szyprowski@samsung.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<saravanak@kernel.org>, <akpm@linux-foundation.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<robin.murphy@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>, <iommu@lists.linux.dev>
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
 <20261021083011.2170525-4-chenwandun1@gmail.com>
 <12e4e687-1ff0-41b2-bdf8-7f48b29e1f2f@huawei.com>
 <a1665f9e-3116-47bc-974e-98dce408fa37@gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <a1665f9e-3116-47bc-974e-98dce408fa37@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/10/21 17:48, Wandun 写道:
> 
> 
> On 10/21/26 17:13, Jinjie Ruan wrote:
>>
>>
>> 在 2026/10/21 16:30, Wandun Chen 写道:
>>> From: Wandun Chen <chenwandun@lixiang.com>
>>>
>>> crash_prepare_headers() counts memory ranges before populating the
>>> allocated crash_mem array. The weak implementation used by ARM64,
>>> RISC-V and LoongArch walks memblock.memory, while x86 performs the same
>>> two-pass operation over system RAM resources. Concurrent memory hotplug
>>> can change range source between the two walks and make the populate
>>> pass overflow cmem->ranges.
>>>
>>> Take device_hotplug_lock when preparing crash headers during
>>> kexec_file_load(). The x86/riscv memory hotplug path already takes
>>> device_hotplug_lock, so call __crash_prepare_headers() directly
>>> to avoid recursive locking.
>>>
>>> Sashiko reported this issue in [1].
>>>
>>> Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
>>> Fixes: 1bcca8620a91 ("LoongArch: Add crash dump support for kexec_file")
>>> Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
>>> Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system call")
>>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>>> Link: https://sashiko.dev/#/message/20260806101002.1F84E1F000E9@smtp.kernel.org [1]
>>> Acked-by: Baoquan He <baoquan.he@linux.dev>
>>> ---
>>>  arch/riscv/kernel/crash.c  |  2 +-
>>>  arch/x86/kernel/crash.c    |  2 +-
>>>  include/linux/crash_core.h |  2 ++
>>>  kernel/crash_core.c        | 17 +++++++++++++++--
>>>  4 files changed, 19 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/riscv/kernel/crash.c b/arch/riscv/kernel/crash.c
>>> index fe5a4b306aae..ac8df2edf2a7 100644
>>> --- a/arch/riscv/kernel/crash.c
>>> +++ b/arch/riscv/kernel/crash.c
>>> @@ -70,7 +70,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>>>  	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>>>  	 * memory resources.
>>>  	 */
>>> -	if (crash_prepare_headers(true, &elfbuf, &elfsz, NULL)) {
>>> +	if (__crash_prepare_headers(true, &elfbuf, &elfsz, NULL)) {
>>>  		pr_err("unable to create new elfcorehdr");
>>>  		goto out;
>>>  	}
>>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>>> index e6f23933a6df..bef008a0cb22 100644
>>> --- a/arch/x86/kernel/crash.c
>>> +++ b/arch/x86/kernel/crash.c
>>> @@ -465,7 +465,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>>>  	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>>>  	 * memory resources.
>>>  	 */
>>> -	if (crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz, NULL)) {
>>> +	if (__crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz, NULL)) {
>>>  		pr_err("unable to create new elfcorehdr");
>>>  		goto out;
>>>  	}
>>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>>> index bc087124cd78..28e7a81cf263 100644
>>> --- a/include/linux/crash_core.h
>>> +++ b/include/linux/crash_core.h
>>> @@ -61,6 +61,8 @@ extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_ma
>>>  				       void **addr, unsigned long *sz);
>>>  extern int crash_prepare_headers(int need_kernel_map, void **addr,
>>>  				 unsigned long *sz, unsigned long *nr_mem_ranges);
>>> +int __crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>>> +			    unsigned long *nr_mem_ranges);
>>>  extern int crash_exclude_core_ranges(struct crash_mem **cmem);
>>>  
>>>  struct kimage;
>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>> index faa0f22dbb41..8a861a946e26 100644
>>> --- a/kernel/crash_core.c
>>> +++ b/kernel/crash_core.c
>>> @@ -16,6 +16,7 @@
>>>  #include <linux/mm.h>
>>>  #include <linux/cpuhotplug.h>
>>>  #include <linux/memblock.h>
>>> +#include <linux/device.h>
>>>  #include <linux/kmemleak.h>
>>>  #include <linux/crash_core.h>
>>>  #include <linux/reboot.h>
>>> @@ -344,8 +345,8 @@ int crash_exclude_core_ranges(struct crash_mem **cmem)
>>>  	return 0;
>>>  }
>>>  
>>> -int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>>> -			  unsigned long *nr_mem_ranges)
>>> +int __crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>>> +			    unsigned long *nr_mem_ranges)
>>>  {
>>>  	unsigned int max_nr_ranges;
>>>  	struct crash_mem *cmem;
>>> @@ -382,6 +383,18 @@ int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>>>  	return ret;
>>>  }
>>>  
>>> +int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>>> +			  unsigned long *nr_mem_ranges)
>>> +{
>>> +	int ret;
>>> +
>>> +	lock_device_hotplug();
>>> +	ret = __crash_prepare_headers(need_kernel_map, addr, sz, nr_mem_ranges);
>>> +	unlock_device_hotplug();
>>
>> I think this patch conflicts with my changes and would also conflict
>> with the implementation of arm64 crash hotplug.
>>
>> https://lore.kernel.org/all/20260921090450.807575-15-ruanjinjie@huawei.com/
>>
> Have these patches already been merged? My current work is based on the latest
> linux-next. If they have already been merged into the maintainer's branch,
> please let me know, I will update my tree and rebase/re-adapt my changes accordingly.
> 
> 
> Also, regarding the changes in kernel/crash_core.c: it looks like we modified
> the same spot, the change is not wrong, is that right?

Hi Wandun,

However, I think someone should have informed me in advance; otherwise,
doing duplicate fix work is pointless.

I see that part of your patch series modifies code I previously changed,
but I was not CC'd.

> 
>> arm64 crash hotplug:
>> https://lore.kernel.org/all/20260918100442.3841135-18-ruanjinjie@huawei.com/
> 
> In addition, if arm64 gains crash hotplug support, the code there would indeed
> need to be modified (to avoid a deadlock). As of now, arm64 crash hotplug
> support has not been merged yet either, has it? I just want to make sure I
> haven't missed anything.

Yes, you are right. If your patch series will be merged soon, I will
develop based on it.

> 
>>
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>  /**
>>>   * crash_exclude_mem_range - exclude a mem range for existing ranges
>>>   * @mem: mem->range contains an array of ranges sorted in ascending order
>>
> 

-- 
Best regards,
Jinjie

