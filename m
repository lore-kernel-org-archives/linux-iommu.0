Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482523BD05;
	Thu, 18 Jun 2026 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781803635; cv=none; b=Iji/iE20bg0jEpTbfhEs3Vv3uZWt+kJUzTYDDPHW0FBAJY59EHXFQsNWhoqrIw3SWp/FcdPk6P47SISLacyp5gqXKuAENjrVHZOFoBOvMwjDht4Z+BCVO8NW2q8bjAS+Qa8Az6mvZJKLmcZrMRQBn1fzEO3iJ9AKwTiKT5S3uWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781803635; c=relaxed/simple;
	bh=1Ph9VLFh06GOUAb1sQ+lnoC51nH0fW/uL1EVfN569rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lq/OJVCaHLMD6CKdbC5DYWYN+pNxTKCODJ/+2/lcaowVdPnJOPXM14daHzS/xzqrr+aYYakk9VXycEtuwU8Y5/XCMoF3ISU5cYIsX27aKSRlePYmrJFfN2bp08hebxRmx7HAQ4wCVLkpFyOLUih1D/nJMgWr/n1wghDxBBXNcgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VTFfDe8Z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VTFfDe8Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KGrsI+dalE9OyOLIFDk4ChpIP1PuLViz+3eauB50DgU=; b=VTFfDe8ZYJE6WeiHk7MkI/wbqC
	b4utRVM3Yy55xe7SYyLuRI/EEbYnFu3rR2U772DqUwKgDbvDXuXlGpQ6MTwkGMDCUodZBNjqMVJ43
	sAZ8DW2Xa9xj0Vtq3qbahB4wkUdorWiPesH1gykbAhOcmG2HFPJFR6V13dwQCMYX4YdUstQ5oKauZ
	h71lNudZybUlW7f/kaM02SOpwMF6zVrZxsf/jXG71jH2HvReHWWhCZ7bKIHswvFsUr4VAILkyySXZ
	MRNs+AJzcHHDp0Ggj1HH1vQSE9sxpmKYx3vBmy/pLW+ZDMGRH3hK8VqPaiyN+dDxjpn5jJNzry8B4
	G9xp5ggA==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waGWD-00000001eCr-3pQB;
	Thu, 18 Jun 2026 17:27:10 +0000
Date: Thu, 18 Jun 2026 13:27:02 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, 
	iommu@lists.linux.dev, kyle@mcmartin.ca, Rik van Riel <riel@meta.com>, 
	maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
Message-ID: <r4jlbi3hbtvv6vrenarz6i7n6cu3vfqqdz2jfenkwsuv3fkadi@nq5u5txbtso6>
References: <61d51d4b5779d80145ceb38e9632a7cc8a79dbec.camel@surriel.com>
 <20260612164852.GL1066031@ziepe.ca>
 <ff5f9e09edbcb9c87feac6af00a1d835c783be4f.camel@surriel.com>
 <20260612180303.GO1066031@ziepe.ca>
 <iv7sxqezzz42xieytbf3lskutricz7ltkr3wii3w4jbnbzto7f@2tz5hwa43l37>
 <20260615115633.GQ1066031@ziepe.ca>
 <vbtql77uf65vyxl4smefpol75x3opa7vnixdbzwg7ylxgre6j4@emvlfmdus4kj>
 <20260617180419.GA231643@ziepe.ca>
 <hsojwfbi5e6mpgtzd6rupod4xkviaehj4uo4xo7k2qmmswrc3v@odf2osyjxehw>
 <20260618152451.GE231643@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618152451.GE231643@ziepe.ca>

On 26/06/18 12:24PM, Jason Gunthorpe wrote:
> On Thu, Jun 18, 2026 at 10:50:56AM -0400, Liam R. Howlett wrote:
> 
> > > If that's the case it should be documented like this too :)
> > 
> > Yeah, very much should add some notes here... but also maybe stop them
> > from doing it by adding this to mas_erase():
> > 
> > if (mt_external_lock(mas->tree))
> >         might_alloc(GFP_KERNEL);
> 
> Yeah, and then I'd add a might_alloc() to mtree_erase() as well, it
> can always sleep..

mtree_erase() calls mas_erase(), so I think the one should be enough.

> 
> > Otherwise, I'll just be telling people they didn't read the docs.
> 
> Okay, so to summarize:
> 
> - mas_erase, mtree_erase cannot fail with ENOMEM. The check for ENOMEM
>   inside should be changed to a WARN_ON to document this.
>   Rational: in a GFP_KERNEL context it will sleep forever until it
>   gets memory "too small to fail"

The ENOMEM check inside mas_nomem() is still possible because we try
NOWAIT first, so it is possible that we hit a retry.

The return from mas_nomem() without allocations should be impossible.
So if (!mas->sheaf && !mas->alloc) should be a WARN_ON_ONCE().

I believe this is what you meant anyways?

> 
> - External locks must be sleepable, add a might_alloc() to check for
>   that and document. mtree_erase must be sleepable
> 
> - I like your idea for Rik to try to store NULL to erase, on failure
>   store ZERO_ENTRY, and then set a note on the next alloc to clean the
>   ZERO_ENTRYs?

The ZERO_ENTRY can be found by mas_* functions and will cause issues
with the gap searching.  You also have to be careful to handle these
entries in mas_for_each() loops - you don't want to treat them as valid
entries.

So cleaning them up should be handled sooner rather than later.  I'm
trying to figure out the best place to do this as I do not like the
retry with the timer idea.

Setting a bit to clear them later makes sense, but I am concerned that
leaving reserved space for a prolonged period may cause other failures?
I guess we could ensure that the tree is 'clean of reserved space' prior
to searching for space to but new entries?

We probably don't really need to worry about speed since this is an
error recovery situation that will happen rarely, so correct is all we
need.

Thanks,
Liam
