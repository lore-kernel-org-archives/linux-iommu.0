Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377AE255248
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765529079; cv=none; b=h4k4MP4z1WgnWz6pKEGf1MRdqgR7jeFsdTPmMfeVS612iO8r8T1diryndvOjYZYMK0lJ+ZYxyf+LSeAN3QhUO3UOpAEge2IbT8hsGKdaXDdUytI3JeAxRGiNtoHfeCF+5a75b8rRS7E+RsyABr0vhW5Fx2PXudrX8zGKYivs2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765529079; c=relaxed/simple;
	bh=YlZVG6EILJaffJguwlBqnLil+hF3zrisdr9uOMs57Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CioMgcQNyjdu/j0pBT2zLyff3+S3etC+CopT0fMRM/OnVRalKqgwnwYhfijDWaOPEYjsZHIa+LFBBqG9WI+c/ZSjRC2oldbwbTYg2Ce1AtxE8aU439dH6guD1kqe7S/tqCUNricT91UX8DR3O9QaGho859OW0e7MFXWPNTDqus0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nXdso5e8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nXdso5e8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1765529075;
	bh=YlZVG6EILJaffJguwlBqnLil+hF3zrisdr9uOMs57Ig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nXdso5e8mTqNIXLu2cVx7wFXHiG+nieYuTSpMvTYVrQOCAy04g0RVrCJDC1jKcsf/
	 z0TpLcINPiOgkvn89GyoInLC/fMKhhExVgksYk9kl348oFtQvU+3Xp5dCeKMTBE+7/
	 J5t5NTqbN4TXjDrTSNl+M23Dd+nCvphe98UBxOo+xkMy6PpX4LrqTzTH5J7zEaM7sa
	 AYDBhI+EyFH1Jftx99sWy/T5E9i1SbycuXsGD5gXCV3lGnlTA8K4lIz02YXmMgQ3qg
	 uep/GimQQe3QQkRfMcc4QE6WqcrwRGVDTqnoCbcjYdnH5bIJoK94Dy6/mgLKAO9Cgo
	 7K5ANLzcoUT+w==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6FF6317E1135;
	Fri, 12 Dec 2025 09:44:34 +0100 (CET)
Date: Fri, 12 Dec 2025 09:44:27 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Will
 Deacon <will@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Joerg Roedel
 <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Asahi Lina <lina+kernel@asahilina.net>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3] io: add io_pgtable abstraction
Message-ID: <20251212094427.2ec0b31e@fedora>
In-Reply-To: <20251128180255.GA836877@nvidia.com>
References: <20251112-io-pgtable-v3-1-b00c2e6b951a@google.com>
	<20251128180255.GA836877@nvidia.com>
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

Hi Jason,

On Fri, 28 Nov 2025 14:02:55 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Nov 12, 2025 at 10:15:00AM +0000, Alice Ryhl wrote:
> > +    /// Map a physically contiguous range of pages of the same size.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// * This page table must not contain any mapping that overlaps with the mapping created by
> > +    ///   this call.
> > +    /// * If this page table is live, then the caller must ensure that it's okay to access the
> > +    ///   physical address being mapped for the duration in which it is mapped.  
> 
> All the iommu page table code runs with a caller provided locking
> regime.
> 
> The caller must effectively hold a range lock over the IOVA it is
> mapping/unmapping/iova_to_phys'ing and it is illegal to race those
> three functions with overlapping IOVA.
> 
> For example the caller cannot map to IOVA A-B while unmapping C-B or
> iova_to_physing(A).
> 
> This locking detail should be a safety statement.

Sure, adding this to the list sounds good.

> 
> > +// These bindings are currently designed for use by GPU drivers, which use this page table together
> > +// with GPUVM. When using GPUVM, a single mapping operation may be translated into many operations  
> 
> Now that we have the generic pt stuff I wonder if GPUVM should be
> providing its own version of the page table implementation that
> matches its semantics better.

Not too sure what you mean here. Are you saying that we should fork
io-pgtable-arm.c (or rather a subset of it), and have it all
implemented in panthor? I actually asked Rob if that was a good way to
go when rolling out the initial panthor version, and he advised me
against it. Now, I see good reasons to do that, like the fact we
would be able to add features like batched repeat mapping updates
(mapping the same page over a wide virtual range without having to
duplicate the intermediate page table levels that are exactly the
same), or the ability to extend the mapping arguments with
shareability/coherency info (that we can do by adding IOMMU_xx flags
too). But there's also downsides to it, like the fact we wouldn't
benefit from bugfixes materializing in io-pgtable-arm.c, if any.

It's a discussion I'm fine having, but it looks like even the IOMMU
maintainers are not on the same page here ;-p.

> 
> > +// on the page table, and in that case you generally want to flush the TLB only once per GPUVM
> > +// operation. Thus, do not use these callbacks as they would flush more often than needed.  
> 
> This doesn't sound quite right to me, the flushing requirements are a
> consequence of what flushing HW is available in the xTLB that is
> caching this. The flushes generated by the common arm code match the
> ARM64 architecture semantics. If the GPU has different semantics then
> it can do something else, but one must be careful not to match a GPU
> that is expecting ARM semantics with "do not use these callbacks".
> 
> IOW it doesn't seem right that common code would be making decisions
> like this, the nature and requirements of the flushing are entirely up
> to the driver binding to HW.

We're not saying this will work for everyone, but rather, this is a
default implementation that does nothing, and if you need to do
something, override it with your own. I guess if that's really
problematic, we can force the user to provide one and keep the NOP
implementation on Tyr's side.

Regards,

Boris
