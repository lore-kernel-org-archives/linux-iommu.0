Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2351712CDBE;
	Wed, 17 Jun 2026 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781718342; cv=none; b=EFCtCA6r75yqsZ0ZMiTTrmwuu7iV/kS/dRZT9EoUTVznotgEjq5cHoqZ61ot42xM71H3EZIMOnavHRXP0gL1LCXQeopK3d3sA0ZGg0vH4j3AD/vGpVHsk1uZHXHhAN2Z8RMYuDww7AUcLilYT5y8EiXYBKIzyVQWQq5ymSWvVj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781718342; c=relaxed/simple;
	bh=GaqLs8AhcqT15C0nXU4xIJ7TgZI0PVs8GPF5zA3sFSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eI8rs3dKSnGUw2liRNsBYcFCPbaEonwubD9c6/ECQjJyAys+kY1qs+zhZtue4XnX2QruwznsIsrHxt1RZftLf0I4Mq/Y8och/LVOvddHbJsIAeFzyDmZvbxawNXACLJd8CPQsG8WEMGi21Q+CsYzc4dkBBeQtuzXJC/3X0cYpTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zIJYYVZL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zIJYYVZL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qSBAr+QtUf/2oc19koOX30hO6YtA2doYTNx7ezc75y8=; b=zIJYYVZLaxxpFbc9tIDnu3DxxH
	KWxsymGYanHLF2flRaNlDinWNStKEal33QhF+kupkXX3H73hldUYRLU/f9W2I3jkhZR6D/Mino8mk
	P2tBmWFkiYmcGo7r+Mjf+/6Xf1hKQO/Icy/8463l74X9ekV4vSq3ASD17NWFAN7rTP7tIe0Ccyyej
	QsIr3xN5zMTFj2cESRzrxZe5jX7Ukbr6FVj4VpvehF46A9NNVu2CHIp/DCzkbf82njCr5TioKYmOn
	6hyzt0+ZEu+WxXTYlW8XN60rSqgobOs0kkGEX8a8UsMImqcA9hJGvX0nmKHbBlSYLaQ+Dl63dfGID
	i8ea+z/Q==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZuKS-0000000084p-2Uzn;
	Wed, 17 Jun 2026 17:45:32 +0000
Date: Wed, 17 Jun 2026 13:45:27 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, 
	iommu@lists.linux.dev, kyle@mcmartin.ca, Rik van Riel <riel@meta.com>, 
	maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
Message-ID: <vbtql77uf65vyxl4smefpol75x3opa7vnixdbzwg7ylxgre6j4@emvlfmdus4kj>
References: <20260603033653.4144138-1-riel@surriel.com>
 <20260603033653.4144138-4-riel@surriel.com>
 <20260609130418.GI2764304@ziepe.ca>
 <61d51d4b5779d80145ceb38e9632a7cc8a79dbec.camel@surriel.com>
 <20260612164852.GL1066031@ziepe.ca>
 <ff5f9e09edbcb9c87feac6af00a1d835c783be4f.camel@surriel.com>
 <20260612180303.GO1066031@ziepe.ca>
 <iv7sxqezzz42xieytbf3lskutricz7ltkr3wii3w4jbnbzto7f@2tz5hwa43l37>
 <20260615115633.GQ1066031@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615115633.GQ1066031@ziepe.ca>

On 26/06/15 08:56AM, Jason Gunthorpe wrote:
> On Fri, Jun 12, 2026 at 02:44:06PM -0400, Liam R. Howlett wrote:
> > > Currently it never returns a failure to the caller. Look at mas_erase():
> > > 
> > > 	entry = mas_state_walk(mas);
> > > 	if (!entry)
> > > 		return NULL;
> > > [..]
> > > 	if (mas_is_err(mas))
> > > 		goto out;
> > > [..]
> > > out:
> > > 	mas_destroy(mas);
> > > 	return entry;
> > > 
> > > There is no propogation of ENOMEM, it returns success. No caller
> > > checks for any error here either.
> > 
> > At one point this was considered to be impossible to fail, and it is
> > documented to return the entry or null.
> 
> I think that is the right API design..

Callers can check mas_is_err() and check for xa_err(mas) == -ENOMEM.
I'm going to add a note about it to the documentation of the erase
function.

> 
> > I think I should probably change this to return -ENOMEM, fix the docs on
> > it, and probably audit the callers (most use external locks or are
> > early-boot-so-don't-worry-about-it).  Any issue here should also be
> > caught by lockdep pretty quickly.
> 
> Locking aside, I don't think most of the callers can handle an -ENOMEM
> return at all..
> 
> > mas_store_gfp() works if you know the range of your entry.  You could
> > also write the XA_ZERO_ENTRY over the entry so that there is no internal
> > node changes - just a value swap.  If you do this, you have to be
> > careful when reading things back when using the mas_ interface.
> 
> That's probably a good option. Try to store NULL, if that ENOMEM's
> then drop a ZERO_ENTRY and set a bit someplace so that the next
> allocation has to sweep the tree and clean the ZERO's. At least that
> shifts the ENOMEM to an alloc side operation where it can be handled.

Why is the retry GFP_ATOMIC on a timer of 10ms?

Also, why is this patch set using an external spinlock only created to
manage the tree?  Why isn't it using an internal lock?  Is it just to
avoid the possibility of the unlock?

> 
> > I think, in your case, hitting an XA_ZERO_ENTRY would be necessary to
> > indicate that we cannot reuse this particular location until it is
> > correctly dealt with?  Or is the maple tree the only reason it is
> > considered unusable?
> 
> Yeah, it would be be a maple tree issue only. Defered rebalancing
> leave space unavailable.
> 
> This is a case where there is no sane way to handle destroy
> failure. You can't return an error code from dma_unmap() for
> example. So the only reason for this complexity is because maple tree
> exposes a failable erase to it's caller..

I think this is even more complicated by the contexts it is called in -
that is, we cannot preallocate prior to going into this state either?

> 
> IDK, could it handle it internally somehow? Or at least document a
> reasonable pattern with some helpers?
> 
> Eg _iommufd_destroy_mmap() is in trouble too, it cargo culted the
> no-check mt_erase.

Are you sure that's not okay?  The mt_mmap tree is allocated with an
internal spinlock.  In this case, the lock will be dropped, the
allocation will be satisfied and the erase operation will retry.

Thanks,
Liam

