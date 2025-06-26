Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60A228314A
	for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 22:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977839; cv=none; b=K9KBpsskXWIv2rdnmi+eqzyeDs029MH9mFesMPRnD3OcT1rxE9EZFFPgI9ThHy/xm2L5CjpyzyN9H8W0OqGIZMvfA3eX2hh5wN5TBzSahVLgKZSZokXB61cgLPJCykvljjKNjDP2UjCINWpHwsLYKMtFo6VFqB/BE5Lmo3wKKx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977839; c=relaxed/simple;
	bh=VfoblnNBGqtqqaCDzhQ9efnYRcPTy5UeogBREfnrevs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pR6TlLVJTRHmzdqbKDuDjyMUSb9KyJG2Yi4S7AheCD5aVwKtlncWPDGMBYdJ2GQNQRzmwZcAp3UU3LBrQBLZipiIn3by7IXFxabXiDWxh4j2i/C3R+xvu10tw1G+JtcnV5jn/wI7M+hXy8pohudgD8N3c+KPNj+ioG/o64UjKYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=m6wIYpV1; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="m6wIYpV1"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d3f1bd7121so147591785a.3
        for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 15:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750977836; x=1751582636; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=If95dr5h6255AmUKlhN6F3DaBJnLFhLX776luHKpLCQ=;
        b=m6wIYpV1Q2uQwb7/HvpEDcOEzOOLoqLdUmvDc8Iq1FN8d2wVcQ6S3S7C3n4rZBU6Rx
         EqpNVSeiETC6xaunm3OBreZQMOqBajbPJYYJUwyd9TjxhBnaV3uwMQlA3J1pou18RXmO
         vaqxINQ69cXHb8j2p1knWe041uZdIjVPqN+AzTdqtizoZ6bHyoupycT6MDywsEo7++8V
         AhQ1snobxQUpzmbWP9fvVnu7aYPWevThXbXJSA4hpIgI0YC2AtjbyUT+nE6SZTc8SvVF
         pN6M808hhkSSM8FoUrL1/1BlcOjSZOWYQgvR/BOD5yp2NXXdjhdHb1TvW88fDzYfJShd
         HEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750977836; x=1751582636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=If95dr5h6255AmUKlhN6F3DaBJnLFhLX776luHKpLCQ=;
        b=QWsKd2P/SGDcksmjCuTvqcwt42Qrl2sKN3oBRugyvQt8yxeuIrNRtsbqdB1AaglVYv
         D/nppPiI6Qds8ZFruYPBaCK8FB6hMn+FDYSQGsCbIcdGRnwrk0KeZ1npq5EufZY/jNJt
         uALVB34/+JOqC/ra7TRaOTDru8x726+EN4LDHZaIViUBht0jnEitBY/WjEj3SxfWnTeG
         WBNCOKrk6c9EKq45hW/t6IvkxvLhk4CtGAwXhS3iau2z0yTtP4AG+pMcSr5Q34QD+7qH
         VKgCPJBss9M6IofGPlnU+vN/zPYcb8WhL5YjXHnNYjUGNZU1DyCsBN8skmBIb0rs2m84
         nA0A==
X-Forwarded-Encrypted: i=1; AJvYcCU1l9u5Q5CRN1ovohaiWnlvmMhoiKbtF9wRzaFwNy0XXiibZY/UM+pHoIgVRj3w5GuUhaW/sw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz52HfxVkNox4hXNq6bCEi/6oeIxvzwpU6SMOX+hMpQ9BtqcQko
	3uZMPt8PyuvAkIoGSb8qE4vOf31Tj1Etck71901eBgo7+cQlQvnlqsIecER7XhMKlhI=
X-Gm-Gg: ASbGncseUa2XzUF4Gt99RhFawgnW98PCG3GeSqJhpShNtqDqvhOMZ5Z+Iglv8cfEvJY
	pgqTIyiO57dc2EnLeqED2Iq1CbmIJ7qsxiVEE5CLLy48PYUIaMJMBJvb2d2nhakTtMlXIfyjzbk
	AWMay3WGQs3SK9gGh6egiaUgnpcyBCrnebh7/4fxEPRcT8mSH/v8neAzKm9eUyaQoL2xL8s0bNF
	9g4Cm1XjEcctzPeQ8o6exEwJkuyNkfVQ/nn17bmsMBARr2pfq9g4bCrdIZcdaSA5AVFbj9+X01t
	dA3JxHPYPssn0+jKllz5XUn2cxn3tvAUpLvu
X-Google-Smtp-Source: AGHT+IFZ3zSfjYQzxyz1yM8Fepo5JqoekfbsnijfBYQsXPZ/Ajozpgkhms1b0mgB5wFz5VVdckjdGw==
X-Received: by 2002:a05:620a:6188:b0:7d4:3af3:8ef9 with SMTP id af79cd13be357-7d44394f4b7mr170906885a.19.1750977836523;
        Thu, 26 Jun 2025 15:43:56 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc57c537sm4265211cf.57.2025.06.26.15.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 15:43:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uUvJz-00000001h7a-0mlm;
	Thu, 26 Jun 2025 19:43:55 -0300
Date: Thu, 26 Jun 2025 19:43:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Lyude Paul <lyude@redhat.com>,
	dakr@kernel.org, Miguel Ojeda <ojeda@kernel.org>,
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
Message-ID: <20250626224355.GE213144@ziepe.ca>
References: <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
 <20250529004550.GB192517@ziepe.ca>
 <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>
 <95ff963ddabf7c3cd2cfd07d0231a0073ff6847e.camel@redhat.com>
 <DAED5BUK7TUQ.4JRHFMWZ99W3@nvidia.com>
 <27e17dbf-df6a-48fc-a652-ad48a776f668@gmail.com>
 <DAENGORNRVZH.2KIGKFV5C5G3L@nvidia.com>
 <f787046921fd608c385dc5c559883c5d70839507.camel@redhat.com>
 <DAP96FEJ0XWT.PWYMIE8IJAVQ@nvidia.com>
 <e2677c26-1c25-4a34-b666-9dcfa9642fd1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2677c26-1c25-4a34-b666-9dcfa9642fd1@gmail.com>

On Thu, Jun 26, 2025 at 11:31:15PM +0300, Abdiel Janulgue wrote:
> Just commenting on this bit. From what I've seen, we don't actually leak
> anything. The cast only creates a reference to the original C `struct
> sg_table` object which was allocated and owned by whichever kernel subsystem
> called sg_alloc_table(). Rust doesn't even allow us to take ownership or to
> dereference the value, so this one is safe. Destructors are not called on
> those "casted" objects.

This does not seem the right kind of philosophy.

Every pointer out of the kernel APIs has some kind of implicit
lifetime contract.

Eg if you have
  b = get_b(a);

Then the lifetime of b might well be 'alive so long as a is alive'

Or if you have some function pointer callback
  void op_foo(a) {}

The lifetime of a might well be 'alive only within the function'

AFAICT rust needs to figure out these implicit rules and the compiler
needs to enforce them.

Eg

 a = make_a()
 b = get_b(a)
 destroy_a()
 do_something(b)

Should be something impossible.

Jason
