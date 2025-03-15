Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36902E3388
	for <iommu@lists.linux.dev>; Sat, 15 Mar 2025 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742031999; cv=none; b=aTbgdAj8dfTn8gGWsmsiX9T0DtJHqaNnIQLF9HhpftMhS1zxyvGuYVfT8WR0PjT2TxiSviizx08U5I/KA8c6m/P9tIk/ViRNCtwCgOOUW0ZrsS6IQcA4aftB6LY39YZFYlP31o5qBletvqOJw4cuKf8NoErbE9D1iKqjp+7dp7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742031999; c=relaxed/simple;
	bh=yPpjQIfHPrVSPxTZqDtcJroHA1maftTCXVJhgGr1bMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lI/5lZtQRuuYYyhKW4Spqq41xSOCqMP9Qrd4cQYaCxkMzLb06yAM/oiPDuXnCD/4B5XJmrDwdIhbDVHwpv8GxiD3619y7VTdhFinXC1dz/zgX2f/YhIamz/ewqM7N8BMh372KO4mNhDqAVx2BQG0RlRxd6Gxt18GfyLq1CTIJ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buRc8wGi; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buRc8wGi"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-22580c9ee0aso52595555ad.2
        for <iommu@lists.linux.dev>; Sat, 15 Mar 2025 02:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742031997; x=1742636797; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SEb9VVsDA46dLUAyiPSlPOMwshN3nVuc78uCBjMPhOQ=;
        b=buRc8wGiBJcpscu7XXaGG4Y8R6ffqjrjbV5ISx1/myhG0HXGHHp9BDWR9R9IAGe8Ix
         tHUIvN98vnvlR3ujXTuqCvEqXbDT5PbDjZHb6ZDoKDh3iUDxgJGZX0acqAzd4FxjYrFm
         nlP+Q6rVEF/Wks3/yU2RPIBXbExErd0ah8S641gQypuYOgdnzjLb9VrWNv4NDuRHRY7h
         GhkRbKB/EDb80KB+MQe/LElJVW5BJrOQSoAqlRQMp5eTiZ8a0tVPnjnbePqzGAL6lb+0
         w+LzXVLeLGl4boPvo/zo6OIQBpPerFDowb3WZ3PzGAeZKyZz2ahFs6QxdvRfIcUzpyoW
         vPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742031997; x=1742636797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SEb9VVsDA46dLUAyiPSlPOMwshN3nVuc78uCBjMPhOQ=;
        b=KN9+Ekbf9ZO0rK9oL2kgFbi577GchBpqzk++oKWva2PnVUPPHomtdTGZgnzo2Vi8CM
         20iuGu637OLtWHxUTuoKCR6+ONT9p+kfHNjBo2t6rRWMWuh6y96HFKZ2aCyDgqPIXykY
         w32HF2yeqxKvd1Xt61LeOT3XATF1T/yClz5SdcC1zH01K7mHRF8ua7wZdGOAUNtbBSe0
         T4XfOHP3brXie8SbkO4q6jCMzIAt+NIS67ewT/ioMiw03o0BHQR34/8HfLro0y3h3Slt
         OdMcbm4RDVb51JwDB38C7heHGij5HpaUHM5lz98GJByTKiwGplMAz0V8fQ7Arr5WbeAf
         F1+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4xLNMLq/GwyoPcWJ1QxLTbuc8jA2dsqitzQmSeF8nw/PviQt3LbxVsQqnRE9cacPWQHU1LQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/at3Wt5jDzqnQujccasrDLsZVfxVhfibvzAmSJ7o2YFwhXHHz
	/+pNcyscLLOkEntiKVXyrAItltC630x9YVsx30jErpgyca1cDRju
X-Gm-Gg: ASbGncsfNoFd3baQHJzZF+0/5xnwTiOYH2YMzb3HPH3SlCxP6onCSclEywO0YGmwLaw
	HK0kMEv4UpatMgoJc1ybt5pUx/t+6tINo0QsvBwO+mnckpIDXN1vfi1tW0hWnFJc62DhOZF9xnp
	vZ/2q80mfT/87mqo9UvAbVH7WKrOh03j6nfGI554IREFeHj2wjJ8wPt0G+eqyxo0v1aZvO34jar
	dxQh0947XP8zYH+nwiJcQvltdW9NL4C7szqHfSDfo2OtaP+cZpopKjHONqYj7qP8wBKU+bFyO3V
	eveBtvDWWGMOL/b8MZ6Q7/fKECRNKwRyikA3SbPgZ2tuRkzh0d06lmNWlFAwef+rkjtxMTB9iq6
	iEWA6iuCc9zSMgVgmhE8yZtWQNpvLfhBMtnfHsKCEg9k=
X-Google-Smtp-Source: AGHT+IFZnXHAgZQceFDsoMuHz5+fTNMK4JbPQMvAAWzKKaXEk43Ak9ISYRI/f/OPeq+PTQyEjWomMg==
X-Received: by 2002:a17:903:2ec3:b0:218:a43c:571e with SMTP id d9443c01a7336-225e0a9c832mr74458735ad.28.1742031996840;
        Sat, 15 Mar 2025 02:46:36 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:9067:2f1e:9768:2c54? ([2409:8a55:301b:e120:9067:2f1e:9768:2c54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe8f9sm41073505ad.175.2025.03.15.02.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 02:46:36 -0700 (PDT)
Message-ID: <db813035-fb38-4fc3-b91e-d1416959db13@gmail.com>
Date: Sat, 15 Mar 2025 17:46:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mina Almasry <almasrymina@google.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox
 <willy@infradead.org>, Robin Murphy <robin.murphy@arm.com>,
 IOMMU <iommu@lists.linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>,
 Yuying Ma <yuma@redhat.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
 <20250314-page-pool-track-dma-v1-3-c212e57a74c2@redhat.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <20250314-page-pool-track-dma-v1-3-c212e57a74c2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/14/2025 6:10 PM, Toke Høiland-Jørgensen wrote:

...

> 
> To avoid having to walk the entire xarray on unmap to find the page
> reference, we stash the ID assigned by xa_alloc() into the page
> structure itself, using the upper bits of the pp_magic field. This
> requires a couple of defines to avoid conflicting with the
> POINTER_POISON_DELTA define, but this is all evaluated at compile-time,
> so does not affect run-time performance. The bitmap calculations in this
> patch gives the following number of bits for different architectures:
> 
> - 24 bits on 32-bit architectures
> - 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_VALUE)
> - 32 bits on other 64-bit architectures

 From commit c07aea3ef4d4 ("mm: add a signature in struct page"):
"The page->signature field is aliased to page->lru.next and
page->compound_head, but it can't be set by mistake because the
signature value is a bad pointer, and can't trigger a false positive
in PageTail() because the last bit is 0."

And commit 8a5e5e02fc83 ("include/linux/poison.h: fix LIST_POISON{1,2} 
offset"):
"Poison pointer values should be small enough to find a room in
non-mmap'able/hardly-mmap'able space."

So the question seems to be:
1. Is stashing the ID causing page->pp_magic to be in the mmap'able/
    easier-mmap'able space? If yes, how can we make sure this will not
    cause any security problem?
2. Is the masking the page->pp_magic causing a valid pionter for
    page->lru.next or page->compound_head to be treated as a vaild
    PP_SIGNATURE? which might cause page_pool to recycle a page not
    allocated via page_pool.

> 
> Since all the tracking is performed on DMA map/unmap, no additional code
> is needed in the fast path, meaning the performance overhead of this
> tracking is negligible. A micro-benchmark shows that the total overhead
> of using xarray for this purpose is about 400 ns (39 cycles(tsc) 395.218
> ns; sum for both map and unmap[1]). Since this cost is only paid on DMA
> map and unmap, it seems like an acceptable cost to fix the late unmap

For most use cases when PP_FLAG_DMA_MAP is set and IOMMU is off, the
DMA map and unmap operation is almost negligible as said below, so the
cost is about 200% performance degradation, which doesn't seems like an
acceptable cost.

> issue. Further optimisation can narrow the cases where this cost is
> paid (for instance by eliding the tracking when DMA map/unmap is a
> no-op).

The above was discussed in [1] and brought up again in [2], so cc
Robin to see if there is any clarifying to see if he still view the
above as misuse of DMA API.

1. 
https://lore.kernel.org/all/9a4d1357-f30d-420d-a575-7ae305ca6dda@huawei.com/

2. https://lore.kernel.org/all/caf31b5e-0e8f-4844-b7ba-ef59ed13b74e@arm.com/

> 
> The extra memory needed to track the pages is neatly encapsulated inside
> xarray, which uses the 'struct xa_node' structure to track items. This
> structure is 576 bytes long, with slots for 64 items, meaning that a
> full node occurs only 9 bytes of overhead per slot it tracks (in
> practice, it probably won't be this efficient, but in any case it should

Is there any debug infrastructure to know if it is not this efficient?
as there may be 576 byte overhead for a page for the worst case.

> be an acceptable overhead).
 > > [0] 
https://lore.kernel.org/all/CAHS8izPg7B5DwKfSuzz-iOop_YRbk3Sd6Y4rX7KBG9DcVJcyWg@mail.gmail.com/
> [1] https://lore.kernel.org/r/ae07144c-9295-4c9d-a400-153bb689fe9e@huawei.com
> 
> Reported-by: Yonglong Liu <liuyonglong@huawei.com>
> Closes: https://lore.kernel.org/r/8743264a-9700-4227-a556-5f931c720211@huawei.com
> Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
> Suggested-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Tested-by: Qiuling Ren <qren@redhat.com>
> Tested-by: Yuying Ma <yuma@redhat.com>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

...

> @@ -1084,8 +1112,32 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
>   
>   static void page_pool_scrub(struct page_pool *pool)
>   {
> +	unsigned long id;
> +	void *ptr;
> +
>   	page_pool_empty_alloc_cache_once(pool);
> -	pool->destroy_cnt++;
> +	if (!pool->destroy_cnt++ && pool->dma_map) {
> +		if (pool->dma_sync) {
> +			/* paired with READ_ONCE in
> +			 * page_pool_dma_sync_for_device() and
> +			 * __page_pool_dma_sync_for_cpu()
> +			 */
> +			WRITE_ONCE(pool->dma_sync, false);
> +
> +			/* Make sure all concurrent returns that may see the old
> +			 * value of dma_sync (and thus perform a sync) have
> +			 * finished before doing the unmapping below. Skip the
> +			 * wait if the device doesn't actually need syncing, or
> +			 * if there are no outstanding mapped pages.
> +			 */
> +			if (dma_dev_need_sync(pool->p.dev) &&
> +			    !xa_empty(&pool->dma_mapped))
> +				synchronize_net();

I guess the above synchronize_net() is assuming that the above dma sync
API is always called in the softirq context, as it seems there is no
rcu read lock added in this patch to be paired with that.

Doesn't page_pool_put_page() might be called in non-softirq context when
allow_direct is false and in_softirq() returns false?

> +		}
> +
> +		xa_for_each(&pool->dma_mapped, id, ptr)
> +			__page_pool_release_page_dma(pool, page_to_netmem(ptr));
> +	}
>   
>   	/* No more consumers should exist, but producers could still
>   	 * be in-flight.
> 

