Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069272F745C;
	Thu, 18 Jun 2026 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810020; cv=none; b=kiWmQsYbhBB8j95NWq8q8oQiybkbHv1GE8++iBZbiKdNY8md1mtQQPBLQLJy0rNpKxmxsJrxD2TLN0XqilCnUHoisTFquCRtdbi26V38mq4dFls6tVxqfermOdz6t1UWFvKkP6645ye6x6IO6ICqdh4OQgHE3R6OCRQTyFA8JDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810020; c=relaxed/simple;
	bh=wKl9Bh0rufFAHBdtvaE7UKjqU1WgVKxqlFeLxq0MM+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBrWGvWcP1efMTLxJHGskhuAQYbzHUCx4b32BIIenfEpMSyz8VPU/R6REY6IGTQjUqQzudhc5NxzIdh6aLgXeEr9fL3MEYERZlhUOQswU2wPdoYQSSSqKMcGVqsJoup1vC6ABiw73rM0Sme42H5cfn8d3uleWRthOSn6X5qSEkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3NPjMUfB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3NPjMUfB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=rqd5O1roOUBrQb6fs+Y31k1jd8npq3fgS/qR1OpZskg=; b=3NPjMUfBn4+4e2uJWix+pkyGym
	8IBL2KJEq8zRx3tzJX2oXKi1INzhdtRALhxGMA8vVqNdIWbkWVKlIamGb4kKbCTNVvwMKwz4/zwqN
	YQJIlxhj5OiTe+5vp9wG1rWFM/RKhyCtPnMVaR0AZaq+iKju7Ak1R6orDbX7Zn/LuWCebFSGF9PH/
	HQHgf6jCXFV8YesCH2IAg2TznOm+Rs9lw5SQ+0bd1aMq8RxHH+wniSsp+cqs6T5o9rGQV3ij1JIY/
	DxaSYuFJ9vABaVQjj6JdlkcilfVvE8xIdHt+CtLWbbAVGSfLsl96X56ljCM802XT3EeXIJTHzv9z5
	DudBsWdw==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waIB8-00000001jjh-1sEk;
	Thu, 18 Jun 2026 19:13:30 +0000
Date: Thu, 18 Jun 2026 15:13:26 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Rik van Riel <riel@surriel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, 
	iommu@lists.linux.dev, kyle@mcmartin.ca, Rik van Riel <riel@meta.com>, 
	maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
Message-ID: <ddd5mwcidfetehvyamu27agsbcwojhmgpffgwes5iey74kodna@3zdj33s264jp>
References: <ff5f9e09edbcb9c87feac6af00a1d835c783be4f.camel@surriel.com>
 <20260612180303.GO1066031@ziepe.ca>
 <iv7sxqezzz42xieytbf3lskutricz7ltkr3wii3w4jbnbzto7f@2tz5hwa43l37>
 <20260615115633.GQ1066031@ziepe.ca>
 <vbtql77uf65vyxl4smefpol75x3opa7vnixdbzwg7ylxgre6j4@emvlfmdus4kj>
 <20260617180419.GA231643@ziepe.ca>
 <hsojwfbi5e6mpgtzd6rupod4xkviaehj4uo4xo7k2qmmswrc3v@odf2osyjxehw>
 <20260618152451.GE231643@ziepe.ca>
 <r4jlbi3hbtvv6vrenarz6i7n6cu3vfqqdz2jfenkwsuv3fkadi@nq5u5txbtso6>
 <fc0bdfd6e0ddcbde208dff785ea0ce7f41d1f875.camel@surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc0bdfd6e0ddcbde208dff785ea0ce7f41d1f875.camel@surriel.com>

On 26/06/18 01:30PM, Rik van Riel wrote:
> On Thu, 2026-06-18 at 13:27 -0400, Liam R. Howlett wrote:
> > On 26/06/18 12:24PM, Jason Gunthorpe wrote:
> > > 
> > > 
> > > - I like your idea for Rik to try to store NULL to erase, on
> > > failure
> > >   store ZERO_ENTRY, and then set a note on the next alloc to clean
> > > the
> > >   ZERO_ENTRYs?
> > 
> > The ZERO_ENTRY can be found by mas_* functions and will cause issues
> > with the gap searching.  You also have to be careful to handle these
> > entries in mas_for_each() loops - you don't want to treat them as
> > valid
> > entries.
> > 
> Could it make sense for the maple tree to have
> something similar to ZERO_ENTRY that is treated
> like a gap, so the gap search can find it, and
> get rid of those entries when the gap gets re-used?

It might, but it's not as simple as adding a new special entry.  Gaps
are propagated up the tree so that we know which subtree has what size
gap.  If we have a special entry that isn't counted as an entry at all,
then we're in a position where the gap calculation code needs to change.

I'm also not sure how we handle this entry if it's at the edge of a
node.  How do you account for a gap in a subtree if it's not fully in
that subtree?  If one node has a gap of 5 and a value and then the next
node starts with a gap of 5, how do we represent that gap in the parent
node?  What if it's multiple levels up?  How do we find that gap and how
do we return something that makes sense to the caller?  What if the gap
spans an entire node or larger?

It also brings into question how much data is considered within a node -
is one of these entries kept if we rebalance?  Do we have to mark the
tree itself to state that it's in this odd state to avoid other stores
from actually happening before the tree is cleaned?  How do we state
that the tree is in this unusual state?

It might be worth doing, but it's not a simple change.

Thanks,
Liam
