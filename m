Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B944C16C69F
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224611; cv=none; b=s7KO3/Fm5kdKlEuhAIsAQel49ZJ84kjrb5pw2dBTL1r8d/PPb8JwmpDSi/1qk+cKZUCmJZk1kaNGFvv0dyh1M5Bx48CDgnZQIRWJslPT+u2oIYt18oYO5UuVRCfMZC2KEc0SnIB/eDMOTzHf0kk2ftlIpOQcQ1WxfPUtXwWCddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224611; c=relaxed/simple;
	bh=P+5Ortlv2xxW8vZxirmzyb1M0rUNyp6jS+VpsuS5KFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qpmespSfpSNFT3Y/L/GlG/Ux3hsseqXycHhx9XyNtcyEf3K8GaYyZgNa76JcITzcryUPSOhQM/31xdS7zfQsqoMLMXYCoU/0jLhyLb2lCYJF0upGMX0LSXe6k4KY59Lf4ibzHcyGQxvhXcLqY6BYJKEnKDSTsOq57Vra0x7rqyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGt51hAb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGt51hAb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742224608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fGtzTo1LAc8iiHgf/rdSrqAOpGbI/PBDwP4kOYIY5Uo=;
	b=aGt51hAbXpLRwAxOGRZ0z0/sUVUC91h1txoYMtrCeWQ1vcmnPVAttmS+2NMpH2+04GFLwk
	6ZfAvNMH11bccCE3u2QICu4bu8tcXnIJhXwYSCavUgN9fiB5Wc1JOszUZbPDalvuTNJP6m
	viBysC/MVQ3LBQxybzRcEGoqKJIoUf4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-ZM0g7VMQMYOEBGbJqmNZAA-1; Mon, 17 Mar 2025 11:16:47 -0400
X-MC-Unique: ZM0g7VMQMYOEBGbJqmNZAA-1
X-Mimecast-MFC-AGG-ID: ZM0g7VMQMYOEBGbJqmNZAA_1742224606
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-30c4168ffd8so19706011fa.3
        for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 08:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742224606; x=1742829406;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzRZI32PvG1jM7oaHs4LUm1pa2tu5/yx3DzI4q+HHBg=;
        b=Y+NDij0O93zbvL4M4EHhwwfCocBgVncJzGlWqoAERdi7RXajzmd40ggXHWnVDMVAI7
         SHUOaGTo1wcce9xXrH7vYur8e5QM/qK3Aium3PZzXTWRKL1OMb5SuzANhPrDi8K32Yy8
         TyGndEcmUMeaYvlg18yzeAUASkwolSO0NoKqOJMFmpSr1ucmD5SC4UB7qaF20x5E/9f7
         0m8y0050uUoRdJ69qVSSAYIeVoS+A70sCMt3HLbXDAQxArtPHSEdmyQKosxr0vAbIi0l
         HQNmP3V0uZjmh+sQP5wPlGpesEAozfcWxHk6IpOcHosUC+//NXZiYTl2+9xTsYWhLIeQ
         PEpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtcs6zg0Ia6o6+1ad/ZqJa9d8WBvl0hEf095v+uCPHBHEhRenQGqfIO+jdB3MChpLhvEXmVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTU2i5xZ9at1lIp2gBZSZeB0YhXWSsRPRFGLexoxIPJ8J30smO
	IxlkPJTlSDhuI6JwNptWUpQ2+rvgkapZyO1b0dp4WXlCROgtGfILWDdEajkaRC8Ttyi9vjoUbBd
	uh25yCb1z5/lFVq7t7pZJAtTqqkCp2c7HB3fzyDNXSNQcqgCnjlcj
X-Gm-Gg: ASbGncswNBRgqWdX6WePOSXX+02eDyVGSQKvkvpYuFxsWleHtpN1E8EZV7pABAYHtKo
	onyo0A4RA3Pl57WyhgIqiNWX+kq0/0A9CrF2LnOBc41gFFbJ7e6+SEbrf3WL8AENO0D8du2zmed
	UV+5XyvccPsJvGGmdyJs7TTl51SKo+98k6nTdKq8e8KGaPFkpnyaVAtXMWyERDJcEl6drUeN7og
	0drlrSjYCpYAmC3foCj/+tjgqQM+uM9ATlKMZmeZI4E44NpZLmCf5noBx9c3moP0yG97nNapuPt
	AVAakprqt7qx
X-Received: by 2002:a2e:740a:0:b0:30b:eb08:53e3 with SMTP id 38308e7fff4ca-30c4a8743d9mr64207541fa.17.1742224605619;
        Mon, 17 Mar 2025 08:16:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSi8cQyOlG/W3LR4YI+3jPWVFa3/mQXBuzJDNH22ZWPZDVglcHs63ffS5X17IwRGbk4plwDg==
X-Received: by 2002:a2e:740a:0:b0:30b:eb08:53e3 with SMTP id 38308e7fff4ca-30c4a8743d9mr64207081fa.17.1742224605112;
        Mon, 17 Mar 2025 08:16:45 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f116a4asm15789761fa.58.2025.03.17.08.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:16:44 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DBB6318FAED8; Mon, 17 Mar 2025 16:16:42 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <yunshenglin0825@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Mina Almasry <almasrymina@google.com>,
 Yonglong Liu <liuyonglong@huawei.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>, Matthew
 Wilcox <willy@infradead.org>, Robin Murphy <robin.murphy@arm.com>, IOMMU
 <iommu@lists.linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <db813035-fb38-4fc3-b91e-d1416959db13@gmail.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
 <20250314-page-pool-track-dma-v1-3-c212e57a74c2@redhat.com>
 <db813035-fb38-4fc3-b91e-d1416959db13@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 17 Mar 2025 16:16:42 +0100
Message-ID: <87jz8nhelh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oyk_q60CGmmMZ1iA6AYRqdv5bok-tqP_NZntUEDhF-Y_1742224606
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <yunshenglin0825@gmail.com> writes:

> On 3/14/2025 6:10 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
> ...
>
>>=20
>> To avoid having to walk the entire xarray on unmap to find the page
>> reference, we stash the ID assigned by xa_alloc() into the page
>> structure itself, using the upper bits of the pp_magic field. This
>> requires a couple of defines to avoid conflicting with the
>> POINTER_POISON_DELTA define, but this is all evaluated at compile-time,
>> so does not affect run-time performance. The bitmap calculations in this
>> patch gives the following number of bits for different architectures:
>>=20
>> - 24 bits on 32-bit architectures
>> - 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_VALUE)
>> - 32 bits on other 64-bit architectures
>
>  From commit c07aea3ef4d4 ("mm: add a signature in struct page"):
> "The page->signature field is aliased to page->lru.next and
> page->compound_head, but it can't be set by mistake because the
> signature value is a bad pointer, and can't trigger a false positive
> in PageTail() because the last bit is 0."
>
> And commit 8a5e5e02fc83 ("include/linux/poison.h: fix LIST_POISON{1,2}=20
> offset"):
> "Poison pointer values should be small enough to find a room in
> non-mmap'able/hardly-mmap'able space."
>
> So the question seems to be:
> 1. Is stashing the ID causing page->pp_magic to be in the mmap'able/
>     easier-mmap'able space? If yes, how can we make sure this will not
>     cause any security problem?
> 2. Is the masking the page->pp_magic causing a valid pionter for
>     page->lru.next or page->compound_head to be treated as a vaild
>     PP_SIGNATURE? which might cause page_pool to recycle a page not
>     allocated via page_pool.

Right, so my reasoning for why the defines in this patch works for this
is as follows: in both cases we need to make sure that the ID stashed in
that field never looks like a valid kernel pointer. For 64-bit arches
(where CONFIG_ILLEGAL_POINTER_VALUE), we make sure of this by never
writing to any bits that overlap with the illegal value (so that the
PP_SIGNATURE written to the field keeps it as an illegal pointer value).
For 32-bit arches, we make sure of this by making sure the top-most bit
is always 0 (the -1 in the define for _PP_DMA_INDEX_BITS) in the patch,
which puts it outside the range used for kernel pointers (AFAICT).

>> Since all the tracking is performed on DMA map/unmap, no additional code
>> is needed in the fast path, meaning the performance overhead of this
>> tracking is negligible. A micro-benchmark shows that the total overhead
>> of using xarray for this purpose is about 400 ns (39 cycles(tsc) 395.218
>> ns; sum for both map and unmap[1]). Since this cost is only paid on DMA
>> map and unmap, it seems like an acceptable cost to fix the late unmap
>
> For most use cases when PP_FLAG_DMA_MAP is set and IOMMU is off, the
> DMA map and unmap operation is almost negligible as said below, so the
> cost is about 200% performance degradation, which doesn't seems like an
> acceptable cost.

I disagree. This only impacts the slow path, as long as pages are
recycled there is no additional cost. While your patch series has
demonstrated that it is *possible* to reduce the cost even in the slow
path, I don't think the complexity cost of this is worth it.

[...]

>> The extra memory needed to track the pages is neatly encapsulated inside
>> xarray, which uses the 'struct xa_node' structure to track items. This
>> structure is 576 bytes long, with slots for 64 items, meaning that a
>> full node occurs only 9 bytes of overhead per slot it tracks (in
>> practice, it probably won't be this efficient, but in any case it should
>
> Is there any debug infrastructure to know if it is not this efficient?
> as there may be 576 byte overhead for a page for the worst case.

There's an XA_DEBUG define which enables some dump functions, but I
don't think there's any API to inspect the memory usage. I guess you
could attach a BPF program and walk the structure, or something?

>> +=09=09=09/* Make sure all concurrent returns that may see the old
>> +=09=09=09 * value of dma_sync (and thus perform a sync) have
>> +=09=09=09 * finished before doing the unmapping below. Skip the
>> +=09=09=09 * wait if the device doesn't actually need syncing, or
>> +=09=09=09 * if there are no outstanding mapped pages.
>> +=09=09=09 */
>> +=09=09=09if (dma_dev_need_sync(pool->p.dev) &&
>> +=09=09=09    !xa_empty(&pool->dma_mapped))
>> +=09=09=09=09synchronize_net();
>
> I guess the above synchronize_net() is assuming that the above dma sync
> API is always called in the softirq context, as it seems there is no
> rcu read lock added in this patch to be paired with that.

Yup, that was my assumption.

> Doesn't page_pool_put_page() might be called in non-softirq context when
> allow_direct is false and in_softirq() returns false?

I am not sure if this happens in practice in any of the delayed return
paths we are worried about for this patch. If it does we could apply
something like the diff below (on top of this patch). I can respin with
this if needed, but I'll wait a bit and give others a chance to chime in.

-Toke



@@ -465,9 +465,13 @@ page_pool_dma_sync_for_device(const struct page_pool *=
pool,
 =09=09=09      netmem_ref netmem,
 =09=09=09      u32 dma_sync_size)
 {
-=09if ((READ_ONCE(pool->dma_sync) & PP_DMA_SYNC_DEV) &&
-=09    dma_dev_need_sync(pool->p.dev))
-=09=09__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
+=09if (dma_dev_need_sync(pool->p.dev)) {
+=09=09rcu_read_lock();
+=09=09if (READ_ONCE(pool->dma_sync) & PP_DMA_SYNC_DEV)
+=09=09=09__page_pool_dma_sync_for_device(pool, netmem,
+=09=09=09=09=09=09=09dma_sync_size);
+=09=09rcu_read_unlock();
+=09}
 }
=20
 static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, g=
fp_t gfp)

