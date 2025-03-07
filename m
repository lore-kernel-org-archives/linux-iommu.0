Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB63039ACC
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353377; cv=none; b=qyuh2FcalNFkqMGjFf+mneavFvcTFgR17mt8IrgY448J7xJzXKhDotFHjWnboXKxzZ/kap6jxOAcMpMOzSj0xpP7WmIInCAHBk38i0XLoGVR9zhlFT+Mbg8yqsouzytEOr6WjnSTVh8/6beP/QUU7yt6/2PlNSeU/TXko4hLSIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353377; c=relaxed/simple;
	bh=hZd3zDcuxytIUObsUdBqQhBZTsjVdEjxbPyYWVGizxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDXTN90sIZ9uTh8LF6rWP4lTbbZGkFKU9v2SYTji3lU2i4VBYyUUaTm9pcbYbOkWyapX+hW+w+5LUY1HjN0A9gW9PMWWbXwdlXSBfqcXC4nEtJCBrNdlXRtPCa7DJCYtn55RXGtkzYMkLMMG9EDf5x9G70GCPBGN54ex70E63B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=IYkpGL84; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IYkpGL84"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abf5f4e82caso359422766b.1
        for <iommu@lists.linux.dev>; Fri, 07 Mar 2025 05:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1741353374; x=1741958174; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8f2sytBVf6nQXJURXlsjCA27TJ+V7rR1VMxVWEgKQo=;
        b=IYkpGL84wAeSnefeCfHFws8Ic4ZEMl6qJIDrvkXR454DZK1An0WuAHlzzlksUX+3X8
         u2i+MZCEXSj/Dzzy+O9bffm6ImW8tcpMocYS2r0tc4nz/8HoYHBb7tKh5E2MrA/fw93i
         AewyRLv4YTdBh9zg321TSjDb1PPJOUndFQKRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741353374; x=1741958174;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8f2sytBVf6nQXJURXlsjCA27TJ+V7rR1VMxVWEgKQo=;
        b=gO3da0eGwVGafboO6iKaGixrRMcrOomLpfqlS1jl4ynhbW1MNH9N5hxkuDKIhoC90g
         RCUeaJJIJzUrqbA0nbev3cZi0Zyg4iQo4UYDBuzxNPhviQbLdTKF7IghalNFVSoP8Z54
         UHGkPmSGedGM+a8AsRC/pNGUCJ2MnYclfJNuFIRrBPU2f7lvJRPoQxzBmRGgBNZUQ/Mb
         Rld4pvfMhdkEnmPpBxNpfPikxCJw7TwKwqB/FZqpElakcs3MWeEilZUVWJbozETv/pu0
         MYLYcmF2Y7FLa0ajWCGrnD238+We6w5I/6iO9WYrf8gkrUyrDAgmK2rmk04nUZZK+dyY
         JRjA==
X-Forwarded-Encrypted: i=1; AJvYcCWs0npp7I9w/QvmtjYPisgBAI4X62K8Ad1r5GKLV1iuA+6EL2ZE5cheleUxjnB7VrH5b4ww+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXN/miVyT3NWofnDSOBMtpwD71GDwiEY2eC+n8majVTp2ahi6e
	YBddefq7U7qHxEoHJ3oyX2LSi0CBI71L/igNWXdl7YQBqzQPKegqLSvsUvANVqI=
X-Gm-Gg: ASbGncv2JPEtwfF7/C/pPe89QvmSfQzbXm7rcuL1ZbjnPnnYI3szQZ2CknN5qCfhU7F
	HGTyJrO9WVSkmJ4UownJlX3yZ61+caj0Wf3if81ZS+WNDIZsiN/Bfg+PUjkhN9coPMVSDts9v59
	p5+Inq7sAJMkpUAvuZxwm0o2N+sJHP1Y6eg2vf9evQUxxdrb4RiGklK3hjC1lb+Weau8CkLIrWg
	sud6Gj40IbxgKJ8Xq83AGVf6wt5HDTYhqqgPeNhCH0m1em51nz/MynLMZC1QV2JwruVNt79V4W7
	mnur0eGHYJmdL4jRK7Lks7BRhS8WL1qHmPxT3Cx80j3WN7OQdNlPdyQ+
X-Google-Smtp-Source: AGHT+IEBr6qwJM6+7eURCpwowuxB3sHU4SE5NlnG84DUfQ8ELCKEuO9h6jhEzjJAVdDNsT77fkD+OA==
X-Received: by 2002:a17:907:1b16:b0:ac2:1c64:b0a with SMTP id a640c23a62f3a-ac252a8827cmr340387366b.14.1741353373823;
        Fri, 07 Mar 2025 05:16:13 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988af19sm278685266b.136.2025.03.07.05.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:16:13 -0800 (PST)
Date: Fri, 7 Mar 2025 14:16:11 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, aliceryhl@google.com,
	robin.murphy@arm.com, daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
Message-ID: <Z8rxm-BHldKqEwyp@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, aliceryhl@google.com,
	robin.murphy@arm.com, daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <20250305174118.GA351188@nvidia.com>
 <Z8mlAxsszdOH-ow8@cassiopeiae>
 <Z8m9j3SwWHqaCTXo@phenom.ffwll.local>
 <20250306160907.GF354511@nvidia.com>
 <Z8qzP3CR8Quhp87Z@pollux>
 <20250307124809.GL354511@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307124809.GL354511@nvidia.com>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Fri, Mar 07, 2025 at 08:48:09AM -0400, Jason Gunthorpe wrote:
> On Fri, Mar 07, 2025 at 09:50:07AM +0100, Danilo Krummrich wrote:
> > > Technically it is unsafe and oopsable to call the allocation API as
> > > well on a device that has no driver. This issue is also ignored in
> > > these bindings and cannot be solved with revoke.
> > 
> > This is correct, and I am well aware of it. I brought this up once when working
> > on the initial device / driver, devres and I/O abstractions.
> 
> Yes it is also incorrect to call any devm function on an unprobed
> driver.

You can, devm groups nest, and I think by default (might misremember)
there's 3:

- probe/remove i.e. driver bound lifetime
- up to device_del in case you've called devm outside of a driver being
  bound.
- Final kref_put on the device.

For added fun, you can create your own nested groups within this and nuke
them as needed. component.c does some of that, which is why I regretfully
know about this stuff.

> > It's on my list to make the creation of the Devres container fallible in this
> > aspect, which would prevent this issue.
> 
> I expect that will require new locking.
> 
> > > The actual critical region extends into the HW itself, it is not
> > > simple to model this with a pure SW construct of bracketing some
> > > allocation. You need to bracket the *entire lifecycle* of the
> > > dma_addr_t that has been returned and passed into HW, until the
> > > dma_addr_t is removed from HW.
> > 
> > Devres callbacks run after remove(). It's the drivers job to stop operating the
> > device latest in remove(). Which means that the design is correct.
> 
> It could be the drivers job to unmap the dma as well if you take that
> logic.
> 
> You still didn't answer the question, what is the critical region of
> the DevRes for a dma_alloc_coherent() actually going to protect?
> 
> You also have to urgently fix the synchronize_rcu() repitition of you
> plan to do this.
> 
> > Now, you ask for a step further, i.e. make it that we can enforce that a driver
> > actually stopped the device in remove().
> 
> So where do you draw the line on bugs Rust should prevent and bugs
> Rust requires the programmer to fix?
> 
> Allow UAF from forgetting to shutdown DMA, but try to mitigate UAF
> from failing to call a dma unmap function. It is the *very same*
> driver bug: incorrect shutdown of DMA activity.
> 
> I said this for MMIO, and I say it more strongly here. The correct
> thing is to throw a warning if the driver has malfunctioned and leaked
> a DMA Mapping. This indicates a driver bug. Silently fixing the issue
> does nothing to help driver writers make correct drivers. It may even
> confuse authors as to what their responsiblities are since so much is
> handled "magically".

I think thus far the guideline is that software uaf should be impossible.
So calling dma_* functions on deleted devices should not be doable (or
result in runtime failures on the rust side).

I think for the actual hw uaf if you leak dma_addr_t that are unmapped in
hw device tables that would need to be outside of the scope of what rust
can prevent. Simply because rust doesn't know about how the hw works.

Wrt magically cleaning up, that is generally the preferred rust approach
with the Drop trait. But there are special traits where you _must_
manually clean up an object with a call that consumes its reference, and
the compiler will fail if you just leak a reference somewhere because it
knows it's not allowed to automatically drop that object. So both patterns
are possible, but rust has a very strong preference for the automagic
approach, unlike C. So there will be somewhat of a style different here in
what a native-feeling api looks like in C or rust.

> > Having that said, it doesn't need to be an "all or nothing", let's catch the
> > ones we can actually catch.
> 
> Well, that's refreshing. Maybe it would be nice to have an agreed
> binding design policy on what is wortwhile to catch with runtime
> overhead and what is not.

Yeah clarifying this stuff is probably a good idea.

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
