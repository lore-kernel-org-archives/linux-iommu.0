Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792576138;
	b=uvAK8BeAqCJ9AKQRGmunk6TCo+Dlr9HzlCaQtcClUx1SYl37HS4JJxKBeN4gWm/4RXNA
	 SZAiuYH28tvlq1Tc4SkCpTE/DOMGUb+6ed3hBMzdyFbeit85QW/kpVlu7dCUdsNb6NsK+
	 4H+yhKmKWO79FtNiZkY2fK0o++NM2sDjMdGLgXPrlmkUMI+m6SWBtgYmRXnhUgS1Hh7xX
	 cele0sIMAdylCCFdZ53Jwx1mb44bU11S7K1EwxQe1Wq5OiBUp9HldoDP+W9FTXIoDbeEo
	 WHINtZVfIfMZ3LNxfRJ4XcJUJPmSKgD95O2jvcL8trwU5p/wVD7kWy2v+MLY50kaluw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qb8CCyZKDo3DU8wu9akhVT7quX2USeXAOK8NbuiE3KM=;
	b=k1StPeHZnsMYgBRXj+qGjonIQue7m03Q1LmEm/FejuGqqgYv1oLuOweLvvpOWAEvXdsm
	 P4ueuS5GUIA7XdYi4vKIIf/8JrprlNx/CJu+3zz7cfe8T4N0Qs7Xxqrnc8z/biNOBfsMH
	 KpKFNsdTGDOrbtht8ybDHKbAmNq9TtEP4hC8dnc+P5z9R4j+7cSUF25SdMOqnnlT8Rc6z
	 eZW9tRaFgaexJAqdhWNSq0ZMQWYLFnWTWrEZy+2Mgtgtmna+67qoVDvNwiLT+aOJJPVUx
	 ZvVWJeb13P2Z8t3QFJnJ0k/lDiKkJukMOL0UCG3/ZmIK1mU7Xf5isSJ7rOp3CaROKTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="W9Xsm/L1";
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB89606A31D
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 09:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECB89606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W9Xsm/L1
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2e831901331so3017215ad.1
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 02:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792576137; x=1793180937; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qb8CCyZKDo3DU8wu9akhVT7quX2USeXAOK8NbuiE3KM=;
        b=W9Xsm/L114qOVc+H9WnV3LSeZJNA5/nyEVFjvokmHXiU3AJws1E1dPvPBzj0tPaCPr
         0XuMG7NaPyzGOEvVzCTy74kvzV0HlNS2j/xZ0QX7WWd5fktl0kedzxKNmGi7okcxmxVc
         jzHzPkbQQ8G7PY9FXe0n2jalhWbZuGOUs2TShXuFsHfn82Lc2SKA+yUb/9ZeyUUqy2kJ
         PCxz1JxHJZgQGb3DzxO8YtAaN+13poc5N3hXWhSQAHr4VQnjyeLzbEJMRsiorEjS0o7r
         1HflssKVpl1jrLXWH/pSTOEZ+jqM3amEzq5AYsbuumOTPFZ+phh0bcP0s0aWxPlh4fEO
         JrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792576137; x=1793180937;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qb8CCyZKDo3DU8wu9akhVT7quX2USeXAOK8NbuiE3KM=;
        b=BTDjtoYfS9078mTFSIVVoGdOm/VSpdI1AoNzZ6e0tWMfo7v/I8E87PhI8BO539Oy3M
         r73r5LukrRI8aKklETyOFOBoUS01s39nGAQA2UZ6JbimPHHTBi7WhhgTt3P11cmQUrxR
         j7i82b+sR59PSaDvP2gCVkpqGextMcb6X5Lq97udiFT0Cyv+qM3UQuCuHgDKjdJmokR1
         gAgrbIBZxJ1RGtFjePJDJq2yw+Bc5AZrKP4CYDAh0DWvVg3I5XgLnsbBrMl1lKcXzb9+
         AoUK2XQciIZeGY6Z9LPFw9Fk/O3CeEhVB5kHLoLlYcUVsvW6tn9Bhmcg4Q7y/BcKSyw1
         yqyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxTDWguIMgmu4OXPHyUVNymZ/RlQG2kz870xhjadkxJgs+xSm1XN4Kt9z8/apoE8ih4+9h9dg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKX5LNucxGyaoTAztftbb65cGxg2DdqXRUPdAcrPabs4Pd/NalX
	U8UxkLh8uwYNlcu0nbIdoYMDDvvxfU2OqWe8SgB7gBW4TIm52nlAoe8a
X-Gm-Gg: AYBFou0fjYCtnfcuieSbnctYhF1IK5F22RKePn8XI5Vq45PYRSBZQUxoto8W2XlaHSb
	jhYmiPxAXokz3gKHDGFEy+ZlFCfZIYBmBWEiLsPlrdg/KqsIua7yibcmxPNvKn2Eui3ibLfGTn8
	BQlfrK403mq3PifyIhyqmJrMqNS1MNFp8LBTBiOZWOLHdjW3w/5gWoWPmSxHUYmR7EC5znYpvsl
	af+e9daEPcFQ/PdhkSfeCp4G8G8/a3UvsUqn9tx1djDYHi7e1PUkTvFBP+rJAfa6/5dHtSUHu8P
	h8bOc6jj1uw8aBQvJw7s6LIegmhdWhxZXdDKAoRL4umKXdcfxTp1ubVyOe3LtYzw7DJRaa06Ij5
	3PUkwBt3VuJQW/nkO1hhHtW4b5VDH54n+H8iNvyUBLNS/S+BBfX6cZiEHO/ArU/NgincRsY9ZqX
	oO865ya15zU5dCc8ZbR04+uu75pNLNpq1cVlCMDnByzwoCiQoAILhuuSJmOjZafHzD6tjpHv5gj
	SSZbqnF9eld+OsGlYN9+5Q1t/05QRuTR5NbaZgIz+fmGWu9y+2QykRjDqbbeIE=
X-Received: by 2002:a17:902:f60e:b0:2ea:192a:13b8 with SMTP id d9443c01a7336-2ea43a13e4fmr10496695ad.20.1792576137131;
        Wed, 21 Oct 2026 02:48:57 -0700 (PDT)
Received: from [10.125.112.22] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b486970sm8858055ad.62.2026.10.21.02.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 02:48:56 -0700 (PDT)
Message-ID: <a1665f9e-3116-47bc-974e-98dce408fa37@gmail.com>
Date: Wed, 21 Oct 2026 17:48:37 +0800
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
To: Jinjie Ruan <ruanjinjie@huawei.com>, robh@kernel.org,
 baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
 chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 kexec@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
 <20261021083011.2170525-4-chenwandun1@gmail.com>
 <12e4e687-1ff0-41b2-bdf8-7f48b29e1f2f@huawei.com>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <12e4e687-1ff0-41b2-bdf8-7f48b29e1f2f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/21/26 17:13, Jinjie Ruan wrote:
> 
> 
> 在 2026/10/21 16:30, Wandun Chen 写道:
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
>> crash_prepare_headers() counts memory ranges before populating the
>> allocated crash_mem array. The weak implementation used by ARM64,
>> RISC-V and LoongArch walks memblock.memory, while x86 performs the same
>> two-pass operation over system RAM resources. Concurrent memory hotplug
>> can change range source between the two walks and make the populate
>> pass overflow cmem->ranges.
>>
>> Take device_hotplug_lock when preparing crash headers during
>> kexec_file_load(). The x86/riscv memory hotplug path already takes
>> device_hotplug_lock, so call __crash_prepare_headers() directly
>> to avoid recursive locking.
>>
>> Sashiko reported this issue in [1].
>>
>> Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
>> Fixes: 1bcca8620a91 ("LoongArch: Add crash dump support for kexec_file")
>> Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
>> Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system call")
>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>> Link: https://sashiko.dev/#/message/20260806101002.1F84E1F000E9@smtp.kernel.org [1]
>> Acked-by: Baoquan He <baoquan.he@linux.dev>
>> ---
>>  arch/riscv/kernel/crash.c  |  2 +-
>>  arch/x86/kernel/crash.c    |  2 +-
>>  include/linux/crash_core.h |  2 ++
>>  kernel/crash_core.c        | 17 +++++++++++++++--
>>  4 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/crash.c b/arch/riscv/kernel/crash.c
>> index fe5a4b306aae..ac8df2edf2a7 100644
>> --- a/arch/riscv/kernel/crash.c
>> +++ b/arch/riscv/kernel/crash.c
>> @@ -70,7 +70,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>>  	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>>  	 * memory resources.
>>  	 */
>> -	if (crash_prepare_headers(true, &elfbuf, &elfsz, NULL)) {
>> +	if (__crash_prepare_headers(true, &elfbuf, &elfsz, NULL)) {
>>  		pr_err("unable to create new elfcorehdr");
>>  		goto out;
>>  	}
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index e6f23933a6df..bef008a0cb22 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -465,7 +465,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>>  	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>>  	 * memory resources.
>>  	 */
>> -	if (crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz, NULL)) {
>> +	if (__crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz, NULL)) {
>>  		pr_err("unable to create new elfcorehdr");
>>  		goto out;
>>  	}
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index bc087124cd78..28e7a81cf263 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -61,6 +61,8 @@ extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_ma
>>  				       void **addr, unsigned long *sz);
>>  extern int crash_prepare_headers(int need_kernel_map, void **addr,
>>  				 unsigned long *sz, unsigned long *nr_mem_ranges);
>> +int __crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>> +			    unsigned long *nr_mem_ranges);
>>  extern int crash_exclude_core_ranges(struct crash_mem **cmem);
>>  
>>  struct kimage;
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index faa0f22dbb41..8a861a946e26 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/mm.h>
>>  #include <linux/cpuhotplug.h>
>>  #include <linux/memblock.h>
>> +#include <linux/device.h>
>>  #include <linux/kmemleak.h>
>>  #include <linux/crash_core.h>
>>  #include <linux/reboot.h>
>> @@ -344,8 +345,8 @@ int crash_exclude_core_ranges(struct crash_mem **cmem)
>>  	return 0;
>>  }
>>  
>> -int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>> -			  unsigned long *nr_mem_ranges)
>> +int __crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>> +			    unsigned long *nr_mem_ranges)
>>  {
>>  	unsigned int max_nr_ranges;
>>  	struct crash_mem *cmem;
>> @@ -382,6 +383,18 @@ int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>>  	return ret;
>>  }
>>  
>> +int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
>> +			  unsigned long *nr_mem_ranges)
>> +{
>> +	int ret;
>> +
>> +	lock_device_hotplug();
>> +	ret = __crash_prepare_headers(need_kernel_map, addr, sz, nr_mem_ranges);
>> +	unlock_device_hotplug();
> 
> I think this patch conflicts with my changes and would also conflict
> with the implementation of arm64 crash hotplug.
> 
> https://lore.kernel.org/all/20260921090450.807575-15-ruanjinjie@huawei.com/
> 
Have these patches already been merged? My current work is based on the latest
linux-next. If they have already been merged into the maintainer's branch,
please let me know, I will update my tree and rebase/re-adapt my changes accordingly.


Also, regarding the changes in kernel/crash_core.c: it looks like we modified
the same spot, the change is not wrong, is that right?

> arm64 crash hotplug:
> https://lore.kernel.org/all/20260918100442.3841135-18-ruanjinjie@huawei.com/

In addition, if arm64 gains crash hotplug support, the code there would indeed
need to be modified (to avoid a deadlock). As of now, arm64 crash hotplug
support has not been merged yet either, has it? I just want to make sure I
haven't missed anything.

> 
>> +
>> +	return ret;
>> +}
>> +
>>  /**
>>   * crash_exclude_mem_range - exclude a mem range for existing ranges
>>   * @mem: mem->range contains an array of ranges sorted in ascending order
> 

