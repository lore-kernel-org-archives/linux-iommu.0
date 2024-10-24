Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5061EF09C
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780850; cv=none; b=DxnpXlEm0U6JJLlQuzpZ3zBOLfO2tU6DPCt7yjmeA9z9I5iwodAMZRvITA03hqSjK6B8TAHmo7XA76rjKAUXiYliAvAHix8np9ImmVcOgSUXxGR3byYqQGJVORg2pao/MDSK84lutPA34GSu5KKtx1yc1FsyO+ELzrxq8n+AhPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780850; c=relaxed/simple;
	bh=RHSCv9bt2jpShj23dRckGzXNJ1xifqFFBkLD9MkzBQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oOw80oW/8ryAvJsyEtaF7aGaQM8fCNvd5cOY6JflmBwlJR+KJGCVOEnOhPQUJnEJMn5Ib1wvIkhOqKlUVV+cx2kOmRCQOD2uEQKE6mK3NFiLK4G0y8k53KjPhKi/BJ7zbnQFHb/qiIuGvOL7D/kCRFEPgA4mhQHg4W1zm/cULkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JrivXQmM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrivXQmM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729780846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RHSCv9bt2jpShj23dRckGzXNJ1xifqFFBkLD9MkzBQQ=;
	b=JrivXQmMkzKr9dKNnypMCM83wTob520kRQgWfBnbrfYeH/wGhNYZWUCXtcGCLnUdBVD1OU
	nbsCGM9fPVP1zbqwvtzRjovQ76wQAacM4EPqgaHWa/xGazhIZUt6+tJw75UJ7HQgVT4kpG
	Xr8MWUdhBu4wlYxMy5lNOm4v38zcJZA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-2E_zw42cPhSgUo-01rCH8Q-1; Thu, 24 Oct 2024 10:40:43 -0400
X-MC-Unique: 2E_zw42cPhSgUo-01rCH8Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d52ccc50eso490722f8f.3
        for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 07:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729780842; x=1730385642;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CjMdzWLILQKd2T9F7nyB4WETCRS6M6pCeZeEmGLW54=;
        b=eSdqQcg0FZOuy8IDTpOUd6XgSKfAveLM1zILk0gBhnj1ei3Q9pB0TkEDiQXXEr4zmp
         kzTJ6nUsqRj1mX7BhdAxP6NfTFJ90AYAEFk3udlJ2HoNXxXfvQDdvKFVJzlKF4cbGnOa
         pU5s1f0VF3v/rr4SR5eeYkpbDkwf8VPe0Fl1HCYttXu5+Yba03ArD8KG8dmI1bBv4QeU
         cQcZZOwfTw90uHuR90HN3bsSU/8lgNyakcbWDqwvUah3BKO7QfY3fUQwv00+ILuyQJkf
         E6RvdsKtwe18qApeUy1GXrT+mBk/NlbBo0k8VVJWSAfyYAE7AfdYmjMZc6Wbv38EIVN6
         flEg==
X-Forwarded-Encrypted: i=1; AJvYcCX/0u+dIyYZu5E81A+TlhA3CtAzq2CTkQkSFcqWwpS/ualc+wSOXBBxdIa5PalO+1NbemXoCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmYfwB9tQqpp0J4czA/hQK1Parz2p0N1HE4mNukCWX4WB7DX1t
	oL4vjFhA50lyY63C/O/WFjoWWNdBB1fai/18Ja6qqfJ1ep9dnW59qP4AcebDgRVstW13YihPXEx
	HJAIx4ksNIvXOTIg9ES3YV1YlyCuUqt5wdhQZm5GWvsWJZApiu2a5
X-Received: by 2002:adf:f850:0:b0:37d:50f8:a801 with SMTP id ffacd0b85a97d-380458ec65bmr1564899f8f.47.1729780842078;
        Thu, 24 Oct 2024 07:40:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHlCZfIV1vlnJ8aUV+taDRYgNoiomN86d8HqIw3XbXDwesM0GycuE5hSHY+Pb/gN5r8/Xadw==
X-Received: by 2002:adf:f850:0:b0:37d:50f8:a801 with SMTP id ffacd0b85a97d-380458ec65bmr1564881f8f.47.1729780841620;
        Thu, 24 Oct 2024 07:40:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94356sm11505321f8f.67.2024.10.24.07.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 07:40:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 41B6B160B4E3; Thu, 24 Oct 2024 16:40:40 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, fanghaiqing@huawei.com, liuyonglong@huawei.com,
 Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
 <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
In-Reply-To: <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 24 Oct 2024 16:40:40 +0200
Message-ID: <878qudftsn.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <linyunsheng@huawei.com> writes:

> On 2024/10/23 2:14, Jesper Dangaard Brouer wrote:
>>=20
>>=20
>> On 22/10/2024 05.22, Yunsheng Lin wrote:
>>> Networking driver with page_pool support may hand over page
>>> still with dma mapping to network stack and try to reuse that
>>> page after network stack is done with it and passes it back
>>> to page_pool to avoid the penalty of dma mapping/unmapping.
>>> With all the caching in the network stack, some pages may be
>>> held in the network stack without returning to the page_pool
>>> soon enough, and with VF disable causing the driver unbound,
>>> the page_pool does not stop the driver from doing it's
>>> unbounding work, instead page_pool uses workqueue to check
>>> if there is some pages coming back from the network stack
>>> periodically, if there is any, it will do the dma unmmapping
>>> related cleanup work.
>>>
>>> As mentioned in [1], attempting DMA unmaps after the driver
>>> has already unbound may leak resources or at worst corrupt
>>> memory. Fundamentally, the page pool code cannot allow DMA
>>> mappings to outlive the driver they belong to.
>>>
>>> Currently it seems there are at least two cases that the page
>>> is not released fast enough causing dma unmmapping done after
>>> driver has already unbound:
>>> 1. ipv4 packet defragmentation timeout: this seems to cause
>>> =C2=A0=C2=A0=C2=A0 delay up to 30 secs.
>>> 2. skb_defer_free_flush(): this may cause infinite delay if
>>> =C2=A0=C2=A0=C2=A0 there is no triggering for net_rx_action().
>>>
>>> In order not to do the dma unmmapping after driver has already
>>> unbound and stall the unloading of the networking driver, add
>>> the pool->items array to record all the pages including the ones
>>> which are handed over to network stack, so the page_pool can
>>=20
>> I really really dislike this approach!
>>=20
>> Nacked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>=20
>> Having to keep an array to record all the pages including the ones
>> which are handed over to network stack, goes against the very principle
>> behind page_pool. We added members to struct page, such that pages could
>> be "outstanding".
>
> Before and after this patch both support "outstanding", the difference is
> how many "outstanding" pages do they support.
>
> The question seems to be do we really need unlimited inflight page for
> page_pool to work as mentioned in [1]?
>
> 1. https://lore.kernel.org/all/5d9ea7bd-67bb-4a9d-a120-c8f290c31a47@huawe=
i.com/

Well, yes? Imposing an arbitrary limit on the number of in-flight
packets (especially such a low one as in this series) is a complete
non-starter. Servers have hundreds of gigs of memory these days, and if
someone wants to use that for storing in-flight packets, the kernel
definitely shouldn't impose some (hard-coded!) limit on that.

>>=20
>> The page_pool already have a system for waiting for these outstanding /
>> inflight packets to get returned.=C2=A0 As I suggested before, the page_=
pool
>> should simply take over the responsability (from net_device) to free the
>> struct device (after inflight reach zero), where AFAIK the DMA device is
>> connected via.
>
> It seems you mentioned some similar suggestion in previous version,
> it would be good to show some code about the idea in your mind, I am sure
> that Yonglong Liu Cc'ed will be happy to test it if there some code like
> POC/RFC is provided.

I believe Jesper is basically referring to Jakub's RFC that you
mentioned below.

> I should mention that it seems that DMA device is not longer vaild when
> remove() function of the device driver returns, as mentioned in [2], whic=
h
> means dma API is not allowed to called after remove() function of the dev=
ice
> driver returns.
>
> 2. https://www.spinics.net/lists/netdev/msg1030641.html
>
>>=20
>> The alternative is what Kuba suggested (and proposed an RFC for),=C2=A0 =
that
>> the net_device teardown waits for the page_pool inflight packets.
>
> As above, the question is how long does the waiting take here?
> Yonglong tested Kuba's RFC, see [3], the waiting took forever due to
> reason as mentioned in commit log:
> "skb_defer_free_flush(): this may cause infinite delay if there is no
> triggering for net_rx_action()."

Honestly, this just seems like a bug (the "no triggering of
net_rx_action()") that should be root caused and fixed; not a reason
that waiting can't work.

-Toke

