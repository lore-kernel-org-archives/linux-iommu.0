Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5805B1E7C25
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581744; cv=none; b=gBjhouhai6uvVLwdojT/VCtCxLZzN8jIeOHilHlSAnElz8Us4Xb4m2gtLiNP9ETl88vvOu09+Zz5r1qvdAZh6q9ZJCR/B274OLrPdqJv3sK8c6CAMsHoCeLw5iRCZP8dcNYEYQpnf2YWfpfyRs6b9yOPUZMepE7NSIkhdk82wls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581744; c=relaxed/simple;
	bh=vhRSD/sXVHlXEO82NM8Vc+1oXUYVgQcVeL2JYmSpP9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juaJKPZrAhlCzlZHLvWBLYv274aPhPSyKxOyUfHkTfZMfXeOw2GsZVnX3vk9LEinY6DirIRAIpN6Ymr1nlCeYD2GWTuQQXax2Y5gWZcrct8zx47lR+5LgXzmevmD8ITiqPxrtwOpCIhVZFbYD3bEIByJN3/LfLy3fu3ceyROaa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JpNnv+a9; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JpNnv+a9"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e41e17645dso22631046d6.2
        for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 11:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742581742; x=1743186542; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OrQ0EzEMWWG6jQuSoJHeIyls2E9YhdY6/vRFZgsC7e0=;
        b=JpNnv+a9lHSSrnFLwcwvYt0Z1S6svh7fkCzzJtGWfTINywPJX/BDtpv//c7kfSegoK
         UguvZV+1APM5YaUNCWhI0zL+lhqx1hzQc8bz7U//sLiFISBcFUt2q3J6mHCzR4EEzjay
         CcwpUT9u7w3kACSY854Wm4hnUsSkVKt63zqII62nJhaKnzm1bYNx8szg4R8GN5OW1kSs
         kZv1/7egJ4gI91eFbiZ7wd/D6yLGwb+M1+7GuNVWRs12ynBa82lZBtCvJawVgTYLm5UQ
         Sqo8cPQDAEp/ejcosDn01t/p9RTTzt7U5DUmlQH5wcwl8My3v0CkDcvDyqnV/urHK+ja
         u4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742581742; x=1743186542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrQ0EzEMWWG6jQuSoJHeIyls2E9YhdY6/vRFZgsC7e0=;
        b=ok/lNYHUBcZg6xMZgoqkP+M4lJCXQsBGozxrsvYZL7eT8n+kShAIo6pGFN85LNPK45
         flD1jUubVgIi8ZvrOPjRtFU9ODPd83e6ajXi8oeE+Dh+7g7GyI30Nqu59Hf9VpRke+4w
         SMz4X59aNAObbJwcFJ/L7i2qkgBf2TG3nfa9o8hPbZfcnrrZOmsjc8vVpk97zHVJfprj
         9WcwA4es5zJFgnJsPdS8vSzJXiOA6vUKQXjIEzkKSML4/afjyb4PtPxMcqDCHr3Lnknm
         zWO9pU77Paf0VUSUQwq8x4uA42UHm9NhREt+jPyGMdvssDzsd6ybmFioXaxtb1oP6jcO
         df2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJyKhyWORskFNmsAtNZmOfJKopEpQLk+7ri5cFkT4y3Iz6Aavdz9NzONATA9c+ww5OLp/+XA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYUpTt6i7wYyb5jOKa3+glTopFWd4YVxUKxrSl0Z9lg1UvgEaI
	jQnfCCWZgRhfBMcgSNmf6J8FIJaUhwcNAvJCzTVOgJGqkjonyQ8LB8lLLrVqyDw=
X-Gm-Gg: ASbGncvtFWJxjlVRUBCkz+Cl07kuGMiotfHNgZkUaKtCKLB6N8w7ILL4/uRWiApvQ7r
	o79HLcmuvObZgkiDJ3ndY133sb9f584UqWKsNzu/LfjsCF0EyOIcS96W74KRO5hTRB3WbrqEqfz
	qNnOeU9kcoH1U8GMe9o3O6ZRufACsf3WvejQOQHwaghn2QV456QL9QdnfWjus32cHyrW3VLDhR1
	HWohaYWKw9GQVNOwtHPh2Fghlud03gFeFgljpHb+1vwwUB9KmFzukB03UnDQY083+ED64QA0pTd
	cT8AzqEcEeYnoueKQ/8q4thF5vzardkroA4uMWZ7H2q1xgFeCAFp6ImEa3KJ6Vmjj8CqxuPWobY
	EoN6/moctM/hvHTUPfIEE6i8=
X-Google-Smtp-Source: AGHT+IE8/kN4YgJruUR+/bfMJ7DomcrEj95sqf6MWrpr+dGE/We4hf0Dqm3GWvJMjve9Iw4bEfc0/g==
X-Received: by 2002:a05:6214:2469:b0:6e8:fbb7:6769 with SMTP id 6a1803df08f44-6eb3f2937c0mr69832456d6.14.1742581742075;
        Fri, 21 Mar 2025 11:29:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef0ed67sm13821566d6.12.2025.03.21.11.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:29:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tvh77-000000016ZW-0DDA;
	Fri, 21 Mar 2025 15:29:01 -0300
Date: Fri, 21 Mar 2025 15:29:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
	robin.murphy@arm.com, aliceryhl@google.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v13 2/7] rust: add dma coherent allocator abstraction.
Message-ID: <20250321182901.GQ126678@ziepe.ca>
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
 <20250307110821.1703422-3-abdiel.janulgue@gmail.com>
 <20250321172353.GO126678@ziepe.ca>
 <Z92jPXvMOqhgv04k@pollux>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z92jPXvMOqhgv04k@pollux>

On Fri, Mar 21, 2025 at 06:34:53PM +0100, Danilo Krummrich wrote:
> On Fri, Mar 21, 2025 at 02:23:53PM -0300, Jason Gunthorpe wrote:
> > On Fri, Mar 07, 2025 at 01:06:19PM +0200, Abdiel Janulgue wrote:
> > 
> > > +        // SAFETY: Device pointer is guaranteed as valid by the type invariant on `Device`.
> > > +        let ret = unsafe {
> > > +            bindings::dma_alloc_attrs(
> > > +                dev.as_raw(),
> > > +                size,
> > > +                &mut dma_handle,
> > > +                gfp_flags.as_raw(),
> > > +                dma_attrs.as_raw(),
> > > +            )
> > 
> > This is not the correct safety statement, the device must have a driver
> > bound to call this function, a struct device reference is not
> > sufficient.
> > 
> > I belive Danilo was suggesting to ignore this unsafety for now, but if
> > so it should be documented correctly.
> 
> If just landed patches [1], which are the foundation of addressing this issue.

Those patches say:

 The context types can be extended as required, e.g. to limit availability  of
 certain (bus) device functions to probe().

Which is not an appropriate limitation for dma_alloc_coherent, we
expect it to be called outside probe in real drivers. Is there more to
that story?

Regardless, the safety comment should not be merged with incorrect
information. :\

> > Also think the use of devres here is going to be very problematic for
> > drivers to use as I said in other emails. :(
> 
> In an earlier reply today in a different thread already gave you the link [2] of
> what we landed, which, besides explaining the situation, also makes clear that
> there is *no* Devres wrapper around a CoherentAllocation and why.

Yes, I see, I have so much email right now it is hard find all the
different versions of everything.

Jason
