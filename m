Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B411FF618
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737122175; cv=none; b=WX2ixE5ChZW1AKkv1BI1wHGxhGrGNsC4SOBYsGMmbJBtWo6xFPcX+wKjdYBR8fNAK1VLQsdO9XP06Ji7Uuh8lXUy4wwAi2dwTZ/FBjvP0k84edxiUjhTKZWbqpXf/f/wq3GCClSiTw8hMzKVB9trV8DsC6utzfqkov9qu4+a5bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737122175; c=relaxed/simple;
	bh=srqwl3Fw9jlCmaDuNLjfpcSCKXE+jZ0BjDKIpTAT+gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJHURC7+au1Lo+5D3fj7DbPi+YaHFkjUvs5Tu9Sux2eXr1AlKJL37M6c4DWYwSiE48UFVR7K3UqIWcReFYFu8376nZWUfWmrklqIsX0XXQGVrQDAyunmYjtOh99xqpcbyA0I/o1+s7tAHpDa15UwfHZj9GnL6ask0zy/FNwRYOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=jKiyQ6ec; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jKiyQ6ec"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso19941845e9.0
        for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 05:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1737122172; x=1737726972; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZpNwTlyJcHVo487ZfsZ8CWH5tK0goLtZKZSQ5PcLz8=;
        b=jKiyQ6ecFYg186Vf9mBhQhjdOu18p8lD/WPoVAEsslsVIIx+VLMEOyY/H+UH19w8ZD
         wnKKO4h2GySOgkSOL9u5Unz03KmIzuIvbwecRWx3+ftEc00XlfrEehtuNeHybeLtMqIk
         eUPaNNC5OZTmVnnQrnAi1ibHImj5313v/9/+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737122172; x=1737726972;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZpNwTlyJcHVo487ZfsZ8CWH5tK0goLtZKZSQ5PcLz8=;
        b=Vi5QekUxCvLpeQVQL1Wp5ncHksaJFdg6P9+5hfI7jsWp7iL/05rZqv9aSns+AF9Zca
         auXLHH4GjOrWm09WSOdbuPuaC1jcRzNZStCIHuWHWW6oxkdQnzxAVHkaBygFzl8XYEsC
         24OWNktQhnOGEM3C/gvi/w6dVXP1RVWsPtpXw4kj4+6eA9o+1Qo5BiLm7Vl45Q36/Yst
         +kfNPg1Tm49MBSevYQIrwVRNATuwAhk+N9JG8ejwjtqs8rJvkwSK8yV/anuL7GLcWthr
         63RK+RJyyY2O8FRlC0YFvP+79HDJlr0g2GKMS1/+Wf66JyMK8WQLXNnNeCdGm+LTnUXh
         Utsg==
X-Forwarded-Encrypted: i=1; AJvYcCUJINmMm/RygMVegDS8gvAKRlXSKm4aRNoInVG8kNGmLwyJtVcxVhgZ19qSSEaq1ws+h9VOwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyZvKhVqLcdeXfT6VXootAGj2zT4HNDRJFLU82H80Zv+AuA4fB
	v1GicHoscSILf7Vym0ItM3uUWDvloB31x/yrobDHru3d852CRn1v/mBnAxT5FUA=
X-Gm-Gg: ASbGncucctNl3fjv60KUzoJD4dUylQ1WP4hnPbt2EJwZ/MMtly9V3qKZlpFBAJshW7C
	SHoy4XCxRiAXft/Phpj7n8zsP3Qt2pofcIQf2pakqOap9+cleBbIRj07rafv7A6igKia60Bkj9E
	icDXD+cbP8EaH59QxWykRVpID0Guu9hdYj/gXK1PKxOxKdamDCz4IYoPF982luY9f29kMFEusOp
	CL9Kzbr+11Tl6zQ2sbzfuPo+h6wbr1gD15xRC0AurlQHNvZs+FSMABmZSGDWgBQdE6a
X-Google-Smtp-Source: AGHT+IFlu90mq1X2vEqFrqXrWBguIkHLIxlum8gc6SPp9rrHs3FGaagI2j2U3kz4BVFaBnlik1HGpg==
X-Received: by 2002:a7b:ce86:0:b0:436:185f:dfae with SMTP id 5b1f17b1804b1-437c6af2037mr92991175e9.6.1737122171873;
        Fri, 17 Jan 2025 05:56:11 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4389041f61bsm34191415e9.17.2025.01.17.05.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 05:56:11 -0800 (PST)
Date: Fri, 17 Jan 2025 14:56:09 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
Message-ID: <Z4pheSjBMOjgvk8W@phenom.ffwll.local>
Mail-Followup-To: Danilo Krummrich <dakr@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Greg KH <gregkh@linuxfoundation.org>
References: <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com>
 <20250108151858.GB24499@lst.de>
 <Z36X_ZnCmBQBMoZ6@pollux>
 <20250109080812.GA20431@lst.de>
 <Z3-NqwAG_96yq8VD@pollux>
 <20250110083955.GA5395@lst.de>
 <Z4D5a5NYrAbNxUL6@pollux>
 <Z4kG5AcVeQKegLnb@pollux>
 <bbc60912-7ed5-4bb1-b273-8061abe49e10@arm.com>
 <Z4kshDHw8NEjQONR@pollux>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4kshDHw8NEjQONR@pollux>
X-Operating-System: Linux phenom 6.12.3-amd64 

On Thu, Jan 16, 2025 at 04:57:56PM +0100, Danilo Krummrich wrote:
> On Thu, Jan 16, 2025 at 01:57:50PM +0000, Robin Murphy wrote:
> > On 2025-01-16 1:17 pm, Danilo Krummrich wrote:
> > > On Fri, Jan 10, 2025 at 11:41:54AM +0100, Danilo Krummrich wrote:
> > > > On Fri, Jan 10, 2025 at 09:39:55AM +0100, Christoph Hellwig wrote:
> > > > > On Thu, Jan 09, 2025 at 09:49:47AM +0100, Danilo Krummrich wrote:
> > > > > > On Thu, Jan 09, 2025 at 09:08:12AM +0100, Christoph Hellwig wrote:
> > > > > > > On Wed, Jan 08, 2025 at 04:21:33PM +0100, Danilo Krummrich wrote:
> > > > > > > > What does "your code" mean? Duplicated in every driver?
> > > > > > > 
> > > > > > > Yes, interfaces to the DMA API should stay in readable C code and not
> > > > > > > in weird bindings so that it reminds greppable and maintainable.
> > > > > > > 
> > > > > > 
> > > > > > Rust drivers shouldn't use C APIs directly, but rather use an abstraction of the
> > > > > > corresponding C API.
> > > > > 
> > > > > Don't force me to deal with your shiny language of the day.
> > > > 
> > > > Again, no one asks you to deal with or maintain this piece of Rust code.
> > > > 
> > > > > Maintaining
> > > > > multi-language projects is a pain I have no interest in dealing with.
> > > > > If you want to use something that's not C, be that assembly or rust you
> > > > > write to C interfaces and deal with the impedence mismatch yourself as
> > > > > far as I'm concerned.
> > > > > 
> > > > 
> > > > This is exactly what we're doing and proposing here, isn't it?
> > > > 
> > > > We wrote a single piece of Rust code that abstracts the C API for all Rust
> > > > drivers, which we offer to maintain ourselves.
> > > > 
> > > > What else are you asking for?
> > > 
> > > Since there hasn't been a reply so far, I assume that we're good with
> > > maintaining the DMA Rust abstractions separately.
> > 
> > Indeed, FWIW it seems like the appropriate level of abstraction to me,
> > judging by the other wrappers living in rust/kernel/ already. As far as the
> > interaction with C code goes, it appears to be a pretty straightforward
> > midlayer consumer of the DMA API much like others we already have (e.g.
> > videobuf2-dma-*), just one which happens to be a language binding rather
> > than some other kind of functional abstraction.
> > 
> > There is a realistic chance that the C API will evolve in ways which break
> > the binding, but as long as a) that won't break non-Rust builds, and b) Rust
> > folks are happy to take responsibility for un-breaking the Rust build if and
> > when it happens, then that seems reasonable IMO.
> 
> Surely you can expect maintainers of the Rust abstraction to help with
> integrating API changes -- this isn't different compared to driver / component
> maintainers helping with integrating fundamental API changes for their affected
> driver / component, like you've mentioned videobuf2-dma stuff.
> 
> At last year's LPC I held a talk [1] about Rust in the kernel and there was a
> question at the end where I was asked how I think about cases where Rust
> abstraction break caused C API changes.
> 
> My answer was that I'm not too concerned about this. We can just rely on what
> already happens every day in kernel development: people work together and
> collaborate. There are a lot of very core components that are widely used and
> depending on the complexity of the change may require the help of the users to
> integrate changes. So, I don't think with Rust abstractions we're adding
> anything that the kernel does not already has a strategy to deal with.

I think when we know that an api change is in the works we should try to
anticipate that, and not add another complex user of a feature that's
likely going to disappear. For dma-api I guess the big thing is the
dma/page split that's been talked about since forever, instead of mixing
it all up into the scatterlist structure.

But with rust abstractions it should be pretty easy to make sure the rust
side interface is really clean here, and so any refactoring limited to
just the middlelayer. Plus this patch here is not even close to tackling
the sg based dma-api parts.

Same applies for rust wrapping dma-buf interfaces, that's just more of the
same.
-Sima

> 
> - Danilo
> 
> [1] https://youtu.be/3Igmx28B3BQ?si=wD0CP-zku4U6fAsN
> 
> > 
> > Thanks,
> > Robin.
> > 
> > > 
> > > Hence, the next version of this patch series will have the corresponding
> > > maintainer entry.
> > > 
> > > - Danilo
> > 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
