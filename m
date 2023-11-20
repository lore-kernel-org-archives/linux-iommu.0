Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42091C6AF
	for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JaJd9Gl4"
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 1D0566605638;
	Mon, 20 Nov 2023 14:38:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700491122;
	bh=eMHNEN+Mufog8F3hIBLGTVt7miTA+TkkEXxArV+ovkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JaJd9Gl4v0TcApHa3lreIU2xf53sao6+oKLUD7h+cT2krHa7QqHGvUz7noNNthXTx
	 tYiIxT+jeNBma1/qV0L6hDmltVKs4nUgsN7r5XpAliy0xObkz7PVGP3ThyquYQLrED
	 x0dbSdQwB6q1cfreP6fptfjeU8lXVX+JU0RmgblO1dq6qcDXWFgaz+LYaIdlzPBBHG
	 5OnSILufdZ+TrxWXKT/3emEuxD+6LBl7IKxOe2aQjNoI0bBZit3jeJ8qzfROzeFbhi
	 1vcjvdYhaAIEmmqo5FWUI4MpBWY/Qp90H4dEdTJ0nam2w+AAjl9iwxRc4hl3ZXbxia
	 VrecUCT4PVtPA==
Date: Mon, 20 Nov 2023 15:38:38 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Rob Clark <robdclark@gmail.com>,
 Gaurav Kohli <quic_gkohli@quicinc.com>, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 0/2] iommu: Allow passing custom allocators to
 pgtable drivers
Message-ID: <20231120153838.2166e7b8@collabora.com>
In-Reply-To: <20231120140425.GA10140@ziepe.ca>
References: <20231110094352.565347-1-boris.brezillon@collabora.com>
	<20231110151428.GJ4634@ziepe.ca>
	<20231110164809.270f82bc@collabora.com>
	<20231110161229.GA462657@nvidia.com>
	<20231110201652.629b7228@collabora.com>
	<20231110194215.GR4488@nvidia.com>
	<20231113101103.1cc05c8c@collabora.com>
	<ZVOgBBEetWf1PFxX@nvidia.com>
	<20231120140425.GA10140@ziepe.ca>
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

Hi Jason,

On Mon, 20 Nov 2023 10:04:25 -0400
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Tue, Nov 14, 2023 at 12:27:48PM -0400, Jason Gunthorpe wrote:
> 
> > > Anyway, given you already thought it through, can I ask you to provide
> > > a preliminary implementation for this IOVA range mechanism so I can
> > > play with it and adjust panthor accordingly. And if you don't have the
> > > time, can you at least give me extra details about the implementation
> > > you had in mind, so I don't have to guess and come back with something
> > > that's not matching what you had in mind.  
> > 
> > Oh, I don't know if I can manage patches in any reasonable time frame,
> > though I think it is pretty straightforward really:
> > 
> >  - Patch to introduce some 'struct iopte_page' (see struct slab)
> >  - Adjust io pagetable implementations to consume it
> >  - Do RCU freeing of iopte_page
> >  - Add a reserve/unreserve io page table ops
> >  - Implement reserve/unresereve in arm by manipulating a new refcount
> >    in iopte_page. Rely on RCU to protect the derefs
> >  - Modify iommufd to call reserve/unreserve around areas attachment
> >    to have an intree user.
> > 
> > Some of this is a bit interesting, like reserving probably will
> > ideally want to invoke the batch allocator for efficiency which means
> > computing the number of radix levels required to fully populate the
> > current empty level - that should be general code somehow  
> 
> At LPC there was quite a lot if interest in improving the io page
> table stuff to work better. Based on that I'm even more against adding
> an external allocator at this time. :\

I'm sure this has been discussed with the IOMMU maintainers, but I'd
really like to hear it from them if you don't mind. Especially since,
as I mentioned, the custom allocator idea comes from Robin, not me...

> 
> I may try to write a sketch of something but I'm not sure when..

Yeah, that's the main problem here. Making panthor (the GPU driver for
newer mali GPUs) depend on some new stuff with no clear estimation of
when this work will actually be conducted is not something I want to
do. We've already had to wait a few months for some DRM deps to land
(and those were actively being worked on), and I was hoping the fact
this custom allocator idea originated from Robin (who's maintaining the
subsystem with others), plus the fact there was no real push back on
v1, was a sign this was good to go. If the final call is to reject the
custom allocator approach, and there's no updates on your generic
solution in the next couple weeks, I'll probably copy the pgtable code
in panthor so I can implement my own stuff, and later switch back to
the generic io-pgtable implementation when things have settled down.

Nothing against you or your solution (I actually commit to move to the
new approach when it's ready), but we have different priorities, and I
can't really delay the driver merging by several months unless there's
a very good reason to do it.

Best Regards,

Boris
