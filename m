Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206F8201026
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854984; cv=none; b=ZzQDZkNOvDAMGsuBL/+LjJuWyzTiH4hs/afYycTtD9QvTrN4FuNGXd1dI7Br5PHzoAjFkGyywb4z0Jm4XbJx4/W7MQErEKSZBzx/4uVhM8G3OO+UetuM2Qoy7ek+g2esNRLKMUHz2/uz5QjTG+Ui0hZ9wqv2aZ0oCSyacV5n74M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854984; c=relaxed/simple;
	bh=BtncGLFtSvO/B5JUwMnR7kZEEvOkSWEdmm5lyRH+VWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zi3+lPqggIcr8eIjqQkGdXStkt7Tnp6ThC75dLI/dNiWJX0HngnMd5oID2nUNGSNQRz46ssu9luYq3y2DNQOR5NOa62GL/pNlvE6VDKVI1K/N5PxypiJv9LwApjFO+LJXhEBMrl036G2gYnEnJ6m8ZhMiLcS5KTBK6Pz1NjciD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1uY9K1h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1uY9K1h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729854981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ojPbtEba3I+pxdii2b5vp6Mvbi/JQ/cy4jqBCqwFgJE=;
	b=Y1uY9K1hudP4PP1grCenI2RRxcxWFN77P8mQvnHb9ms936EsePpv4H33n/WKLiAHmI3E2F
	tMEn3sSCFAszPvbQ8bWp1blQkxPO2uk8lJ2EU1xHvvPfPIAbrL2M/voFenwv0FS/FoS8fT
	+5vis+sojQay2BdHNgt6Q3Slfhc/z8s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-FabN5q5vNM-CEnJLfIvUxg-1; Fri, 25 Oct 2024 07:16:19 -0400
X-MC-Unique: FabN5q5vNM-CEnJLfIvUxg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-431518e6d8fso14012775e9.0
        for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 04:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729854978; x=1730459778;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0qPBrRNSLkb3KGkLhlgiZrNu9jD/XhF/NDSopp9rNg=;
        b=JZBqnlOzYxLhnLSjr/RG/MwbXduR+0JZKAXiils0+BCTFT0TFD+MTsX4QlQLI3aIGk
         xNRNFU6kklIzV++BZPd+WqY949TSAIcarN1yZ9rZxWNv1HIWgPtYxOOfF8MLirW5FNaw
         dQt4aaAlQkyDKuwFozldNPIU3TFEfsbwpB2WILoAriYUgfNMfCPAywhH5tr45tDpELl0
         dqSBjr1tqdZXonTp3IKctzfMbXgvKcyTBwZaUr3uwPfUrPYDiP06myuVom2d0deTaYiZ
         YT3AFHE0RzTkm5mK1x7pWdWuKw938VsRkv7DNe6juykyVvxEJRqoOlZC96lcf7Mfcqgq
         v3Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUlU3sFTquluK+kxDONXiqvQB9fGJJdpkFlMBflyMVVidsiKJJuV+jpysvRIa0Mit9J+73z8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBJubr6O7WR+jz66TacUgGW1Bt4v8qdXan+VlCvApg/zvAIT+r
	ilBtQM9Ywww21UBbFqtcX8IKSMjXYR4LqanuCs5HbDE3rTft/o2VSS2GMWO/3j4fEGS6ie131Lj
	ru9COBE4fYs93i3SU0+j4PFvVDRE4O4r4ZEcltsveo2JZWl/66zSX
X-Received: by 2002:a05:600c:4509:b0:42f:8fcd:486c with SMTP id 5b1f17b1804b1-43184246f16mr69382275e9.33.1729854977946;
        Fri, 25 Oct 2024 04:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz/TKf3cyp29H5EI56yHsa6P9AJDFSiMIPoxYVeexqi7wh6wrfOKtvYZ15vyaqaeliDwSAJQ==
X-Received: by 2002:a05:600c:4509:b0:42f:8fcd:486c with SMTP id 5b1f17b1804b1-43184246f16mr69381965e9.33.1729854977523;
        Fri, 25 Oct 2024 04:16:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431934be328sm15153085e9.0.2024.10.25.04.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 04:16:16 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DC671160B56C; Fri, 25 Oct 2024 13:16:15 +0200 (CEST)
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
In-Reply-To: <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 25 Oct 2024 13:16:15 +0200
Message-ID: <87r084e8lc.fsf@toke.dk>
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

> On 2024/10/24 22:40, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
> ...
>
>>>>
>>>> I really really dislike this approach!
>>>>
>>>> Nacked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>>
>>>> Having to keep an array to record all the pages including the ones
>>>> which are handed over to network stack, goes against the very principl=
e
>>>> behind page_pool. We added members to struct page, such that pages cou=
ld
>>>> be "outstanding".
>>>
>>> Before and after this patch both support "outstanding", the difference =
is
>>> how many "outstanding" pages do they support.
>>>
>>> The question seems to be do we really need unlimited inflight page for
>>> page_pool to work as mentioned in [1]?
>>>
>>> 1. https://lore.kernel.org/all/5d9ea7bd-67bb-4a9d-a120-c8f290c31a47@hua=
wei.com/
>>=20
>> Well, yes? Imposing an arbitrary limit on the number of in-flight
>> packets (especially such a low one as in this series) is a complete
>> non-starter. Servers have hundreds of gigs of memory these days, and if
>> someone wants to use that for storing in-flight packets, the kernel
>> definitely shouldn't impose some (hard-coded!) limit on that.
>
> You and Jesper seems to be mentioning a possible fact that there might
> be 'hundreds of gigs of memory' needed for inflight pages, it would be ni=
ce
> to provide more info or reasoning above why 'hundreds of gigs of memory' =
is
> needed here so that we don't do a over-designed thing to support recordin=
g
> unlimited in-flight pages if the driver unbound stalling turns out imposs=
ible
> and the inflight pages do need to be recorded.

I don't have a concrete example of a use that will blow the limit you
are setting (but maybe Jesper does), I am simply objecting to the
arbitrary imposing of any limit at all. It smells a lot of "640k ought
to be enough for anyone".

> I guess it is common sense to start with easy one until someone complains
> with some testcase and detailed reasoning if we need to go the hard way a=
s
> you and Jesper are also prefering waiting over having to record the infli=
ght
> pages.

AFAIU Jakub's comment on his RFC patch for waiting, he was suggesting
exactly this: Add the wait, and see if the cases where it can stall turn
out to be problems in practice.

> More detailed about why we might need to go the hard way of having to rec=
ord
> the inflight pages as below.
>
>>=20
>>>>
>>>> The page_pool already have a system for waiting for these outstanding =
/
>>>> inflight packets to get returned.=C2=A0 As I suggested before, the pag=
e_pool
>>>> should simply take over the responsability (from net_device) to free t=
he
>>>> struct device (after inflight reach zero), where AFAIK the DMA device =
is
>>>> connected via.
>>>
>>> It seems you mentioned some similar suggestion in previous version,
>>> it would be good to show some code about the idea in your mind, I am su=
re
>>> that Yonglong Liu Cc'ed will be happy to test it if there some code lik=
e
>>> POC/RFC is provided.
>>=20
>> I believe Jesper is basically referring to Jakub's RFC that you
>> mentioned below.
>>=20
>>> I should mention that it seems that DMA device is not longer vaild when
>>> remove() function of the device driver returns, as mentioned in [2], wh=
ich
>>> means dma API is not allowed to called after remove() function of the d=
evice
>>> driver returns.
>>>
>>> 2. https://www.spinics.net/lists/netdev/msg1030641.html
>>>
>>>>
>>>> The alternative is what Kuba suggested (and proposed an RFC for),=C2=
=A0 that
>>>> the net_device teardown waits for the page_pool inflight packets.
>>>
>>> As above, the question is how long does the waiting take here?
>>> Yonglong tested Kuba's RFC, see [3], the waiting took forever due to
>>> reason as mentioned in commit log:
>>> "skb_defer_free_flush(): this may cause infinite delay if there is no
>>> triggering for net_rx_action()."
>>=20
>> Honestly, this just seems like a bug (the "no triggering of
>> net_rx_action()") that should be root caused and fixed; not a reason
>> that waiting can't work.
>
> I would prefer the waiting too if simple waiting fixed the test cases tha=
t
> Youglong and Haiqing were reporting and I did not look into the rabbit ho=
le
> of possible caching in networking.
>
> As mentioned in commit log and [1]:
> 1. ipv4 packet defragmentation timeout: this seems to cause delay up to 3=
0
>    secs, which was reported by Haiqing.
> 2. skb_defer_free_flush(): this may cause infinite delay if there is no
>    triggering for net_rx_action(), which was reported by Yonglong.
>
> For case 1, is it really ok to stall the driver unbound up to 30 secs for=
 the
> default setting of defragmentation timeout?
>
> For case 2, it is possible to add timeout for those kind of caching like =
the
> defragmentation timeout too, but as mentioned in [2], it seems to be a no=
rmal
> thing for this kind of caching in networking:

Both 1 and 2 seem to be cases where the netdev teardown code can just
make sure to kick the respective queues and make sure there's nothing
outstanding (for (1), walk the defrag cache and clear out anything
related to the netdev going away, for (2) make sure to kick
net_rx_action() as part of the teardown).

> "Eric pointed out/predicted there's no guarantee that applications will
> read / close their sockets so a page pool page may be stuck in a socket
> (but not leaked) forever."

As for this one, I would put that in the "well, let's see if this
becomes a problem in practice" bucket.

-Toke

