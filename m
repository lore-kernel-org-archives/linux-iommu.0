Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793989074;
	b=ZNlSYNTpLc3ft/CQcIDCKGhAG1Wjsf0xcOV/Dy5gNKnaSNfwYzQpHRhnyfDGEM/qCf9H
	 Q1TZ8oA5le3NRFICCnPSRUSjFBql5KdDOYSsc9RV4/ahu3Q7/bEgElDF5a68AaD1iiVxj
	 QRRDABrPd0HOYgEtb3dlJbylG5vpo4paO89Jt11olVSaKVcP5fKSUXZL/9ecGbVsKGaEd
	 4biIjfmcfFWBhrDBxUc1UlqqVoWmZ7JQoqrA76V9sf5aHVNQhrzYGd/L0r8Q60TKbKSwP
	 q5Zpjs/qJnCugUgSHXtvMtyX/XnZyh+CCVISRWu7jW/u8hGgD2e/TWYA20VUfVkOeoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BvW3kJ042sHlnHfK0H238m7dXO47goeCrBgoSLkn/eI=;
	b=jQitIM7MYYJMsvi4wXkPi9zQ70owvaBBl7E0YNdLxQpBR5aaoD/6DGxn1QzBVbAoNVuv
	 GMpTQ9/rizA5KLSk7FQkrMOhQitWKnDv7oygKBQKOR3aAq9PK5Fx8u+pirCoc1Po77+7c
	 /8HlWHZ6obPz4erxz6jqfpHFB/eq05sGxOmHltM0NBb1xBDwViiko3S0Q5urfv2Vnhwlk
	 ZKTU+OTIEXArSYWUr703cYpM3hofaugDDf627jyQceTdaYJt85/Pk/Ow4fJs7UMLZIMvx
	 BvaBfpfWTi+z543YOpHAXS8SxaknGb9o8zGeL0tE7XeyWjBI8H6BrjIzQDPjzju+YpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BbBoR0rP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978DC606A338
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 18:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 978DC606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BbBoR0rP
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a018493d57so14175e9.0
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 10:17:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793989072; cv=none;
        d=google.com; s=arc-20260327;
        b=TcefraJSc16/+d11+HdXwY/rfzMIPzO0GG55rLn7MeedjMVznEc0ktscdfSGsTChba
         lmi/Tgj92ufG7cpI3KpylL3wY6qO6Y06d38sb4nJs4VEDDXxee6O6h/NE1una4HxPNPZ
         jlyYLJwsugAaFC2l7DKV2uD+4U0EHspkyKvsKYQVa9c8pPCIbsCzm8KAqrohHKHOsmpV
         8lT8rHVnXes+72toI96SmmUfzV/dNVko6IGgya1SLUCBQVHbkDKo7JqqfiEHj+yh629g
         qH9ecauLehZ6W3hxU15DgqxrRIkEv3B5Kwq47wcknl9EziuMSov0ETR51f/Y/Ctxv5uA
         pllA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BvW3kJ042sHlnHfK0H238m7dXO47goeCrBgoSLkn/eI=;
        fh=6zLcl8CZ/EA/VEbKTI5f/MBaHzMKtp5xcBBRshntTn4=;
        b=jjpMtheLVp6Nh0Uc8nl3kK5r9UstTwhf3PguqynRIkpJgi+osTwkkO+sJQqlXu53nj
         uuPdFwYUGuRfN4zNfg/y+5lfbndTHIm2bJqRFg/0ngv0kWuqRaInyDLqIgVT9nOkDdoJ
         zGHmoFTfcZ/L7aIv6JYAWy8Cc2sd/WUdtEQQn5J04Id6k3O8Ur4+ALl/KwOMVVzmJY/w
         G4ievtwM/Le8CjJW0xFfBH+hRojixddeQGVVUbFRrjo+xsmWGmciBXbnnZuRmRXx1awR
         w+uy8aG44Q028IXqGz5FUpvx8SbmDqyDMaUFdLfwhXv2JR7dx3/cM4K6MgRfqhJiI+l9
         JLFA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793989072; x=1794593872; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BvW3kJ042sHlnHfK0H238m7dXO47goeCrBgoSLkn/eI=;
        b=BbBoR0rPdz2orTRqTSO0MKEwBzUIkwhVOrmOQYe+tI2lVUjQT2QNFjMG2c9V8cPcU+
         f5YKj+6s/z43cB+XWxpu+kU2UvsGEZaagUNnrBcbmysudnEHq+yNVuUNWzQM5c/rGChs
         ajZNUjfOW0SnWfD82Sk4O29bF9gslOYEC/fNP09jhviTz1OQvSqkLpdCNbwUqsiszb7z
         /ZUOh7GJU3iYihHdfWVyQn5mwMLnw7mLf5177X4jVIT66JX3QyM13NpPfopNiyVtvHY+
         Cx2gHpyYfBfu5RBvm7uq7RB0XzKsU5l6delORrey8pi6+tMwPB6dzKUz8pWh3tpiZ9V4
         hpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989072; x=1794593872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BvW3kJ042sHlnHfK0H238m7dXO47goeCrBgoSLkn/eI=;
        b=ERjih8K7pcBPSJiBdOVojt//UiKqRcFMp7DpR2ttjM5NNYXHfeBngJxIL7nlKNqPnh
         JINBR1uZ5tw7xuO4Ejc9YxAHB4LKDNHrASVFstBK5rTOnZSRB6dBXaK2m4uoJFipm2dZ
         E9tNkLiXJa32qN14Mdu1vIkzHeemsXMHa8Gi3wD324+VagN5+lJ5xB82nlGqz/nmjtoc
         6f9cI9VELXlRCDCtC0sWdMukkw3lZAOx7c/dgezUitbxN/raWUXtHZomMLqAzZWZIMTm
         hqn5UO/vL11PTancVdrg8jU6lesMVpwfZptEUQvtN18SVjA8iFvT30UtyVrOkACcHPAp
         IlHw==
X-Forwarded-Encrypted: i=1; AKwUvBw/RXVjuXyL6VpuX9n7vwR3UY9/dzGfGkW/P8YUFgyzPmsCMxFDR1zb8VtFlUA6p9aGNgRT/Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+U6ZulkrNDGIoyAYSsQM4zuGxDvHyk0pFPfQfdoge4AnIF5J+K
	wPRy6DVpkUGM47Fqaurcv2Rg+vnhWmoqoeLWJQ+sJQIrmLch0Z7Fn6a2OS1O76ILQ7Q2O4OheQk
	bil3WLBX2s3a91TawykmsM48+8BDWumYJgIt9DnG7
X-Gm-Gg: AYBFou30oF58JJCrIsyx1Pn+Pczxh1sA8xcv9l4d01AfzA22rOa1I9njlO4xaKOfMhd
	hlVybrdHD9TxWBXZ4cx6J5KGOUebJbPkp1Wpa17DNfOX423J2443XBB/ueCylZwcmhDxboRJXrD
	AgLTceCss88zuLY7bLHIL+5eLa1Pf3vgm4alKRlLt5iLToZxSqo1PpXwl6e0W/my0bTIkT21kXT
	LYP1n2Wbv5YpWdBNdpRws8kxMdbHTgvfZ8RbPJaslSBEnS4K3wTz+5maAHhlVvw9ezN5IWA1oy0
	0JIM1+JKUmQlxBbz/fu2okzxocdqrYbqfPy6WA30ymjHIJGYLsMylKD7gahOzz8dwmbz3eFBMdv
	QRjzTub39kyr+Oc6oFgVU3+sfVyLOEV0EiHMPiYnf19sBZwiv+qap0m8UVXDA7HUynfLEig==
X-Received: by 2002:a05:600c:8b12:b0:4b6:24ca:8848 with SMTP id
 5b1f17b1804b1-4b78a30d377mr98115e9.11.1793989071681; Fri, 06 Nov 2026
 10:17:51 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261022201229.GH3381610@ziepe.ca> <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
 <20261023140107.GC3977851@ziepe.ca> <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca> <20261103080933.GA4213@lst.de>
 <20261103151021.GK3889730@ziepe.ca> <CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69trmw+BJRVYf3JB1g@mail.gmail.com>
 <20261106173054.GH663069@ziepe.ca> <CAMP57yU-VhZWXijvwAXcN9=zZ+eWXZ6J1bkHuCJw3ocRaFaV=Q@mail.gmail.com>
 <20261106180714.GI663069@ziepe.ca>
In-Reply-To: <20261106180714.GI663069@ziepe.ca>
From: Naman Gulati <namangulati@google.com>
Date: Fri, 6 Nov 2026 10:17:38 -0800
X-Gm-Features: AclHuK-83DU2Twv76ErkJhEGQxs5tivwJ4EGd2AJl7A0D8r5G3Ha6ydUc43L3ns
Message-ID: <CAMP57yW6Y4g-xM9YTB+MpgxPN7RFeEWhAPWvqrfOoMDEuL8HZA@mail.gmail.com>
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

On Fri, Nov 6, 2026 at 10:07=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Nov 06, 2026 at 10:00:35AM -0800, Naman Gulati wrote:
> > On Fri, Nov 6, 2026 at 9:31=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> w=
rote:
> > >
> > > On Fri, Nov 06, 2026 at 09:21:08AM -0800, Naman Gulati wrote:
> > > > I drafted an implementation [1] for premapped TX and RX buffers on =
top
> > > > of the existing networking page_pool. It is implemented entirely in
> > > > the networking layer and extends page_pool as the default RX
> > > > allocator, to the TX path. There are no hooks in the IOMMU, DMA or
> > > > page allocator code. I wanted to understand if this implementation
> > > > correctly captured the feedback on this thread. Key components of t=
his
> > > > design:
> > > >
> > > > - Chunks: as in Luigi's series, memory comes in 2 MiB chunks, but e=
ach
> > > > chunk is mapped once per opted-in device through the DMA API and
> > > > records its IOVA for each device, rather than using a shared IOVA
> > > > window.
> > > >
> > > > - TX: page_pool accepts a memory provider for pools that are not bo=
und
> > > > to an RX queue. Per-CPU page_pools take 32 KiB pages from the chunk=
s
> > > > of their NUMA node; TCP copies sendmsg() data into them through the
> > > > task page_frag and allocates its skb heads from them.
> > > >
> > > > - RX: an instance of the same memory provider, sharing the chunk co=
de,
> > > > backs RX queue page_pools. RX chunks of order-0 pages belong to one
> > > > device and NUMA node, and are shared by that device's queues on the
> > > > node.
> > > >
> > > > [1] https://github.com/torvalds/linux/compare/master...NamanGulati:=
linux:netdev_dma_pool
> > >
> > > IMHO the netstack should never read from shared/decrypted memory. If
> > > you put it in a SKB you have to be sure the only touch after that
> > > point will be a DMA read from an untrusted device on the TX side
> > > (sending it to a trusted device would be a fail) and the final copy t=
o
> > > userspace on the RX side.
> >
> > That's likely a fair callout. TBH I'm not very familiar with CoCo and
> > will spend some time understanding the constraints. I kept CoCo out of
> > my implementation as I approached this solution from the overcommitted
> > VM problem where we are trying to overcommit memory in VMs and use
> > these pre-mapped pages to avoid using bounce buffers.
>
> Why does overcomitted VM use bounce buffers? Do you mean this is
> about getting better memory clustering in page pool since the VM
> paging granule is 2M?

Not exactly, we are trying to use VFIO passthrough NICs in
overcommitted VMs. Since the guest memory is overcommitted we can't
dma-map the entire guest address space (as non-overcommitted VMs do).
So overcommitted VMs can use bounce buffers to have a set of
pre-mapped buffers to bounce traffic in and out. We're trying to use
this solution to map pages dynamically with virtio-iommu and recycle
them via page-pool to avoid traps on each TX/RX and avoid the copy
cost of bounce buffers.

This problem extends to generally reducing IOMMU overhead in
networking - taking the dma map/unmap cost out of the hot-path and
avoiding IOTLB thrashing.

>
> Jason
