Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803633DE451;
	Tue, 30 Jun 2026 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844784; cv=none; b=Wxg63y0pRAu5BP/o2/AMFnXjA4s3Z8U6ygzBSr0HlcZ+f7gf5WUP0mZ6UHzbFKkbpHis747w2a29mclgFAl43TtQIfu/OsiO9d5zbdfzWYA/jQ0GIudi9xJvHFfNKpHp6SbOBmH2oeP7ixbME+nsa3R11CW/i6VGAoNZdL+3vKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844784; c=relaxed/simple;
	bh=1AqnINwVyr54yl9bnnNtfcun+6VQRA0RIvv7fbFIkpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmHI1zYY07BOmr/SAZ62iuC546HMA4myhkXOFiPlc80DdLILXog46vFcTw5KuWOq5MqSrbIID4yTcJw8MVcE+O+nNWsL22vwKpT7IOVPpfmc3kcJ49or7BrgeRkkUorHjpUxcDyMB57S6LVd5mPsdWaCU4bMXQxCG4Z4s4/SjNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f7nc668V; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f7nc668V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SHjwFOAhvsASRijm+SVYf2tJ5249QQ8kmD9oJXhAHss=; b=f7nc668V6l0z8UMtSIDsI8vYCa
	ph3rQXYcWYOUkkN5jOjNa6Rg4IKUSvx4DjUUwCfyFiRvE5RD4ge3ig4ltLYVh42gP9l90yPnjCmK0
	jj3qYbtMProDxr3hdH3EuD7RywuU+uwnFlUUHP3Vv/eA9v80iSj9nHUYY75V41FstdH8Rc1tSuSIA
	IAqKImhYierXNKUUeMg4WoRwPDxg9d2NK4ox0ciwWcjJ2j4qsGzW309+F9/UCN8z+SF/naYLQ8lw+
	gHm7Cu1ToPBGq/gs0tVdrQT3tFclO1skLpijutp5XI+JeDCFhyw7eGbd68qsf8WuC6C39GKqp+dBj
	mxaxC4kw==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wedMx-000000003Gn-05Z8;
	Tue, 30 Jun 2026 18:39:39 +0000
Date: Tue, 30 Jun 2026 14:39:35 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, 
	iommu@lists.linux.dev, kyle@mcmartin.ca, Rik van Riel <riel@meta.com>, 
	maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
Message-ID: <kfqgoauq4jia4jlgndxz54jblzarvltqr6eh2odaygqqkfvgzd@exr4hirlatnu>
References: <ff5f9e09edbcb9c87feac6af00a1d835c783be4f.camel@surriel.com>
 <20260612180303.GO1066031@ziepe.ca>
 <iv7sxqezzz42xieytbf3lskutricz7ltkr3wii3w4jbnbzto7f@2tz5hwa43l37>
 <20260615115633.GQ1066031@ziepe.ca>
 <vbtql77uf65vyxl4smefpol75x3opa7vnixdbzwg7ylxgre6j4@emvlfmdus4kj>
 <20260617180419.GA231643@ziepe.ca>
 <hsojwfbi5e6mpgtzd6rupod4xkviaehj4uo4xo7k2qmmswrc3v@odf2osyjxehw>
 <20260618152451.GE231643@ziepe.ca>
 <r4jlbi3hbtvv6vrenarz6i7n6cu3vfqqdz2jfenkwsuv3fkadi@nq5u5txbtso6>
 <20260619120854.GJ231643@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619120854.GJ231643@ziepe.ca>

On 26/06/19 09:08AM, Jason Gunthorpe wrote:
> On Thu, Jun 18, 2026 at 01:27:02PM -0400, Liam R. Howlett wrote:
> > On 26/06/18 12:24PM, Jason Gunthorpe wrote:
> > > On Thu, Jun 18, 2026 at 10:50:56AM -0400, Liam R. Howlett wrote:
> > > 
> > > > > If that's the case it should be documented like this too :)
> > > > 
> > > > Yeah, very much should add some notes here... but also maybe stop them
> > > > from doing it by adding this to mas_erase():
> > > > 
> > > > if (mt_external_lock(mas->tree))
> > > >         might_alloc(GFP_KERNEL);
> > > 
> > > Yeah, and then I'd add a might_alloc() to mtree_erase() as well, it
> > > can always sleep..
> > 
> > mtree_erase() calls mas_erase(), so I think the one should be enough.
> 
> I was thinking an unconditional one before locking:
> 
> @@ -5919,6 +5919,8 @@ void *mtree_erase(struct maple_tree *mt, unsigned long index)
>         MA_STATE(mas, mt, index, index);
>         trace_ma_op(TP_FCT, &mas);
>  
> +       might_alloc(GFP_KERNEL);
> +

Right, yes.  I'll do that.

>         mtree_lock(mt);
> 
> Since with internal locking this can still sleep, and it has to be
> called in a sleepable context.
> 
> The one in mas_erase() is conditional on external locking and is
> basically asserting the external lock is non-atomic.
> 
> > > Okay, so to summarize:
> > > 
> > > - mas_erase, mtree_erase cannot fail with ENOMEM. The check for ENOMEM
> > >   inside should be changed to a WARN_ON to document this.
> > >   Rational: in a GFP_KERNEL context it will sleep forever until it
> > >   gets memory "too small to fail"
> > 
> > The ENOMEM check inside mas_nomem() is still possible because we try
> > NOWAIT first, so it is possible that we hit a retry.
> > 
> > The return from mas_nomem() without allocations should be impossible.
> > So if (!mas->sheaf && !mas->alloc) should be a WARN_ON_ONCE().
> > 
> > I believe this is what you meant anyways?
> 
> Yeah, probably, or maybe this:
> 
> 	if (mas_is_err(mas))
> 		goto out;
> 
> Can it ever be anything but -ENOMEM within mas_erase()?
>  
> > So cleaning them up should be handled sooner rather than later.  I'm
> > trying to figure out the best place to do this as I do not like the
> > retry with the timer idea.
> 
> I would clean them up when gap searching to allocate a new thing. That
> is a safe place to fail and ensures the gaps are correct before
> checking them.
> 
> Jason
> 
> -- 
> maple-tree mailing list
> maple-tree@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/maple-tree
