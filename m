Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7AC17578
	for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915492; cv=none; b=bE+y3s4z3KiCXY/IscxkjvOd9mnqFCcR4aoVPdavL2h1EQ9oItCFpB2RXj1JcW7H9WOk1Knb/gjDqy4db7q6SZcWY17twDzr0mzkzles8x1FTmYN2LsCv0npU1kUwow5sJ5WuP+mk/X6VRrJxS0d+iJ4yKLfz/5XD0BcVOre7/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915492; c=relaxed/simple;
	bh=crSbkX5wZCnAYf+xoVb8D9BZ0tyCYd1uy4y9JGpiV64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BeRN8LKOTjd3zVkWp+71oe6a4vU+xyeoKQIeaDqgDrigLNJJWIhH8p5WGkA7FawUHhMXcQ0jA5G7d0UKIvjsgo1zOLDBOhzyAosHFsM+q4BVfNDKqFJmvOnih8ayjWV/V2hBdaT9bWGySsxCGeIitb03N9lOabsEFzZZcz13i+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 800DF1D13;
	Mon, 11 Aug 2025 05:31:20 -0700 (PDT)
Received: from [10.57.5.137] (unknown [10.57.5.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EC983F738;
	Mon, 11 Aug 2025 05:31:24 -0700 (PDT)
Message-ID: <d8048adc-b19a-4d10-83e8-44b9a85c4d48@arm.com>
Date: Mon, 11 Aug 2025 13:31:28 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 2/2] arm64: Add encrypt/decrypt support for vmalloc
 regions
To: Shanker Donthineni <sdonthineni@nvidia.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Steven Price <steven.price@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: Gavin Shan <gshan@redhat.com>, Mike Rapoport <rppt@kernel.org>,
 Vikram Sethi <vsethi@nvidia.com>, Jason Sequeira <jsequeira@nvidia.com>,
 Dev Jain <dev.jain@arm.com>, David Rientjes <rientjes@google.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250811005036.714274-1-sdonthineni@nvidia.com>
 <20250811005036.714274-3-sdonthineni@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=0
X-Identity-Key: id1
Fcc: imap://robin.murphy%40arm.com@outlook.office365.com/Sent Items
In-Reply-To: <20250811005036.714274-3-sdonthineni@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-08-11 1:50 am, Shanker Donthineni wrote:
> On ARM64 systems with CCA (Confidential Compute Architecture) enabled,
> the kernel may need to change the encryption attributes of memory
> regions. The existing implementation of set_memory_encrypted() and
> set_memory_decrypted() assumes that the input address is part of the
> linear mapping region '__is_lm_address()', and fails with -EINVAL
> otherwise.
> 
> This breaks use cases where the memory region resides in the vmalloc
> area, which is mapped in non-linear mapping region.
> 
> This patch introduces a new helper, realm_set_memory(), which detects
> whether the given address is from a non-linear mapping. If so, it uses
> vmalloc_to_page() to resolve each page’s physical address and applies
> attribute changes one page at a time. For the linear address regions,
> it maintains the existing fast-path.
> 
> This change ensures that encrypted/decrypted memory attribute updates
> correctly for all memory regions, including those allocated via vmap(),
> module allocations, or other vmalloc-backed paths.
> 
> Call stack of Realm crash, QEMU hypervisor + NVME device (emulated):
>   ...
>   Freeing unused kernel memory: 6336K
>   Run /sbin/init as init process
>   Internal error: synchronous external abort: 0000000096000250 [#1]  SMP
>   Modules linked in:
>   CPU: 0 UID: 0 PID: 64 Comm: lsblk Not tainted 6.15.5 #2 PREEMPT(undef)
>   Hardware name: linux,dummy-virt (DT)
>   pstate: 43400005 (nZcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
>   pc : __pi_memset_generic+0x16c/0x188
>   lr : dma_alloc_from_pool+0xd0/0x1b8
>   sp : ffff80008335b350
>   x29: ffff80008335b350 x28: ffff800083162000 x27: ffff80008335b3c0
>   x26: ffff80008144f000 x25: ffff8000801a27e8 x24: ffff800081e14000
>   x23: ffffc1ffc0000000 x22: 0000000000001000 x21: ffff800081458310
>   x20: 0000000042a40000 x19: ffff00000232fcc0 x18: 0000000000200000
>   x17: 00000000000120c0 x16: ffff0000795520c0 x15: 0000000000000000
>   x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>   x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
>   x8 : ffff800083162000 x7 : 0000000000000000 x6 : 000000000000003f
>   x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000004
>   x2 : 0000000000000fc0 x1 : 0000000000000000 x0 : ffff800083162000
>   Call trace:
>     __pi_memset_generic+0x16c/0x188 (P)
>     dma_direct_alloc_from_pool+0xc4/0x230

But isn't that exactly the case that patch #1 is supposed to have fixed? 
 From a quick scan of set_memory_decrypted() callers I don't see 
anything obvious jumping out - can you clarify who you think needs this 
for reasons other than papering over bugs in the DMA layer?

Thanks,
Robin.

>     dma_direct_alloc+0x80/0x4a0
>     dma_alloc_attrs+0x94/0x238
>     dma_pool_alloc+0x128/0x258
>     nvme_prep_rq.part.0+0x5f0/0x950
>     nvme_queue_rq+0x78/0x1e8
>     blk_mq_dispatch_rq_list+0x10c/0x6f0
>     __blk_mq_sched_dispatch_requests+0x4a0/0x580
>     blk_mq_sched_dispatch_requests+0x38/0xa0
>     blk_mq_run_hw_queue+0x288/0x2f8
>     blk_mq_flush_plug_list+0x134/0x630
>     __blk_flush_plug+0x100/0x168
>     blk_finish_plug+0x40/0x60
>     read_pages+0x1a0/0x2b0
>     page_cache_ra_unbounded+0x1f8/0x268
>     force_page_cache_ra+0xa4/0xe0
>     page_cache_sync_ra+0x48/0x268
>     filemap_get_pages+0xf4/0x7a0
>     filemap_read+0xf0/0x448
>     blkdev_read_iter+0x8c/0x1a8
>     vfs_read+0x288/0x330
>     ksys_read+0x78/0x118
>     __arm64_sys_read+0x24/0x40
>     invoke_syscall+0x50/0x120
>     el0_svc_common.constprop.0+0x48/0xf0
>     do_el0_svc+0x24/0x38
>     el0_svc+0x34/0xf8
>     el0t_64_sync_handler+0x10c/0x138
>     el0t_64_sync+0x1ac/0x1b0
> 
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> ---
>   arch/arm64/mm/pageattr.c | 55 +++++++++++++++++++++++++++++++++++-----
>   1 file changed, 48 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 04d4a8f676db4..65c3322a86b49 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -202,21 +202,26 @@ int set_direct_map_default_noflush(struct page *page)
>   				   PAGE_SIZE, change_page_range, &data);
>   }
>   
> +/*
> + * Common function for setting memory encryption or decryption attributes.
> + *
> + * @addr:        Virtual start address of the memory region
> + * @start:       Corresponding physical start address
> + * @numpages:    Number of pages to update
> + * @encrypt:     If true, set memory as encrypted; if false, decrypt
> + */
>   static int __set_memory_enc_dec(unsigned long addr,
> +				phys_addr_t start,
>   				int numpages,
>   				bool encrypt)
>   {
>   	unsigned long set_prot = 0, clear_prot = 0;
> -	phys_addr_t start, end;
> +	phys_addr_t end;
>   	int ret;
>   
>   	if (!is_realm_world())
>   		return 0;
>   
> -	if (!__is_lm_address(addr))
> -		return -EINVAL;
> -
> -	start = __virt_to_phys(addr);
>   	end = start + numpages * PAGE_SIZE;
>   
>   	if (encrypt)
> @@ -248,9 +253,45 @@ static int __set_memory_enc_dec(unsigned long addr,
>   				      __pgprot(0));
>   }
>   
> +/*
> + * Wrapper for __set_memory_enc_dec() that handles both linear-mapped
> + * and vmalloc/module memory regions.
> + *
> + * If the address is in the linear map, we can directly compute the
> + * physical address. If not (e.g. vmalloc memory), we walk each page
> + * and call the attribute update individually.
> + */
> +static int realm_set_memory(unsigned long addr, int numpages, bool encrypt)
> +{
> +	phys_addr_t start;
> +	struct page *page;
> +	int ret, i;
> +
> +	if (__is_lm_address(addr)) {
> +		start = __virt_to_phys(addr);
> +		return __set_memory_enc_dec(addr, start, numpages, encrypt);
> +	}
> +
> +	for (i = 0; i < numpages; i++) {
> +		page = vmalloc_to_page((void *)addr);
> +		if (!page)
> +			return -EINVAL;
> +
> +		start = page_to_phys(page);
> +		ret = __set_memory_enc_dec(addr, start, 1, encrypt);
> +		if (ret)
> +			return ret;
> +
> +		addr += PAGE_SIZE;
> +	}
> +
> +	return 0;
> +}
> +
>   static int realm_set_memory_encrypted(unsigned long addr, int numpages)
>   {
> -	int ret = __set_memory_enc_dec(addr, numpages, true);
> +	int ret = realm_set_memory(addr, numpages, true);
> +
>   
>   	/*
>   	 * If the request to change state fails, then the only sensible cause
> @@ -264,7 +305,7 @@ static int realm_set_memory_encrypted(unsigned long addr, int numpages)
>   
>   static int realm_set_memory_decrypted(unsigned long addr, int numpages)
>   {
> -	int ret = __set_memory_enc_dec(addr, numpages, false);
> +	int ret = realm_set_memory(addr, numpages, false);
>   
>   	WARN(ret, "Failed to decrypt memory, %d pages will be leaked",
>   	     numpages);

