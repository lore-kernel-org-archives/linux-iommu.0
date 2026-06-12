Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6847130FC27;
	Fri, 12 Jun 2026 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289855; cv=none; b=MyILs3bxzHS3/7tYzr4qBXyV+Of56StnG3IiS2+fqbFQvV/4WDvAB9AJvnFCLdLXzJHZWJLsiKQeyK+VhwFFnAzCVZnyWxzgSr+0G9HKNHVNH6dUl+/TA7xsASJzqljtXk1gEu3MA8DWrDBLEFbmT10G9NzzadYX1xWi5A13qbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289855; c=relaxed/simple;
	bh=QG23j8pGHy1yeWe2sd5i15l313O4whPFG8zCiwSDvCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZqcLaOABEVOuPrV3QBQUAF1ylVaGwA4fdhvvMt6j7mZuQKjWOgQo4gWE70IQWQ6tEcTw+vhX/lGo57ub9R08suxuM3SOXtR/l7mYGUGYJ7Crwx63SavJv+4T+I41cIVybGqBpE0smiO5OOfPwoMgDrns6v0I0uh9yZH3rT65/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c4SRP2W6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c4SRP2W6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/Rs3piD1obkr4E1lwxUpi/km6OaloDV8jShDRtjgSBw=; b=c4SRP2W6VW67SW55gDANoo9Jew
	qd1FW5W+fiDj4/4TDcxUHkf6bP/aHogRAQCE4sVxD5CrCEJ002kD1KflZ2LXW6JTr+W1vb4T2LnPs
	/Jl+yKz9SoGVy6ZRi7XUxf4yA+fI3APS4Rce2xJNRQpKum/hMTnoBwlKKWDwk4/2oZ44MO6EmBx36
	8Q5jiWvyOOSZ7IjKu+jDl3cdjs7BEhnCZIDWKkIjt5fjpJml8+jVhaAYcVnAy/z5w5gRR51XgwE5/
	/TuWbGXNK70jJaGO2LSXHC+XyL/7bt+dyTUn0DFclkqygJ/K/ObxvLnUFkLX2Hfq80t/DtaxGcdp1
	+gs1x1AQ==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY6rT-0000000BPtq-2sx1;
	Fri, 12 Jun 2026 18:44:11 +0000
Date: Fri, 12 Jun 2026 14:44:06 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, 
	iommu@lists.linux.dev, kyle@mcmartin.ca, Rik van Riel <riel@meta.com>, 
	maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
Message-ID: <iv7sxqezzz42xieytbf3lskutricz7ltkr3wii3w4jbnbzto7f@2tz5hwa43l37>
References: <20260603033653.4144138-1-riel@surriel.com>
 <20260603033653.4144138-4-riel@surriel.com>
 <20260609130418.GI2764304@ziepe.ca>
 <61d51d4b5779d80145ceb38e9632a7cc8a79dbec.camel@surriel.com>
 <20260612164852.GL1066031@ziepe.ca>
 <ff5f9e09edbcb9c87feac6af00a1d835c783be4f.camel@surriel.com>
 <20260612180303.GO1066031@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612180303.GO1066031@ziepe.ca>

+Cc maple-tree list.

On 26/06/12 03:03PM, Jason Gunthorpe wrote:
> On Fri, Jun 12, 2026 at 01:23:58PM -0400, Rik van Riel wrote:
> > On Fri, 2026-06-12 at 13:48 -0300, Jason Gunthorpe wrote:
> > > On Fri, Jun 12, 2026 at 12:02:55PM -0400, Rik van Riel wrote:
> > > > 
> > > > The mas_erase() function calls mas_nomem(mas, GFP_KERNEL),
> > > > which is not safe to call while holding a spinlock.
> > > 
> > > Oh, the kdoc doesn't say that, it doesn't return any error code if it
> > > can't allocate memory, and not a single caller checks for erase
> > > failures.

I should fix that.

> > > 
> > > I assumed internally it "somehow worked out" even though there are
> > > allocations in the callchains..
> > > 
> > > This is probably a better question for Liam? Can mtree_erase actually
> > > fail ENOMEM? Is it safe to call it in an atomic context?
> > 
> > Yes, it can fail.
> 
> Currently it never returns a failure to the caller. Look at mas_erase():
> 
> 	entry = mas_state_walk(mas);
> 	if (!entry)
> 		return NULL;
> [..]
> 	if (mas_is_err(mas))
> 		goto out;
> [..]
> out:
> 	mas_destroy(mas);
> 	return entry;
> 
> There is no propogation of ENOMEM, it returns success. No caller
> checks for any error here either.

At one point this was considered to be impossible to fail, and it is
documented to return the entry or null.

> 
> So I think the intention is that it cannot fail, yet it does have the
> memory allocations and busted failure path. Hence asking Liam what it
> should be, and what about an atomic context.
> 
> Perhaps this might be relying on the modern kernels "small allocations
> never fail", meaning mas_erase never fails, but then you can't
> call it from an atomic context..

It _can_ fail, but right now that error will not be propagated to the
caller.  The caller could infer the failure due to the return of NULL...
if that's what would happen, so there's very much an issue on failure
that I need to investigate and fix.

It is possible that it fails with -ENOMEM.  And the spinlock can be
dropped if you are not using an external lock and the gfp flag allows
blocking.  On failure to allocate and the lock is dropped, we retry the
operation from the start in case there was a race with another writer.

I think I should probably change this to return -ENOMEM, fix the docs on
it, and probably audit the callers (most use external locks or are
early-boot-so-don't-worry-about-it).  Any issue here should also be
caught by lockdep pretty quickly.

> 
> In any case, it does look like you can't use mas_erase from an atomic
> context anyhow so your prior option with the mas_store_gfp() and
> failure handling seems reasonable.

mas_store_gfp() works if you know the range of your entry.  You could
also write the XA_ZERO_ENTRY over the entry so that there is no internal
node changes - just a value swap.  If you do this, you have to be
careful when reading things back when using the mas_ interface.

I think, in your case, hitting an XA_ZERO_ENTRY would be necessary to
indicate that we cannot reuse this particular location until it is
correctly dealt with?  Or is the maple tree the only reason it is
considered unusable?

One thing to remember is that each write can cause allocations to occur,
so if you have a list of items being overwritten then you are causing
the tree to do each write and potentially rebalancing (as you shrink the
data beyond the lower limit of the node).

One way around that is to write XA_ZERO_ENTRY over each one as you
deal with your entry.  Then, when you are done you do a single
mas_store_gfp() of NULL over the whole range.  It will be a larger tree
operation, but smaller than the incremental steps.

Thanks,
Liam

