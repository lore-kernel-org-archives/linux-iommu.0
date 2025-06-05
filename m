Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E326C86347
	for <iommu@lists.linux.dev>; Thu,  5 Jun 2025 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749139328; cv=none; b=im/rY45yeX+Vd0SBMx/lxdN+tIH8MSQ5qJr66d5mCOSTrKmSsxUF1pwpUDfFjGflaHxVCRljXjN0/lFIVsmk/7C20ppkEyxOIGrKVLt9Miwht+eMrjXwiIAmlHPKjb3ItRu8yoLEnziLfN+rgV+vo/M4F6F4yG3duq92vJN4c78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749139328; c=relaxed/simple;
	bh=cl4ucnscv6CHIcnutTwdkRM+vCkQnkKeFsyDVSBopSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmnPihqiKKo39mQKptAYxGioUC7uJdwk3vDtFgWxr0DhkMhRiHbgm6gF0KP9rCtMtaKPrYVZgVProSaTxHr+BRBH/GCYkKy+B6ZsGy06qWlS+Zb9roWeg8jQcssaTEfFC8ClqIByPr0fJ92W+6io2BaN6bVBKyCk00jG5rRT3Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SxXEqHI+; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SxXEqHI+"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a52d82adcaso14960741cf.0
        for <iommu@lists.linux.dev>; Thu, 05 Jun 2025 09:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1749139326; x=1749744126; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cl4ucnscv6CHIcnutTwdkRM+vCkQnkKeFsyDVSBopSw=;
        b=SxXEqHI+RszxUv9+FdLrrAqxMXIU60hgEKx+RjCXrJs1qzK29twq2yZJRn7gjyHokZ
         Njwn1B2wTO8VMR3YpVMfROfnGrBlBT0YO0PBfcLnC+oFs+2LCnF1c3ugNjiP08Y/GqQi
         0x7dJqrN47fXcLQ9c328UBe4F6wPLXpfofPEw9xvAmgWGvY4FV7EY2T1gm4E69EIgH0q
         rpvgd8SRNcpVN0jYCzUFcnBLMDSFMpRjtEmQyfI28ws2z3eYnytCDCYOHDwWwD0Y6lqm
         K9s5dZCVWBWxinIfHwpqff5lMUXw1JAx2UwZtsu2E8g38pNYSEQcpNO7QETh+NLBGFPm
         pTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749139326; x=1749744126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cl4ucnscv6CHIcnutTwdkRM+vCkQnkKeFsyDVSBopSw=;
        b=mvWizFkb6gLCwXCK2JAsB4OzdnlTskjXyANa9arjtoPyrikwlSzO6QsnaXUmJdFDKF
         S53m+16pdTbYEHw5eNPlt7SgFt+YlwkEgeT0JXTFDWsPWcdXmzPFSyR6t+tOFNIzMGQP
         YPD3MQxwqTnCTQ3PG/FktTIDNjzhc4OuBu66OsQQ6I7vB3SEJkbmIDYxPKkP9o0btmxO
         VcgWySymFZhOaeGsuvU0EITHNsiJwrtsIXNCJmWA3+wJlmYmSc8aLgHVsfkrTVP62ep0
         11gJT31EBfnzI2mK9PWxaK36hwGIt3x/zCSKNaRh64ZHyHOrd8VH+IsFG9ZqwsoNRjdA
         NfbA==
X-Forwarded-Encrypted: i=1; AJvYcCWQJltXa5Rh2dIsk6+qdSw1v8SUWKzKA5TsuCX+SA925jBLIckK5WBl/HcxYeRIxZlmGsZWXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YykYoTkdBPwi6xpJZGCWArqZgyEhfYwjd6IX8hKi3S8X8J/5jgO
	UIMCNdkDGmLPvFa0/FaY0zRngb1hz/Izku1CIOu1FyZl2fTn8Hnzx6+rq8uICb4sPnA=
X-Gm-Gg: ASbGncvQwt8oyRXpn2/lZ/XNS3E8wfSHgBgW0chUyfEub37kxiZXwBMJm68+bctbUZA
	2eEvw0cva0EggUxzIVT2+gWW35X8Tp38atlRbRZ6SwbUbsvXPDOMdfdy+JDx+up4qwTS4JNSeik
	5JW0rafQgTF9kfBWknIPx1GkCwLexOiGUYQjfPsLj/Q7x9fZYOYCQb4KkjZv4I3kuX0MWiaChKg
	0HKVAFJOS66BGc4OR8PFBcItz/LHe9hlRVzwSGMe1OfXrj+sSWgF+tsgwZ7j/oVi4DpIAdAttIv
	vJZol2Jak2KupYgNY2+UsFk+GoLSviQqhLI7Zf7k5W0XfS21suP+w8AEE+PABwgTkkJzFwABwUc
	JDvMlhSuT2KMImwk3OCDv8SXrVo4=
X-Google-Smtp-Source: AGHT+IFiawY3TdkU1c2blIEaPT+D15Jb8mRuBjYoikvI4CVvIzUMkgXJuKc07rw9aBvqhR+5BYsXQw==
X-Received: by 2002:a05:622a:5c95:b0:476:8f75:b885 with SMTP id d75a77b69052e-4a5b9ece0f5mr3684891cf.44.1749139325648;
        Thu, 05 Jun 2025 09:02:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a435a7ff06sm113387851cf.73.2025.06.05.09.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:02:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uND2a-00000000GSr-0tWm;
	Thu, 05 Jun 2025 13:02:04 -0300
Date: Thu, 5 Jun 2025 13:02:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, dakr@kernel.org,
	lyude@redhat.com, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
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
Message-ID: <20250605160204.GC44681@ziepe.ca>
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
 <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
 <20250529004550.GB192517@ziepe.ca>
 <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>
 <aEG5X7FduqFvgXxH@Mac.home>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEG5X7FduqFvgXxH@Mac.home>

On Thu, Jun 05, 2025 at 08:35:59AM -0700, Boqun Feng wrote:
> Late to the party, but seems to me the main problem here is that we
> cannot pass a reference to .set_page(), note that there is some work
> that would change the Rust struct Page from a `*mut page` to a
> `page`[0], and then we can impl Ownable[1] and AlwaysRefCounted for
> `Page`, if that's done, then I believe the correct parameter for
> set_page() would be an ARef<Page>.

There are alot of things that want to go into scatterlists that don't
have struct pages that are refcountable (eg frozen pages used by
kmalloc).

So I don't think you want to go in the direction of forcing
struct page refcounting in scatter table. That is not how the C API
works for good reason.

I also don't think it is a good idea to push more struct page stuff
into Rust as we are trying to eliminate struct page from the
kernel. It is better for rust to stick to KVAs and convert to struct
page in core code only where absolutely necessary for someon reason.

Which is another part of why I suggested set_page should not be part
of the driver facing rust API for scatterlist.

Jason
