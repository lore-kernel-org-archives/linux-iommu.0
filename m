Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792705938;
	b=u+Rnt4dL0+Yj4zuXJ8mBLZpLE4z16FFiVJtTt7RdfAno33TRoBd3aI64pIVG6cYFrnSw
	 ItsRMm5Fjr/QcqvFkCvuWIsKJ1qk18wLGY1Ni9ctCEDeslSmVP3kr/oTojUSCjQQlZZTZ
	 VAKhM/QM6zVHNWZcAqTy+NPYump4ZY0bjz/6aYC6Zi6v1yqoDoGj8C+w6KCFg/z491q91
	 BJzmudzNCHfWmiSaGqnQiXXKTKqSOjHuHT0G5Y+CcWMr55g5rVPNM2uSVCfWtV2LLQxRS
	 tGNjBEYkJKc6pgH2PxQzSFuYOgkgb5bg+3HZKJCOfEDkY2JEbt3TfSld6Wha8KVMxEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=enf2YbTyhYZro8noMVoZG0AyfViHUg43We1xb8wdUb4=;
	b=ZQE6exnoaLoYtfbdjbKX8/TkyG8bzMSNYVWhR9m5M2xvIBkzJZ5Ih8MSEfhWlsXKgk2p
	 +COqHz/1C1cYMLly6lBuIVF0/RM4iqcZCuyo1QvYVs0xj3Frr7T7wrvsLSSR6WRqT1gT1
	 TGN11X/nJlkaVPwQyiMPC4tdG4Tb6AnXn/VFJzwPKPaOLAJ0frS1vz6O2ITH64YEpyb2m
	 EiZGYCBzC5PK9Gk3zut4Tx39FlgnhD73tCCkyhzL6jLkAshrhVbEqf/ytdz8sXcQJj0Rd
	 pJq4M0etyc0JHuBFRP5KwJcu6Wqs1iRP7ghY0IO8fZf5Grqz+QAqbsVvKanRK0Pj45w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DxisIW5E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D26E60A2616
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 21:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D26E60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DxisIW5E
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e9f6a16afcso9835ad.1
        for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 14:52:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792705938; cv=none;
        d=google.com; s=arc-20260327;
        b=n6U6vAYFt4oDPyLCn3Gyj7HTye77K1kZLAGUMPQaBylue0nEuvt0GQBkaFma8czRXO
         m44ttqfmBKaFmkJQiL43x9xzS0ifw/jOxVWvVAjaZlnplvI6FR8jBd/kX/JZifSc7a69
         XD3ZiwJEcBPaUm5Kj005OcYR+kCdCJfyaocNmeiY3kc/icPRM5mrIYPmBmzsx/gGR25u
         r6+Tg3tgPwBiI7GbWk0eWGA2Yg6IVhQysOp51RXt9U0CYOupJBYUF+ifRdFaAaPDA5lh
         Vc7iL3j1PLLSlm04e3/jJWffXPbYNHi0g9+8ueGMxZsEzUEyTbRZenKK6wFZTePWEmAm
         gXSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=enf2YbTyhYZro8noMVoZG0AyfViHUg43We1xb8wdUb4=;
        fh=0gU8X7IvlZaWrLhABr8Xb0l8X4p8NnIGBY5K9VSbYn8=;
        b=dxlgQ6HOEHv01unLhEFEWrCqYK256tXt6c5QzqNJEfcQOIEsJdcF1V5jrrDa3vjHZl
         qNeDnl+OgF5CjVR/vMsKzZA5bvqQ+fg36E9wHpMhSrbfbxeB7rXpk2bKtVL1UFDNRg+U
         VY1hARWVWPeJsi23GDokWUgGh5BiIzMArnZXfLzdu88lBA5fjLyXihqcRKoIR74aJYBu
         iXlwYlv8PRRbGdcRvjqJdAqlt1RRUCE3pTM2sV45A/irjU14IvLVHCcD3kJ0VtL3U/TS
         DI7gNX96UDb8AMtieCNmQNRsmbS420robHK/9XXUN2PmfQnp4YudjMxYSZERfUJNTB4Q
         bCUw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792705938; x=1793310738; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=enf2YbTyhYZro8noMVoZG0AyfViHUg43We1xb8wdUb4=;
        b=DxisIW5EX9BnXdjvCgp1Lp3mluRfuGbHKMspSDFAFLy5z2Sskghhil+eioVSG27690
         p6I4ZpTDUhRqNzYNWNloeDhzdKoBzdh5h8ErHTsbx9KT7kmO7JUM4s3fs+hpDzq/wr3J
         eerAIZnt6ljzsrDWbggEW8Of6AH2lTYUSutKxFo96aRtMbSmx1uRt4so6+nZj0HflQYc
         jrfoinrsbAQTrUtmXS37+sGiK43YJ4SvHelBoVbtwqw8bpCNMQio958aMPfzb/YxUZiZ
         XZhLDN3jY4lSkKpKXmCzyICrb/eXbfzhNfRL63Q9b87TnWtZkARnH/Ah9Tm3VL7RiNwy
         PADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792705938; x=1793310738;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=enf2YbTyhYZro8noMVoZG0AyfViHUg43We1xb8wdUb4=;
        b=Ew+Bk1r4fHJmbZ8+RSdDI1i6R5w6/uwTFrlF3Tob32VM4syOyfhK1r3AXATz2Vjz+W
         b1oQThSHddnxRZy1XzHn1UoOoWwaoHH/RCFVuAgbD9O7ku9dINIrfREJQLIkLU914iG+
         3U/pqYexyRci1sj0Xf4aCScBl5cqH654D7pPQLEyXWGxX+zVAjC5HUeLwAcko8cgKmsZ
         WaHokUmBhevKDxIwUnNUD/14rV1xQ+hqPIDrV/r0kJsncFJbpqRGwHdoFMkkKqjQgN4h
         lJFO5/Ji1j4fI/4edRoNcAnnQAETEwmh3J+DL0JMGm3c6duj8FCjCFrC9IJPCwbXjpPf
         1j1A==
X-Forwarded-Encrypted: i=1; AKwUvBzzklIHMQuvuoIo9chNgbYSvo+C4GO8jCQw28I3xHNXd8hYKkrU5H4+8TdD47wCY6AIc0/z9Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYLgZzOW0oBtPI0xTZGRdWKz3YOeBn36V8k+iBN9VLyqhCLGqWoh
	2iFzqk1MwGiOUbDQWTnfS46zMLiC77ENLC/caLTa71mjz+aUP4df52IsVVE1x4xVkoufJnSuIOM
	lAjNF6c8lxQPrpdGtXFQbmTEe7c9DLttEybl+uYtyFrr3o45mFDByrg9PIqfTnw==
X-Gm-Gg: AYBFou2Yu+g4T0bwCQNsbiYx2xwmi6P5qSSBajlVNpRSl4s9W0cpUSrwjixkFWPpoWO
	jg/sHyD8B0SsXUot6lGrkxyawVeuoJJ7jyySxjq39vcif1scf/Ggz1P/UfQdlGSGRZt1J98+U0/
	gEA+hMJQ3960trCqdHr4ZXpt3yehRldEdPGLIDRy963jmzVOOBM8sL16zn62VajRvxxbRNwE8bg
	u1gNlU47ixi57OvnVYziwZVjkp0qgIlSVvr2S+RS0JnlC1vz7dwpYPcAsFZtBKzbC/VV7LhQSqm
	Ko/AJnAQ+gsUFa+35SSrExHHDrxa4wEblxmtF4LH0mDg+/d8c4dff8n+Q169eb6f3befwD+K9oo
	ncbiuXcnC1eYYUsquuR+NOQBPyZDqGed2dXmgcmywhyERsKITjsO2HCb4Sk8=
X-Received: by 2002:a17:902:e881:b0:2e6:1917:fa with SMTP id
 d9443c01a7336-2ea7ed0feb4mr728955ad.7.1792705937217; Thu, 22 Oct 2026
 14:52:17 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org> <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
 <20261022201229.GH3381610@ziepe.ca>
In-Reply-To: <20261022201229.GH3381610@ziepe.ca>
From: Luigi Rizzo <lrizzo@google.com>
Date: Thu, 22 Oct 2026 23:51:40 +0200
X-Gm-Features: AclHuK-9aqzBfV-60_dzPgAjNzAFJyPZLZoLZFY0CUqnWbJGyVX0XJhPkps5rLY
Message-ID: <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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

On Thu, Oct 22, 2026 at 10:12=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Sat, Oct 17, 2026 at 07:11:28PM +0200, Luigi Rizzo wrote:
> > > We should probably just find a way to describe that this is a POOL th=
at focuses
> > > on physical contiguity in some configured granularity.
> >
> > Before embarking in a global renaming, I would like to get opinions on
> > acceptable alternative names (possibly with a short prefix usable for
> > identifiers in the code). I could think of the following
> >
> > DMA_PMAP (for PreMapped or Persistent Mapped)
> > or, ahemm...
> > DMA_PISA (Pooled IOMMU Superpage Allocator)
> > both using dmap_ for internal name prefixes
>
> Can someone explain what outside netdev would use this? And why you
> couldn't do this in the netdev page pool?

I can try.

Regarding users, the next target is disks (not included in this series)

Regarding why not just pagepool, see below.

FWIW when I started this (after the previous work on swiotlb copy elision
https://lore.kernel.org/all/20260824152932.1583506-1-lrizzo@google.com/ )
I thought this would take only some simple tweaks to pagepool and
skb_page_frag_refill, a couple of days with some agents tops.
But the agents did point out that there were a ton of corner
cases to handle (device detach, reconfiguration, memory
reclaiming, reducing locking contention...).

As a reminder my goals are the following:
- reduce DMA map/unmap costs in strict iommu mode without the DMA-FQ
  compromise on security
- address the IOTLB thrashing problem when using 4K mappings
  (very serious even with DMA-FQ)
- help reduce bounce buffer usage in confidential computing and
overcommitted VMs.

With that in mind:

> It is not a common workload to have the DMA allocator be the one that
> allocates the memory. Usually we are DMA'ing from memory that was
> allocated someplace else.

Aside from the fact that dma_alloc_attr()/dma_alloc_coherent()
does memory allocation + iova allocation/mapping,
this is not what happens here.
Maybe the confusion comes from one function name
(dma_map_alloc_pages()), but it doesn't map any thing.

My code (in this version, and more in the upcoming release)
mainly implements a specialized memory allocator with an
API equivalent to alloc_pages() and variants, but ensures that
the order-N blocks come from contiguous 2MB blocks reserved on the fly.

The physical addresses of these blocks are recognized by the
"dma allocator" (I suppose you meant the entity that allocates the IOVA ran=
ge)
so that it can apply specialized IOMMU mappings backed by 2MB IOMMU leaves.

And finally, it hooks into existing kernel subsystem (pagepool,
the skb transmit buffer allocation, dma_alloc_*(), dma_map_*()
so that devices can opt-in to use it without any driver code change.

Regarding pagepool:
For the receive path, I do use my allocator to feed pagepool
(in the next version I have wrapped it into a proper memory provider
interface. Non-pagepool NICs can either use a few trivial changes
to call dma_map_alloc_pages() when filling their rings,
or convert to pagepool (slightly bigger change; anyways
there are options).

Note that just feeding the pagepool with 2MB pages is not efficient because
the fragmentation in pagepool is done with a bump
allocator, so recycling blocks from a 2MB page is difficult
(it has to wait until all 512 blocks to become idle). My code
has a bitmap to track usage, so it naturally recycles at the block level.

Then there is the transmit path.

For skb heads, one simple solution is to use tx head bounce buffers
some of the patches in the series show that option (the next version
implements a proper tx-copybreak).

Otherwise we need to populate skb heads with pre-mapped
memory. In the next version I have a simple modification to
the slub code to accept an opt-in alternative to alloc_pages().
I considered using the pagepool, but the changes would be
similar and the layering seemed really odd, with a cache on top
of a cache.

For transmit, there is a bit of impedance mismatch as well:
skb_page_frag_refill() does not know which device
we want to use (in fact, it is a per-task so there may be
many netdevs used by a task). We could tweak the pagepool
to be device-agnostic, but that would be a bit more
intrusive (more architecturally than in terms of code);
also we need to make sure dma_map() on those pages does the right thing
without trying to map/unmap the individual 4K fragments,
and we need to make sure the skb_free() etc does
not leak those pages into free_pages().

>
> I think Robin is right, this is just a special case of the dma pool,
> and it certainly shouldn't be something as grandiose as a subsystem..
>

dma_pool() could be tweaked to allocate 2MB and return order-N fragments,
so maybe that could be a provider for pagepool, but it has some caveats:
- when fragmenting, the freelist is constructed in-band, ie using
  memory exposed to the IO device. That is really a no-go if we use the IOM=
MU
  because we don't trust the device, so we would also need to
  allocate extra memory for the freelist (no big deal, but
  that is basically what my dma_pmd_meta supports)
- memory is never released until the pool is destroyed,
  so there is a problem of stranded idle memory.

Trying to use dma_pool for the transmit path has all the problems
listed above: lack of device, inefficient release of memory,
coarse grained locking...

In summary: of course we could tweak existing subsystems, trying
to reuse them in ways that were probably not anticipated
(see the above partial list of missing features).

I think that once one addresses the functional and performance
problems, the changes would become quite intrusive and the risk
of penalizing the currently supported code path might become significant.

cheers
luigi
