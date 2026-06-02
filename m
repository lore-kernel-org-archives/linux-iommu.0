Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0B92192F9;
	Tue,  2 Jun 2026 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417492; cv=none; b=GcHXFQ/5V/Od+MqNQj5BKmzZaapH+bx4uioKKKHtdi2M5V35SFjlM7tBNewh1FRaOFBHTGwuzrngdj2qfGEfZ8cU/NKxCuUcuNrXzQ7aHAlIMHUEtk53WbVJlct+ETrQzbicyYu/VEFKxqVQz0EbcHRaQBg7BhRlS6SX/EgZGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417492; c=relaxed/simple;
	bh=Ulo3FgHC4z/nNBW5LOUpZTDZp261YFmHHWqLTwWxWkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugoxjgql8gHGs6a6PZk9Ey2ukYAJpXsTwzQq09l31jTYUg+wm6TpbXOn90ElpvTAEOqFLXE5l76aIO3XhJrX4sDyBdPll1PancwdE4a3kkx8dyo/v7D2ALJ6c/YNSic5NiOmvmv+svvK+N+1deARxVWh2y27HwFJtB9mn67f3ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWgXm3gq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWgXm3gq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112731F00893;
	Tue,  2 Jun 2026 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417491;
	bh=ARchzyUNZAbw3oM5o7JzGNUTWxidv0kmAjA3GG9Rj+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hWgXm3gqMKY1cga0sOGDmfX5tuur2FyZ2+UBKReLheii8J6pYT4NdM8Jm0IdJQTQn
	 YWb5GtNBHGO5azMu8v0S2CijL/q9nO0etmifndyKMg/5hUFS6st/r1flJP8/8tttch
	 THCbDFAXfUiokcjRZ8qLXphB/uxFsMKIq/qqcvhpFYvqfilke+/F4bnb9zSexfdfMJ
	 PBW5qll4e5sf/7LoTMSvRxiI3pFmz3IHO5uXBSfN1L/ZrofDyZuS5elvTeSfdzxzJ/
	 QHyYqEaWl9xKmA0OOuDM8nLNcMlZp52JjLzyOmS/xiU9ZsWzbevIAWWlCjMz0sBFvA
	 xnlna8VtJdPPA==
Date: Tue, 2 Jun 2026 11:24:50 -0500
From: Rob Herring <robh@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	iommu@lists.linux.dev, zhaomeijing@lixiang.com,
	catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
	kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, saravanak@kernel.org,
	akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, m.szyprowski@samsung.com,
	robin.murphy@arm.com, quic_obabatun@quicinc.com
Subject: Re: [PATCH v3 03/11] of: reserved_mem: avoid post-init UAF when
 alloc_reserved_mem_array() fails
Message-ID: <20260602162450.GA442759-robh@kernel.org>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
 <20260527032917.3385849-4-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527032917.3385849-4-chenwandun1@gmail.com>

On Wed, May 27, 2026 at 11:29:09AM +0800, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> The global pointer 'reserved_mem' continues to reference the
> reserved_mem_array which lives in __initdata if
> alloc_reserved_mem_array() fails. of_reserved_mem_lookup() is
> exported for post-init use, that would dereference freed memory
> and trigger a use-after-free.
> 
> So reset reserved_mem_count to 0 when alloc_reserved_mem_array()
> fails.
> 
> Fixes: 00c9a452a235 ("of: reserved_mem: Add code to dynamically allocate reserved_mem array")

Fixes should come first in a series.

> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> ---
>  drivers/of/of_reserved_mem.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 313cbc57aa45..6d479381ff1f 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -69,29 +69,31 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
>   * the initial static array is copied over to this new array and
>   * the new array is used from this point on.
>   */
> -static void __init alloc_reserved_mem_array(void)
> +static bool __init alloc_reserved_mem_array(void)
>  {
>  	struct reserved_mem *new_array;
>  	size_t alloc_size, copy_size, memset_size;
>  
> +	if (!total_reserved_mem_cnt)
> +		return true;
> +
>  	alloc_size = array_size(total_reserved_mem_cnt, sizeof(*new_array));
>  	if (alloc_size == SIZE_MAX) {
>  		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -EOVERFLOW);
> -		return;
> +		goto fail;
>  	}
>  
>  	new_array = memblock_alloc(alloc_size, SMP_CACHE_BYTES);
>  	if (!new_array) {
>  		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -ENOMEM);
> -		return;
> +		goto fail;
>  	}
>  
>  	copy_size = array_size(reserved_mem_count, sizeof(*new_array));
>  	if (copy_size == SIZE_MAX) {
>  		memblock_free(new_array, alloc_size);
> -		total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
>  		pr_err("Failed to allocate memory for reserved_mem array with err: %d", -EOVERFLOW);

These prints could be moved to 'fail'. Perhaps instead of just printing 
an error value, you can return the error value instead of boolean.

If you respin just this patch, I can pick it up for 7.2.

Rob
