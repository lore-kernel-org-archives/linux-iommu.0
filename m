Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31959280CD5
	for <iommu@lists.linux.dev>; Tue,  5 Aug 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408545; cv=none; b=n2sB+SzsNJdFboWnYMauVtx5hDXeVF9CbeyFiirt7TJ961i8JF4gDWEFZ3w6W68U0EdW57fLH1lOoAUXpbo7iH6mM270ou4nQwp3GAM9KMpVWoBdYbLQY91zkQelTSFoUuHnYHoPsSxIhhQ31Dn1zeNIvfvwI6eH4xGMvFb8HKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408545; c=relaxed/simple;
	bh=a4XlgZlbGJ3sRkVR1drtwriay9L4ComlRut5kWFIm1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ry8gaxF6gzr1FFO04O/tm6vDX8zqyy1L/rXxCyUDB+TKA0JXa6Hs6PS6oMxOBrXjTd39HF3FFiTAe+uo4rwWC4DWb3oS+UiRy0nOsk3cSVoScqgpKLOak8s1mYlUsTgyzXbxMhlpXc005kD/8UaYbJ/7P7Ed2JQVWqgUW5F5glA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dEtWm7je; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dEtWm7je"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b07d779287so13346361cf.2
        for <iommu@lists.linux.dev>; Tue, 05 Aug 2025 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754408543; x=1755013343; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4+S5TU1iU+zykGCf9bu6hpucmYtXHh8bdT1E2A37b38=;
        b=dEtWm7jelK1sj8wVU6UGEHFs5Fz4A2PUHzbbivoAPrJ7VswB0h3N3v6KssnSl6DjFW
         NHDdzg8Ds0GaNBbDVeOETsPSMzMTrqewGOeYwZKPaRqik092NJokrezewt/cs3tDLQcm
         wQTetnGg/2iEcZQf68xp3okH5cuH6NdNU6Y2D0Qr5CcWA1+QmSyDF//fDZ+tJKI/MtD9
         lqpB9fJ1V5+b6Uawp0KCeBdIuafFLvu77pQiT6kyMYg9aam93kaKTvhnKtVJH0KcEk2n
         JLTKPh+aWxIuP06Ak36nAqCCPnJ4bSxgz1z5OZl1VFD4V0uSTMoGaU40/bgmlZUJYNF0
         IVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754408543; x=1755013343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+S5TU1iU+zykGCf9bu6hpucmYtXHh8bdT1E2A37b38=;
        b=mS/NRVMpTv7wooGxbNMUMyRBX4uhd/8HYecupQpMGZq0u5f6rNMhzjF/Q6fCiEq/9k
         Mf/MUKeI/G+5BtDyUXqc3XZuHSxI9ynKDnTzQNFez/ucWIOa+S2vXadE7BFdA0VCxxqI
         6WriEpi97Tz7rC+LqHHLES/F3OcEL1pUfwKzhkWXHiLzFSc4o4RG61Lsbq3CY/R2LCN6
         qdquZY/JXgqc8gb2J020z0We4OdVMHOtToTod1vnS3XTgmi9iN9fVrrGsrD1emroevtx
         rDnyO0gsehTmjWc2AIc3nHy8+BpiWl8BxdU4WsQm7nD7ShKmHMVEwsDPS/ddmOf+qf5/
         EC3g==
X-Forwarded-Encrypted: i=1; AJvYcCW6gOXiKYp0gU4JB/xbDra1J68ePI2JNx1fxw9v1NW5o1uNjHhqjmkr4SP93h77nb9v//Y4Pg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzT22UaYYo6jgTybyW/FA0t0TbMy078HPbSzAqoSUThxFcQFrwM
	q7hU3EyoYwRBUQf9dy1SfNj1y/MNJ/EFh92d2UQ1eE75mA/mIEMzjz+P53O3WmwQQAY=
X-Gm-Gg: ASbGncuWtXI4ccNqBAahW4pm+rrv8WtDfzGM6NiO8cn03Skm4FBtrR6P7i6oOcjfTac
	++3kz5WuzyYl38fPo2rzkeH2WF4q8RmdU/sJ0Bn3SFkvseb/rUpf5nGo+tVV3GgNWHiDtH81+Qg
	wdGwNroAVaplK/CNLmYeuldcGAZU6vVWqSu6XZ9bbhw1RtDTemug9XL3/7ZsfiGG2pOwwmFYQmN
	ryt9KGTpXNaGxYtvgCnoiMWIFPENPdEy6PdY9PxgoArRJZHhjZJMZQKpC4bbfV6IAQvzliiYRsT
	kGk+GrJiCuuS8NBNFPfHSXEObkjGIqeJNdIK7mzE6j5TW3WR6pN0Se42jl6NOBb+88ktL3WvTrh
	eimYvxabfhn9wSQLbKMiSqwF6Osy+RxdeWQJ7vN1wvQlbSSbgBWIbHldLKyALtgzmGefq
X-Google-Smtp-Source: AGHT+IELNrIMqnerJkL1A0WsqSjDCP2vRHWDCNTCx480e/QMCD91vV4yAiss3qzKjBGdBblt5Jsn4Q==
X-Received: by 2002:a05:622a:4107:b0:4ab:6d49:eb59 with SMTP id d75a77b69052e-4af10954c24mr187961691cf.5.1754408543089;
        Tue, 05 Aug 2025 08:42:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeedb2b7asm66390101cf.46.2025.08.05.08.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 08:42:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujJny-00000001YZf-0BVr;
	Tue, 05 Aug 2025 12:42:22 -0300
Date: Tue, 5 Aug 2025 12:42:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, dakr@kernel.org,
	lyude@redhat.com, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Petr Tesarik <petr@tesarici.cz>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rust: add initial scatterlist abstraction
Message-ID: <20250805154222.GS26511@ziepe.ca>
References: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
 <20250718103359.1026240-2-abdiel.janulgue@gmail.com>
 <DBK1M000P87N.2HJHDJN1LG5CA@nvidia.com>
 <676ac763-cd23-4077-815f-8eaa9bc960fb@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <676ac763-cd23-4077-815f-8eaa9bc960fb@gmail.com>

On Mon, Aug 04, 2025 at 11:56:53AM +0300, Abdiel Janulgue wrote:
> Hi,
> 
> On 24/07/2025 08:40, Alexandre Courbot wrote:
> > 
> > I see a few issues with the `Item` type here.
> > 
> > The first one is that `Page` can only be created by allocating a new
> > page from scratch using `Page::alloc_page`. This doesn't cover the cases
> > where we want to map memory that is now allocated through this
> > mechanism, e.g. when mapping a `VVec`. So I think we have no choice but
> > return `*mut bindings::page`s.
> > 
> Just commenting on this bit, still going through the others one by one.
> Anyways, there is already existing code I'm working on that should be able
> to extend Page that are not allocated by it's constructor (e.g. those coming
> from vmalloc_to_page). I think's it's safe at least to not expose the raw
> pointers here if we can? Just a thought.

I would try not to expose vmalloc_to_page() to safe rust.

alloc_page() at least gives you a refcounted page with a sensible
refcount based lifecycle, vmalloc_to_page() gives you something that
is not refcountable at all and has a lifetime bound to the vmalloc.

They may both be struct page in C but for rust they have very
different rules and probably types.

If you want kmalloc/vmalloc to get into a scatterlist you should have
APIs to go directly from void * and into the scatterlist, and also
link the scatterlist to the lifetime of the original allocation.

Jason
