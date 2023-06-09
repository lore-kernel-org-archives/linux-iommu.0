Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADA0256D
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 12:33:05 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 46B5B1FDFC;
	Fri,  9 Jun 2023 12:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1686313978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZsrEHzsYnyHtsbKLymBWtLxiNzEIMAt6EujZ9H8hQ8=;
	b=Q3kyfEg8qtDawtF0d9l8bcuIQMXUBls1bY9nnx+FmpdW6CEZBW7leROyAMRuVh7JqWEa03
	8o1+LRoCt6PB9j1MtWa4rnl1dnPSXhMsBU2G7choTB/bZuKR4JNjHCHJEq6b9lyS+4Rkyk
	8QwY/xh5gDSCLp1bOmjCh6TbBwR2pLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1686313978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZsrEHzsYnyHtsbKLymBWtLxiNzEIMAt6EujZ9H8hQ8=;
	b=7FncRbw0qFhiQvgGLLF0qQYbko8s1TtF8MAVcJVh/VMUTLs+7VQ20/c5ZDDmuSiTsdry7P
	5CkFpj54l/mw5CDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05BE613A47;
	Fri,  9 Jun 2023 12:32:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id iu1XAPobg2QbQgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Fri, 09 Jun 2023 12:32:58 +0000
Message-ID: <dfacd429-31c4-872f-d0ac-447abf65d0f9@suse.cz>
Date: Fri, 9 Jun 2023 14:32:57 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v6 01/17] mm/slab: Decouple ARCH_KMALLOC_MINALIGN from
 ARCH_DMA_MINALIGN
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ard Biesheuvel <ardb@kernel.org>,
 Isaac Manjarres <isaacmanjarres@google.com>,
 Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>,
 Mark Brown <broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>, linux-mm@kvack.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20230531154836.1366225-1-catalin.marinas@arm.com>
 <20230531154836.1366225-2-catalin.marinas@arm.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230531154836.1366225-2-catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/23 17:48, Catalin Marinas wrote:
> In preparation for supporting a kmalloc() minimum alignment smaller than
> the arch DMA alignment, decouple the two definitions. This requires that
> either the kmalloc() caches are aligned to a (run-time) cache-line size
> or the DMA API bounces unaligned kmalloc() allocations. Subsequent
> patches will implement both options.
> 
> After this patch, ARCH_DMA_MINALIGN is expected to be used in static
> alignment annotations and defined by an architecture to be the maximum
> alignment for all supported configurations/SoCs in a single Image.
> Architectures opting in to a smaller ARCH_KMALLOC_MINALIGN will need to
> define its value in the arch headers.
> 
> Since ARCH_DMA_MINALIGN is now always defined, adjust the #ifdef in
> dma_get_cache_alignment() so that there is no change for architectures
> not requiring a minimum DMA alignment.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>  include/linux/dma-mapping.h |  2 +-
>  include/linux/slab.h        | 14 +++++++++++---
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 0ee20b764000..3288a1339271 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -545,7 +545,7 @@ static inline int dma_set_min_align_mask(struct device *dev,
>  
>  static inline int dma_get_cache_alignment(void)
>  {
> -#ifdef ARCH_DMA_MINALIGN
> +#ifdef ARCH_HAS_DMA_MINALIGN
>  	return ARCH_DMA_MINALIGN;
>  #endif
>  	return 1;
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 6b3e155b70bf..50dcf9cfbf62 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -235,12 +235,20 @@ void kmem_dump_obj(void *object);
>   * alignment larger than the alignment of a 64-bit integer.
>   * Setting ARCH_DMA_MINALIGN in arch headers allows that.
>   */
> -#if defined(ARCH_DMA_MINALIGN) && ARCH_DMA_MINALIGN > 8
> +#ifdef ARCH_DMA_MINALIGN
> +#define ARCH_HAS_DMA_MINALIGN
> +#if ARCH_DMA_MINALIGN > 8 && !defined(ARCH_KMALLOC_MINALIGN)
>  #define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
> -#define KMALLOC_MIN_SIZE ARCH_DMA_MINALIGN
> -#define KMALLOC_SHIFT_LOW ilog2(ARCH_DMA_MINALIGN)
> +#endif
>  #else
> +#define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
> +#endif

It seems weird to make slab.h responsible for this part, especially for
#define ARCH_HAS_DMA_MINALIGN, which dma-mapping.h consumes. Maybe it would
be difficult to do differently due to some dependency hell, but minimally I
don't see dma-mapping.h including slab.h so the result is
include-order-dependent? Maybe it's included transitively, but then it's
fragile and would be better to do explicitly?

> +
> +#ifndef ARCH_KMALLOC_MINALIGN
>  #define ARCH_KMALLOC_MINALIGN __alignof__(unsigned long long)
> +#elif ARCH_KMALLOC_MINALIGN > 8
> +#define KMALLOC_MIN_SIZE ARCH_KMALLOC_MINALIGN
> +#define KMALLOC_SHIFT_LOW ilog2(KMALLOC_MIN_SIZE)
>  #endif
>  
>  /*
> 

