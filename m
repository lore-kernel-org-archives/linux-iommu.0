Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B440F730
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721171; cv=none; b=Jh8VbBr4q8M9Vzv2V2WaDva4ggMjahTFUehQ6BSwIkxWQ2Ht2+qj3d+rrJJQHXQp9isyOhrvBqWWEr1XG2Oirl2GH44nBE40z0V7Ng5+A0MN0Rt9JsB0K8zNGgJnNhkxdvl2D/KuROqe/p+MFmUqKr9NmzqwMEv9B+3t6aTuw6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721171; c=relaxed/simple;
	bh=g9DyVnCzjg6xs0vsonq9NBBakJdLTwOa4ruwGGiTlRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UlnkEzJGV57Sxwa3B5FvqDXJFo534aetXy6cqh3cg9a2kNHj94w6kF3zlObDSkEre06Izh5P6jaY+Jkbb3UXbSIK4cQttuMnlkDqHZ+zancBXuiHD2JMWYcPNVg7cRiO9kZ0Iti5er1WGgtFa28mescSqNHMNYIPJPjrzH4SXpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f21FlS3t; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f21FlS3t"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-398a0a87595so665521a91.1
        for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 01:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789721169; x=1790325969; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0JHVWPEX+y53lIHPhD5/BSPnjVOTml/jp7Miw8vUP8=;
        b=f21FlS3tV/s6bFYsarKWN2cCsQCni+9LDZINg6wCqmiffRqinwViazXeliYZE39xGu
         W1QexmlU13h3YYLbdjj8LZy6sZuLjouHTG/BONyLHIjH7sdQr5/3iqiMvJ9zbuDsBJKg
         aQUb4891heSo5658DygGLSuMzv1k91WJxWbe7J6Vd2hQuzsEp2effoynkExi2nZIcMz5
         d24JTEWc4cGuK07enIwrB3GoNVxYjr34uYRQ1HZeUpJTgZKSDMgzOLop/lRbjZmFQKZI
         CgNTCLqN/KHc/P/oC5K7EHPDPaSEOtBYRWeLCQfIOjFlw/r9V1/hsff4EDwhCsqWOydT
         OQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789721169; x=1790325969;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T0JHVWPEX+y53lIHPhD5/BSPnjVOTml/jp7Miw8vUP8=;
        b=iZ1hj4tn2OKmIw/OGOw3xVBDgOEmzmr/yq9nFd2+2kYHClq/ERXTWz7NHju2dJwP0f
         Z/AgkoTcGg3YIrRpBh7DUHN0aYNxXSckpNf8/BWEBWvVUhaOTbiSftFLJ3rkITum80Wf
         /Te53f+ItogT9ceT96kwzydYNfbns1vvqtpzJ7fOP4Mv81pWQZSCzA2dwWVQSF5ljPp9
         45Y+D4JH5YgwOSC7vRuWPoD6H7EfG+nyT2JJ9jKHv9mgQuLKnXVLy+CA3qQ32vRaFinB
         HeLKdPmJ/Dfha6C3NwpU3Xu5d4t1OdmQxZ7BI5oAVWT1KbfujAAcrLTe4lrkYV36B3kx
         ZhiA==
X-Forwarded-Encrypted: i=1; AKwUvBzGtfF7t0KCnqKyws5Xg0ItVlRX1bZzZQK7j5Ia2g2IhPCMZpJWSdJMIrnulGNwln8UqAoz4A==@lists.linux.dev
X-Gm-Message-State: AFuF++nMjOfKHX4zAVoMoWEQO4spEuVPgsrC/9oGIqBwxqYlzKi4LVCg
	cr0z3Z1hsBKtGq+KDw+Oyc++UnaTP2dRb/XS9NYMepQDZbI6fAVjDMIz
X-Gm-Gg: AYBFou2qw9vNtAbUiyJJ3qLwxT7KLEgiFUqsaqDX1YHaaXuzeJyOqsHlCM8jo7m+2ez
	UGy5Cnwh7qyO633bipLyvg9SO3jOqav4LQ73LJU/BIbFIaPaEXI1SAnqz52XvAm1TkUDh1WSmql
	PmHtGILE9HPZnnwW/Jjl/XXBp3VtFacUwek/DiW+uJL0Wfoa5A6ZTDf5A6xNnUIH65Nsio5lwTx
	q2yq0OCe6N4jEHAESijuf54xowUxTI7PsONGaua3Kk0Fu80MihY1GrLUCdsE7G5fa4gdsHHdTYX
	MipT65vunPp7E7c5OmF8HkkGyU3VPXdjxx30XRRPqS/s8wwuy5zyWMjuBYU0YDZRP/Mm0FfGnZb
	Vq+/Kn0mcALkKJ0G9TNLRQko2iQNro5SSVFCq/LTI+W028nQrDrRYtobH3QdhpPXEGQcZE8gm4+
	wA+kL5Jy1QDlh1WY9vOxZ/K6qsfW19FCkVjmId1IMJe3cN+8Kt5l5zOqQkubf02bV7RheawoZ5R
	EwH1w==
X-Received: by 2002:a17:90b:5784:b0:39d:f5b1:e365 with SMTP id 98e67ed59e1d1-39e54f35b9cmr3920258a91.25.1789721168773;
        Fri, 18 Sep 2026 01:46:08 -0700 (PDT)
Received: from [10.125.112.20] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e59e4a508sm2264153a91.0.2026.09.18.01.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 01:46:08 -0700 (PDT)
Message-ID: <c58e9b6a-e421-4265-aa77-48c07a4fb8e4@gmail.com>
Date: Fri, 18 Sep 2026 16:45:49 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/10] crash_core: fold duplicated memblock arch hooks
 into the weak default
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
 <20260902073116.802752-4-chenwandun1@gmail.com> <aqzolBceoRchBdbx@fedora>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <aqzolBceoRchBdbx@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/26 15:30, Baoquan He wrote:
> On 09/02/26 at 03:31pm, Wandun Chen wrote:
>> From: Wandun Chen <chenwandun@lixiang.com>
>>
>> arm64, loongarch and riscv open-code the same memblock walk in
>> arch_get_system_nr_ranges() and arch_crash_populate_cmem(). Move it into
>> the __weak defaults in kernel/crash_core.c and delete the arch copies.
>>
>> No functional change.
> 
> In one version, you also tried to remove these functions on x86, I could
> remember it wrong. 

Yes, the x86 implementation can also remove these functions and use the same
approach as arm64, RISC-V, and LoongArch. However since this change would not
reduce the vmcore size on x86 at all, I did not include it in the current series.

I plan to refactor this part on x86 after this series.

Best regards,
Wandun


> 
> Anyway, this looks good to me.
> 
> Acked-by: Baoquan He <baoquan.he@linux.dev>
> 
>>
>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
>> ---
>>  arch/arm64/kernel/machine_kexec_file.c     | 29 ----------------------
>>  arch/loongarch/kernel/machine_kexec_file.c | 27 --------------------
>>  arch/riscv/kernel/machine_kexec_file.c     | 26 -------------------
>>  kernel/crash_core.c                        | 25 +++++++++++++++++--
>>  4 files changed, 23 insertions(+), 84 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>> index 854d872dfd0f..34d944d3f22f 100644
>> --- a/arch/arm64/kernel/machine_kexec_file.c
>> +++ b/arch/arm64/kernel/machine_kexec_file.c
>> @@ -14,7 +14,6 @@
>>  #include <linux/kernel.h>
>>  #include <linux/kexec.h>
>>  #include <linux/libfdt.h>
>> -#include <linux/memblock.h>
>>  #include <linux/of.h>
>>  #include <linux/of_fdt.h>
>>  #include <linux/slab.h>
>> @@ -39,34 +38,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>>  	return kexec_image_post_load_cleanup_default(image);
>>  }
>>  
>> -#ifdef CONFIG_CRASH_DUMP
>> -unsigned int arch_get_system_nr_ranges(void)
>> -{
>> -	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* for exclusion of crashkernel region */
>> -	phys_addr_t start, end;
>> -	u64 i;
>> -
>> -	for_each_mem_range(i, &start, &end)
>> -		nr_ranges++;
>> -
>> -	return nr_ranges;
>> -}
>> -
>> -int arch_crash_populate_cmem(struct crash_mem *cmem)
>> -{
>> -	phys_addr_t start, end;
>> -	u64 i;
>> -
>> -	for_each_mem_range(i, &start, &end) {
>> -		cmem->ranges[cmem->nr_ranges].start = start;
>> -		cmem->ranges[cmem->nr_ranges].end = end - 1;
>> -		cmem->nr_ranges++;
>> -	}
>> -
>> -	return 0;
>> -}
>> -#endif
>> -
>>  /*
>>   * Tries to add the initrd and DTB to the image. If it is not possible to find
>>   * valid locations, this function will undo changes to the image and return non
>> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
>> index 5412aa9f3568..481b8f906a56 100644
>> --- a/arch/loongarch/kernel/machine_kexec_file.c
>> +++ b/arch/loongarch/kernel/machine_kexec_file.c
>> @@ -13,7 +13,6 @@
>>  #include <linux/ioport.h>
>>  #include <linux/kernel.h>
>>  #include <linux/kexec.h>
>> -#include <linux/memblock.h>
>>  #include <linux/slab.h>
>>  #include <linux/string.h>
>>  #include <linux/types.h>
>> @@ -56,32 +55,6 @@ static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdline_tmpl
>>  }
>>  
>>  #ifdef CONFIG_CRASH_DUMP
>> -unsigned int arch_get_system_nr_ranges(void)
>> -{
>> -	int nr_ranges = 2; /* for exclusion of crashkernel region */
>> -	phys_addr_t start, end;
>> -	uint64_t i;
>> -
>> -	for_each_mem_range(i, &start, &end)
>> -		nr_ranges++;
>> -
>> -	return nr_ranges;
>> -}
>> -
>> -int arch_crash_populate_cmem(struct crash_mem *cmem)
>> -{
>> -	phys_addr_t start, end;
>> -	uint64_t i;
>> -
>> -	for_each_mem_range(i, &start, &end) {
>> -		cmem->ranges[cmem->nr_ranges].start = start;
>> -		cmem->ranges[cmem->nr_ranges].end = end - 1;
>> -		cmem->nr_ranges++;
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>  /*
>>   * Add the "mem=size@start" command line parameter to command line, indicating the
>>   * memory region the new kernel can use to boot into.
>> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
>> index 808e872f4063..fdc6695e8588 100644
>> --- a/arch/riscv/kernel/machine_kexec_file.c
>> +++ b/arch/riscv/kernel/machine_kexec_file.c
>> @@ -37,32 +37,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>>  }
>>  
>>  #ifdef CONFIG_CRASH_DUMP
>> -unsigned int arch_get_system_nr_ranges(void)
>> -{
>> -	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* For exclusion of crashkernel region */
>> -	u64 i;
>> -	phys_addr_t start, end;
>> -
>> -	for_each_mem_range(i, &start, &end)
>> -		nr_ranges++;
>> -
>> -	return nr_ranges;
>> -}
>> -
>> -int arch_crash_populate_cmem(struct crash_mem *cmem)
>> -{
>> -	u64 i;
>> -	phys_addr_t start, end;
>> -
>> -	for_each_mem_range(i, &start, &end) {
>> -		cmem->ranges[cmem->nr_ranges].start = start;
>> -		cmem->ranges[cmem->nr_ranges].end = end - 1;
>> -		cmem->nr_ranges++;
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>  static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
>>  				 unsigned long cmdline_len)
>>  {
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 2b36aa9fade0..77285ae3ce60 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -281,8 +281,29 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
>>  	return cmem;
>>  }
>>  
>> -unsigned int __weak arch_get_system_nr_ranges(void) { return 0; }
>> -int __weak arch_crash_populate_cmem(struct crash_mem *cmem) { return -1; }
>> +unsigned int __weak arch_get_system_nr_ranges(void)
>> +{
>> +	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* crashk_res + crashk_low_res, +CMA splits */
>> +	phys_addr_t start, end;
>> +	u64 i;
>> +
>> +	for_each_mem_range(i, &start, &end)
>> +		nr_ranges++;
>> +	return nr_ranges;
>> +}
>> +
>> +int __weak arch_crash_populate_cmem(struct crash_mem *cmem)
>> +{
>> +	phys_addr_t start, end;
>> +	u64 i;
>> +
>> +	for_each_mem_range(i, &start, &end) {
>> +		cmem->ranges[cmem->nr_ranges].start = start;
>> +		cmem->ranges[cmem->nr_ranges].end = end - 1;
>> +		cmem->nr_ranges++;
>> +	}
>> +	return 0;
>> +}
>>  int __weak arch_crash_exclude_ranges(struct crash_mem *cmem) { return 0; }
>>  
>>  int __weak arch_crash_exclude_mem_range(struct crash_mem **mem,
>> -- 
>> 2.43.0
>>

