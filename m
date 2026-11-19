Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098878;
	b=QsIeYI43E3J5K5kA8FfADuIQZ36XP5LnhS3K0p94pEzCtyEKX5uemGvcSyQqLkzqrDsO
	 HgFFcJDduud+R2G2xLjoV1j9/mWkk0JCEXVojEQZuL/nGW5bP3bPHNG6lXD/Tg/uYdpDi
	 kKsg1vv9NpVAHFEZU7Q2HTwc6rg96YcXxfkctUYJiXsm2YDPGxzOa9mI5zCaJj65eX/Jy
	 2XK2bW7YpHpx0vt8zp02zuuALF9GEwl5nGHGzhkTjJ0LDeVA6fFisvsWdhpq/T2+UiR1K
	 0posvanib94J0MhG/ifHSPt3Ar9D6PHSwb34wDVpqjCqarN2ZR7zYHFqRTERT/oKm+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=D76bRl0iXWEy5tiDkPamZVFcHdRNx6r1Nq+m1WWa9kE=;
	b=fDqIRoWCus3sGd+PafwtYqp2zebFPXQPzIHMp/Yo0yOv4bc5MLFckfTuYbtM5f3gOCCS
	 Go9Y6rS5KPjGnAus42mm+GwkQadhzYxBzaH1brBB/QVag1ergR2GmUMcJgyVKqqp3CJ0B
	 JAb6leueF+lGIM39tZrEuothoWpmx+0dEF9N2Lm4wC7mvkBz+8es2Mxdvg2NJb1ZJW1LW
	 p/lBayVIzLyLd556283aY9Zlu8x/0TohTTb/OsdrWe4VD8EYFEun70BaP46GhrKMV1Ifq
	 93YxdsIgSpgKPGKvBpLtTzI7cF9yMraqMTYvVHlYGDeXlKlPWuuJ8bUltV4Uu/gHCLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=K3MXkWKH;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6084D606A335
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 14:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6084D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=K3MXkWKH
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91f0274f88cso29274576d6.0
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 06:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795098877; x=1795703677; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D76bRl0iXWEy5tiDkPamZVFcHdRNx6r1Nq+m1WWa9kE=;
        b=K3MXkWKHlr21Q2aDnKybn3E/5hxrJuWc0RHue9G5BaoSXMyfiMxNP11P7Cfc3tjf1q
         HvyKVHGH43VIFjx0bSOaUG1k7NNQ6k3v4nb0MpNtZUCuIZkW82awpgb+qmmVWrxiu+F1
         MCi9XCKSOyUEGCW1KNYRXkbe6rL2BBAXw5TT2UKQMGU/pUeNTEmDCJCgYFXVktc3HOMw
         eP+n5J3KkB+sZmOVDTEkygq8mm7zNShmRM/xIvsdmWSsD+uOyzUtMJiPVSNzgCc5r0Nr
         90P6rlRNm8Vst6hXW98JaZdjPGRGwF3Tj3MYFmFBRMuXTZNjnzCmmJ0F3eN0KDiCg27i
         3rOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098877; x=1795703677;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D76bRl0iXWEy5tiDkPamZVFcHdRNx6r1Nq+m1WWa9kE=;
        b=aswZr+j7hXmB3g4lN08tBjDGiNQ287shTMFugHHvd5iaQob4+2qbd8mMkOuBLkWMqX
         e2nNA0ySnIKCMUT4EjS4+ZSeo2DBgoWKdFMblbNGIOtj921hWiD1LKO1ZVRWrLWG2NRW
         NfaGM33ekxMbsuYHMVSJMnIE6FhW2TAWpgMhIe/lBXIrwnBj4Cvo4wXhSvlwXSnIdqgN
         /Mqyg/62naJEbqIzTHgAtoAqjzyX5qlLnU6nPuY9RN/fzP7pJ4WzNpUP/r0qC+26ZX3p
         P+P7jlhUi8jVPMLp4xO9Z5CU1GQYp/T4BOII7Qct15zf2EbVljZFH70qxKsztuXn9OHw
         txOw==
X-Forwarded-Encrypted: i=1; AL+hErGRx8OGhs+EHpep8dzEHoL4wqzEtDMGDWVVpDyjqATbLDZLPjBz/Xhxpj1dKtWjK6zxC3t7Mw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+syOGUeen7OssT1sNfl6a5u3+ZnERgjuWHYJHHBwkkK1seWexK
	ZerI8Or7kwMstiuXCgE9XzJpXwJP7GK91fBFkWIh7y8cEXGQWHWa896J8jgevBU1AVY=
X-Gm-Gg: AZFdTZdOJy84dICEnoWVb/yAFIJqPYL2qqrzRoTpBAPefIzVNQBXpMjWbjOA3L0K5ph
	irJCGUzcl8iepXgjVblDT02rIKbE/mjsU/6YoBJ/OWL7OPuD8mlBb0lun27/wcwrfWFyDdfh6mU
	B9LfqXMXfLpae2YXu1iP6daQBvxjvygE2/J2j5mw6x54CRJxWobSCkjMpJ1JYcj+kaMtvqRVOqX
	QcMyiyyP1ycSbM5zR5raljBmJK6paVA00DMB+Q0b/tN9RQ05jf/g1YOyCpfLnuOxAqagSj4bQSC
	Olnt4gTATxl8oBqiuUIDulYCuVcKkVmsWTiv/js4EwhI4CANLeCdJovR0fyNJ3cQ8LDtd9e7noH
	5+NwI0Y7IDE07nefvsEti6hh8nTmDSBFFABbuuDIe6msWSE7NYTvEPyKegPyO+XZ2LBsvOf7fda
	uKg1W95YQTLhtxH0bWWl1TthtAOt6NibjHstDRFuyeLPfgV3h2mGZSr+UppsS8qUp5hC+Adu2vk
	0D43KZPODjJ33LwPcWWmToTB2J12c146lflVx1FWeimIiWJjUmHsJQQ40WqdKAucAUuKK/LigAA
	IWvcjA==
X-Received: by 2002:a05:6214:5e02:b0:921:16d1:7cb9 with SMTP id 6a1803df08f44-92116d17de5mr70719896d6.40.1795098877201;
        Thu, 19 Nov 2026 06:34:37 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92133fe4670sm339426d6.17.2026.11.19.06.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:34:36 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xU3Df-00000000tJC-0ytS;
	Thu, 19 Nov 2026 10:34:35 -0400
Date: Thu, 19 Nov 2026 10:34:35 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, iommu@lists.linux.dev,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH 0/6] rust: iommu: add a paging domain abstraction
Message-ID: <20261119143435.GI3115493@ziepe.ca>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
 <20261116193821.GC2452510@ziepe.ca>
 <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
 <20261117202055.GA3115493@ziepe.ca>
 <b145b2ceb92c73a4fa0477d7b3895a6e3b4adf99.camel@collabora.com>
 <20261118160909.GC3115493@ziepe.ca>
 <fe60c0bd-1ee2-4b33-8ca3-564ee08e6db5@arm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe60c0bd-1ee2-4b33-8ca3-564ee08e6db5@arm.com>

On Thu, Nov 19, 2026 at 12:24:50PM +0000, Robin Murphy wrote:

> There is a middle ground, where a kernel driver wants pages to appear at
> specific IOVAs under its own control. This is entirely legitimate to do by
> using the public IOMMU API "as intended" 

Yes, but, we never fully implemented this because we never gave a
cache flushing solution for these users. Which is a problem for safe
rust to expose an API without any way to do the mandatory flushing..

Jason
