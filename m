Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574EC1CF9C
	for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FKEt6Wtf"
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id E815F6600873;
	Mon, 20 Nov 2023 15:14:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700493262;
	bh=Q+8j2hw32DMqkrCZiSbZV5V/aS1dShF6GkSFVQuAi4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FKEt6WtfDwQDlbRCJDkbdOf6sjsdngiaFVG5U5ZGVhUaN3ncEb6OYJGoKtl3cMXCW
	 wHzqHZzqYRHDYSeiawOopeXLjRXHiriXQwBwil7+NkKeFo4anC94YL/VF7ezgiRqVN
	 m61fsHxVQ5HS9uEJeoKnTBDT1e9mewk1fRaTs2AVKrjVBwpwP083goM3+gbbuHSfDG
	 2lxBBDc7riaEb40yXqu4rZS7yC83RsGFf5rVipFKfdcxQJ/FrgvzfeEIIF+at/nVfg
	 NOBNFuSaLZ3P25HU0ByhUiaB97v5kRKmddPiPZFHbwrZWxfLyfr3O9b2UdoJ2xObx8
	 h4gTz0gW6E8Wg==
Date: Mon, 20 Nov 2023 16:14:18 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Rob Clark <robdclark@gmail.com>,
 Gaurav Kohli <quic_gkohli@quicinc.com>, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 0/2] iommu: Allow passing custom allocators to
 pgtable drivers
Message-ID: <20231120161418.5eca178e@collabora.com>
In-Reply-To: <20231120144604.GD10140@ziepe.ca>
References: <20231110094352.565347-1-boris.brezillon@collabora.com>
	<20231110151428.GJ4634@ziepe.ca>
	<20231110164809.270f82bc@collabora.com>
	<20231110161229.GA462657@nvidia.com>
	<20231110201652.629b7228@collabora.com>
	<20231110194215.GR4488@nvidia.com>
	<20231113101103.1cc05c8c@collabora.com>
	<ZVOgBBEetWf1PFxX@nvidia.com>
	<20231120140425.GA10140@ziepe.ca>
	<20231120153838.2166e7b8@collabora.com>
	<20231120144604.GD10140@ziepe.ca>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 10:46:04 -0400
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Mon, Nov 20, 2023 at 03:38:38PM +0100, Boris Brezillon wrote:
> 
> > > At LPC there was quite a lot if interest in improving the io page
> > > table stuff to work better. Based on that I'm even more against adding
> > > an external allocator at this time. :\  
> > 
> > I'm sure this has been discussed with the IOMMU maintainers, but I'd
> > really like to hear it from them if you don't mind. Especially since,
> > as I mentioned, the custom allocator idea comes from Robin, not me...  
> 
> It is a community effort - this is my opinion. We now understand this
> io page table area needs a lot of work to meet all the new needs. I'm
> against hacking it up like this and making that work harder.

Consider it a hack if you like, but the thing is pretty self-contained,
and I doubt it will get to a point where things become unmaintainable
before you get the generic caching system working. Not to mention
Gaurav's use case, which can't really be solved with your caching
solution.

> 
> > v1, was a sign this was good to go. If the final call is to reject the
> > custom allocator approach, and there's no updates on your generic
> > solution in the next couple weeks, I'll probably copy the pgtable code
> > in panthor so I can implement my own stuff, and later switch back to
> > the generic io-pgtable implementation when things have settled down.  
> 
> That's horrible, DRM should refuse that too,

Most GPU drivers have their own MMU/pgtable logic, partly because they
are the only users, and also because most of them delegate the page
table updates to the GPU (page tables leave in VRAM). I've actually
been recommended to go for this approach when I submitted the first
version of the driver, but after further discussions with Robin and
Rob we agreed this was probably not a good idea (because the code
exists already, and having a second implementation is never a good
thing, and also because what's needed for discrete GPUs with VRAM
doesn't necessarily apply to GPUs that share the memory with the rest
of the system).

> yet I expect you will
> probably end up merging like that.
> 
> I would not expect a resolution in a few weeks.

OOC, what's the time frame?

> 
> > Nothing against you or your solution (I actually commit to move to the
> > new approach when it's ready), but we have different priorities, and I
> > can't really delay the driver merging by several months unless there's
> > a very good reason to do it.  
> 
> Welcome to Linux, nothing runs fast :(

I've maintained a subsystem for a few years, so I know what it means
to contribute upstream and ask or being asked to extend the core to do
something the right way. I'm generally patient and try to follow
maintainers' recommendations, but there's some point where waiting is
no more an option, and you have to be more pragmatic, because there's
always a better way of doing things, and perfection is often the enemy
of good...
