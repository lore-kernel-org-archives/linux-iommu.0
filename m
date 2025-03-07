Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365E3214212
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342700; cv=none; b=VrjntbMzfkktibfaoYnlkDR008RVVhEwtcku8ZlwEbkLTkiPD/Q3X/tShUUAjU5mHxj8Y017qjJF6f+Zdcus1DNX1Y5S3LildmfXs9+NcMUovb8VHTuQf/oQqVAGNmYKFzuSXwCrrUaJNW/UjuROZimA57VOVcwvk6wVkmjSGc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342700; c=relaxed/simple;
	bh=A2ngPlxsViHeU++f/T0fHfvoDhTTkba+2oBbb7Nj+nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQlYHb6bzQARgUrGOR3/MS5fg8WaduS5jJpdI249dIsZWSbNXEuIDxb9DlVfMJ78ccXjtkybiUoZSs8ppbWGzVOVfrQDoyl8U6vK1cyYpjGc32hv0WzhwEJMDeYnoqT/Ow/U1MiAg5y1UA8+ew9og5wnMlHKRrOY8j8Zm9WZv4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=CI3x9ls1; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CI3x9ls1"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-391342fc0b5so655574f8f.3
        for <iommu@lists.linux.dev>; Fri, 07 Mar 2025 02:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1741342695; x=1741947495; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eriVuZyAjeW4XZxzbs/VYx0wmamknYVQrCt+Q1+FUXw=;
        b=CI3x9ls1vNo0wMddyXT6KrPdC8dNe4Cd439pIdaMkfayVqsVaUTzxAFQgxZgvz6hTD
         xKrk9D0/ZQtKNYbAdNjLzVnGpvHwIa2zZBG13bsd4GA/uRRsZr2AjK5LVbzGE/gQ3/PA
         uPzxzwlDbkML557qbxFJNRktIDqJ208552PLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741342695; x=1741947495;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eriVuZyAjeW4XZxzbs/VYx0wmamknYVQrCt+Q1+FUXw=;
        b=YVwSRrtC0M5Q23656YzznwpZbS3ai854Sqe2srZPSOOUmTM4/XToLd6KHGOMoOAq+M
         QfGGv40JI5o1FG7lj14r+q3wpCSp5Ni7pb8PIM7N+r236MPhn0WI1UWwU2hGX6KcD/PE
         8oXIrBAD6r6czgEyS6DGzZhQGUMnfkiev+kbecIb407PM6MWEOWLEx6ZSmgpmkSkzFIy
         MOxVp57RVgtk94aKpejjR2uL30cyw+Y7VNrCsONPFvgM4avaQ2StvO6UBADbaWLW3IT3
         h9ZXXKI5zwMCCVoKtvkbo3cSA7pp43j8FKz23JBh7YtgAX22pZ4a9vOZIUWPdKu5tYms
         2ZrA==
X-Forwarded-Encrypted: i=1; AJvYcCUNOjebVPWHCSrVGfcvpgniCCUOO2aigfsPM0LLC73FtHgJaqVRvTV6kiddPU6aSYo6ORG50Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzU2i42UOjqJ1clhNiNiGQf1jQitsdWa5uoAo4rlfeWddajKQ5Y
	7MBELNXhguIcL3PvQEFMXuzuXvwWx1NnJ7ffl5FVu+Dyk7lLcliz/FFt/EGerYg=
X-Gm-Gg: ASbGncvq2xmqckIonUsoK2fgf3WPmKV6kNYgJEqjTAOCQ7Rzx96YsF3VFSOfBmmIwgA
	jT7gHOExL1c/FM2+NfdigRLVdP+t69x0otuYT0Fpxjgn9noMLZRT5VVEh2SiytsABYM3zzOu0PK
	MRbmEhxMRw+r+Zm01X3FsTxEeC5Z24jD8RNTNSfh69VxW9aBNPG25zlGckAEzSIigbsyiahG4VB
	t50Yutb262lWBAOyuylk0kQ/WfHUSE9y+Eec8SwuLjNklSdOEvT60M3+Q0aeSCkuAHKZNiHb0Yd
	vn7NEZDYH56dmSexgn1PgAkCxBAB/YMRVH2OTTLC4mFGS3ZUnEmF88qD
X-Google-Smtp-Source: AGHT+IEAZISqACsxvEE8pMsJbbIN/kzp1kRyxcTMswdSMukChQqkklpQTvMwVWdtKsOw5sLVVDQLwg==
X-Received: by 2002:a5d:584f:0:b0:391:2e7:67ff with SMTP id ffacd0b85a97d-39132d090fbmr2149096f8f.10.1741342695383;
        Fri, 07 Mar 2025 02:18:15 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfcdasm4798966f8f.23.2025.03.07.02.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 02:18:14 -0800 (PST)
Date: Fri, 7 Mar 2025 11:18:12 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <Z8rH5D5S7QzyJo1D@phenom.ffwll.local>
Mail-Followup-To: Danilo Krummrich <dakr@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
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
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8qzP3CR8Quhp87Z@pollux>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Fri, Mar 07, 2025 at 09:50:07AM +0100, Danilo Krummrich wrote:
> On Thu, Mar 06, 2025 at 12:09:07PM -0400, Jason Gunthorpe wrote:
> > On Thu, Mar 06, 2025 at 04:21:51PM +0100, Simona Vetter wrote:
> > > > >  > a device with no driver bound should not be passed to the DMA API,
> > > > >  > much less a dead device that's already been removed from its parent
> > > > >  > bus.
> > > > 
> > > > Thanks for bringing this up!
> > > > 
> > > > I assume that's because of potential iommu mappings, the memory itself should
> > > > not be critical.
> > 
> > There is a lot of state tied to the struct device lifecycle that the
> > DMA API and iommu implicitly manages. It is not just iommu mappings.
> > 
> > It is incorrect to view the struct device as a simple refcount object
> > where holding the refcount means it is alive and safe to use. There
> > are three broad substates (No Driver, Driver Attached, Zombie) that
> > the struct device can be in that are relevant.
> > 
> > Technically it is unsafe and oopsable to call the allocation API as
> > well on a device that has no driver. This issue is also ignored in
> > these bindings and cannot be solved with revoke.
> 
> This is correct, and I am well aware of it. I brought this up once when working
> on the initial device / driver, devres and I/O abstractions.
> 
> It's on my list to make the creation of the Devres container fallible in this
> aspect, which would prevent this issue.
> 
> For now it's probably not too critical; we never hand out device references
> before probe(). The only source of error is when a driver tries to create new
> device resources after the device has been unbound.
> 
> > IOW I do not belive you can create bindings here that are truely safe
> > without also teaching rust to understand the concept of a scope
> > guaranteed to be within a probed driver's lifetime.
> > 
> > > > > Also note that any HW configured to do DMA must be halted before the
> > > > > free is allowed otherwise it is a UAF bug. It is worth mentioning that
> > > > > in the documentation.
> > > > 
> > > > Agreed, makes sense to document. For embedding the CoherentAllocation into
> > > > Devres this shouldn't be an issue, since a driver must stop operating the device
> > > > in remove() by definition.
> > >
> > > I think for basic driver allocations that you just need to run the device
> > > stuffing it all into devres is ok. 
> > 
> > What exactly will this revokable critical region protect?
> > 
> > The actual critical region extends into the HW itself, it is not
> > simple to model this with a pure SW construct of bracketing some
> > allocation. You need to bracket the *entire lifecycle* of the
> > dma_addr_t that has been returned and passed into HW, until the
> > dma_addr_t is removed from HW.
> 
> Devres callbacks run after remove(). It's the drivers job to stop operating the
> device latest in remove(). Which means that the design is correct.
> 
> Now, you ask for a step further, i.e. make it that we can enforce that a driver
> actually stopped the device in remove().
> 
> But that's just impossible, because obviously no one else than the driver knows
> the semantics of the devicei; it's the whole purpose of the driver. So, this is
> one of the exceptions where just have to trust the driver doing the correct
> thing.

In general it's impossible, but I think for specific cases like pci we can
enforce that bus mastering/interrupt generation/whatever else might cause
havoc is force-disabled after ->remove finishes. For platform devices this
is more annoying, but then it's much harder to physically yank a platform
devices. So I'm less worried about that being a practical concern there.

> Having that said, it doesn't need to be an "all or nothing", let's catch the
> ones we can actually catch.

Yeah, agreed.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
