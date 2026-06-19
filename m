Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABB6279DB1;
	Fri, 19 Jun 2026 04:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781844864; cv=none; b=TUBpHtSvq69B0HeIQ4TcT1MAePTP2GdnkAIWCSpwbLOzEqdRmscodvaQcNZnaLhIA6WGsvRAWvW0L4u1vZbDSCUOOxz6K0FbFWdpVpNhEJQcCW4mwTBIXglpBViToI6MW+abW0Nixc0xGulspS3pZS9yw5nSLoImkz0yyI0uI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781844864; c=relaxed/simple;
	bh=ximStfpWqHNdaXSuBrJk8XQoXjSPgGirAMwh8y/I2Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEjRnWCU+cr9C/iT7GRwQb9nODbqfoF3JmwwFARcib/lJju3TNHflThgAkOvS2Cdm1pY/Ih0I/lvznu+/jEn2D531mrrk2kjJBrfv/l1kAnumHvB2kdOQf/b3SmZlrXJogxyoI25Ljamif1VHhftv0HAiQ/qEQg74+/xSEHfc9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AYt3dX/7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AYt3dX/7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=3wUfh7umMvAZz9rQNp9pQkFi4gH5uuSR7/gSSbtlqvc=; b=AYt3dX/7hAduYPVXr5VkQHGSLA
	dxMIBHHChanbZh/cdSjAuqK6m+ov68fWC85WLFpVn596qibtF6BZKQwZaqnv3LdDjOIm2D9f8i4A0
	Vp/ydm81VQrH8eXLbCGFQOgQGb+ypnJoMrKdVWbB0brngVHySS5GQncIMbOTdvao3kZ8SDPwkjhjw
	ZM0Y6msP2rQ+rdMBMmVNlzn6RpcLRq8F6EucBXX0TRGqbZmrqBzN6iJfznMqAdNxSIgsn45vTsEZ1
	NUBlS/o16eMtW1Kh1kM0yjC4wdBGOha6YRCcf2kgZvIWJ4F9Wu7x21cNcEUlxSBywBh6iylM4P9wf
	YhkYLACw==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waRFA-00000001z18-2af0;
	Fri, 19 Jun 2026 04:54:16 +0000
Date: Fri, 19 Jun 2026 00:54:13 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Rik van Riel <riel@surriel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, 
	iommu@lists.linux.dev, kyle@mcmartin.ca, Rik van Riel <riel@meta.com>, 
	maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
Message-ID: <76xtcbn5hxv3z2w6zbbudr5exjqdgjan4dkcsvrpgagdfpc45x@7prb5j6ivh4w>
References: <20260612164852.GL1066031@ziepe.ca>
 <ff5f9e09edbcb9c87feac6af00a1d835c783be4f.camel@surriel.com>
 <20260612180303.GO1066031@ziepe.ca>
 <iv7sxqezzz42xieytbf3lskutricz7ltkr3wii3w4jbnbzto7f@2tz5hwa43l37>
 <20260615115633.GQ1066031@ziepe.ca>
 <vbtql77uf65vyxl4smefpol75x3opa7vnixdbzwg7ylxgre6j4@emvlfmdus4kj>
 <20260617180419.GA231643@ziepe.ca>
 <hsojwfbi5e6mpgtzd6rupod4xkviaehj4uo4xo7k2qmmswrc3v@odf2osyjxehw>
 <20260618152451.GE231643@ziepe.ca>
 <ea36fdc51f710d01f0e9bc389334e0b8be96eaea.camel@surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea36fdc51f710d01f0e9bc389334e0b8be96eaea.camel@surriel.com>

On 26/06/18 11:51PM, Rik van Riel wrote:
> On Thu, 2026-06-18 at 12:24 -0300, Jason Gunthorpe wrote:
> > 
> > - I like your idea for Rik to try to store NULL to erase, on failure
> >   store ZERO_ENTRY, and then set a note on the next alloc to clean
> > the
> >   ZERO_ENTRYs?
> > 
> Is there any efficient way to find those XA_ZERO_ENTRYs?
> 
> Without a good way to find them, we might still need the
> llist to clean them up, though I agree that cleaning them
> up from the allocator side looks cleaner than doing it
> from an external worker, and I did make that change for v4.

no, but how often is there a failure?  Would walking the list and
writing NULLs be out of the question (I really don't know, sorry if it's
a dumb one)?

Something like this totally untested code:

unsigned long pfn_lo, pfn_hi;

pfn_hi = 0;
pfn_lo = 0;
mas_lock(&mas);
mas_set(&mas, 0);
mas_for_each(&mas, entry, ULONG_MAX) {
        if (entry == XA_ZERO_ENTRY) {
                if (mas.index < pfn_lo)
                        pfn_lo = mas.index;
                pfn_hi = mas.last;
        }
}
                
if (pfn_hi) {
        mas_set_range(&mas, pfn_lo, pfn_hi);
        mas_store_gfp(&mas, NULL, GFP_KERNEL);
}

mas_unlock(&mas);

If you want to optimise it, you can just keep the first failure in the
contiguous area there are failures and reuse the pfn_hi to set the
range. (are the areas contiguous usually?) It's probably better to free
any memory you can since you just ran out of memory anyways.  Although
it's 16B.. how many are usually processed in a group?

Would a normal workqueue be okay to do the freeing?

Thanks,
Liam
