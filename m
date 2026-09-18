Received: from mta0.migadu.com (out-137.mta0.migadu.com [91.218.175.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5637435C6AB
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718681; cv=none; b=r7psb3JUwhVuOOHSGEx3V0w8POtJ7LVvVVXEAZlO3WkPpW4uuCRPnd90D1qRgOXZKBvp4983NlQcRn7QIGAY29sgkBhYv0aYgCF8VGRZNbKrtTJZ8OItBaSMNq2TeTLtr7nMlHpG6E9+qC8YPdfNbw0XJ9WA0vOZTrw90UvPK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718681; c=relaxed/simple;
	bh=aMbcna5jLWNAqx3Ry2+7V7gyF2U3dGtOqExnDesb2fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+FVarSuW6yKraKFRweZvEc9NrFdYgEw8GGVzL2DHh4QCTncJuEgg3Fmj6V6X/rvcKd8abmwOw9D2Fpa30OkWTKgJ4S/Poa2gSvVO3xzc7/zex+PZBerd8wsR1lbY3kvqUAb0qwlUHbXBxOvSrTlnxVtoYJkoomH5I2X+cGTct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GM3c5Eao; arc=none smtp.client-ip=91.218.175.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GM3c5Eao"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=aMbcna5jLWNAqx3Ry2+7V7gyF2U3dGtOqExnDesb2fI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789718677; v=1; x=1790323477;
 b=GM3c5EaoyflUF7CWwtfTtu5IXbmYDA4S9MecRd3maV8jL/5eBAPLJhtz+IIeC27Bg8YeXroG
 sGJ10OP8XciAgkKoXHv3C/Q9rbV6R0sQRw623xarvpsk0LTGkyrGtTbGwOkNou2kuzaoTXZarC3
 ePWlB0u1vXPB9v/SPwZ13Bfk=
X-Envelope-To: iommu@lists.linux.dev
Received: by mta12.migadu.com with ESMTPS id e28637c2a9188785;
	Fri, 18 Sep 2026 08:04:36 +0000
X-Mizu-Trace-ID: e28637c2a9188785
X-Migadu-Flow: FLOW_OUT
Date: Fri, 18 Sep 2026 16:04:33 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Wandun Chen <chenwandun1@gmail.com>
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
Subject: Re: [PATCH v6 05/10] crash_core: replace for_each_mem_range() with
 for_each_mem_region()
Message-ID: <aqzwkVldaBWcMojx@fedora>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
 <20260902073116.802752-6-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902073116.802752-6-chenwandun1@gmail.com>

On 09/02/26 at 03:31pm, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> for_each_mem_range() skips MEMBLOCK_NOMAP regions implicitly. Switch the
> weak defaults to for_each_mem_region(), which exposes struct
> memblock_region and per-region flags, and filter NOMAP regions explicitly
> via the new crash_should_skip_region() helper. This prepares for a
> subsequent patch to extend the skip filter.
> 
> No functional change.
> 
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> ---
>  kernel/crash_core.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)

Acked-by: Baoquan He <baoquan.he@linux.dev>

> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 3adee1ae120c..bd64cf585795 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -270,6 +270,12 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>  	return 0;
>  }
>  
> +/* Exclude NOMAP regions from the vmcore. */
> +static bool crash_should_skip_region(struct memblock_region *reg)
> +{
> +	return memblock_is_nomap(reg);
> +}
> +
>  static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
>  {
>  	struct crash_mem *cmem;
> @@ -285,22 +291,25 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
>  unsigned int __weak arch_get_system_nr_ranges(void)
>  {
>  	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* crashk_res + crashk_low_res, +CMA splits */
> -	phys_addr_t start, end;
> -	u64 i;
> +	struct memblock_region *reg;
>  
> -	for_each_mem_range(i, &start, &end)
> +	for_each_mem_region(reg) {
> +		if (crash_should_skip_region(reg))
> +			continue;
>  		nr_ranges++;
> +	}
>  	return nr_ranges;
>  }
>  
>  int __weak arch_crash_populate_cmem(struct crash_mem *cmem)
>  {
> -	phys_addr_t start, end;
> -	u64 i;
> +	struct memblock_region *reg;
>  
> -	for_each_mem_range(i, &start, &end) {
> -		cmem->ranges[cmem->nr_ranges].start = start;
> -		cmem->ranges[cmem->nr_ranges].end = end - 1;
> +	for_each_mem_region(reg) {
> +		if (crash_should_skip_region(reg))
> +			continue;
> +		cmem->ranges[cmem->nr_ranges].start = reg->base;
> +		cmem->ranges[cmem->nr_ranges].end = reg->base + reg->size - 1;
>  		cmem->nr_ranges++;
>  	}
>  	return 0;
> -- 
> 2.43.0
> 
