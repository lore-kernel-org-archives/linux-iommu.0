Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E301A840A
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766155137; cv=none; b=D2QyN/fa4oNBEPKOeuhB7/NbT/rD28ER8IwfNGPYSHeL46ISFuPax7nu0CDqjcMgrtl56/tj5ULVWaag0rBQblrOtVB8UMbDYtc7dvOADng88W33EzwcFAfAcF55eIvuvImrr6lges5cWCMhLjfb8IsDC8a9HwGo2T4YO8mun54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766155137; c=relaxed/simple;
	bh=tzimXUpPz/zg3NdCk2OmrJcENbwrPXNc11dumAfPvgs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HF5t2Cr4Rzp/CcXJH/6ZXw06U15sNonZGYgabggSF7i0BQofuW9J3v5CSnqyftLi+CSwsj8KGz40Z5d6IzcQj+2RRyqY7WO9sIC0UgHf1vA15nqdBwgXp2Ikt8v0P2LAcFnULV2lF+XXS8NUDgQbWrFN0PYVYK8jKX/KPyKHoak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I/7TDTj5; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/7TDTj5"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477cabba65dso10705145e9.2
        for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 06:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766155132; x=1766759932; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jOmyd9DWvECzG90gfBeqQtyNiAxdrLgSD+wKw6UfL7Y=;
        b=I/7TDTj5khGmIELwQfRZNYwuQN5Io5znugXK8GBBQALJL0Kwv+HBd4uftXkcAFKIRD
         URmcWI5a5XuKxGKRENatjglWdt0JlV9fCGbGRgAmX2wTWEV6PxD5PR989SlQoxA2DmC0
         5OT/kJEeX9496TDn4IR/aWv4hgQtDey4VtTDFVKb4VsfVu95AIFMWZLEslTely0a+hHF
         qZi/mnOYFNiJdV0gV4U2XakZ6arQr9oIBU0hk3FTI1vfDbPl6JEO9w3jxmxE3X/jVACl
         igIUgdPhwQmWHU6Ha7tCmtv/RkujUdceErmg1pXUVN6AdZ//IqrIj+eloXodOL3TDxpM
         dutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766155132; x=1766759932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOmyd9DWvECzG90gfBeqQtyNiAxdrLgSD+wKw6UfL7Y=;
        b=L9cU2dAG6gtqlJjqM/DUdexumF6wRKvui8aOvdNb8B9IJEEpPHgA/2feXa3dLKVTuQ
         KlU6b28v2MiV0yAsdj6i73Er+FFCoamni1GuxnPzGIjXnWkPGCmdKelGkuSQ74d7Z8Os
         yVnq47LQxHLqiVTYZHoH41D5LxAedGFZCJUK1qCnsYSb7vXVs4Ly1s5QN+cdMIW2yLzp
         VEqNOMdwZwqxRojTYx4bnqu1ED6q+miKmc6b5hsV1UMl5Iy/WMag4dVispa9YepUUTFH
         Klg5ha1CjoWGJv2JrNgT3wjkQOiKVim/4zcb5c8CsVvT9pPEHGtXIchAgkyWjUVLGpQH
         EViA==
X-Forwarded-Encrypted: i=1; AJvYcCVDw5sBfUCt4AuH/6N5EBubzdZx1RhNT2mshYrHP78YOztN2oOl5TQDnWrdfqRbP9jAmUPVyg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0+1qKaQ8ulJgpr4sA0zvF0UVixL9pghOsbPRehsAyKBaGGwI8
	OCmQKDkny9R9bMU0+5zlFRWIRadF004j9xok1Q7SIKKjLjBM3pI4kzUsFZL5BrNuHB/PO02Bvnm
	qgIs0ra44f7UvlTCdzw==
X-Google-Smtp-Source: AGHT+IErMGwUK2SBp0iKRCGeYMRpkaCULx6zVFN8P1+g0RA4ffuZbMddhqUM3GNAvGi3LgVlXFFniESPnoRBsS4=
X-Received: from wmbz6.prod.google.com ([2002:a05:600c:c086:b0:477:9b53:8816])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c174:b0:477:b642:9dc9 with SMTP id 5b1f17b1804b1-47d19582bd6mr30147205e9.28.1766155132493;
 Fri, 19 Dec 2025 06:38:52 -0800 (PST)
Date: Fri, 19 Dec 2025 14:38:51 +0000
In-Reply-To: <20251219140557.GH31492@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251219-io-pgtable-v4-1-68aaa7a40380@google.com> <20251219140557.GH31492@ziepe.ca>
Message-ID: <aUVje_QZvJ9rjedp@google.com>
Subject: Re: [PATCH v4] io: add io_pgtable abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Asahi Lina <lina+kernel@asahilina.net>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"

On Fri, Dec 19, 2025 at 10:05:57AM -0400, Jason Gunthorpe wrote:
> On Fri, Dec 19, 2025 at 10:50:52AM +0000, Alice Ryhl wrote:
> > +// For now, we do not provide the ability to flush the TLB via the built-in callback mechanism.
> > +// Instead, the `map_pages` function requires the caller to explicitly flush the TLB before the
> > +// pgtable is used to access the newly created range.
> > +//
> > +// This is done because the initial user of this abstraction may perform many calls to `map_pages`
> > +// in a single batched operation, and wishes to only flush the TLB once after performing the entire
> > +// batch of mappings. These callbacks would flush too often for that use-case.
> > +//
> > +// Support for flushing the TLB in these callbacks may be added in the future.
> > +static NOOP_FLUSH_OPS: bindings::iommu_flush_ops = bindings::iommu_flush_ops {
> > +    tlb_flush_all: Some(rust_tlb_flush_all_noop),
> > +    tlb_flush_walk: Some(rust_tlb_flush_walk_noop),
> > +    tlb_add_page: None,
> > +};
> 
> This comment seems quite off..
> 
> Usually you don't flush on map, you flush on unmap. The TLB should be
> empty upon mapping and not need flushing - except for the rarer
> special cases of clearing the walk cache which cannot be detected any
> other way than using these callbacks. Doing a big flush on map to deal
> with the walk cache would be worse than implementing these callbacks.
> 
> The flush on unmap, at least for ARM style invalidations, needs these
> callbacks because they provide required information. If the actual HW
> does not use an ARM style invalidation system then this page table
> code is not optimal for it.

You should not assume that the way I worded something implies that the
GPU hardware does something weird. It's more likely that I just got
something wrong.

It looks like panthor / tyr flush the range that was modified after both
map and unmap operations.

Alice
