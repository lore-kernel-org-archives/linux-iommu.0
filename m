Received: from mta0.migadu.com (out-128.mta0.migadu.com [91.218.175.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553804973BB
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721338; cv=none; b=m4Kxk3shZy+pJN0FoOJvjv7SwNb49yqCvVKT84/wHuVD4M2y1vta44ZQitQ8V1aVgKxkyL/wrxJ0bkCsc3M07bVHafg0PfVyzfnXur10NaNWDeOaaQiA3haUd1hjUVh41LOeuPzxa74j2N3tnp9g/WcHM5YNBznBwRV59ul2CLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721338; c=relaxed/simple;
	bh=BGRV/j7qC/zFRryyQ69/Qz6UrrritH2vK+O2tUc3+pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhQeKQWhR4pmRhkohybOk2sk3jqbnsomAcKcGeCkRYO70UrjPiQUpADG+2yalVhkywyDwDg5ha7fNVL1CDyK0qLPZoedxlksr4ifAaETkr0ZnlozRIMz1VJAonVkUtkrI5kdPqkCPw6rxQ7Jc1fSFZQ9yGwlMnfvElg9Ijs5Yjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N+eIauUv; arc=none smtp.client-ip=91.218.175.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N+eIauUv"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=BGRV/j7qC/zFRryyQ69/Qz6UrrritH2vK+O2tUc3+pA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789721328; v=1; x=1790326128;
 b=N+eIauUvk9q0yZwY04e7hswM20JaJhHMg1rsm5Pxz8h9GmWgeU/13NnFpzrfk/AH2+YXEgIk
 d3p51EiZ3CrKDfboFo/JBI9HuHIizs67n7gGPFEhJikQH8YQ8rYal/OzX4pV1O/sDf8J0JYoltL
 0NwFltHidckM8QCMAq/h/144=
X-Envelope-To: iommu@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id 308a52a5f758be34;
	Fri, 18 Sep 2026 08:48:48 +0000
X-Mizu-Trace-ID: 308a52a5f758be34
X-Migadu-Flow: FLOW_OUT
Date: Fri, 18 Sep 2026 16:48:41 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Wandun <chenwandun1@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, robh@kernel.org,
	saravanak@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	m.szyprowski@samsung.com, mark.rutland@arm.com, kernel@xen0n.name,
	alex@ghiti.fr, hpa@zytor.com, ruirui.yang@linux.dev,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v6 03/10] crash_core: fold duplicated memblock arch hooks
 into the weak default
Message-ID: <aqz66dMlp3NiMifc@fedora>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-4-chenwandun1@gmail.com>
 <aqzolBceoRchBdbx@fedora>
 <c58e9b6a-e421-4265-aa77-48c07a4fb8e4@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c58e9b6a-e421-4265-aa77-48c07a4fb8e4@gmail.com>

On 09/18/26 at 04:45pm, Wandun wrote:
> 
> 
> On 9/18/26 15:30, Baoquan He wrote:
> > On 09/02/26 at 03:31pm, Wandun Chen wrote:
> >> From: Wandun Chen <chenwandun@lixiang.com>
> >>
> >> arm64, loongarch and riscv open-code the same memblock walk in
> >> arch_get_system_nr_ranges() and arch_crash_populate_cmem(). Move it into
> >> the __weak defaults in kernel/crash_core.c and delete the arch copies.
> >>
> >> No functional change.
> > 
> > In one version, you also tried to remove these functions on x86, I could
> > remember it wrong. 
> 
> Yes, the x86 implementation can also remove these functions and use the same
> approach as arm64, RISC-V, and LoongArch. However since this change would not
> reduce the vmcore size on x86 at all, I did not include it in the current series.
> 
> I plan to refactor this part on x86 after this series.

OK, that's fine. I remember I saw the code, but couldn't find it in this
patch. Thanks for telling.

> 
> 
> 
> > 
> > Anyway, this looks good to me.
> > 
> > Acked-by: Baoquan He <baoquan.he@linux.dev>
> > 
> >>
> >> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> >> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> >> ---
> >>  arch/arm64/kernel/machine_kexec_file.c     | 29 ----------------------
> >>  arch/loongarch/kernel/machine_kexec_file.c | 27 --------------------
> >>  arch/riscv/kernel/machine_kexec_file.c     | 26 -------------------
> >>  kernel/crash_core.c                        | 25 +++++++++++++++++--
> >>  4 files changed, 23 insertions(+), 84 deletions(-)
> >>
> >> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> >> index 854d872dfd0f..34d944d3f22f 100644
> >> --- a/arch/arm64/kernel/machine_kexec_file.c
> >> +++ b/arch/arm64/kernel/machine_kexec_file.c
> >> @@ -14,7 +14,6 @@
> >>  #include <linux/kernel.h>
> >>  #include <linux/kexec.h>
> >>  #include <linux/libfdt.h>
> >> -#include <linux/memblock.h>
> >>  #include <linux/of.h>
> >>  #include <linux/of_fdt.h>
> >>  #include <linux/slab.h>
> >> @@ -39,34 +38,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
> >>  	return kexec_image_post_load_cleanup_default(image);
> >>  }
> >>  
> >> -#ifdef CONFIG_CRASH_DUMP
> >> -unsigned int arch_get_system_nr_ranges(void)
> >> -{
> >> -	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* for exclusion of crashkernel region */
> >> -	phys_addr_t start, end;
> >> -	u64 i;
> >> -
> >> -	for_each_mem_range(i, &start, &end)
> >> -		nr_ranges++;
> >> -
> >> -	return nr_ranges;
> >> -}
> >> -
> >> -int arch_crash_populate_cmem(struct crash_mem *cmem)
> >> -{
> >> -	phys_addr_t start, end;
> >> -	u64 i;
> >> -
> >> -	for_each_mem_range(i, &start, &end) {
> >> -		cmem->ranges[cmem->nr_ranges].start = start;
> >> -		cmem->ranges[cmem->nr_ranges].end = end - 1;
> >> -		cmem->nr_ranges++;
> >> -	}
> >> -
> >> -	return 0;
> >> -}
> >> -#endif
> >> -
> >>  /*
> >>   * Tries to add the initrd and DTB to the image. If it is not possible to find
> >>   * valid locations, this function will undo changes to the image and return non
> >> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
> >> index 5412aa9f3568..481b8f906a56 100644
> >> --- a/arch/loongarch/kernel/machine_kexec_file.c
> >> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> >> @@ -13,7 +13,6 @@
> >>  #include <linux/ioport.h>
> >>  #include <linux/kernel.h>
> >>  #include <linux/kexec.h>
> >> -#include <linux/memblock.h>
> >>  #include <linux/slab.h>
> >>  #include <linux/string.h>
> >>  #include <linux/types.h>
> >> @@ -56,32 +55,6 @@ static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdline_tmpl
> >>  }
> >>  
> >>  #ifdef CONFIG_CRASH_DUMP
> >> -unsigned int arch_get_system_nr_ranges(void)
> >> -{
> >> -	int nr_ranges = 2; /* for exclusion of crashkernel region */
> >> -	phys_addr_t start, end;
> >> -	uint64_t i;
> >> -
> >> -	for_each_mem_range(i, &start, &end)
> >> -		nr_ranges++;
> >> -
> >> -	return nr_ranges;
> >> -}
> >> -
> >> -int arch_crash_populate_cmem(struct crash_mem *cmem)
> >> -{
> >> -	phys_addr_t start, end;
> >> -	uint64_t i;
> >> -
> >> -	for_each_mem_range(i, &start, &end) {
> >> -		cmem->ranges[cmem->nr_ranges].start = start;
> >> -		cmem->ranges[cmem->nr_ranges].end = end - 1;
> >> -		cmem->nr_ranges++;
> >> -	}
> >> -
> >> -	return 0;
> >> -}
> >> -
> >>  /*
> >>   * Add the "mem=size@start" command line parameter to command line, indicating the
> >>   * memory region the new kernel can use to boot into.
> >> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
> >> index 808e872f4063..fdc6695e8588 100644
> >> --- a/arch/riscv/kernel/machine_kexec_file.c
> >> +++ b/arch/riscv/kernel/machine_kexec_file.c
> >> @@ -37,32 +37,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
> >>  }
> >>  
> >>  #ifdef CONFIG_CRASH_DUMP
> >> -unsigned int arch_get_system_nr_ranges(void)
> >> -{
> >> -	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* For exclusion of crashkernel region */
> >> -	u64 i;
> >> -	phys_addr_t start, end;
> >> -
> >> -	for_each_mem_range(i, &start, &end)
> >> -		nr_ranges++;
> >> -
> >> -	return nr_ranges;
> >> -}
> >> -
> >> -int arch_crash_populate_cmem(struct crash_mem *cmem)
> >> -{
> >> -	u64 i;
> >> -	phys_addr_t start, end;
> >> -
> >> -	for_each_mem_range(i, &start, &end) {
> >> -		cmem->ranges[cmem->nr_ranges].start = start;
> >> -		cmem->ranges[cmem->nr_ranges].end = end - 1;
> >> -		cmem->nr_ranges++;
> >> -	}
> >> -
> >> -	return 0;
> >> -}
> >> -
> >>  static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
> >>  				 unsigned long cmdline_len)
> >>  {
> >> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> >> index 2b36aa9fade0..77285ae3ce60 100644
> >> --- a/kernel/crash_core.c
> >> +++ b/kernel/crash_core.c
> >> @@ -281,8 +281,29 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
> >>  	return cmem;
> >>  }
> >>  
> >> -unsigned int __weak arch_get_system_nr_ranges(void) { return 0; }
> >> -int __weak arch_crash_populate_cmem(struct crash_mem *cmem) { return -1; }
> >> +unsigned int __weak arch_get_system_nr_ranges(void)
> >> +{
> >> +	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* crashk_res + crashk_low_res, +CMA splits */
> >> +	phys_addr_t start, end;
> >> +	u64 i;
> >> +
> >> +	for_each_mem_range(i, &start, &end)
> >> +		nr_ranges++;
> >> +	return nr_ranges;
> >> +}
> >> +
> >> +int __weak arch_crash_populate_cmem(struct crash_mem *cmem)
> >> +{
> >> +	phys_addr_t start, end;
> >> +	u64 i;
> >> +
> >> +	for_each_mem_range(i, &start, &end) {
> >> +		cmem->ranges[cmem->nr_ranges].start = start;
> >> +		cmem->ranges[cmem->nr_ranges].end = end - 1;
> >> +		cmem->nr_ranges++;
> >> +	}
> >> +	return 0;
> >> +}
> >>  int __weak arch_crash_exclude_ranges(struct crash_mem *cmem) { return 0; }
> >>  
> >>  int __weak arch_crash_exclude_mem_range(struct crash_mem **mem,
> >> -- 
> >> 2.43.0
> >>
> 
