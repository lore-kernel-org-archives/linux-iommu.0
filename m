Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703542D594F;
	Thu, 18 Jun 2026 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794264; cv=none; b=N8H9mkPUVj9tMxhSG04oLezLooOBc1XbdqMA7g+nKJfFs5a+mvwEuqfFWlCcGhw+2o78EQC3Jvq6J3gd4B470rJBN63Lpu/k3weFeyPZi9HSgKQ9tLuUwSSXQH7+RAgm/eu8IL/kCZtx7FU0G+SwyYHKltj1U6/Sm0WS37P8Gqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794264; c=relaxed/simple;
	bh=fcR0fQM9b78iFvWRt11Pf0T0wie4EgkVcPK9r3a3d90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWNOYn9aMwt4XPaTYoPSpqUoTQBkVyN2fkxlYIAspQu47gN9lKD2v0rcXks3JiPWMe+fPd7lmwLuRXkKKI+IIuZEFL4Di28oYKjx7IUIX2/bj3Nvwk8hYzIP7hc/ZUtX11ZA1yP/vQ1qCDs2WnJ6WJK26qqhSeOxzrpvBRpbop0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UdHW1qa9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UdHW1qa9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ss2q8e7IjK7do5RD+B3ViKnMv47sNPazJFdiTFYwFpE=; b=UdHW1qa9Xa88JcqAlBRlunjT3I
	pC5u7jZkM/hSIbGtS/JueW2FVm/Si03DsGFQcQzxb4HQzmp+sy5JrMdH/FTeM5W/ReJjUWBgc5SMP
	+h6Qx707zdM9TlCGg4gS8rt1vE2Rn1WlzO4ldDWiYIaUtpxvRnjbgWsCnDvw1kG+b4Q8nR2xLKKMY
	dx1eKK0nqwjnORBdqxjT4UH16cCYa4tlxR9Ged3ZTJFRLvKOrhL3T+Zv9GhQGxcA4r3i+2edHfr45
	X98H34hSqFBOdNffwFPX8p05zzIhbwNAHB3hfLhhs6s6q5jlopBWvGkPXmyVUyhnLI6a0OxtmAHRa
	YUomcy7w==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waE56-00000001S0N-39gn;
	Thu, 18 Jun 2026 14:51:00 +0000
Date: Thu, 18 Jun 2026 10:50:56 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, 
	iommu@lists.linux.dev, kyle@mcmartin.ca, Rik van Riel <riel@meta.com>, 
	maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
Message-ID: <hsojwfbi5e6mpgtzd6rupod4xkviaehj4uo4xo7k2qmmswrc3v@odf2osyjxehw>
References: <20260603033653.4144138-4-riel@surriel.com>
 <20260609130418.GI2764304@ziepe.ca>
 <61d51d4b5779d80145ceb38e9632a7cc8a79dbec.camel@surriel.com>
 <20260612164852.GL1066031@ziepe.ca>
 <ff5f9e09edbcb9c87feac6af00a1d835c783be4f.camel@surriel.com>
 <20260612180303.GO1066031@ziepe.ca>
 <iv7sxqezzz42xieytbf3lskutricz7ltkr3wii3w4jbnbzto7f@2tz5hwa43l37>
 <20260615115633.GQ1066031@ziepe.ca>
 <vbtql77uf65vyxl4smefpol75x3opa7vnixdbzwg7ylxgre6j4@emvlfmdus4kj>
 <20260617180419.GA231643@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617180419.GA231643@ziepe.ca>

On 26/06/17 03:04PM, Jason Gunthorpe wrote:
> On Wed, Jun 17, 2026 at 01:45:27PM -0400, Liam R. Howlett wrote:
> > On 26/06/15 08:56AM, Jason Gunthorpe wrote:
> > > On Fri, Jun 12, 2026 at 02:44:06PM -0400, Liam R. Howlett wrote:
> > > > > Currently it never returns a failure to the caller. Look at mas_erase():
> > > > > 
> > > > > 	entry = mas_state_walk(mas);
> > > > > 	if (!entry)
> > > > > 		return NULL;
> > > > > [..]
> > > > > 	if (mas_is_err(mas))
> > > > > 		goto out;
> > > > > [..]
> > > > > out:
> > > > > 	mas_destroy(mas);
> > > > > 	return entry;
> > > > > 
> > > > > There is no propogation of ENOMEM, it returns success. No caller
> > > > > checks for any error here either.
> > > > 
> > > > At one point this was considered to be impossible to fail, and it is
> > > > documented to return the entry or null.
> > > 
> > > I think that is the right API design..
> > 
> > Callers can check mas_is_err() and check for xa_err(mas) == -ENOMEM.
> > I'm going to add a note about it to the documentation of the erase
> > function.
> 
> That's something for mas_erase, but doesn't help mtree_erase() ..

Indeed.

I'd rather avoid the leaking of the very much unlikely failure checks.

...

> > > 
> > > > I think, in your case, hitting an XA_ZERO_ENTRY would be necessary to
> > > > indicate that we cannot reuse this particular location until it is
> > > > correctly dealt with?  Or is the maple tree the only reason it is
> > > > considered unusable?
> > > 
> > > Yeah, it would be be a maple tree issue only. Defered rebalancing
> > > leave space unavailable.
> > > 
> > > This is a case where there is no sane way to handle destroy
> > > failure. You can't return an error code from dma_unmap() for
> > > example. So the only reason for this complexity is because maple tree
> > > exposes a failable erase to it's caller..
> > 
> > I think this is even more complicated by the contexts it is called in -
> > that is, we cannot preallocate prior to going into this state either?
> 
> Yes, in this case at least the context is GFP_ATOMIC and there is no
> way to pre-allocate.. But that seems like another issue since the
> mas_erase does not support GFP_ATOMIC anyhow..

Yes.  If you need atomic allocations then you should stick to the API
that allows you to pass in the GFP flags.  It may not be clear to users
that allocations might be required for erase, so I should document that.

> 
> > > Eg _iommufd_destroy_mmap() is in trouble too, it cargo culted the
> > > no-check mt_erase.
> > 
> > Are you sure that's not okay?  The mt_mmap tree is allocated with an
> > internal spinlock.  In this case, the lock will be dropped, the
> > allocation will be satisfied and the erase operation will retry.
> 
> Is this what I was asking before? Under some conditions the allocation
> can not fail because in the modern kernel we don't allow small
> GFP_KERNEL allocations to fail?
> 
> Otherwise this:
> 
> 	if (gfpflags_allow_blocking(gfp) && !mt_external_lock(mas->tree)) {
> 		mtree_unlock(mas->tree);
> 		mas_alloc_nodes(mas, gfp);
> 		mtree_lock(mas->tree);
> 	} else {
> 		mas_alloc_nodes(mas, gfp);
> 	}
> 
> Is always called with GFP_KERNEL for erase. It doesn't seem like
> external lock has any impact if mas_alloc_nodes can fail or not?
> 
> It looks like if you have an external lock then the hard wired
> GFP_KERNEL in mtree_erase/mas_erase mean the lock has to be a sleeping
> kind to use those functions.
> 

Ah, right.

Yes.  The idea here is Too Small To Fail.

Also, note that we call our first allocation with NOWAIT, so that may
have already started the process of getting memory (I think?).

Also note that this is in sheaves, so we'd have to have nothing left in
the maple tree kmem_cache, the sheave, and no page laying around (1 page
is 16 nodes..), and the NOWAIT to have no effect when arriving here.


> If that's the case it should be documented like this too :)

Yeah, very much should add some notes here... but also maybe stop them
from doing it by adding this to mas_erase():

if (mt_external_lock(mas->tree))
        might_alloc(GFP_KERNEL);

Otherwise, I'll just be telling people they didn't read the docs.

Thanks,
Liam

