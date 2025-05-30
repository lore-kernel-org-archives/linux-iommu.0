Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A01F22ACD1
	for <iommu@lists.linux.dev>; Fri, 30 May 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748614474; cv=none; b=Nco5mfOmQN9MNZ4FcPggZohBh3gaDxD8NY5h7x6DmF6LH1novb5t+Jh44JGomXWKaNIJrk4VUGgjxLGw39vVtXhKWUCawzZXbOQUybiZfLZFhZ4Uz9n261nFSHT0eFwGm/rwwBMZjRUyfqjfRwh21JVOA5k3eKGUzFitgVmXOKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748614474; c=relaxed/simple;
	bh=w6vyIbiIt60OQA+budbiiEAKBy6+C3l3+8JZbPAM7MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOKKyWOvs9c4X5ZWx3vFx8oWjZeN3XaQ7r6Dqx0L5UpucNLg3Zl+W+lEncIkUXfOfVSZMxTErhFarcUzQPKDnXdgz2/84DizEPkE9M3Tdh8Kgc2nU0uTq7rFbEFbh7v4hmMy/W70rMHTINHMnXviCHQRfs6y3IqzewlawGhlwTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BsTN4kpV; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BsTN4kpV"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-601a8b6c133so1500364eaf.1
        for <iommu@lists.linux.dev>; Fri, 30 May 2025 07:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748614471; x=1749219271; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mJhRCQ3+5ch56FEt+lYFH6O5ry6RxHPulLxItBAvDBE=;
        b=BsTN4kpVlG2nraPqqbIJj79OL/txKxm8mGGV6IEyFRx8jFcRdfKctwCAYPkxYD1jbX
         qllT95s+cLcP6VQU7DF3MvaeEtXdYe2Z3J5VtP/suwTTGZSEawax1sjUPAKwdM/+Q9K5
         E+Xu96xO355Wa8SxxlFZcJhntKM/Hij7CIiG+xGTKLszDyV4lel+1f34Ku2rVU5iJKDP
         ZVqMGRUmEt06BJ16QwkEQ7d5otdxjN3qGLB6KbLEekWfc0vMBQXpfxmyUykgxNh2bR72
         uryfv3U4J4vxFNN43PgFu+40JviNbZqkNtgBmvUtKHiUD/+0GIKkvnkIsm7fFmnr+liY
         qJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748614471; x=1749219271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJhRCQ3+5ch56FEt+lYFH6O5ry6RxHPulLxItBAvDBE=;
        b=LUAhZakz1VXGsgC+vaRtpYHiBiJ2yLb8jhHlrg5tImSyQAB3MlTHV3cJJqCFyJWiaQ
         EynC9XaoZcHpmP2h0syC2rPEqqA1IbZMtiOPYoLptr+SWBnbO5nC3XJgHi63y4Cr1yic
         1Lvvl26u7zXDVPRcyi1GHsjTsOwx0NHv9YTpmuDjW6Znn+5w31hqdd9T37DIbeMA3YgB
         lDvhkREL2NWwNSQXT6n2pa+nsp+5Q0tmTtRpEeUzz5hVqbyXiewKhNs6omwu7twJNjNw
         3bqZoHNGkQinQDT86D+j6JyIkSoObWBJkZSV/yBJbiiBvDUc6nJ/si/+cIlBoBWa4nKT
         LSNg==
X-Forwarded-Encrypted: i=1; AJvYcCXFsPiN36cBKVDmomid9YK7ZuXf5pEEGOcXTO8SCmy+dNFFFx3NWTKOh1J2nqsBPFv5ykWpkA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxe3L67A18+xQDosQWcnZpJKCNrNwlKJTSnUHCekGEBLKVqgasl
	MEcYDU+BAitIRE86kfIHHcInsicVWa1Vr0KRmUpQCm/eogJhWd0PbaY+5xcmm11s4XeXLyjaxOf
	GmHNG
X-Gm-Gg: ASbGncvBnm9NL92/M2GtpfRwZlI3hBG6zbwrjKi4FfoelS9MHpsY/8ljgLMRunnARIm
	qrmZgBf8SiyMInT/HYU7Fe8Ne9ffGU44H/jZi8UrQNjh83bR3cOfRrMS3FeKuT6jWRGgKz0tlKC
	NNZzovZwSFBOHL4dtDwSO+iZaxseGXTGm0yNkEP+OcJ1Mm8nwKCJRNoXk3CrmeRi8hspnxzjINf
	+bnVj1qW/AxaGp7lUpxvpyNXYoG0dXyLtc1uNaRaJxYSLczpbq+UkBYgyMHhE493rF3zYzPVPS4
	kNFJx1iyhrnLMzrGRUtF9V2jQ1XR5hx4u1p3cE3S2b2lBOnWC/CxRUWF0ZXgzb+/CaT1saryKge
	r9bksthKIn3yJVXPbCEp0g0sK6gP6yd3TIuRl1w==
X-Google-Smtp-Source: AGHT+IFOf7i5ZEFKDYgnQUFLsEV+BJeDM6urOVFUTsIaLbJ8t+i0AJQ0vieWmToACnEapeCdrhFPoA==
X-Received: by 2002:a0c:f098:0:b0:6fa:a52b:d4ba with SMTP id 6a1803df08f44-6fac5d3ab9bmr105797986d6.12.1748614460927;
        Fri, 30 May 2025 07:14:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6e00dcfsm23235216d6.87.2025.05.30.07.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 07:14:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uL0V1-00000001ELN-1sQe;
	Fri, 30 May 2025 11:14:19 -0300
Date: Fri, 30 May 2025 11:14:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, dakr@kernel.org,
	lyude@redhat.com, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
	rust-for-linux@vger.kernel.org,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Petr Tesarik <petr@tesarici.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH 1/2] rust: add initial scatterlist bindings
Message-ID: <20250530141419.GA292183@ziepe.ca>
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
 <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
 <20250529004550.GB192517@ziepe.ca>
 <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>

On Fri, May 30, 2025 at 11:02:02PM +0900, Alexandre Courbot wrote:
> You would have a trait for providing the pages and their range:
> 
>     /// Provides a list of pages that can be used to build a `SGTable`.
>     trait SGTablePages {
>         /// Returns an iterator to the pages providing the backing memory of `self`.
>         fn pages_iter<'a>(&'a self) -> impl Iterator<Item = &'a bindings::page>;
>         /// Returns the effective range of the mapping.
>         fn range(&self) -> Range<usize>;
>     }
>
> The `SGTable` becomes something like:
> 
>     struct SGTable<P: SGTablePages, T: MapState>
>     {
>         table: Opaque<bindings::sg_table>,
>         pages: P,
>         _s: PhantomData<T>,
>     }

At this point it isn't exactly a sgtable anymore, it is some rust
specific way to get a dma mapped scatterlist. Most of the actual ways
to use a sgtable's cpu side would become unavailable for safety
reasons.

That seems fine to me, and is what I was suggesting when I said not to
expose set_page at all.

But I would maybe lean into it a bit more, why have the type state at
all anymore if the flow is SGTablePages -> SgTable -> Dma Mapped?
There isn't really a reason to expose the CPU populated but not yet
mapped state to the user at all. They can't do anything with it. Just
directly create the DMA mapped scatterlist and only expose the DMA
list through the rust API in a single step.

So much simpler to understand and doesn't leak the bad decisions of
the scatterlist design.

Certainly the initial uses of scatterlist don't need to ever know
about or touch the CPU side of the scatterlist, and it would be great
if Rust could stay that way..

Jason
