Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764070;
	b=CNbsnHKWJHeGu5Uukwi2+toT4N6ZmXvy6DdO/fzbNPrJ59VJU2D+Kl5sG9yc5ZJjdJ4y
	 RATtZV8OZgFN3ucS5Q7W2gvVQK4uXhYf4PbxD5y35Zch67VjFnJ+iKLqbK5U+JAf0wvMq
	 M913S8Av11MFARXgvqFy3L4/B6NOELWVZmbZlKDWIhkVh8D9R5lZtbAVIwfm81N9QJ9Q3
	 +bEQVJ3MBNXpA8EwC3afY7SjW3n99knHuggzgbCOI3aZMOPvw2nKr0+ox8cv6vvTZuEBD
	 fGuLNIdc6YBLZ+PN2Wu0IkHf/3CrJgxxck8I8Wl+S853YDJ/NlBFZXaikuGyFpHdQ9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=EtyMFPm1AoXY1rEO0WfbSM6JxPHkULRdHaFEkgfjDaI=;
	b=zpv5sS3XZ1kx5x1vp7c8C+ljhAW6jusWCjR2imIMnyCeCG0Qz9iPhdAHYFPRazyfmK27
	 rB0S3W4FRb8gYoiIZBaRs5HrezviOd+PkQwer0ffVyIH/3DpdRL1vojQy8/hgBYR1ZtGf
	 d3SmuscYA+2AyXcV977tqGmwFSmmqfHr/EzOQy0L8Vhcv8EskVWjWOgqZh8YZnZVzyX+Y
	 CNxN2jVqmXQ+ryCdqorigmgeyw6Mj5DAMp2D+KDVgEyXS+kzoug46aqHNVqfExWE8y6cc
	 SllQP4HrR4kcgYxcobAXPp05EFBcuffnKrSTUmjRubGHHeoyL7uW8C/saGc+1G5ocNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=LMz91tFs;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0CD606A31E
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 14:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB0CD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=LMz91tFs
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53664b4860bso8394041cf.1
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 07:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792764069; x=1793368869; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EtyMFPm1AoXY1rEO0WfbSM6JxPHkULRdHaFEkgfjDaI=;
        b=LMz91tFsGE+bi9Ry9kL+paLAvwNCbCgVvXEI6GhfnfkYpG13gCFyl3Qz9PdFPgOuu1
         qvekepVIX+QFfDFA+N0S2D0GeGWmNJZpjhG3vK2G6i+pesk21UsGTniUAHNx6pmPqza9
         1g99r3ObuSNi3TcXQHXgvgCXB+ULTohCKC/sOaj0KMRVSLdw+oPkhc0BsL2WmGM+vDbI
         EXXUXZP+GRosDXXQEIR1b4IzFErqfU4tO9jmCpIgDDs3qVEOKDAXT5uXi0KVqJj8oRd/
         pfMS0p+BStisZUPNFqTJJUSmIx9+VDtG48JYbrlC0v4+m0D4f//oJGsmaR0NxTSKYfvb
         24JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764069; x=1793368869;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EtyMFPm1AoXY1rEO0WfbSM6JxPHkULRdHaFEkgfjDaI=;
        b=XWd1hI8BXdykA5WDSDptdA3loLmQ03k0LeOq4yZ+DFD4uNPfxbeD9it1irOXxhcnTe
         lpyp0GDiHsHQvrBbWnJdDmJ8Oi/nx0UyoAwwzjO5tLLR0/+uP95kx3zB0abWckQGB+oU
         TXnRCJOTJr47g2fUsHZt5yUPsYRHhcoSY11JHSb15YMTbCrl/Iu8smCp5fuMeBnZZ1vg
         LxFhNDwjYLhZ566Nw5jc4rVU8a2VShT5+DOXbt1ESYMuyVNytvKYRztcii3tjTmpP8yh
         G/7UZHGu/nG1XtFnyjxy/kwpkBI3dvu13FhI9ThaodwCw6Z4bDeO2yaod6yrg6dgE2la
         DPxw==
X-Forwarded-Encrypted: i=1; AKwUvBxskD7GKhKCzADX1/94Nw7cuYqu36fdbTf+K2+ElVyX4LB8rs9YP9Uk0iK+n3ph/x1jDo+9MQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJpYyuTalCx05Ew4rVDpJzjlvpFqEhj0H8Y8dnfxmYZkagewZla
	6sSSrwdOF5vvqnsf7AA74YBBmeKRwmP4rLjQWQpe6SHn9IouU9BKDoVC+1mQpyby7Fw=
X-Gm-Gg: AYBFou35OD/lYM6v0OLcBvewQRHE2QIm7zkPGqQLq1s9mHwI6FLI/464WORFkkJbPa2
	4P8jiepKh6+pi7tTTAL2e7pCpFtUac2+mFEH+0tfdexjFGbYeTh8lA9w3lKyNeQeHf43gjNnEho
	X9QwLCZOGEeZ8sSwe+oit0pLdcESNfDOCAAdZnCvdCAFJe81z+o82kCzybwUYNvPMYKIFzsMdra
	PLZw1PgRGeQUOFawyngiP6ckVqyaymgB3yu9s8BR3uAvO56E7er5cLRUe6WIU4VuGgn9frror/X
	6cD53HXpv0OXZI1ZrypIIwlAO4GUs/ZQQhUvtwdAtfi1hpZwIKH12KiFzGYxLFKFlryCmsttYyW
	o4DX4nzQBmLuxmaQZ5KXthMq/S93/ger3FzgEZc0RKSYWOdK2wBomQR8191OO9Eu93PnARcTbqj
	FV4aSePACfuWQXzCcA7n7kBvQ2QRkzpMJ4dV2+c4ah1cW+szdFnmJTDfJC7Au/UVGYzze17YhpR
	HrGi+t9nvHNZCmdE2/XMiEqe4vww0iYp5C/eKLneYQTDQZ6IyhFd/TxEI/pK1vmmCsO9h/zYLgY
	xZXLg7jk7B+6EWKjbjc08XibsIVoHRU1d4ScCw==
X-Received: by 2002:a05:622a:4d88:b0:535:92a6:22ec with SMTP id d75a77b69052e-536c263076fmr30716841cf.29.1792764068500;
        Fri, 23 Oct 2026 07:01:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940479fc830sm24750685a.21.2026.10.23.07.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:01:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKFpT-0000000Ghww-1SWZ;
	Fri, 23 Oct 2026 11:01:07 -0300
Date: Fri, 23 Oct 2026 11:01:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Luigi Rizzo <lrizzo@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev,
	netdev@vger.kernel.org, linux-mm@kvack.org,
	driver-core@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
Message-ID: <20261023140107.GC3977851@ziepe.ca>
References: <20261003212241.3432303-1-lrizzo@google.com>
 <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org>
 <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
 <20261022201229.GH3381610@ziepe.ca>
 <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>

On Thu, Oct 22, 2026 at 11:51:40PM +0200, Luigi Rizzo wrote:
> On Thu, Oct 22, 2026 at 10:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Sat, Oct 17, 2026 at 07:11:28PM +0200, Luigi Rizzo wrote:
> > > > We should probably just find a way to describe that this is a POOL that focuses
> > > > on physical contiguity in some configured granularity.
> > >
> > > Before embarking in a global renaming, I would like to get opinions on
> > > acceptable alternative names (possibly with a short prefix usable for
> > > identifiers in the code). I could think of the following
> > >
> > > DMA_PMAP (for PreMapped or Persistent Mapped)
> > > or, ahemm...
> > > DMA_PISA (Pooled IOMMU Superpage Allocator)
> > > both using dmap_ for internal name prefixes
> >
> > Can someone explain what outside netdev would use this? And why you
> > couldn't do this in the netdev page pool?
> 
> I can try.
> 
> Regarding users, the next target is disks (not included in this series)

Disks don't use a memory pool, they do IO to folios allocated by the
page cache.

The only other candiates I know of besides page pool would be the
existing dma pool users. I don't think they are so performance
sensitive as netdev.

IOW I think this entire series is only useful to netdev.

> > It is not a common workload to have the DMA allocator be the one that
> > allocates the memory. Usually we are DMA'ing from memory that was
> > allocated someplace else.
> 
> Aside from the fact that dma_alloc_attr()/dma_alloc_coherent()
> does memory allocation + iova allocation/mapping,
> this is not what happens here.
> Maybe the confusion comes from one function name
> (dma_map_alloc_pages()), but it doesn't map any thing.

> My code (in this version, and more in the upcoming release)
> mainly implements a specialized memory allocator with an
> API equivalent to alloc_pages() and variants, but ensures that
> the order-N blocks come from contiguous 2MB blocks reserved on the fly.
> 
> The physical addresses of these blocks are recognized by the
> "dma allocator" (I suppose you meant the entity that allocates the IOVA range)
> so that it can apply specialized IOMMU mappings backed by 2MB IOMMU leaves.

Why? This seems completely divergent from how anything else works in
DMA mapping, and I don't see a reason for it to be anything like
this. Other than it makes page pool work a bit easier

Frankly this looks like you had AI to transpose a bunch netdev page
pool into iommu.

> Note that just feeding the pagepool with 2MB pages is not efficient because
> the fragmentation in pagepool is done with a bump
> allocator, so recycling blocks from a 2MB page is difficult
> (it has to wait until all 512 blocks to become idle). My code
> has a bitmap to track usage, so it naturally recycles at the block level.

It doesn't seem like this little issue should motivate all this
 
> Then there is the transmit path.
> 
> For skb heads, one simple solution is to use tx head bounce buffers
> some of the patches in the series show that option (the next version
> implements a proper tx-copybreak).

> Otherwise we need to populate skb heads with pre-mapped
> memory. In the next version I have a simple modification to
> the slub code to accept an opt-in alternative to alloc_pages().
> I considered using the pagepool, but the changes would be
> similar and the layering seemed really odd, with a cache on top
> of a cache.

With AI there is no limit to the layering violations one can make :(

> For transmit, there is a bit of impedance mismatch as well:
> skb_page_frag_refill() does not know which device
> we want to use (in fact, it is a per-task so there may be
> many netdevs used by a task). We could tweak the pagepool
> to be device-agnostic, but that would be a bit more
> intrusive (more architecturally than in terms of code);
> also we need to make sure dma_map() on those pages does the right thing
> without trying to map/unmap the individual 4K fragments,
> and we need to make sure the skb_free() etc does
> not leak those pages into free_pages().

This is all a page pool problem, has nothing to do with iommu or the
common dma layer.

You can already get optimally mapped 2M IOVA and memory out of the
APIs we have. I can see no justification for the intrustive mess under
this beyond it makes netdev page pool easier to hack on top.

Every thing you listed boils down to 'netdev page pool work the way I
want'

Jason
