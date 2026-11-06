Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793985686;
	b=wEZU8u/sLk+lDI8g/ykSHjPI5kYmZBno7IcdSrEolfkpLaYI5gNMRpYtmhZfxOhPQUG3
	 vTbvH/hnmX9qOI6zMLUPRs5eWKySBlId4T+oXMb73qQYdCxW+ktrmR90RsjqDzo1u7jqV
	 pFdFGmvK6WXzeJhFmWv2EyrM632BTyGD81s1I3spkXH7E09iyeJ04W34tp6RgjdHvZWPo
	 aPh+RidWrxUtljhNqb7W02/ZHw4tJkNyFDGd0Ujxu/wueYTol+78rZM6b83ISUUuoPLv1
	 kSRw7oRY01UoRmbwkUJYNnE8xuYXB2pWztSQlcrp6714E3PUnLwayiHKq7tANIeN2Dw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3RKt6UkQZGhVMeIsFX1m9xEh639vUr0Dxv9GzpFuH2Y=;
	b=tdTiTNZb9OB+mX4J4HyaXAbs9mfnNLd4LSsWeU8oD3NkWKRwNp1T4h+CRB4LM8EBIzsq
	 5yyzyDMYOb4uIUt6GS4RAfzghLMEJrPuZTsO0unny6usev+4MvtAk06A3q1cTKTCsYDT9
	 2OWSwYgjGFYPExcD/b+SrsSFqkL2Xz4v9G2x+ejG+K2tXgDrbdEcWfziV1zimFhI9gE6i
	 Cvk1vQhdJOAutwR+12rVJXQ6AULq3x5RPw2/BgbuBGq+UgAPBDNEu/UhRt58GCHl1/yqq
	 N+od3+mJ3IkQOY7TYhDIyThdUpgpNZYj9HT5oRJGg1dXABMMDpFwZ+cnMknfvibtC5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="jd/ABCi2";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D32606D810
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 17:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0D32606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jd/ABCi2
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a206f0b95bso14005e9.0
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 09:21:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793985684; cv=none;
        d=google.com; s=arc-20260327;
        b=KCTxBU1PsRBZy0MPjhBeCrRqJzzVTY4GQZEWdZL4INgNJmOtXaAs/ZKpCJg1mRi4vK
         ifDZp9lwyYa5ENPYyCFiHh2JcVsoEUyeUBKzeoyXEqu4LGWi29QVyhzY99xT2GBBhyfX
         af7bmmOCKnBUjvmUhVA1Fv4dje6gwkY73OwFFwjHiI1WHlD+PM+efb7SNUuEadifb/JJ
         Wgpw//EGDP/PrRNFtkW7tpUTx84OXwwe1nhgABui/RXy95qo1W86Wr6so1P4jkmJ5ZOP
         4I0MxLuJxrxuDkBEYGmZ0Z91fTzO6HgoMAMfDYMwranljH8IQJ70VOYgPw2R+dM1RYWh
         gyFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3RKt6UkQZGhVMeIsFX1m9xEh639vUr0Dxv9GzpFuH2Y=;
        fh=ShboYH4N7ds2BsNksDsI6epqMHsoqeu4o6PIBaKh04s=;
        b=eHXREJXynojScGD7/s6LU1B7BV3x9r8WNMxpP7Ll9Mo9siAQWdJ2BOweO6/cyERW4z
         5uJWJHTU22EtVrnvtPVFUDcGx4ipntRbSdg9LetV9xdNmv6cN8MaymwK7z8ZBz3g2zYZ
         x1L7skohTq4Dy7QowIBGC6dJjwA+nrgXLwcSLyQpoM8+BsB1usZNzRDaxo3Yujof9y9K
         THbhE8RuIGjrO1bBfhpWvByZjorMTK9wn5J6LOrh3PrO+GGhG/eqvadpuxna32UddZ/6
         e7zqFmPiy3pQpagVQbRE58UXJS6K4fW2o6FfXNbboEAUUGQ1LDBkawjjUz6pjzvh9v4C
         P5EQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793985684; x=1794590484; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3RKt6UkQZGhVMeIsFX1m9xEh639vUr0Dxv9GzpFuH2Y=;
        b=jd/ABCi2UOl5Qg51+OhCFzxnOtKDueOhrUEbS5/S20Tzj8cG8PVM+LGlr9mkdMIJtp
         W2avG3LheoWbCXrq+ZYnSWa5EAZaFdBKsr5wFr4/l3EQIUzAmpmnMJeA2xD0kfI2a+tz
         UMkI1O1+VynqbYI4bM7JYloQv7SAd2RDuFTQSc9VX15t/y8VFq7XWIY7NAJx9ByPw/ph
         0KfKsSirs/PBc57fpalmhWobqgXj2oDQij/s2L42SunhSdVf01csUS9sRtDc4fjIPT4D
         /YPMQv1Z6GnLoUiy0zipNx0Jgn6gSyZvUvTZb5oyElSW5OW7fSeJYw0E3dZ7BJHaTx4f
         pM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985684; x=1794590484;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3RKt6UkQZGhVMeIsFX1m9xEh639vUr0Dxv9GzpFuH2Y=;
        b=F7Aplj2Jwp2tbxFhp926bPghjHYOuAbwIc1oqcJ68EUdFOkJXUB/NdCulZB8KRHpDJ
         Ok+vPQLl6w0wO93iCNEShcxKq3valLVehXQ2BiqHKBGgAezHMBASg9Vj6pQDunrDEO8R
         4NVJE4R7uCWyEhbqO37JMfQelfEqs4FDLPpc2WrFhvqW7qRrbKX6s+v9AwLxiaINw/6e
         sf7d1amuWNXhbgxfDIH85GG+t1L+Xdabd0iZsCGN9bcWQXOJRLJr0kGTp/YhM3QsUeVV
         7dZ+V7qFV+VUjGhnnvbJ9fGjl88AeUlqECRybyGGjJR/mRNUg1bQPssVNVqE6gMPMaf5
         VsVA==
X-Forwarded-Encrypted: i=1; AKwUvBzvHAw0AqnPm3lLcy3PwkYBdycU5DRbw78UYRURs8iz8lbhHLGZNBoGysrpxePfJ3x2rCjG+Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z/kxnZCRJVuo6/Cgf5AhClmEVFrAcbQvo94VbgtGpAgdcR7NDLT
	zxeS/4JRrsC6aelFLP9b2BOfm35+mqGc00d/gqKCAZwpibh2mLhN0n2CGcjIwihsY4z5QcwZbsU
	pVNyzSsPo7Zxj+3WrHgFtLfoJFkmfSmB4u2nIQiZA
X-Gm-Gg: AYBFou3BzJY+5Tj5IojBLxy7XlSQhxo77bnlnLKkgWAodYxOxg6QdzumbT4au7tHsnH
	3nZMAntkh3tSrxtljjFeA4V6QHrBUQCBDCDS9VDXLaJpK4r4haF42BLua/j6Oh6a77LvVN8PQ1N
	Y0j812wabvXyyA7JObgK4aUtcIup648CxNFInZnLSpMlJhHw+BbPpJDwNDcD1YQg2zDQbo85/zx
	hDRT+43IQ2yylANDnNC6jzmcKIT1ETRSqhKMUGm3klwaNIzDJNHrTM5+2Ab/cznvm6QxeocXNQF
	7JkVNR841tNrOS0XJWh5tgl5I8p0+LY4Mh4T3Jo+HSdVtfxKp09Jmfv3Uhl/eGl4BvTQYsO0gVy
	tY65nsC56wUvftW20hO3fP+AC84bjqyG2+6/WOUm521O1ME1FVja8o0CjgpE9kKjKEbjfTA==
X-Received: by 2002:a7b:c8d7:0:b0:4a1:eb02:37c with SMTP id
 5b1f17b1804b1-4b76cdf14e3mr150235e9.6.1793985683858; Fri, 06 Nov 2026
 09:21:23 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org> <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
 <20261022201229.GH3381610@ziepe.ca> <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
 <20261023140107.GC3977851@ziepe.ca> <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca> <20261103080933.GA4213@lst.de> <20261103151021.GK3889730@ziepe.ca>
In-Reply-To: <20261103151021.GK3889730@ziepe.ca>
From: Naman Gulati <namangulati@google.com>
Date: Fri, 6 Nov 2026 09:21:08 -0800
X-Gm-Features: AclHuK9QrDyTYpPe0hyDJDnSB0d1jRnWKMXKMwxckIvbaQIWb85nKJEtPirUyxs
Message-ID: <CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69trmw+BJRVYf3JB1g@mail.gmail.com>
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

I drafted an implementation [1] for premapped TX and RX buffers on top
of the existing networking page_pool. It is implemented entirely in
the networking layer and extends page_pool as the default RX
allocator, to the TX path. There are no hooks in the IOMMU, DMA or
page allocator code. I wanted to understand if this implementation
correctly captured the feedback on this thread. Key components of this
design:

- Chunks: as in Luigi's series, memory comes in 2 MiB chunks, but each
chunk is mapped once per opted-in device through the DMA API and
records its IOVA for each device, rather than using a shared IOVA
window.

- TX: page_pool accepts a memory provider for pools that are not bound
to an RX queue. Per-CPU page_pools take 32 KiB pages from the chunks
of their NUMA node; TCP copies sendmsg() data into them through the
task page_frag and allocates its skb heads from them.

- RX: an instance of the same memory provider, sharing the chunk code,
backs RX queue page_pools. RX chunks of order-0 pages belong to one
device and NUMA node, and are shared by that device's queues on the
node.

[1] https://github.com/torvalds/linux/compare/master...NamanGulati:linux:ne=
tdev_dma_pool



On Tue, Nov 3, 2026 at 8:24=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Tue, Nov 03, 2026 at 09:09:33AM +0100, Christoph Hellwig wrote:
> > On Fri, Oct 23, 2026 at 11:50:23AM -0300, Jason Gunthorpe wrote:
> > > > Disk I/O is still potentially affected by the same problems
> > > > (cost if io mapping/unmapping, iotlb thrashing, bounce buffers
> > > > in confidential computing...)
> > >
> > > The disk folks already have a proposal to address all of this using
> > > io_uring and preallocated buffers. I really doubt yet another version
> > > is going to be interesting there.
> >
> > Huh?  If you mean the dma-buf I/O it doesn't really have anything
> > to do with disks, except that this is the first user.
>
> Yeah
>
> > The dma-buf iovec can work for every ->read_iter/->write_iter
> > consumer, and should be adopted more broadly.  Including by
> > networking instead of their own totally weird different world.
>
> I'm not holding my breath on that one..
>
> Jason
>
