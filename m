Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B143199AF
	for <iommu@lists.linux.dev>; Tue, 31 Oct 2023 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="oa8JtXsd"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id B244D190C97;
	Tue, 31 Oct 2023 11:43:22 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1698749003; bh=jdCPy8MRdQgBRdIuWsT+HvlNGVFk2v04c88rT8qjyqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oa8JtXsdnPE4gwCftToiBbqkSMSYruxk7HFOzsgPFJUXN1KiQHmEZIDe7FYcTPyyi
	 iPd2ruOehuiA3Az6MM9lOXB1GWJkpnQ+j9aKMyJwzCGi5Lp1RWh6FzOOvgz5LUYgoI
	 SiZRztBziVKU/KKg1uSgtLTWa0nQPknt/a1qt9VqbPjT20dPJ1M+mnCdfHzPPLkhEk
	 vekx+ktehleXu753zt6LKNMwyN88zJCOmjW9Gol2ANZToAEdT9pPeyHRynkr1CZ5Aa
	 9z7+uDLcktI5MFk85meR7Bjtx+7FZuq3Qu5ZRHLaC9DnjR8+ckQVEw/jMWRqaq6oDV
	 TCBIzrCEp6BLA==
Date: Tue, 31 Oct 2023 11:43:16 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
 peterz@infradead.org, kirill.shutemov@linux.intel.com,
 elena.reshetova@intel.com, isaku.yamahata@intel.com, seanjc@google.com,
 Michael Kelley <mikelley@microsoft.com>, thomas.lendacky@amd.com,
 decui@microsoft.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev
Subject: Re: [PATCH 04/10] swiotlb: Use free_decrypted_pages()
Message-ID: <20231031114316.0bfa8d91@meshulam.tesarici.cz>
In-Reply-To: <20231017202505.340906-5-rick.p.edgecombe@intel.com>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
	<20231017202505.340906-5-rick.p.edgecombe@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 13:24:59 -0700
Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:

> On TDX it is possible for the untrusted host to cause
> set_memory_encrypted() or set_memory_decrypted() to fail such that an
> error is returned and the resulting memory is shared. Callers need to take
> care to handle these errors to avoid returning decrypted (shared) memory to
> the page allocator, which could lead to functional or security issues.
> 
> Swiotlb could free decrypted/shared pages if set_memory_decrypted() fails.
> Use the recently added free_decrypted_pages() to avoid this.
> 
> In swiotlb_exit(), check for set_memory_encrypted() errors manually,
> because the pages are not nessarily going to the page allocator.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: iommu@lists.linux.dev
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  kernel/dma/swiotlb.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 394494a6b1f3..ad06786c4f98 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -524,6 +524,7 @@ void __init swiotlb_exit(void)
>  	unsigned long tbl_vaddr;
>  	size_t tbl_size, slots_size;
>  	unsigned int area_order;
> +	int ret;
>  
>  	if (swiotlb_force_bounce)
>  		return;
> @@ -536,17 +537,19 @@ void __init swiotlb_exit(void)
>  	tbl_size = PAGE_ALIGN(mem->end - mem->start);
>  	slots_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), mem->nslabs));
>  
> -	set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
> +	ret = set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
>  	if (mem->late_alloc) {
>  		area_order = get_order(array_size(sizeof(*mem->areas),
>  			mem->nareas));
>  		free_pages((unsigned long)mem->areas, area_order);
> -		free_pages(tbl_vaddr, get_order(tbl_size));
> +		if (!ret)
> +			free_pages(tbl_vaddr, get_order(tbl_size));
>  		free_pages((unsigned long)mem->slots, get_order(slots_size));
>  	} else {
>  		memblock_free_late(__pa(mem->areas),
>  			array_size(sizeof(*mem->areas), mem->nareas));
> -		memblock_free_late(mem->start, tbl_size);
> +		if (!ret)
> +			memblock_free_late(mem->start, tbl_size);
>  		memblock_free_late(__pa(mem->slots), slots_size);
>  	}
>  
> @@ -581,7 +584,7 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes)
>  	return page;
>  
>  error:
> -	__free_pages(page, order);
> +	free_decrypted_pages((unsigned long)vaddr, order);
>  	return NULL;
>  }

I admit I'm not familiar with the encryption/decryption API, but if a
__free_pages() is not sufficient here, then it is quite confusing.
The error label is reached only if set_memory_decrypted() returns
non-zero. My naive expectation is that the memory is *not* decrypted in
that case and does not require special treatment. Is this assumption
wrong?

OTOH I believe there is a bug in the logic. The subsequent
__free_pages() in swiotlb_alloc_tlb() would have to be changed to a
free_decrypted_pages(). However, I'm proposing a different approach to
address the latter issue here:

https://lore.kernel.org/linux-iommu/20231026095123.222-1-petrtesarik@huaweicloud.com/T/

Petr T
