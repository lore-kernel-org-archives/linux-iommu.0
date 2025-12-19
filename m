Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80C0327C10
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766153162; cv=none; b=AuBFCcVZo/9qTkkPKiQF64Y1TTN1TOiZ/xbcvlYDDTNfHCOuNidLRRt8CnadTFSBjQDH+9QPTOIK4F2At5aP41KN+HYX5SUehDO3Ucooui1YLSXe1yqU7s7a7rJHrmvvlfXn73JWMSENtwTLCZXSMY6/E0XLj+K2zXmfso//eIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766153162; c=relaxed/simple;
	bh=nIsNPow5kM9UVujhZhsZ0wdNvrec7uwwcDAP2NNAzuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KthLgSjHq4dE9segodnHCKddaiXoBavYiJS3JwMasPvjBff3n4iHMkaSusgvY9Tf0+9eFDZwAj+++5e2icrDn5p6QWg5TdGfSHY7jMkSRw9sUgL7XoozV/a1tBtGYuoIM2VYsn+9m0wsdBb+xRbL3gVsRYHhqkrdZ2q8yvzM1qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KvMV9Qif; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KvMV9Qif"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8886fdf674bso19217036d6.2
        for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 06:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1766153160; x=1766757960; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zZMm+69u9x+z8ibStDNPIaAJod8bPs48RdpWzI/bCtw=;
        b=KvMV9QifGiZygR/L+b6Vz1iPo8YyWS1C+aZta8pey8cu+JcYRbCZl0jp/GaGhFjya9
         JxW8fD4BLJMy2mwzLdUIitIgqGlOu9AQmKH/b5LsGjOqb4Wpj2aJ432tzjILp1NMzp0a
         6y24/PLUnf1jjRTn5QI1M+M8o/g0V6DjdBbac+KrC/M9CQQg9S9nrIL2799OmvTI/qKh
         elYsB0/yGoe1Be/mYOBgbme23QAU1nDfdo7JfHfizr6RaJPbQfQ30vudXrP/SuGg+etX
         dJgZsitD9qbWLMY6136vI6ZTY66lBQvruupCiWziESHHbCRJZ/E2jSpmRxGw47OnZDUS
         XeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766153160; x=1766757960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZMm+69u9x+z8ibStDNPIaAJod8bPs48RdpWzI/bCtw=;
        b=F+zL3eHjl2qWCdds2BZHz0CD8IUoD7l6MWhe9iKgCjPetXwaLrW+wdUmaZ1+dlNpCu
         cpkN/G++NXFTQ89fZL+SZFAI4TxyqhUbbN4LzA8XjAWO+7grmYz/PFIXpCVvId/25Lhu
         Ahn0olFwZ6kxhofOVnZcETv0Ae09xbSSvxjsPGP1a8fPfG/NPomCtgRfNNDjgdxaz3XR
         MA+jyaBJpFkonXEX6vZymGLOF3f/g7Su5Zvfe2vVEITRwe1sTZgnl0HvB8dOkFzp/8tC
         h5gw3SCXHCdjxib4yKdyKyerR5bu/KrRjX394+Sig9q9GC2ukMf5og/83y8zlT2x/3BB
         Z1fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUcEjY7EUQHMIMEcZYZ90yMuUZb+kp1QSwb0+04uFo6IdHc7NoXOxfQ/VMsxiAli+AHUPeSg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+H71ZoJYgQtqTIx8sfP4AkukN+v0PMYcvMT5NWOOneLb/rkvp
	WWiuSFo0wZ2xhLAsB74hgFcGxszMcrka4NsX+eBlx0fVDWHfjGmji7GtzjoYvTuFp2c=
X-Gm-Gg: AY/fxX4pcTNvgNsYh7vDPoBd90QtRp+Na0NR0xcimbsxLhHfCSA7BpD/nwAcrtHBSkd
	Ww5NJpZ87IGWFErxdVDgaAO32sBOMKbDZm0498mCTdhGQ0mwq5NoUzRuuNC3tcbwvek1Vi958EI
	BIaVQxxYgiYbdyPHlUQcy+XnVTog4mcvwePpHhmf1uu+QymLSLeIXueJbCJNRw4bmj6FFbf/DzL
	k659KxYbR4wdywkB4SCWxGRH+jBwEBF+iwsgjUHgmNjcGi3grsXcd9gTbvSJCD5fE3g19Ry7lEk
	EWvkq3Ty3rvLSMm4Qqu7bosN+HGym5+r3qJcfS5bcnXCAkIUhfhk4B0E0/6YTfG/Dw+6h0dapoD
	1BuLjY3zD2FVlZI8fPtL0Enw8WDZ3O9atjhJFftHhUJivxko7hP0pMoFc6fy4ciFIJSdNIIBcY7
	TgrUTbiuoAvyUkJSdWctpVB0/RUekb/pTZ3VmWLZooorhwE5lajVNF/ZAS
X-Google-Smtp-Source: AGHT+IFvQBh34jY1BRicAO6irDa1zAgb1lDbuHzEzV01DhrEsnJRDHmMIYj0wyL099ZnzNEOzHLyuQ==
X-Received: by 2002:a05:6214:4ec1:b0:88a:3b1d:2f70 with SMTP id 6a1803df08f44-88d8166a292mr48660746d6.10.1766153159564;
        Fri, 19 Dec 2025 06:05:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0971ee182sm184273485a.33.2025.12.19.06.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 06:05:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vWb7F-00000001Y07-2SxB;
	Fri, 19 Dec 2025 10:05:57 -0400
Date: Fri, 19 Dec 2025 10:05:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Asahi Lina <lina+kernel@asahilina.net>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v4] io: add io_pgtable abstraction
Message-ID: <20251219140557.GH31492@ziepe.ca>
References: <20251219-io-pgtable-v4-1-68aaa7a40380@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219-io-pgtable-v4-1-68aaa7a40380@google.com>

On Fri, Dec 19, 2025 at 10:50:52AM +0000, Alice Ryhl wrote:
> +// For now, we do not provide the ability to flush the TLB via the built-in callback mechanism.
> +// Instead, the `map_pages` function requires the caller to explicitly flush the TLB before the
> +// pgtable is used to access the newly created range.
> +//
> +// This is done because the initial user of this abstraction may perform many calls to `map_pages`
> +// in a single batched operation, and wishes to only flush the TLB once after performing the entire
> +// batch of mappings. These callbacks would flush too often for that use-case.
> +//
> +// Support for flushing the TLB in these callbacks may be added in the future.
> +static NOOP_FLUSH_OPS: bindings::iommu_flush_ops = bindings::iommu_flush_ops {
> +    tlb_flush_all: Some(rust_tlb_flush_all_noop),
> +    tlb_flush_walk: Some(rust_tlb_flush_walk_noop),
> +    tlb_add_page: None,
> +};

This comment seems quite off..

Usually you don't flush on map, you flush on unmap. The TLB should be
empty upon mapping and not need flushing - except for the rarer
special cases of clearing the walk cache which cannot be detected any
other way than using these callbacks. Doing a big flush on map to deal
with the walk cache would be worse than implementing these callbacks.

The flush on unmap, at least for ARM style invalidations, needs these
callbacks because they provide required information. If the actual HW
does not use an ARM style invalidation system then this page table
code is not optimal for it.

Jason
