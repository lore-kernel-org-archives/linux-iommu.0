Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA479E5
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 13:03:32 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0CD31FDF3;
	Fri,  9 Jun 2023 13:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1686315810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXTWetRzovuM3+C3woIc5wlaXXPnqlr1/vd1G1usCnA=;
	b=NKLoDM9VxAHZQolEa6XBydB5sCBmBTA3EOB2v427Zs52gF1hLvLUYg5JjVWJMbQZFOuW1u
	QZjHQck54atKJ+w5nuFomg+f5tac2cYX3GANmZuEuNQDHw/d2WcqsKVrLTXp4097QiZcaP
	S6beFnRf85KmuZ8CmIOlBwi/iBH0Oo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1686315810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXTWetRzovuM3+C3woIc5wlaXXPnqlr1/vd1G1usCnA=;
	b=4Kdhoqs9Qk7qEWjtCHoULTU+YsvIjww6lRSJ86R/yJgBpAL2FPREiYO023sOcOIlLv1NTP
	y2skYyMci389GzCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5AA8713A47;
	Fri,  9 Jun 2023 13:03:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id MKRFFSIjg2SYTQAAMHmgww
	(envelope-from <vbabka@suse.cz>); Fri, 09 Jun 2023 13:03:30 +0000
Message-ID: <91484289-3bbc-d834-f891-0b2ea1a0ae41@suse.cz>
Date: Fri, 9 Jun 2023 15:03:30 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v6 03/17] mm/slab: Simplify create_kmalloc_cache() args
 and make it static
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
 linux-arm-kernel@lists.infradead.org, David Rientjes <rientjes@google.com>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
References: <20230531154836.1366225-1-catalin.marinas@arm.com>
 <20230531154836.1366225-4-catalin.marinas@arm.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230531154836.1366225-4-catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/23 17:48, Catalin Marinas wrote:
> In the slab variant of kmem_cache_init(), call new_kmalloc_cache()
> instead of initialising the kmalloc_caches array directly. With this,
> create_kmalloc_cache() is now only called from new_kmalloc_cache() in
> the same file, so make it static. In addition, the useroffset argument
> is always 0 while usersize is the same as size. Remove them.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nice cleanup, thanks!

> ---
>  mm/slab.c        |  6 +-----
>  mm/slab.h        |  5 ++---
>  mm/slab_common.c | 14 ++++++--------
>  3 files changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index bb57f7fdbae1..b7817dcba63e 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1240,11 +1240,7 @@ void __init kmem_cache_init(void)
>  	 * Initialize the caches that provide memory for the  kmem_cache_node
>  	 * structures first.  Without this, further allocations will bug.
>  	 */
> -	kmalloc_caches[KMALLOC_NORMAL][INDEX_NODE] = create_kmalloc_cache(
> -				kmalloc_info[INDEX_NODE].name[KMALLOC_NORMAL],
> -				kmalloc_info[INDEX_NODE].size,
> -				ARCH_KMALLOC_FLAGS, 0,
> -				kmalloc_info[INDEX_NODE].size);
> +	new_kmalloc_cache(INDEX_NODE, KMALLOC_NORMAL, ARCH_KMALLOC_FLAGS);
>  	slab_state = PARTIAL_NODE;
>  	setup_kmalloc_cache_index_table();
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index f01ac256a8f5..592590fcddae 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -255,9 +255,8 @@ gfp_t kmalloc_fix_flags(gfp_t flags);
>  /* Functions provided by the slab allocators */
>  int __kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
>  
> -struct kmem_cache *create_kmalloc_cache(const char *name, unsigned int size,
> -			slab_flags_t flags, unsigned int useroffset,
> -			unsigned int usersize);
> +void __init new_kmalloc_cache(int idx, enum kmalloc_cache_type type,
> +			      slab_flags_t flags);
>  extern void create_boot_cache(struct kmem_cache *, const char *name,
>  			unsigned int size, slab_flags_t flags,
>  			unsigned int useroffset, unsigned int usersize);
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 607249785c07..7f069159aee2 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -658,17 +658,16 @@ void __init create_boot_cache(struct kmem_cache *s, const char *name,
>  	s->refcount = -1;	/* Exempt from merging for now */
>  }
>  
> -struct kmem_cache *__init create_kmalloc_cache(const char *name,
> -		unsigned int size, slab_flags_t flags,
> -		unsigned int useroffset, unsigned int usersize)
> +static struct kmem_cache *__init create_kmalloc_cache(const char *name,
> +						      unsigned int size,
> +						      slab_flags_t flags)
>  {
>  	struct kmem_cache *s = kmem_cache_zalloc(kmem_cache, GFP_NOWAIT);
>  
>  	if (!s)
>  		panic("Out of memory when creating slab %s\n", name);
>  
> -	create_boot_cache(s, name, size, flags | SLAB_KMALLOC, useroffset,
> -								usersize);
> +	create_boot_cache(s, name, size, flags | SLAB_KMALLOC, 0, size);
>  	list_add(&s->list, &slab_caches);
>  	s->refcount = 1;
>  	return s;
> @@ -863,7 +862,7 @@ void __init setup_kmalloc_cache_index_table(void)
>  	}
>  }
>  
> -static void __init
> +void __init
>  new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>  {
>  	if ((KMALLOC_RECLAIM != KMALLOC_NORMAL) && (type == KMALLOC_RECLAIM)) {
> @@ -880,8 +879,7 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>  
>  	kmalloc_caches[type][idx] = create_kmalloc_cache(
>  					kmalloc_info[idx].name[type],
> -					kmalloc_info[idx].size, flags, 0,
> -					kmalloc_info[idx].size);
> +					kmalloc_info[idx].size, flags);
>  
>  	/*
>  	 * If CONFIG_MEMCG_KMEM is enabled, disable cache merging for
> 

