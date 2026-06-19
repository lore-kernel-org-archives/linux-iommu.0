Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DDE382385
	for <iommu@lists.linux.dev>; Fri, 19 Jun 2026 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781871204; cv=none; b=sblWKU3aYlIDAfdLlkeqK46y4AU47ns8+V3KQMHDZt1Z03cwyvaRsI8MOXUrQYp6h1yzdzfrG2a+wJsTn9pVx1zIcGbYoq0rb+lIm5iAe3IbjT9Yxk5wwkiJULNctqFxZDjnLJaMAEtOgHeUIn93aKZu5bnUt9p0hgjLVipNs1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781871204; c=relaxed/simple;
	bh=xCOd2Abm7rjL31sqKZGWY/fZi4cDeolszxapJJCdzGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugfoZ2lxxK2JWRcqe+zXWEkgWEVTGxnESx/GnxpXGP5mcX/H0pqhJH24qhMQnTqM2uzp880/R3zikTAeeiHI9yQ8+Rtz/rG3cwspsjtovzxqfpcTZCvRyLMG8aiM3EaAF7evj9DVtt952cHwujha+l1PbPNoZgWq4YZJTVbqP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EtAB0oSQ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EtAB0oSQ"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9185503e6a5so248398085a.0
        for <iommu@lists.linux.dev>; Fri, 19 Jun 2026 05:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781871201; x=1782476001; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5wW3gwVQxuEF/ajB/V7X/tjPr24VnlVybZ4B5VeQy/E=;
        b=EtAB0oSQNajwbAkP7fRk4ldNH+gf9iW2OEg5je9e5sqO+LhiAMYqDAAUp77aUZD8dV
         CRg/SXwSpg4f5074R4Omh0ux8IgVf5+bu4GU1fiQdLY/ZX1ogV6Cl+B9uXdGOcecbzBX
         E35ahYQUj0/TMpeikW6JoSu2wjzGdBRh0jDEWa+tisYOHPQ4n94nLRZM2U03mVJ+kKWr
         qNYLVobTs9HWsnijT7lqxYRbY7WEGzbIyzx9K0vTF83mCyhsjWFgG2YTrPaavjCVSVKr
         kh7qUV3tWgToYFJdkmXQVMeU5FZyvKAYdusj/s4hoHdvfEtZP9JKb9lg2rIcMEiLhmXR
         lcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781871201; x=1782476001;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wW3gwVQxuEF/ajB/V7X/tjPr24VnlVybZ4B5VeQy/E=;
        b=E4i8eiUp6bhSYmdU8zClGPy+DDivzL9Q6gVanUbD+ahjNPzB8Q5ZuM1NJMz1S4VumR
         X9Xg7Yto9Ibe4Ikc0Vk6LObtAfXvarpzqrkbdk0i8ICmYPT9Z5I3xiuyEsuuoqXh4oXa
         RaEYjwwdSZ4AGjUZOmCAhI1jEvr5gNLjhxJ4nPoFQh3vbsVMDEZn1Pb5+R+xGICaal2Y
         5fE7N81/st9T7BLy6EfdWctrvmSBVayOQPjBI3MoasSHSMlY8yDaUAOnZ0qwzULjwgYj
         qs/ho2+pMFZ7gKaU7fsTJnDP40e7CXTIf9/d/NW6zi1n42+jSeXdKEU1I8L3i3rVKQpq
         jpXA==
X-Forwarded-Encrypted: i=1; AFNElJ/1/sErWwiQ1d3fBuf9bzMDa2fdqFSdTHU4roHWcqXHICVYVKLKUjKbBqDc1oLU5LuDoAmksA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYclgYB3pnDg6A9CTwHo/mlpX8lLI0p5DdY1f40jDjiLGBOrCN
	Z/UqXk+jpu4LH46a31AVyfiQrQlpePf0T1mcDiOm7Im3Q5C41Av6oT62A4catOVRYB4=
X-Gm-Gg: AfdE7cm1/4ontt26QAwbi8XU0n5mt8HNsmYE2J67q6XQ1Yn4dIyqRF1h80RHYrtPSMD
	pdEOv112NSP/Wv1Qsyq5p+OSpJF7sZGSzvKcbhgsmUnalJh2t/uDNUOR2wrsABYPsh4EZxXUh6Q
	tIILdBv+haEoQmCnesyqCwTWhC945MPRa+za+Y45nWPmZqvs1qkveOfp66y63l9Rf/bJx9wASYx
	LD+HFYZroMha4dEemrfvAXmHhdehoZjh5lU1iUU467aJkc5GyTuNxtblXHENZe/Dvu/nbRsod+m
	uro9xuRfvqqXeWZoJ8qbtCpP75QOH4KVWpqFuYgASopao58IgK6mNTsPCF9/tmt+5t8GJkC23u/
	wNmFEY3d78PxVTXdX353v5jKvLe6SetcuWrGxkQtoLOfYeFQuL60a9usbPUa9q1d94MkTLOtvPb
	yQw3dPkPrn6kCVCaZ6Yehw8t5bSDFXNE8jRBjCbufXqjZWAhhmCCpcyHaAQVW+ytuDB8SnQ/Ei3
	mNecA==
X-Received: by 2002:a05:620a:3183:b0:916:5f5:de22 with SMTP id af79cd13be357-9208acb1ademr389775685a.12.1781871200741;
        Fri, 19 Jun 2026 05:13:20 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8de5ed06c6bsm21142376d6.18.2026.06.19.05.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 05:13:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1waY63-00000004THz-2S2T;
	Fri, 19 Jun 2026 09:13:19 -0300
Date: Fri, 19 Jun 2026 09:13:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Liam R. Howlett" <liam@infradead.org>
Cc: Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, iommu@lists.linux.dev, kyle@mcmartin.ca,
	Rik van Riel <riel@meta.com>, maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
Message-ID: <20260619121319.GK231643@ziepe.ca>
References: <ff5f9e09edbcb9c87feac6af00a1d835c783be4f.camel@surriel.com>
 <20260612180303.GO1066031@ziepe.ca>
 <iv7sxqezzz42xieytbf3lskutricz7ltkr3wii3w4jbnbzto7f@2tz5hwa43l37>
 <20260615115633.GQ1066031@ziepe.ca>
 <vbtql77uf65vyxl4smefpol75x3opa7vnixdbzwg7ylxgre6j4@emvlfmdus4kj>
 <20260617180419.GA231643@ziepe.ca>
 <hsojwfbi5e6mpgtzd6rupod4xkviaehj4uo4xo7k2qmmswrc3v@odf2osyjxehw>
 <20260618152451.GE231643@ziepe.ca>
 <ea36fdc51f710d01f0e9bc389334e0b8be96eaea.camel@surriel.com>
 <76xtcbn5hxv3z2w6zbbudr5exjqdgjan4dkcsvrpgagdfpc45x@7prb5j6ivh4w>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76xtcbn5hxv3z2w6zbbudr5exjqdgjan4dkcsvrpgagdfpc45x@7prb5j6ivh4w>

On Fri, Jun 19, 2026 at 12:54:13AM -0400, Liam R. Howlett wrote:
> On 26/06/18 11:51PM, Rik van Riel wrote:
> > On Thu, 2026-06-18 at 12:24 -0300, Jason Gunthorpe wrote:
> > > 
> > > - I like your idea for Rik to try to store NULL to erase, on failure
> > >   store ZERO_ENTRY, and then set a note on the next alloc to clean
> > > the
> > >   ZERO_ENTRYs?
> > > 
> > Is there any efficient way to find those XA_ZERO_ENTRYs?
> > 
> > Without a good way to find them, we might still need the
> > llist to clean them up, though I agree that cleaning them
> > up from the allocator side looks cleaner than doing it
> > from an external worker, and I did make that change for v4.
> 
> no, but how often is there a failure?  Would walking the list and
> writing NULLs be out of the question (I really don't know, sorry if it's
> a dumb one)?

Yeah, this is what I was thinking. Should never happen? I wouldn't
burn memory in each node to make an emergency recovery run faster.

The idea of keeping track of the high/low along with the flag makes
sense, it will narrow the IOVA range to search.

Jason
