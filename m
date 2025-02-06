Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB304235376
	for <iommu@lists.linux.dev>; Thu,  6 Feb 2025 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738860878; cv=none; b=Vx5OfSp+EUJSDGsdzGOowC+LFu6ZXYDL81nsKoze2AE0f+FMqjBByMHAqVZAw0ma6edkX7Hn2Daw6Ex8Sb7nsLGb6W1d6n+nWPwk1Ak/GjhBhf0Go1nLKfPoJ6BNJ7xZStk6HYz7KGTRdSBfU94QXLEjEbTsG/rhX9UnodofS7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738860878; c=relaxed/simple;
	bh=3ZZUQukPMQhDSn6JUeVKKpej9i1kOO3tGVWwO1oxg2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0UuMmd2+KqNhBS+xuQcrEGyrkys7SA8h6AXfT2ETgzqh05PEDDkgLxHnffYJteeVGK7m5p+Y7+VZvEVn07iYmjzHw3l1ofdcAtkGVE11A+XO3IOgf7Jz+8G6emqDaaf/EdRBBBVhWE2tR9YjGeNmjR15kAXczNEl8ZkEt8EKW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xPrMoqto; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xPrMoqto"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f032484d4so37715ad.0
        for <iommu@lists.linux.dev>; Thu, 06 Feb 2025 08:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738860876; x=1739465676; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTi6XQsJ5RIwztDyjcq4PDuI/5/RV6XdKp/ZtUfpYp0=;
        b=xPrMoqtoZrPXmLoErp09QjwpbAE83oTVbNmiMxyWwJ6BmaZRoZ4ZzyHcxpKiR5ZfT4
         393BEwLv/U9np5XvWXAdvfefUiP6VpEyTDZmMouPlLXVH140cCqJ6lhoIkLNRaMP0in9
         LXH/ARKiInEsqb6awoHpthlKTLJp56ghAM7EGR4nWhBVLnOhfgEXCW9/9bfTVe6qvTT5
         z+owNbsVDFKVIsuw+gP+umhHVd+hZAAaQq1RO5SNnA6pOZU03FRcAoD+HRSE0T1/G9XF
         UERYpmlzDq/G6EKcSOf7QC7LZX62256i6h3FxsDGc5ArHyNj4buKTene9ids5KBdyCaU
         fhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738860876; x=1739465676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTi6XQsJ5RIwztDyjcq4PDuI/5/RV6XdKp/ZtUfpYp0=;
        b=TdziIKb7kXGaCHnf2zAS4S3EodujQ7gXKYuRxVtJAt/Ejh+6ltz1izemB4tL1t5QLN
         f739v6MY2+uThxplOJwG1vz0I/bkJp7ko5ZTZm8u88wtsZC6B22WitJEqI9gmYQ8RrLa
         p1uwKxKBUTghqm60wpqddQJYD/egcMXZPYjr3YhMtuVwrR5vZusOg8oZP74qyasl4cHp
         E5qJzT/HKSXrq5fH9DO4q8rzVGrYEKSW36avwJdMQZKjB8LpfEdgmgyecaDRvlI1ZADK
         M5EY/YFrXwi3YheFCmuqZ4kUePLHeozUmawI6ihMk6ktYyAk2OuzOXz/mMy0volxrJr4
         4HSA==
X-Forwarded-Encrypted: i=1; AJvYcCU3/ncOi9/zHUTwkHa8X5r0vYnnB7mim9YljUGjdbWFUeBGASN2cx0dbE2yzRa81qKTRh/qcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmG+2flHVzN/hkxLURy/9IR6m7dI68OiVzvxCPx8oHUHRMCLLI
	K4TrQCQY3zR0cDOoQlMsC77TrgVJN48B7SkrCJRTg4Q7OwfwNaBBQ4gVhKrDO2SXQjYBcrWLeuX
	n71vDEljcP42nuHBvDKZrj1xQ4ut2HVABasF7
X-Gm-Gg: ASbGncuY6OB5AUcftpw1qK/xrDbMmJLB81k0f2G9UGNQs+KVcMru6i1kTqXmBglzRTY
	HesRq955B0ipqe9S1RMqxHP5vF6abAm0tG9+/TNdPY6eSuvWvsQqVlW+TLwJwFbfa37b/Raqb
X-Google-Smtp-Source: AGHT+IHzryBnDyIuG4kua5nqFv0t3CUZetv5VWZDEVSBd2Q6xKHftpMfzmT/4FNKDJh9y7JmfSRCt/+KPeHBMGILBJ4=
X-Received: by 2002:a17:902:ef4c:b0:21f:2ded:bfa0 with SMTP id
 d9443c01a7336-21f4c50aef0mr178385ad.25.1738860875702; Thu, 06 Feb 2025
 08:54:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250127025734.3406167-1-linyunsheng@huawei.com>
 <20250127025734.3406167-4-linyunsheng@huawei.com> <Z5h1OMgcHuPSMaHM@infradead.org>
 <c4b8f494-1928-4cf6-afe2-61ab1ac7e641@gmail.com>
In-Reply-To: <c4b8f494-1928-4cf6-afe2-61ab1ac7e641@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 6 Feb 2025 08:54:23 -0800
X-Gm-Features: AWEUYZkAfsd2D0WA6s0xLr-HWyLjnZliAFrvM7gs-k38rOzilGMV9dLNA263rHA
Message-ID: <CAHS8izO5_=w4x8rhnHujCWQn7nhEDzaNGgJSrcZEwOQ+dN_o3w@mail.gmail.com>
Subject: Re: [RFC v8 3/5] page_pool: fix IOMMU crash when driver has already unbound
To: Yunsheng Lin <yunshenglin0825@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, zhangkun09@huawei.com, 
	liuyonglong@huawei.com, fanghaiqing@huawei.com, 
	Robin Murphy <robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, 
	IOMMU <iommu@lists.linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 6:23=E2=80=AFAM Yunsheng Lin <yunshenglin0825@gmail.=
com> wrote:
>
> On 1/28/2025 2:12 PM, Christoph Hellwig wrote:
> > On Mon, Jan 27, 2025 at 10:57:32AM +0800, Yunsheng Lin wrote:
> >> Note, the devmem patchset seems to make the bug harder to fix,
> >> and may make backporting harder too. As there is no actual user
> >> for the devmem and the fixing for devmem is unclear for now,
> >> this patch does not consider fixing the case for devmem yet.
> >
> > Is there another outstanding patchet?  Or do you mean the existing
> > devmem code already merged?  If that isn't actually used it should
> > be removed, but otherwise you need to fix it.
>
> The last time I checked, only the code for networking stack supporting
> the devmem had been merged.
>
> The first driver suppporting seems to be bnxt, which seems to be under
> review:
> https://lore.kernel.org/all/20241022162359.2713094-1-ap420073@gmail.com/
>
> As my understanding, this should work for the devmem too if the devmem

From a quick look at this patch, it looks like you're handling
netmem/net_iovs in the implementation, so this implementation is
indeed considering netmem. I think the paragraph in the commit message
that Christoph is responding to should be deleted, because in recent
iterations you're handling netmem.

> provide a ops to do the per-netmem dma unmapping
> It would be good that devmem people can have a look at it and see if
> this fix works for the specific page_pool mp provider.
>

We set pool->dma_map=3D=3Dfalse for memory providers that do not need
mapping/unmapping, which you are checking in
__page_pool_release_page_dma.

--=20
Thanks,
Mina
