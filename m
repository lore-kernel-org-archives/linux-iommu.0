Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440E2339878
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157122; cv=none; b=sUEB/ZIY5bImSGCh85pnSu6wq+Gradvshsv6R9vVyBlC6/iQqXC0yiMeAOq6JTyfzfyOByrC8XwrntONXonlrne+j46YP5GtJxJDNLClgb0BNLj2mtwof5rlCP7jSmsNLet4g7g9QgeNCko5sgEsstxY0elUMOV9urhs375eJ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157122; c=relaxed/simple;
	bh=hbXC2AdsrfOcablKNwPdrwTw50dVWbz4YA+va0S+KXg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dk0r0ZATdH2u0Uv+EIMSrdoouFygDD1qJ7NxGSsvRNO6yqzbW5pV4WR1+3+m0BvqZltrdGJADMGGfMdbKtM+wphSacI6KHq5CFfzmhMnfzJ+IPLZtsdsbjvVyp8eAisikKrwvEFYvoIt+GcroFQOQH8O/WAhjyalcqK2wG342ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fm8LUnUO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fm8LUnUO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1766157118;
	bh=hbXC2AdsrfOcablKNwPdrwTw50dVWbz4YA+va0S+KXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fm8LUnUON6zeA0olAxNc0JU+8h3LF7uwreCv3zmfhIqhq3cZIVfo691ye0odnLRjx
	 ya8cG6pNcSmizToFufznzPsErbNG8+ZH6J8/ihp/tkBL8ElCiWasFSSGZU+do880P2
	 l1a+SXVcQtzwxTEpXy94YKF/UUw7Nqg2rxGb4ZHYKfxrB4W7nnP9lXxKoLyrArRHrq
	 bLgVJFttqPGml0Gd21HOgdDgLOl7Lu7Na2gMtf3T6O8kkpDPcNusGaxq00jP1xhGMJ
	 L5O9f+aakBx+R/WoniuXLojoh1DXotOx7RC24OshSCo1vfg4S4JlfryWWrXkkNUgPV
	 xl+2BLkR5XZSQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 820E817E0CA3;
	Fri, 19 Dec 2025 16:11:57 +0100 (CET)
Date: Fri, 19 Dec 2025 16:11:53 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Miguel Ojeda <ojeda@kernel.org>, Will
 Deacon <will@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Joerg Roedel <joro@8bytes.org>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Asahi Lina <lina+kernel@asahilina.net>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v4] io: add io_pgtable abstraction
Message-ID: <20251219161153.420d1c46@fedora>
In-Reply-To: <aUVje_QZvJ9rjedp@google.com>
References: <20251219-io-pgtable-v4-1-68aaa7a40380@google.com>
	<20251219140557.GH31492@ziepe.ca>
	<aUVje_QZvJ9rjedp@google.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Dec 2025 14:38:51 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> On Fri, Dec 19, 2025 at 10:05:57AM -0400, Jason Gunthorpe wrote:
> > On Fri, Dec 19, 2025 at 10:50:52AM +0000, Alice Ryhl wrote:  
> > > +// For now, we do not provide the ability to flush the TLB via the built-in callback mechanism.
> > > +// Instead, the `map_pages` function requires the caller to explicitly flush the TLB before the
> > > +// pgtable is used to access the newly created range.
> > > +//
> > > +// This is done because the initial user of this abstraction may perform many calls to `map_pages`
> > > +// in a single batched operation, and wishes to only flush the TLB once after performing the entire
> > > +// batch of mappings. These callbacks would flush too often for that use-case.
> > > +//
> > > +// Support for flushing the TLB in these callbacks may be added in the future.
> > > +static NOOP_FLUSH_OPS: bindings::iommu_flush_ops = bindings::iommu_flush_ops {
> > > +    tlb_flush_all: Some(rust_tlb_flush_all_noop),
> > > +    tlb_flush_walk: Some(rust_tlb_flush_walk_noop),
> > > +    tlb_add_page: None,
> > > +};  
> > 
> > This comment seems quite off..
> > 
> > Usually you don't flush on map, you flush on unmap. The TLB should be
> > empty upon mapping and not need flushing - except for the rarer
> > special cases of clearing the walk cache which cannot be detected any
> > other way than using these callbacks. Doing a big flush on map to deal
> > with the walk cache would be worse than implementing these callbacks.
> > 
> > The flush on unmap, at least for ARM style invalidations, needs these
> > callbacks because they provide required information. If the actual HW
> > does not use an ARM style invalidation system then this page table
> > code is not optimal for it.  
> 
> You should not assume that the way I worded something implies that the
> GPU hardware does something weird. It's more likely that I just got
> something wrong.
> 
> It looks like panthor / tyr flush the range that was modified after both
> map and unmap operations.

There's actually a confusion between TLB invalidation and L1/L2 cache
flush/invalidation. The things we can decide to flush/invalidate around
map/unmap ops are L1/L2 caches. The TLB invalidate, we don't have
direct control on: it happens as part of the LOCK+UNLOCK sequence, and
no matter what you execute (map or unmap), you have to surround it with
a LOCK/UNLOCK to provide support for atomic updates (GPU is blocked if
anything accesses the locked range while an update is on-going).

Robin, feel free to correct me if I'm wrong.
