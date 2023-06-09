Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84706D39
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 14:34:01 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1849B21A1C;
	Fri,  9 Jun 2023 14:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1686321237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQ5/N7tIpnehH7MNg1vCRZG6KJhrS3cnWdoR3DT75S0=;
	b=0x4PDx2WgWEEMtCNo0TUQk8emvr+6TCjcUkl/iYzM5SaUCuAW6CcpwnWUbxjChnbeINtfU
	DMIuNCS3djQAsKqf3O8xe/QKzPejV7Cd5G9uba4tgX7+ho3EQMwkwhKIvYVTw3Axmfry1T
	7uMFJPrXsLnYamEahXpT4Xa75B0b20Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1686321237;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQ5/N7tIpnehH7MNg1vCRZG6KJhrS3cnWdoR3DT75S0=;
	b=iVjQ83RC5Vfu9jY7+B+Iscc8r0IIsumksRx96GBNACPaLUsTuQtjmwglOEHowGwLN8/HFc
	6exgN8sJteR9X8BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D65013A47;
	Fri,  9 Jun 2023 14:33:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id liS3JFQ4g2QVcAAAMHmgww
	(envelope-from <vbabka@suse.cz>); Fri, 09 Jun 2023 14:33:56 +0000
Message-ID: <90b845e6-c121-2e10-6750-c170b1fa8c7f@suse.cz>
Date: Fri, 9 Jun 2023 16:33:56 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v6 04/17] mm/slab: Limit kmalloc() minimum alignment to
 dma_get_cache_alignment()
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
 linux-arm-kernel@lists.infradead.org, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Pekka Enberg <penberg@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20230531154836.1366225-1-catalin.marinas@arm.com>
 <20230531154836.1366225-5-catalin.marinas@arm.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230531154836.1366225-5-catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/23 17:48, Catalin Marinas wrote:
> Do not create kmalloc() caches which are not aligned to
> dma_get_cache_alignment(). There is no functional change since for
> current architectures defining ARCH_DMA_MINALIGN, ARCH_KMALLOC_MINALIGN
> equals ARCH_DMA_MINALIGN (and dma_get_cache_alignment()). On
> architectures without a specific ARCH_DMA_MINALIGN,
> dma_get_cache_alignment() is 1, so no change to the kmalloc() caches.
> 
> If an architecture selects ARCH_HAS_DMA_CACHE_LINE_SIZE (introduced
> previously), the kmalloc() caches will be aligned to a cache line size.

It this part leftover from a previous version?

> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slab_common.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 7f069159aee2..7c6475847fdf 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -17,6 +17,7 @@
>  #include <linux/cpu.h>
>  #include <linux/uaccess.h>
>  #include <linux/seq_file.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/proc_fs.h>
>  #include <linux/debugfs.h>
>  #include <linux/kasan.h>
> @@ -862,9 +863,18 @@ void __init setup_kmalloc_cache_index_table(void)
>  	}
>  }
>  
> +static unsigned int __kmalloc_minalign(void)
> +{
> +	return dma_get_cache_alignment();
> +}
> +
>  void __init
>  new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>  {
> +	unsigned int minalign = __kmalloc_minalign();
> +	unsigned int aligned_size = kmalloc_info[idx].size;
> +	int aligned_idx = idx;
> +
>  	if ((KMALLOC_RECLAIM != KMALLOC_NORMAL) && (type == KMALLOC_RECLAIM)) {
>  		flags |= SLAB_RECLAIM_ACCOUNT;
>  	} else if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_CGROUP)) {
> @@ -877,9 +887,17 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>  		flags |= SLAB_CACHE_DMA;
>  	}
>  
> -	kmalloc_caches[type][idx] = create_kmalloc_cache(
> -					kmalloc_info[idx].name[type],
> -					kmalloc_info[idx].size, flags);
> +	if (minalign > ARCH_KMALLOC_MINALIGN) {
> +		aligned_size = ALIGN(aligned_size, minalign);
> +		aligned_idx = __kmalloc_index(aligned_size, false);
> +	}
> +
> +	if (!kmalloc_caches[type][aligned_idx])
> +		kmalloc_caches[type][aligned_idx] = create_kmalloc_cache(
> +					kmalloc_info[aligned_idx].name[type],
> +					aligned_size, flags);
> +	if (idx != aligned_idx)
> +		kmalloc_caches[type][idx] = kmalloc_caches[type][aligned_idx];
>  
>  	/*
>  	 * If CONFIG_MEMCG_KMEM is enabled, disable cache merging for
> 

