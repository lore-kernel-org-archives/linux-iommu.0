Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795832347;
	b=O/BW241fciE10NqrI5m5QxThskrVRUe/zj0J4jCUjbDfHJMNsJFYtKtJqLitUDOgOrnu
	 Tbr7x3Pu1iX9eVIAR7BIj4DZ52a6xeBdxMQRWay0tLgtpr4r9C4JC5vZgp/P7/TYrwN66
	 6OAQpCnXkU72mbO77SnH7QC25FsiNTfhB02SEHsKYLZ44gGc8Mkk21VAmt12LBzO628SL
	 3Zrh2cAst7lGfPN8SLmEbkoSjvQ23Ew+Ek/+MjX89XCYThgUAB7Im61+EMqTg4UBD9MYE
	 DcZIlQ8Quwcq9QgEXv5IElCqiI/Poxa/9bmOyzr5kdeYtoneATmf2ryYY98KgrV0RVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795832347;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=HZiLbeveVkP0thWq6lXBRnjI4/oS76xhNlaIHRsGwXI=;
	b=WcDzkrcaBTwlSiRw8lAvG3nj0UQVijHIG0ZQQPADTzuNbYZEF6AYaVt3kgJXc5Qk51xb
	 bLc4RfsIG7nHAPwuXGI9cAtKANhgPlLUjSjDKnhhSybDoKUvts/kmbLfsF4Ow6JBJUCYk
	 W+UheNP05Bwavm95Vu1y/b2MWQNzqalzB528gc9JUBy9/FP99Kbzk9R8+dBu2Z7a8EydD
	 H8vHCVyfRCWqLkL8TipbLbgEfYhqH6+zHR1xNX/bfieCzRRmTdEwCZr0JJW5VYkvNhutc
	 Fw6ap+kn7Ts10DvZhhYbXtoSRJW/PPZd8BwpP7YUtmatGowWOOgv8EWTOiFZTbt7SCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=wl6gPvEb;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D063C606A683;
	Sat, 28 Nov 2026 02:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D063C606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=wl6gPvEb
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HZiLbeveVkP0thWq6lXBRnjI4/oS76xhNlaIHRsGwXI=;
	b=wl6gPvEb8+GbDNNj0Igr3ynb5fLY54UN8ir/arw4RT8N4XcxGf6b4e2TsKYfaErA97c21omUh
	9NJPI8/bB1k8Quxo1eFSqwsMZDnYh6r8JrXrKbhWN6rmvW/QIPXRnXyaBDOJDioODOuD+MDpA+X
	L8fDffTxns7RVHqRIsC7vF4=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jbv904pYxz1prKm;
	Sat, 28 Nov 2026 10:18:44 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 4879540538;
	Sat, 28 Nov 2026 10:19:03 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 28 Nov
 2026 10:19:01 +0800
Message-ID: <6339810b-1666-441c-a8b8-17bfb885fc8f@huawei.com>
Date: Sat, 28 Nov 2026 10:19:01 +0800
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
Subject: Re: [PATCH v10 2/8] crash_core: fold duplicated memblock arch hooks
 into the weak default
To: Wandun Chen <chenwandun1@gmail.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<robh@kernel.org>, <baoquan.he@linux.dev>, <rppt@kernel.org>,
	<m.szyprowski@samsung.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <pasha.tatashin@soleen.com>,
	<pratyush@kernel.org>, <ruirui.yang@linux.dev>, <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-mm@kvack.org>, <iommu@lists.linux.dev>
References: <20261127090723.741253-1-chenwandun1@gmail.com>
 <20261127090723.741253-3-chenwandun1@gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20261127090723.741253-3-chenwandun1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/11/27 17:07, Wandun Chen 写道:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> arm64, loongarch and riscv open-code the same memblock walk in
> arch_get_system_nr_ranges() and arch_crash_populate_cmem(). Move it into
> the __weak defaults in kernel/crash_core.c and delete the arch copies.

The code looks good, but shouldn't the commit message also mention x86
and loongarch? Loongarch does not implement crash CMA reservation, so
crashk_cma_cnt is 0. x86 has its own arch hook implementation, so the
__weak implementation will be overridden by the arch implementation.

otherwise, LGTM
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

Best regards,
Jinjie

> 
> No functional change.
> 
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> Acked-by: Baoquan He <baoquan.he@linux.dev>
> ---
>  arch/arm64/kernel/machine_kexec_file.c     | 29 ----------------------
>  arch/loongarch/kernel/machine_kexec_file.c | 27 --------------------
>  arch/riscv/kernel/machine_kexec_file.c     | 26 -------------------
>  kernel/crash_core.c                        | 27 ++++++++++++++++++++
>  4 files changed, 27 insertions(+), 82 deletions(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 14f453dd0946..18695f01043c 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -14,7 +14,6 @@
>  #include <linux/kernel.h>
>  #include <linux/kexec.h>
>  #include <linux/libfdt.h>
> -#include <linux/memblock.h>
>  #include <linux/of.h>
>  #include <linux/of_fdt.h>
>  #include <linux/slab.h>
> @@ -39,34 +38,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>  	return kexec_image_post_load_cleanup_default(image);
>  }
>  
> -#ifdef CONFIG_CRASH_DUMP
> -unsigned int arch_get_system_nr_ranges(void)
> -{
> -	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* for exclusion of crashkernel region */
> -	phys_addr_t start, end;
> -	u64 i;
> -
> -	for_each_mem_range(i, &start, &end)
> -		nr_ranges++;
> -
> -	return nr_ranges;
> -}
> -
> -int arch_crash_populate_cmem(struct crash_mem *cmem)
> -{
> -	phys_addr_t start, end;
> -	u64 i;
> -
> -	for_each_mem_range(i, &start, &end) {
> -		cmem->ranges[cmem->nr_ranges].start = start;
> -		cmem->ranges[cmem->nr_ranges].end = end - 1;
> -		cmem->nr_ranges++;
> -	}
> -
> -	return 0;
> -}
> -#endif
> -
>  /*
>   * Tries to add the initrd and DTB to the image. If it is not possible to find
>   * valid locations, this function will undo changes to the image and return non
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
> index 0fe60907b97f..bef459287683 100644
> --- a/arch/loongarch/kernel/machine_kexec_file.c
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -13,7 +13,6 @@
>  #include <linux/ioport.h>
>  #include <linux/kernel.h>
>  #include <linux/kexec.h>
> -#include <linux/memblock.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
> @@ -56,32 +55,6 @@ static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdline_tmpl
>  }
>  
>  #ifdef CONFIG_CRASH_DUMP
> -unsigned int arch_get_system_nr_ranges(void)
> -{
> -	int nr_ranges = 2; /* for exclusion of crashkernel region */
> -	phys_addr_t start, end;
> -	uint64_t i;
> -
> -	for_each_mem_range(i, &start, &end)
> -		nr_ranges++;
> -
> -	return nr_ranges;
> -}
> -
> -int arch_crash_populate_cmem(struct crash_mem *cmem)
> -{
> -	phys_addr_t start, end;
> -	uint64_t i;
> -
> -	for_each_mem_range(i, &start, &end) {
> -		cmem->ranges[cmem->nr_ranges].start = start;
> -		cmem->ranges[cmem->nr_ranges].end = end - 1;
> -		cmem->nr_ranges++;
> -	}
> -
> -	return 0;
> -}
> -
>  /*
>   * Add the "mem=size@start" command line parameter to command line, indicating the
>   * memory region the new kernel can use to boot into.
> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
> index dad7f02365d3..fdc6695e8588 100644
> --- a/arch/riscv/kernel/machine_kexec_file.c
> +++ b/arch/riscv/kernel/machine_kexec_file.c
> @@ -37,32 +37,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>  }
>  
>  #ifdef CONFIG_CRASH_DUMP
> -unsigned int arch_get_system_nr_ranges(void)
> -{
> -	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* For exclusion of crashkernel region */
> -	phys_addr_t start, end;
> -	u64 i;
> -
> -	for_each_mem_range(i, &start, &end)
> -		nr_ranges++;
> -
> -	return nr_ranges;
> -}
> -
> -int arch_crash_populate_cmem(struct crash_mem *cmem)
> -{
> -	phys_addr_t start, end;
> -	u64 i;
> -
> -	for_each_mem_range(i, &start, &end) {
> -		cmem->ranges[cmem->nr_ranges].start = start;
> -		cmem->ranges[cmem->nr_ranges].end = end - 1;
> -		cmem->nr_ranges++;
> -	}
> -
> -	return 0;
> -}
> -
>  static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
>  				 unsigned long cmdline_len)
>  {
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index d0bd2d0cf899..faa0f22dbb41 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -281,8 +281,35 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
>  	return cmem;
>  }
>  
> +#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
> +unsigned int __weak arch_get_system_nr_ranges(void)
> +{
> +	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* crashk_res + crashk_low_res, +CMA splits */
> +	phys_addr_t start, end;
> +	u64 i;
> +
> +	for_each_mem_range(i, &start, &end)
> +		nr_ranges++;
> +	return nr_ranges;
> +}
> +
> +int __weak arch_crash_populate_cmem(struct crash_mem *cmem)
> +{
> +	phys_addr_t start, end;
> +	u64 i;
> +
> +	for_each_mem_range(i, &start, &end) {
> +		cmem->ranges[cmem->nr_ranges].start = start;
> +		cmem->ranges[cmem->nr_ranges].end = end - 1;
> +		cmem->nr_ranges++;
> +	}
> +	return 0;
> +}
> +#else
>  unsigned int __weak arch_get_system_nr_ranges(void) { return 0; }
>  int __weak arch_crash_populate_cmem(struct crash_mem *cmem) { return -1; }
> +#endif
> +
>  int __weak arch_crash_exclude_ranges(struct crash_mem *cmem) { return 0; }
>  
>  int __weak arch_crash_exclude_mem_range(struct crash_mem **mem,

