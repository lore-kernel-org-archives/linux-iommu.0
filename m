Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793988052;
	b=dtDVTx+iK5av//kgA8v30VgJzVwJrORJ6FJWgSwCCgzZjvNGfhPmGgPdz3qpeDO9+bmy
	 uiw8jQ0i8xbBpeUBtwHNR1xSRGZ6Q1zI8wZE3gMY5Fnvz3W3ngk0IRMY1uYW4GEhNNQX9
	 3nXCq+0KPIXMOyB3EL13FqkKuOiVtk5mKGnvLWqhuZAlbCr/7oG7e6tzTs/BrIX8SeUyo
	 i+JXRvtKScslYCyXQuGafEk5Y1gdKULC8IHBOpS5a/UvqQNFx8yCbcFy7rsLeEuFgid23
	 BnH/i7cUrMVYHrsLcfXDGs/RLnrBUL6FwDycOdSgBaYp44u1HiHfHMUvFLj0Y8OPybw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YnPe9jMocBvynbA9CNTJ1Pl6eniz/8su5Gj2vJyxmpg=;
	b=SrgAJdSu2a3ZSZ9uiBOMW3U9PMcdBpSGf9VXsE5TbtYkZnB8aKkS2DvSydAfDbrrD3Sn
	 XKlG4UPvrKEoUH8KqTNXiKz36eYb/PKZlWzrfKCml7DjOtwHVhU8OxU262YwLGoBlBsij
	 UmbpGmHiEs+Cdv13k4Z+N19tAXI2NbgCtFdaOF6Ck1e1jVGnYQPn3zneop6W22iFhDQMe
	 ox6mb1L/TOJy6siVMGzsK1XT0Sc8IJrztUDgQGfEmygTjZWddtja3uquXxTPXsCc9rEam
	 K9ivEQGZisTxuhjTsNUJyYVoMe6xvW3pfEacVelr3jmaLQP7M+XtASkviS5/IFIHmBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="FKwM3S/R";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A61B606A330
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 18:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A61B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FKwM3S/R
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b6266b5bc4so3235e9.1
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 10:00:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793988050; cv=none;
        d=google.com; s=arc-20260327;
        b=PNR7B8Y1DrId8XU06SauVH2kELScnoXv+4qgAXRb0R+MUZBSDVb4Jpj2YxA7KRLcU6
         fIjAl1wgi43AGvMvWC3/1nEZ0rutMleST5vUVgfFHnXOK1F5hDyJijUWmqT5rSD+ImAN
         XFdJ3lQOHmR1920cbpICwaZ3N1W0tv4q/Sf7+IUbfTU3tWjzcnSoS0GYdlV4LQ9zN6KQ
         lB4dMwZqyOd0dlVENM9CMy6PzjFQGHb/GpSixtUPYk6KgtIkdhwc+uOYswF7YzU+cdzS
         3GCk2Gsevbyq+es+ER3hzRmsEI1X7OrqzIMvmOdbSP1vekzHMT5nCw4V9JNNjhgjMul5
         AgGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YnPe9jMocBvynbA9CNTJ1Pl6eniz/8su5Gj2vJyxmpg=;
        fh=rcl3t8TIuqkZnfiTOhrcyaio0yK/uZXFZy1VghS0Dd4=;
        b=OF4CSHngP2pz7CCUMASqFhdkM8iS2ca3WjzT50n1e6CNkyPO+DhiH9khdHxxqUjylw
         pTA/FaDudACpAW95aOTuJwm1GGCRv6ztWt/RcypAfD8ayOoVy2ipNBVVCgw54/rTAt0A
         gu1q5ItbuNQESnxcTSpXorUDH+5aCfVsr2eYFMdBv+5lbBn8swOzYl0ouT+ZffJ87EH4
         QVDyElf9vplmCnO9elK751Cqzk3jrvO4nDJz1k8ANmqNQlIkF0bm8Rv5A0tpKZZ1XRcr
         2iLdXPt+2t5qlse2uk3KPgAJJqiHCAPHrL6ih3XhHI1BHveEmhmwcbE3q4XfL82NnTIi
         JsuQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988050; x=1794592850; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YnPe9jMocBvynbA9CNTJ1Pl6eniz/8su5Gj2vJyxmpg=;
        b=FKwM3S/R7hV0DCiyLA37Ai/gJ2L+cws67+Wy68EXQ22vjvrV4DyBtLq9NJ1vbVrGu6
         bKRq2ZWqOkJ+vfLLuJWNYkRqa4NA4NDGP7wrtG0EVgDjYgm+HrZMaMDC+iOjmvMm66Za
         YuR1X70xAmWn0EEJvA9C7mxdngEHAvcQPZO1cBTZAsV639Qm6QmFjj+wRDiD/AxqTqAP
         yE0mJiDr8kqz7CPJv32gYejYxi2SaErm++3eXYcSHgAHG1riETsCVImsvF/NMJtQmYwE
         cM9V9XEKcRiNBcIMBeZjetAK98rFvCvf8Et6cgyGYk3OVbaW+Vpx0FIZl1/ftX8E4lZO
         nYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988050; x=1794592850;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YnPe9jMocBvynbA9CNTJ1Pl6eniz/8su5Gj2vJyxmpg=;
        b=fRbLHEIoWqPOpnZtAX31vZVa7Y0lyFfsMDtF2QS4KbgsNoaP5qSVHLbHfZjJkRBO+p
         Q6+VI/uG/bds1BZCoNYAXoVAAlA0ZXP3eH68+To8GEUpIootB2DJmfW8wIUbGkkOn4Eq
         nmfMbxhM0BGqKAACqAsZ+s5jhM5sPjAcQpYsBl7/KnnH6PpMoTUSeQvGh5KtpyHWGT08
         yU5nwwN7uJ0jpE5c3TsHdC52tI5FP8F9FU6IjHz4sVGNnX0/NPzRC2Gbs72LHTge4dZ0
         vwr5YbJweL2YORw2TIOcbTIq1BIVxLx6jMk2kXS2dL86yUXFqSGyBRegO6aDAMjDF4mp
         fJtg==
X-Forwarded-Encrypted: i=1; AKwUvBz2ltmOl8VjGnwLjEy3M7F+ZOqLPKTdFjHGr3PEPAD0tlfqyMqXhaYskvxRf/6BPEE/xsSjmQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+c5asa8gnjveuKKlv5lTc5WM2uOBmyuo98sM4QV0IQ9EJpl9TN
	rvpPjPz57k3lpuahdRkfF8Hu1n/+sYz11tHRnKupPCC6hGOrXeIV1Deq/bxJpN0h/xgcbMiIRlH
	VMWrgBw0V8RTh0mLrJBlPYlcOWx76Uy/oApPVEmdM
X-Gm-Gg: AYBFou3657F1hZ29v7lKqLhvTEnvX/7CbNSV1IuToljTPSj9TqbItIstzETh/Gjsh+G
	3kUPydcb8Cd2G35E3Dxf92i0gZBR/pjyEHcvX+/yETVxi8f38M30U6UNes4EsOiEzHuH0MJqDSJ
	3MbEQzCXKvUhT78TcmYpLjHQW+ygpsA7+/k5NlKV79CtlACmffaVAVnVUWkA5nXy8UyAMSwlrwf
	Cq+ZIGq0QS6M/qxSLnQvZOBcevTgqMBFD1MXatdc7EKsxd9S8p6yB/5PiP73jHWyy8mVpYRyCEp
	1XX0MiejDwByOhUb00nt5Tbezcax9ozxMvUEQRmo2T29Ep1LyvbjeD4N962mNGUd9krTzQwXU8b
	gpYuMva9fOHefDpHwGkvgBTYWj6O0S53SPusm5R/YfLSj6Xzc6mk/7Xr+PexD0b+v0Zus8Q==
X-Received: by 2002:a05:600c:c3db:20b0:4a1:fb0b:1c9c with SMTP id
 5b1f17b1804b1-4b78a30d10emr50205e9.10.1793988049366; Fri, 06 Nov 2026
 10:00:49 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org>
 <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
 <20261022201229.GH3381610@ziepe.ca> <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
 <20261023140107.GC3977851@ziepe.ca> <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca> <20261103080933.GA4213@lst.de>
 <20261103151021.GK3889730@ziepe.ca> <CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69trmw+BJRVYf3JB1g@mail.gmail.com>
 <20261106173054.GH663069@ziepe.ca>
In-Reply-To: <20261106173054.GH663069@ziepe.ca>
From: Naman Gulati <namangulati@google.com>
Date: Fri, 6 Nov 2026 10:00:35 -0800
X-Gm-Features: AclHuK8x57W7AnFw360PBbTWaHMwGgtNX68cpPd5ipqmMu4tcyLJQyWTDt3UxIA
Message-ID: <CAMP57yU-VhZWXijvwAXcN9=zZ+eWXZ6J1bkHuCJw3ocRaFaV=Q@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Luigi Rizzo <lrizzo@google.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 9:31=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Fri, Nov 06, 2026 at 09:21:08AM -0800, Naman Gulati wrote:
> > I drafted an implementation [1] for premapped TX and RX buffers on top
> > of the existing networking page_pool. It is implemented entirely in
> > the networking layer and extends page_pool as the default RX
> > allocator, to the TX path. There are no hooks in the IOMMU, DMA or
> > page allocator code. I wanted to understand if this implementation
> > correctly captured the feedback on this thread. Key components of this
> > design:
> >
> > - Chunks: as in Luigi's series, memory comes in 2 MiB chunks, but each
> > chunk is mapped once per opted-in device through the DMA API and
> > records its IOVA for each device, rather than using a shared IOVA
> > window.
> >
> > - TX: page_pool accepts a memory provider for pools that are not bound
> > to an RX queue. Per-CPU page_pools take 32 KiB pages from the chunks
> > of their NUMA node; TCP copies sendmsg() data into them through the
> > task page_frag and allocates its skb heads from them.
> >
> > - RX: an instance of the same memory provider, sharing the chunk code,
> > backs RX queue page_pools. RX chunks of order-0 pages belong to one
> > device and NUMA node, and are shared by that device's queues on the
> > node.
> >
> > [1] https://github.com/torvalds/linux/compare/master...NamanGulati:linu=
x:netdev_dma_pool
>
> IMHO the netstack should never read from shared/decrypted memory. If
> you put it in a SKB you have to be sure the only touch after that
> point will be a DMA read from an untrusted device on the TX side
> (sending it to a trusted device would be a fail) and the final copy to
> userspace on the RX side.

That's likely a fair callout. TBH I'm not very familiar with CoCo and
will spend some time understanding the constraints. I kept CoCo out of
my implementation as I approached this solution from the overcommitted
VM problem where we are trying to overcommit memory in VMs and use
these pre-mapped pages to avoid using bounce buffers.

>
> Everything else is very security questionable.
>
> It is unclear to me how any of these page pool proposals meet that
> requirement since page pool typically provides memory that ends up
> widely used in the netstack.
>
> Jason
