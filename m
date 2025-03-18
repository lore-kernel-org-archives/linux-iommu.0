Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62991212FA0
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742331331; cv=none; b=V6DIwOa0IczPN658YGDaB45sNElEbeXwB94sYdD6OENuWuzN902JyvJ0wUorFSmzyjrjKnLq/57RHfQma4VX+eL6uYXztL6LSYXMUqgHqNBgTC7pxBn67UcfA+CzcT0jVFsIXCS+txgYJ4+vjYEdggyfPEECy7vwKBjhWbm9flY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742331331; c=relaxed/simple;
	bh=mY4MzNV0Kx5OLaD4uszO866HPEMSRyOwk8wt0/fVFjQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OiS1EQvhV+t+Ir5vZmr19Pc2zPYx/wZW+DYIZ0yxLELrv2b0iFSizjGOayc9wlFzNTa3sk9lk3me6nsbwqiF6tMgNi4EhxNhRg2/oVIC3aV3vHluavRPFvBk8J9HvfN3BpRDnes8w+4nY4oe6CJfy+XBVZBPB7g6kdTLzAOYnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUzj14Xd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUzj14Xd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742331328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYzXhht3cKnfthyiHWn6jaBTDF2fnvR7pGQuVqZGiTU=;
	b=GUzj14XdN9l+t8W3IOopOrD5oXAEPtryCPpZCRoqULf2hRvaItBhvPvpsk991UP6k4jF8/
	GfMdw2uzToZZfcEEnzXKVE9SM430kKYHdM1lNIYW7b6u/yxPgSxfYWTFH/uQmkj2MXYTgh
	3FDFU/umN11oC+xc2ZzbZwGalYkSv7k=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-JejqE-L4OaCgClZ7SS8qhw-1; Tue, 18 Mar 2025 16:55:25 -0400
X-MC-Unique: JejqE-L4OaCgClZ7SS8qhw-1
X-Mimecast-MFC-AGG-ID: JejqE-L4OaCgClZ7SS8qhw_1742331323
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-549b1b371fdso3151290e87.0
        for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 13:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742331323; x=1742936123;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47f/ey+Rw47qKqlvyNz3Y2mw/kjp4yg5557bp9nPawQ=;
        b=ttjIJfFjxHMAo3gPzpMRbUzn74EXsMJW/W5s9r6Ncp2pBe0TEfyAziGr3BBBHOSEI7
         afQak0LlQK4x/SmL+3IBUcJLLx6vt5wP45IMaQlnTCbKlN3E0J95szsE5oVPnYithtbM
         NDUcccZD28Y4wJpP7ahfHE4izAvD45xFx0ROgDwcPx0Qpm6emp1a26oddaHXFDcPa1pq
         kraMLcZ4WVEZkCsXhPACeSbnkJKjx5Kw41Z951u5ocescD+9Y4odx58sG73jTa4Wryql
         4EVKiAU5qNqVED1TyaOWF59XdSxKSg9DOs87i+UJn/93eph1twVM3PqcMYNH1G9LdYt4
         Y3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUlxFglyPBf2Sf5ltAZDtoXOWaIsYAbtvCARnw/l0r0YMAIaJSuDXCm2K9VIDsBkShz+3LT7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgmguH4jHXlexww3EyYNWMgWbMinCL31t43mPHloMm8CffjMqN
	sci5mz/RqR9WQZORLxmRM8cSvxAM43q3YKhA+ah+O9Ezgielnfq1pvSICmqwdhEU1AgooP++6vI
	vqv3rtncguKJT7t9Ou8Hp5ua+uygZ/+4LcEEc3CKjGY8577wWvb83
X-Gm-Gg: ASbGnct/sIQTscOIUs7mzJUon/fJSvrzVpvcFgB9/cVtPJ57EQOtfLa64PCw5+9CdOY
	KQh3blZVAl+zVJQ+9p5W9H9jI8vmEDygziyUL/OPEWGlYmmIUwWyJXDpfHESDWNpyhLDmyVWm2b
	gZoF5WNCYmOTn/7vC1W8SC8xzmmKgomYUUFaqJni60cTf7NTmfTPjT1cB5yAVCNrnp2xN/jhDS8
	gujGGGWxfe0xQD9kzMQrcGhMb5dATOPR7p3SrHD04JY6ibPP6udlJhUg+1nBSLvNNX0rJhKGiCg
	bhlf1rhqB8Zc
X-Received: by 2002:a05:6512:2351:b0:542:91a5:2478 with SMTP id 2adb3069b0e04-54acb200b32mr9411e87.32.1742331323210;
        Tue, 18 Mar 2025 13:55:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv32MD9rYrAaB4w0H+GGjiPxz+dxQSbBbZExsG4PudOWzTXu9r6mA2Br+a28dY1YTqZpmi5w==
X-Received: by 2002:a05:6512:2351:b0:542:91a5:2478 with SMTP id 2adb3069b0e04-54acb200b32mr9386e87.32.1742331322568;
        Tue, 18 Mar 2025 13:55:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a81basm1814300e87.28.2025.03.18.13.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 13:55:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C778D18FB055; Tue, 18 Mar 2025 21:55:20 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Yunsheng Lin
 <yunshenglin0825@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox
 <willy@infradead.org>, Robin Murphy <robin.murphy@arm.com>, IOMMU
 <iommu@lists.linux.dev>, segoon@openwall.com, solar@openwall.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <7a76908d-5be2-43f1-a8e2-03b104165a29@huawei.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
 <20250314-page-pool-track-dma-v1-3-c212e57a74c2@redhat.com>
 <db813035-fb38-4fc3-b91e-d1416959db13@gmail.com> <87jz8nhelh.fsf@toke.dk>
 <7a76908d-5be2-43f1-a8e2-03b104165a29@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 18 Mar 2025 21:55:20 +0100
Message-ID: <87wmcmhxdz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0PWvIgtRC9dVIWUewh4yZ_0DuvnkDYBnTFf5QmE5hgQ_1742331323
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <linyunsheng@huawei.com> writes:

> On 2025/3/17 23:16, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Yunsheng Lin <yunshenglin0825@gmail.com> writes:
>>=20
>>> On 3/14/2025 6:10 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>
>>> ...
>>>
>>>>
>>>> To avoid having to walk the entire xarray on unmap to find the page
>>>> reference, we stash the ID assigned by xa_alloc() into the page
>>>> structure itself, using the upper bits of the pp_magic field. This
>>>> requires a couple of defines to avoid conflicting with the
>>>> POINTER_POISON_DELTA define, but this is all evaluated at compile-time=
,
>>>> so does not affect run-time performance. The bitmap calculations in th=
is
>>>> patch gives the following number of bits for different architectures:
>>>>
>>>> - 24 bits on 32-bit architectures
>>>> - 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_VALUE=
)
>>>> - 32 bits on other 64-bit architectures
>>>
>>>  From commit c07aea3ef4d4 ("mm: add a signature in struct page"):
>>> "The page->signature field is aliased to page->lru.next and
>>> page->compound_head, but it can't be set by mistake because the
>>> signature value is a bad pointer, and can't trigger a false positive
>>> in PageTail() because the last bit is 0."
>>>
>>> And commit 8a5e5e02fc83 ("include/linux/poison.h: fix LIST_POISON{1,2}=
=20
>>> offset"):
>>> "Poison pointer values should be small enough to find a room in
>>> non-mmap'able/hardly-mmap'able space."
>>>
>>> So the question seems to be:
>>> 1. Is stashing the ID causing page->pp_magic to be in the mmap'able/
>>>     easier-mmap'able space? If yes, how can we make sure this will not
>>>     cause any security problem?
>>> 2. Is the masking the page->pp_magic causing a valid pionter for
>>>     page->lru.next or page->compound_head to be treated as a vaild
>>>     PP_SIGNATURE? which might cause page_pool to recycle a page not
>>>     allocated via page_pool.
>>=20
>> Right, so my reasoning for why the defines in this patch works for this
>> is as follows: in both cases we need to make sure that the ID stashed in
>> that field never looks like a valid kernel pointer. For 64-bit arches
>> (where CONFIG_ILLEGAL_POINTER_VALUE), we make sure of this by never
>> writing to any bits that overlap with the illegal value (so that the
>> PP_SIGNATURE written to the field keeps it as an illegal pointer value).
>> For 32-bit arches, we make sure of this by making sure the top-most bit
>> is always 0 (the -1 in the define for _PP_DMA_INDEX_BITS) in the patch,
>> which puts it outside the range used for kernel pointers (AFAICT).
>
> Is there any season you think only kernel pointer is relevant here?

Yes. Any pointer stored in the same space as pp_magic by other users of
the page will be kernel pointers (as they come from page->lru.next). The
goal of PP_SIGNATURE is to be able to distinguish pages allocated by
page_pool, so we don't accidentally recycle a page from somewhere else.
That's the goal of the check in page_pool_page_is_pp():

(page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE

To achieve this, we must ensure that the check above never returns true
for any value another page user could have written into the same field
(i.e., into page->lru.next). For 64-bit arches, POISON_POINTER_DELTA
serves this purpose. For 32-bit arches, we can leave the top-most bits
out of PP_MAGIC_MASK, to make sure that any valid pointer value will
fail the check above.

> It seems it is not really only about kernel pointers as round_hint_to_min=
()
> in mm/mmap.c suggests and the commit log in the above commit 8a5e5e02fc83
> if I understand it correctly:
> "Given unprivileged users cannot mmap anything below mmap_min_addr, it
> should be safe to use poison pointers lower than mmap_min_addr."
>
> And the above "making sure the top-most bit is always 0" doesn't seems to
> ensure page->signature to be outside the range used for kernel pointers
> for 32-bit arches with VMSPLIT_1G defined, see arch/arm/Kconfig, there
> is a similar config for x86 too:
>        prompt "Memory split"
>        depends on MMU
>        default VMSPLIT_3G
>        help
>          Select the desired split between kernel and user memory.
>
>          If you are not absolutely sure what you are doing, leave this
>          option alone!
>
>        config VMSPLIT_3G
>               bool "3G/1G user/kernel split"
>        config VMSPLIT_3G_OPT
>              depends on !ARM_LPAE
>               bool "3G/1G user/kernel split (for full 1G low memory)"
>        config VMSPLIT_2G
>               bool "2G/2G user/kernel split"
>        config VMSPLIT_1G
>               bool "1G/3G user/kernel split"

Ah, interesting, didn't know this was configurable. Okay, so AFAICT, the
lowest value of PAGE_OFFSET is 0x40000000 (for VMSPLIT_1G), so we need
to leave two bits off at the top instead of just one. Will update this,
and try to explain the logic better in the comment.

> IMHO, even if some trick like above is really feasible, it may be
> adding some limitation or complexity to the ARCH and MM subsystem, for
> example, stashing the ID in page->signature may cause 0x*40 signature
> to be unusable for other poison pointer purpose, it makes more sense to
> make it obvious by doing the above trick in some MM header file like
> poison.h instead of in the page_pool subsystem.

AFAIU, PP_SIGNATURE is used for page_pool to be able to distinguish its
own pages from those allocated elsewhere (cf the description above).
Which means that these definitions are logically page_pool-internal, and
thus it makes the most sense to keep them in the page pool headers. The
only bits the mm subsystem cares about in that field are the bottom two
(for pfmemalloc pages and compound pages).

>>>> Since all the tracking is performed on DMA map/unmap, no additional co=
de
>>>> is needed in the fast path, meaning the performance overhead of this
>>>> tracking is negligible. A micro-benchmark shows that the total overhea=
d
>>>> of using xarray for this purpose is about 400 ns (39 cycles(tsc) 395.2=
18
>>>> ns; sum for both map and unmap[1]). Since this cost is only paid on DM=
A
>>>> map and unmap, it seems like an acceptable cost to fix the late unmap
>>>
>>> For most use cases when PP_FLAG_DMA_MAP is set and IOMMU is off, the
>>> DMA map and unmap operation is almost negligible as said below, so the
>>> cost is about 200% performance degradation, which doesn't seems like an
>>> acceptable cost.
>>=20
>> I disagree. This only impacts the slow path, as long as pages are
>> recycled there is no additional cost. While your patch series has
>> demonstrated that it is *possible* to reduce the cost even in the slow
>> path, I don't think the complexity cost of this is worth it.
>
> It is still the datapath otherwise there isn't a specific testing
> for that use case, more than 200% performance degradation is too much
> IHMO.

Do you have a real-world use case (i.e., a networking benchmark, not a
micro-benchmark of the allocation function) where this change has a
measurable impact on performance? If so, please do share the numbers!

I very much doubt it will be anything close to that magnitude, but I'm
always willing to be persuaded by data :)

> Let aside the above severe performance degradation, reusing space in
> page->signature seems to be a tradeoff between adding complexity in
> page_pool subsystem and in VM/ARCH subsystem as mentioned above.

I think you are overstating the impact on other MM users; this is all
mostly page_pool-internal logic, cf the explanation above.

>>=20
>> [...]
>>=20
>>>> The extra memory needed to track the pages is neatly encapsulated insi=
de
>>>> xarray, which uses the 'struct xa_node' structure to track items. This
>>>> structure is 576 bytes long, with slots for 64 items, meaning that a
>>>> full node occurs only 9 bytes of overhead per slot it tracks (in
>>>> practice, it probably won't be this efficient, but in any case it shou=
ld
>>>
>>> Is there any debug infrastructure to know if it is not this efficient?
>>> as there may be 576 byte overhead for a page for the worst case.
>>=20
>> There's an XA_DEBUG define which enables some dump functions, but I
>> don't think there's any API to inspect the memory usage. I guess you
>> could attach a BPF program and walk the structure, or something?
>>=20
>
> It seems the XA_DEBUG is not defined in production environment.
> And I am not familiar enough with BPF program to understand if the
> BPF way is feasiable in production environment.
> Any example for the above BPF program and how to attach it?

Hmm, no, not really, sorry :(

I *think* it should be possible to write a bpftrace script that walks
the internal xarray tree and counts the nodes along the way, but it's
not trivial to do, and I haven't tried.

-Toke

