Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795419636;
	b=J7DeUJsrpiSVtyxKsUPpFRL+IXEm4ylq/UrOCFT8U8FD6vlue3wGafIGYm+MPNMaIMAM
	 XTZ1pZ6Q1MCeCQsjeoBd97qukAF3RAjekDnxLM1Lkwvbdr5vf1tD6RZsdG3G1Vcv/5cdf
	 hvS4P5O80HqQmpDyR4P3/yPgbY4RV53GAfJlpXsIbglt+wP+GSay7ughcOyt1wfzuBXA2
	 kE4OV0LIj20v9Thvi4RvO6qekLp+a+H2rUPgvdQhfPE14lOy5r0rXtG6IzIFv8F23mr7C
	 Bqj+D3ppsC00Ry/0Dl8sziiXhpC5lUC1eNWpSIIMctJlKnR6Akc6dpyRTM4GIQpK57Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795419636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=0OSpOlJ5QU7jjdI5ogSU6KcCruhdHca3yQivXfMqClg=;
	b=UXqOIXPy2BjdaMC2dcv3UMx+I/DGUDNo/Y3TpYzD2OllXdu03s/pPB3k17VMRVw3AN16
	 WIK72yfak80X19+QHeirlN8P39mASPafNmzoCKuPKDgU3WfJO05i3tXfT5+/JJkbwuvoK
	 qFQnPrpsFZLqWtfKS3zHItkkFlWU8fQhi8KDM1RLWo+fuYUbNbAjcnMSeh6fpM+l3OXMn
	 k/UVtJQzuNn851nKzbRCNsCQ5vxv5a7IJV5zwTLmOrUdxqUkzNu/991e2kyJtLLAMctmJ
	 9NA1Q6qDlfqWx4qc2jm7xe2WA2IEwrxOy96yOD41YyY4v5Zv6b9ZN7wriETNBj6GxhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fd56S2lJ;
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A17B606A321
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 07:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A17B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fd56S2lJ
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3adc0ac3566so709070a91.1
        for <iommu@lists.linux.dev>; Sun, 22 Nov 2026 23:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795419635; x=1796024435; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0OSpOlJ5QU7jjdI5ogSU6KcCruhdHca3yQivXfMqClg=;
        b=fd56S2lJFljsyT+gKD2lEqCNaSpEfSUjnn9IgdoNKbRtz2dEGB9987grS0eiqQFc3w
         hBbrJm9SWvjhnMK2lYQC3SoRdqaAyQQXRD+0scI4BFndoQLeIIlbRCZEHy8j0LwLYtcU
         v70Sfj71p3ui5vMIuX3kxbV853h8GQhDR2B3Do+6ic5EXwuG701tpQ+qHndlNRhFVAwA
         nJSCK/loGqUYl6HofAVEFWdOz3QMt83AqTYsQBs0/rmD96L9ncKJoYHsXrCvvtV98oSU
         Z4xg14uTzbYLUsbRdMjJobkz6f8MeIDc7yfx96X1S65m7q0Hb9ldJHeT295o5xpIqmYc
         wtgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795419635; x=1796024435;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0OSpOlJ5QU7jjdI5ogSU6KcCruhdHca3yQivXfMqClg=;
        b=1b6jSYLCQa/kk4QFYQ9FG+s/1PRbJJAy0lipQbOBPCVXBMzJEKWkqyByie5s1HDGNt
         lQZap8zeW2iGW3eFIvSvxmnkZe/LUo/tC8Hy9wwqgQgSqh6v3bdLO0rxuoOn9XgdKJPQ
         c2Wv9r3kp2lKpFpsoxxIaF0YerF+FvYPpMTEzBQiP8Acwa/tw5wN9FEk+mb7pxQfhHzr
         dpRiw5WFRTNnrA+H9AfCrj0Kx00Kj6EnFRGvqhMTSRKN186RqRZxy1SMgFZ0tgXHKsKO
         SPZxsFG55Xm/opGblvPPp8fe9XjC5iAT616LjHsWRsrAOAUIan0ZC7LmKEZRg5lQXlG/
         qb7Q==
X-Forwarded-Encrypted: i=1; AL+hErEzCuZLgtM+F5q6RHH68n2EqCE4zavVqW79NmwHwFqF4IDQev0z2cP1UeM9WRw8CaJDNu3c9A==@lists.linux.dev
X-Gm-Message-State: APuU4Z9zjDjEU/H6N96p78S74zhzhdOtkPa6zsYO1MIswiCITEsNAGjL
	Kd9EB9f/ZnJIWvjng7BHG/2EzjzGsM48z1di4tLCE6QKyAsBZudh45+D
X-Gm-Gg: AZFdTZc/7zadm84ezA4YIWWUhwQBSsi7G82K8IKs3QW9kgz3XneDs8EHxxAwyVJs+Qj
	x4tfE/+5xv4mEXrWdPbc5PbPJL+L+9IFw4G9U9D0dIZdQcoNM9AIzkSU0FvxdGBud7vJOM1Cydz
	4K7BF8ijCnnwypOUPJhYHnHItLJo3d17itdSD3kXqxK7Lp0fzbKBxJYsVnIY3xp2NagRl4A51wj
	dYhC6PJBVZPrKt4N/MhdtOi3PPM/vYnCx+31CS42HOb+QN31NPL8xkKqvzepbLT2pmFk7ChQRIa
	pIsJtlrlDWtuTOwQhHA8ydIOzbWuwgq5fkPLqVaO2nF7yM5KfmcvAfWOy82RV8kVMS2cVT7ekrk
	HW1UlnXzupWv4Tsf4JbAXvm/ugx4Z9jcO5sKIh7SjvVwG/xga6OzWJ7pDhpxGSyduNh+2C2x/xZ
	H3hS2A0MMh0XLEUqgRNZTITfD9gmsJG1sqedeUSaz7lguksaUHBKNzl0OHsxEHF2HXaPCewEWgl
	fyolj4HDf1OVV4WlVLXn5UZzKsepwoH33vGdeP+EYC0tI1BuKi+4NBrGLCcMmU8fd3OYHPjIyYg
	EpY4Rv+taxE4W1R8ItsWuFnunuuyVTLCTqt1
X-Received: by 2002:a17:90b:2f8c:b0:3b4:1997:3495 with SMTP id 98e67ed59e1d1-3b41c9613bbmr9155015a91.57.1795419634749;
        Sun, 22 Nov 2026 23:40:34 -0800 (PST)
Received: from [10.125.112.22] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad8ef99sm17103994a91.12.2026.11.22.23.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 23:40:34 -0800 (PST)
Message-ID: <a3ebfc1c-9c98-44a1-96e2-4d92daed4ba4@gmail.com>
Date: Mon, 23 Nov 2026 15:40:19 +0800
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
Subject: Re: [PATCH v9 1/8] riscv: build crash_mem ranges from memblock
 instead of resource tree
From: Wandun <chenwandun1@gmail.com>
To: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
 chenhuacai@kernel.org, kernel@xen0n.name, alex@ghiti.fr, tglx@kernel.org,
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
 <20261021083011.2170525-2-chenwandun1@gmail.com>
Content-Language: en-US
In-Reply-To: <20261021083011.2170525-2-chenwandun1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/26 16:30, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> Replace walk_system_ram_res() with for_each_mem_range(). A later patch
> introduces MEMBLOCK_NODUMP in memblock, the reserved-memory regions
> marked with MEMBLOCK_NODUMP can be excluded from the vmcore by walking
> memblock.
> 
> for_each_mem_range() iterates memblock.memory, which is freed after
> init unless ARCH_KEEP_MEMBLOCK is selected. riscv needs ARCH_KEEP_MEMBLOCK
> to filter reserved memory from the vmcore, so extend its condition
> (ACPI || KEXEC) with CRASH_DUMP. arm64 and loongarch already select
> ARCH_KEEP_MEMBLOCK unconditionally.


Hi Paul, Palmer, Albert,

A gentle ping on this patch.

Mike has requested a RISC-V maintainer Ack before taking the revised
series through the kexec tree. Could you please take a look when you
have a chance?

Thanks,
Wandun

> 
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> Acked-by: Baoquan He <baoquan.he@linux.dev>
> ---
>  arch/riscv/Kconfig                     |  2 +-
>  arch/riscv/kernel/machine_kexec_file.c | 31 ++++++++++----------------
>  2 files changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e7891a2a89da..e21d0bab77ee 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -58,7 +58,7 @@ config RISCV
>  	select ARCH_HAS_UBSAN
>  	select ARCH_HAS_VDSO_ARCH_DATA
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
> -	select ARCH_KEEP_MEMBLOCK if ACPI || KEXEC
> +	select ARCH_KEEP_MEMBLOCK if ACPI || KEXEC || CRASH_DUMP
>  	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
>  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
> index 26cd2a8bd0cd..808e872f4063 100644
> --- a/arch/riscv/kernel/machine_kexec_file.c
> +++ b/arch/riscv/kernel/machine_kexec_file.c
> @@ -37,39 +37,32 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>  }
>  
>  #ifdef CONFIG_CRASH_DUMP
> -static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
> -{
> -	unsigned int *nr_ranges = arg;
> -
> -	(*nr_ranges)++;
> -	return 0;
> -}
> -
>  unsigned int arch_get_system_nr_ranges(void)
>  {
>  	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* For exclusion of crashkernel region */
> +	u64 i;
> +	phys_addr_t start, end;
>  
> -	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
> +	for_each_mem_range(i, &start, &end)
> +		nr_ranges++;
>  
>  	return nr_ranges;
>  }
>  
> -static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
> +int arch_crash_populate_cmem(struct crash_mem *cmem)
>  {
> -	struct crash_mem *cmem = arg;
> +	u64 i;
> +	phys_addr_t start, end;
>  
> -	cmem->ranges[cmem->nr_ranges].start = res->start;
> -	cmem->ranges[cmem->nr_ranges].end = res->end;
> -	cmem->nr_ranges++;
> +	for_each_mem_range(i, &start, &end) {
> +		cmem->ranges[cmem->nr_ranges].start = start;
> +		cmem->ranges[cmem->nr_ranges].end = end - 1;
> +		cmem->nr_ranges++;
> +	}
>  
>  	return 0;
>  }
>  
> -int arch_crash_populate_cmem(struct crash_mem *cmem)
> -{
> -	return walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
> -}
> -
>  static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
>  				 unsigned long cmdline_len)
>  {

