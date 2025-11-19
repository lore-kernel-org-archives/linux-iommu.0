Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D302E5B27
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542788; cv=none; b=GO/WH89gfNg8qhlxstmFHpSnO9iVI+y1kEFPn6NR9gi6v1YpEIgGOSmsyh/rnSXzB2JnchfjnM62PkgRF12n09s8DHz4wyvNo9FushwGh6U+6iWCBfu+i8HSeEUAv4Y/uC/BwaPo+yex8zi+wmTsrzjmwRn5mBXp66PnjvWqNEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542788; c=relaxed/simple;
	bh=E8Mtrj+6S1Pc+EnCAlfDCRNIIkXp3AAXGB5KdLL7wzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0PEScUJaYInpY9NwKPj/T14OKOBJgPPIQOcrEtWad9WkeBPldV/z/wHdFiGLM43Oo62L6rIHCcy1mDh2s4ZMfJJ603MxY5Ga4MwfjaljjLtH4r6TvJHwlMNHGWlTimB/vxFfUSixBSF7PKKQUgmIo04S0sbBqQ2NE3I6ySpHD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qtHfYsxu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qtHfYsxu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763542778;
	bh=E8Mtrj+6S1Pc+EnCAlfDCRNIIkXp3AAXGB5KdLL7wzQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qtHfYsxuljOy2QzpjQ9gVt2m9B3q6jMSIEfa8stZ8krjK26dpdxvEkmd0vcZ4A5H2
	 pWvsavwzRRqTo92LpKdR0dBXvZdg09jQ4vGu1QkJkA6Th5sf14utWASO6SRsyD1W+a
	 oGnMXQk+QNq4WHLilgKXqSR3MAaQA7b/e2yEycl0teipL6DutDBA5h3qDfFm5NRv82
	 FqEeOO5QMm5yHj4WUH0kCBhwH1M7u4tOzREUKWesx56W9qQ25gusgfLd8U9Ni1GxRP
	 x/Xz7qq+J3EA5mMAtv2LbB6TiLDrqVQSdX0RLrVt09Dvxpygf95cVfBLciDTjhczPm
	 HnZV6/DWdI33g==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 280C217E005F;
	Wed, 19 Nov 2025 09:59:38 +0100 (CET)
Date: Wed, 19 Nov 2025 09:59:34 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda
 <ojeda@kernel.org>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, "=?UTF-8?B?QmrDtnJu?=
 Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin
 Murphy <robin.murphy@arm.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Asahi Lina <lina+kernel@asahilina.net>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3] io: add io_pgtable abstraction
Message-ID: <20251119095934.28624652@fedora>
In-Reply-To: <aRtOfhNjlCavCTjU@google.com>
References: <20251112-io-pgtable-v3-1-b00c2e6b951a@google.com>
	<8A5C6836-992B-477A-A77C-EE0736166552@collabora.com>
	<aRtOfhNjlCavCTjU@google.com>
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

On Mon, 17 Nov 2025 16:34:06 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> On Wed, Nov 12, 2025 at 09:57:09AM -0300, Daniel Almeida wrote:
> > Hi Alice,
> >   
> > > On 12 Nov 2025, at 07:15, Alice Ryhl <aliceryhl@google.com> wrote:
> > > +    /// Map a physically contiguous range of pages of the same size.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// * This page table must not contain any mapping that overlaps with the mapping created by
> > > +    ///   this call.  
> > 
> > I don't think there is a restriction that forbids you from mapping a region that has already been mapped.
> > 
> > If A->B->C are adjacent regions, and you try to map A -> C when B->C is already mapped, I think this
> > call will simply return length(A->B).  
> 
> I think that such overlapping ranges are not allowed. It triggers a
> warn:
> 
>         } else if (pte) {                                                           
>                 /* We require an unmap first */                                 
>                 WARN_ON(!(cfg->quirks & IO_PGTABLE_QUIRK_NO_WARN));             
>                 return -EEXIST;

I confirm the io_pgtable framework (or at least some of its
implementations) doesn't allow you to do that (remap without an
explicit unmap coming first).
