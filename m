Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232B9189B84
	for <iommu@lists.linux.dev>; Fri, 27 Sep 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727428932; cv=none; b=VwosCO9sPf15HmvSFgxy5seFgnrV5wArsvDAGt9CyMMbFoWc05e0FGdVg58Ux7uwI2dEi6K8wd7shSuSzzCfuiTtFemVeZOYBNkFKjfbV+eJyZSdwpwjQpLhjOThD0LS7DHrM3AeH5OXixwN0A4Czhxqa1VnEhykKAVS7du0saA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727428932; c=relaxed/simple;
	bh=12b5Ewn3cylugkvg1EbdzJzESK9RcP19B7oJlHII/b8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQoaxkT9BwuYBWkvWKUgRaarrtuSr7scGYIJ8HRlNZOC780hu2OMu85v06TG8YHhcR/DpTyd0sQUwhp0IS/h7vEGgOpTO1g/Ky9RBMZaeunFji2N5q3EZmtq3NVqpckkVyvuKBuqj0WsXiEfVcT6vBBP7miEyPPK8kgywcBQa0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bFLZc8CC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFLZc8CC"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-206aee40676so16344925ad.0
        for <iommu@lists.linux.dev>; Fri, 27 Sep 2024 02:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727428930; x=1728033730; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u12Tug5k2bdyzIU9WiqUE2EObFB7IXUcT3bKNNPZCB0=;
        b=bFLZc8CC9zRLrRcLYBWPaQnSJH6TcZou0mx10Hn/alEjPVs2emSyu8z3ltklcFp+A3
         2oOj+a76C11s8iitvuFtmepIXvWrHNPp2VqBSj4wpnyB6K3zpUex7s2nP0WBzXvYGssq
         hc+lIuKBTz9jetfUgOCT6LqO3KaBNlHFnkEpsytYYRZwKFriN+bWVltNJMPSxNBRwljA
         F+JpEMiOCrQgiLaAX2Wz2yG37JWM5riLA0zUZGkmQoaZD02XQ1S8nqIMks/Gc857cFEg
         lRzOER5GJOknUOSIkhQGhTQuzc7wIUPC2CO45FapTsXpoLz/7RAvg0kUuY1AvYBri9d2
         ic6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727428930; x=1728033730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u12Tug5k2bdyzIU9WiqUE2EObFB7IXUcT3bKNNPZCB0=;
        b=dSqCqaQXtEkXTZRCsuJP1PjnSexKhTkjqIxUccN/gnCsGVgd4YXX241xvzjEoL5t2V
         UgpwAMIQ1sJcZm1FPCGePK/Klmur3btBEuJCmR8dQB8RbMWLjhfsHAGrFF7KUx+3g8pM
         H8dhkzrnO4KVDMOuElqU0yywDvC/AFUl2erA5oozExscOocH6nsclmN29n/vWVMkwRv5
         5Qq01mhQG9Dp2A+5Gb0F030rVOXIjOGaPxiZJtvJldBcmxZso+w8R/Df0N2WZ3kW6Yy2
         XXe2yGY6UQCxPxHnGwq4n7cRuY0QJFMr3YW87CXLRMVxbm7KG+oFP/rcBKIP2qdkgIWX
         oI0A==
X-Forwarded-Encrypted: i=1; AJvYcCW2XZSTS4N2rnyC295ahT1GQfPWKm9foe9Gbg3pJFvRRGvdg5QVFnG50Qms0FsUqRWrXfjH0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXLOpjZrULXKj0iedCKc492uPZHstobfKa+eU+Q5cC2kACRnPm
	MdmJ53VkmVBwpN73dtRLkK8qrmtP0HVgRtPp2YNyPoAlWq5TNRF5KFB7c2bMXYWE/QY3c8t9n+k
	6Kfi7o/mmG3ubhBQVdHfqWgyBpuQkzzokHa2dFA==
X-Google-Smtp-Source: AGHT+IGhQGOutUtxLVOzhj1pZESUxIJEMnWirkI07rvkOdCYDPIQ+9U4QYWB0UPwoiObJJWrhA4Koam3DQfasHbzz4I=
X-Received: by 2002:a17:90a:4b07:b0:2e0:9147:7db5 with SMTP id
 98e67ed59e1d1-2e0b8ed4cebmr2795273a91.38.1727428930437; Fri, 27 Sep 2024
 02:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-3-linyunsheng@huawei.com> <CAHS8izOxugzWJDTc-4CWqaKABTj=J4OHs=Lcb=SE9r8gX0J+yg@mail.gmail.com>
 <842c8cc6-f716-437a-bc98-70bc26d6fd38@huawei.com>
In-Reply-To: <842c8cc6-f716-437a-bc98-70bc26d6fd38@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Sep 2024 12:21:33 +0300
Message-ID: <CAC_iWjLgNOtsbhqrhvvEz2C3S668qB8KatL_W+tPHMSkDrNS=w@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, liuyonglong@huawei.com, fanghaiqing@huawei.com, 
	zhangkun09@huawei.com, Robin Murphy <robin.murphy@arm.com>, 
	Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>, imx@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hi Yunsheng

On Fri, 27 Sept 2024 at 06:58, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2024/9/27 2:15, Mina Almasry wrote:
> >
> >> In order not to do the dma unmmapping after driver has already
> >> unbound and stall the unloading of the networking driver, add
> >> the pool->items array to record all the pages including the ones
> >> which are handed over to network stack, so the page_pool can
> >> do the dma unmmapping for those pages when page_pool_destroy()
> >> is called.
> >
> > One thing I could not understand from looking at the code: if the
> > items array is in the struct page_pool, why do you need to modify the
> > page_pool entry in the struct page and in the struct net_iov? I think
> > the code could be made much simpler if you can remove these changes,
> > and you wouldn't need to modify the public api of the page_pool.
>
> As mentioned in [1]:
> "There is no space in 'struct page' to track the inflight pages, so
> 'pp' in 'struct page' is renamed to 'pp_item' to enable the tracking
> of inflight page"

I have the same feeling as Mina here. First of all, we do have an
unsigned long in struct page we use for padding IIRC. More
importantly, though, why does struct page need to know about this?
Can't we have the same information in page pool?
When the driver allocates pages it does via page_pool_dev_alloc_XXXXX
or something similar. Cant we do what you suggest here ? IOW when we
allocate a page we put it in a list, and when that page returns to
page_pool (and it's mapped) we remove it.

Thanks
/Ilias
>
> As we still need pp for "struct page_pool" for page_pool_put_page()
> related API, the container_of() trick is used to get the pp from the
> pp_item.
>
> As you had changed 'struct net_iov' to be mirroring the 'struct page',
> so change 'struct net_iov' part accordingly.
>
> 1. https://lore.kernel.org/all/50a463d5-a5a1-422f-a4f7-d3587b12c265@huawei.com/
>
> >
> >> As the pool->items need to be large enough to avoid
> >> performance degradation, add a 'item_full' stat to indicate the
> >> allocation failure due to unavailability of pool->items.
> >>
> >
> > I'm not sure there is any way to size the pool->items array correctly.
>
> Currently the size of pool->items is calculated in page_pool_create_percpu()
> as below, to make sure the size of pool->items is somewhat twice of the
> size of pool->ring so that the number of page sitting in the driver's rx
> ring waiting for the new packet is the similar to the number of page that is
> still being handled in the network stack as most drivers seems to set the
> pool->pool_size according to their rx ring size:
>
> +#define PAGE_POOL_MIN_INFLIGHT_ITEMS           512
> +       unsigned int item_cnt = (params->pool_size ? : 1024) +
> +                               PP_ALLOC_CACHE_SIZE + PAGE_POOL_MIN_INFLIGHT_ITEMS;
> +       item_cnt = roundup_pow_of_two(item_cnt);
>
> > Can you use a data structure here that can grow? Linked list or
> > xarray?
> >
> > AFAIU what we want is when the page pool allocates a netmem it will
> > add the netmem to the items array, and when the pp releases a netmem
> > it will remove it from the array. Both of these operations are slow
> > paths, right? So the performance of a data structure more complicated
> > than an array may be ok. bench_page_pool_simple will tell for sure.
>
> The question would be why do we need the pool->items to grow with the
> additional overhead and complication by dynamic allocation of item, using
> complicated data structure and concurrent handling?
>
> As mentioned in [2], it was the existing semantics, but it does not means
> we need to keep it. The changing of semantics seems like an advantage
> to me, as we are able to limit how many pages is allowed to be used by
> a page_pool instance.
>
> 2. https://lore.kernel.org/all/2fb8d278-62e0-4a81-a537-8f601f61e81d@huawei.com/
>
> >
> >> Note, the devmem patchset seems to make the bug harder to fix,
> >> and may make backporting harder too. As there is no actual user
> >> for the devmem and the fixing for devmem is unclear for now,
> >> this patch does not consider fixing the case for devmem yet.
> >>
> >
> > net_iovs don't hit this bug, dma_unmap_page_attrs() is never called on
> > them, so no special handling is needed really. However for code
>
> I am really doubtful about your above claim. As at least the below
> implementaion of dma_buf_unmap_attachment_unlocked() called in
> __net_devmem_dmabuf_binding_free() seems be using the DMA API directly:
>
> https://elixir.bootlin.com/linux/v6.7-rc8/source/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c#L215
>
> Or am I missing something obvious here?
>
> > quality reasons lets try to minimize the number of devmem or memory
> > provider checks in the code, if possible.
> >
