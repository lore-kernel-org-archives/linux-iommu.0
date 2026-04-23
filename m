Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF07C340290
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776983840; cv=none; b=h9C5+oUhk2dOrwN2pq1QaVi5zd1jHGE/7/iqvTu2m9WgSp6MbuK4nn3IWowEYuX0KgSK0bKjCMsKAHt8OtHC1187ZaL11k7oVz3RJwthvSI8KMAEE7AeksVBSzHYTRnOMXNqw2Cn1cv36B3ThKSzIS8F15AUpQ9TDreiwfKGl9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776983840; c=relaxed/simple;
	bh=jz6d2Rk2R9fNPwkMSiv35sDmoM0WBb2VdkFyl4+3Wzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2Q+UXFKfooY5lPQaOlalZ5GdUfxS1vjsvVRO1IVbxPZRfSodACLstYJN/0odfojQn14qUZeLRwgXIPTyjXmdZH8hEXkSbk+8K8s7Q5YbMG0hjBqxIhqNxBDvxjKioyabyPe+n2RcuS5KMET5CZu8QMZFQ1k7DyzLXpfQMl+3Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UtymMcQl; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UtymMcQl"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50d87c138e1so73290641cf.1
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776983837; x=1777588637; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Os93XZ5HK9zO/mWUsxanxIiJC+1bt4BZQrH2i+zDIdk=;
        b=UtymMcQlSACW4xP8ab8fgDspo4j1oZ9zvUWh78eqLtjVW9LsfDp2Ka8dUfFnVeF47i
         P1h7RtdF45O1iW1tnYP07dBvlopa4fhT+eOGIMip9UAg7iobG6RDpf3+8zu15m/T7dNJ
         ohcCrO+oKpH/1HEGel/N9Qz2+M4rhdC7gMneR4iciQrv6suLM+gUwTSi4m0ChPpFC2i+
         0dSujDUFGgm7AOEcMgD2u5JUlvrdJr8In64MHLCVEkcxTMtgXdhkk+j2Y6VABtBeHJYJ
         PUdBYHuuwVLZqs6ne1bv/ov5H5ayj2BD/iuB0s/wjn4paDrkSlYVbpe/jCOj7bLNNcRJ
         MxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776983837; x=1777588637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Os93XZ5HK9zO/mWUsxanxIiJC+1bt4BZQrH2i+zDIdk=;
        b=A5U/S8E6B/2Jswv2L6UOORhoKvdUH+zDWFYrx4jNaUgojq3GvdBZeUhroQYGoVliiC
         8TMEPdXsOZMpJhfHW69V5xcTBNivde++lws8A9RFJmIjP3XyL7ghwRMx5aCuWquulPHv
         SLtPtdzVN8vo78lCEO2/9D77iTCrTYI1oC1pWv6kX0HCYGfcUoY6512w/BdIxZzRWzdW
         PT9j5FXuuKBvM06C35xe/fI8xtGZvLmxhCHaFWfElN8mbb1sj9X5AQ+87de3VXRXuGhr
         0gFJhU/Q/A6rKQrjdkjM+nMAZzMs+VRsh3de2FchnQBN2IpOTM9s8OuZPywXOTKQd9Ev
         D15Q==
X-Forwarded-Encrypted: i=1; AFNElJ9I8OByoOj0YHE5nzQISK9DOZtYANjdZetcYizHq9Fi6dUTtAcPTTnjUI3zorTS2jv6M/8eRg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxyd1yGJCZrHSjkNpDqqkGAqZf+ZgC5BNQ/aqw5EhpxUOZ84ia3
	vyTv4eDkIDM4o7ZZDOO3zxpJHzJwnkHdd/ZxOqTQqB408YGXOusqAJNsIR55Ze89mYY=
X-Gm-Gg: AeBDieuLMFJ3XdD3hVqljbWssC7UhF8ZsVSnXqgUaCjIYNvS8j55aFSnCBpyf3p61Gd
	pZvSRKXknjHFNUJRYIIzUYVzoHANn5JGPUUINhBDpdJKYGeBCNmEW6lQoFQ2d+Va69+eqN9yboR
	KCizI1qtKViourgC87cANO4j3d0hCctz9Tx6Bp+PDA9yok+GUaQsyhPx73LmiUVOiBu0M/OUiAr
	fOXcpC4Hgwxuefkpz7w8VKvS2uISDmWXe9DqtwzZqP0dUodVqimObhZW2TFxYI8IuXfLXFD2iBy
	3jEar1Y+EjCpVrGx80yct8DSqI8BafgHSXcTvJ/1LLUUgBkXaUzuv0JNwNKkhf9jfFlBT5AVghx
	KBpMel5pWqSFYNMwHy8tehk2muqepUlv3kO6Je4rKvLNCNwAZXnY+U9B3Axwm0NHd6ND6M8mTkp
	jZnB8D7dLlU+YqbMOmKho0TPhq17cDG0to8EYxFaA0SWw+AY68cFRdlUoJhgjg8+anT2Ynb16+S
	BiSfsdrPS9VK/vGMQjFNsYlxew=
X-Received: by 2002:ac8:7f90:0:b0:50d:5a11:1b5 with SMTP id d75a77b69052e-50e3694a5a4mr448735281cf.17.1776983837535;
        Thu, 23 Apr 2026 15:37:17 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac72915sm172200376d6.15.2026.04.23.15.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 15:37:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wG2fc-0000000GJhm-1AI6;
	Thu, 23 Apr 2026 19:37:16 -0300
Date: Thu, 23 Apr 2026 19:37:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com,
	Zeev Zilberman <zeev@amazon.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow disabling Stage 1 translation
Message-ID: <20260423223716.GS3611611@ziepe.ca>
References: <20260420123221.20801-1-epetron@amazon.de>
 <20260420124032.GO2577880@ziepe.ca>
 <20260422064431.GA49867@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
 <20260422162351.GK3611611@ziepe.ca>
 <aenp6FHzx9rtUQkZ@willie-the-truck>
 <aenqxasLJ8yKYqbT@willie-the-truck>
 <20260423142326.GP3611611@ziepe.ca>
 <aepRy7Gp7Ng85Zr7@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aepRy7Gp7Ng85Zr7@willie-the-truck>

On Thu, Apr 23, 2026 at 06:07:23PM +0100, Will Deacon wrote:

> I don't think it's that odd given that the STE/CD entries are bigger
> than PTEs and the SMMU permits a lot more relaxations about how they are
> accessed and cached compared to the PTW.

Well I'm not sure bigger really matters, but I wasn't aware there was
a spec relaxation here that would make the cachable path not viable
for STE but not PTW...

> Having said that, the page-table code looks broken to me even in the
> coherent case:
> 
> 	ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
> 
> as the compiler can theoretically make a right mess of that.

Heh, great. The iommupt stuff does better.. It does a 64 bit cmpxchg
to store a table pointer and a 64 bit WRITE_ONCE to store the pte,
then a CMO through the DMA API.

DMA API has to guarentee the right ordering, so we only have the
question below:

> > STE/CD is pretty simple now, there is only one place to put the CMO
> > and the ordering is all handled with that shared code. We no longer
> > care about ordering beyond all the writes must be visible to HW before
> > issuing the CMDQ invalidation command - which is the same environment
> > as the pagetable.
> 
> You presumably rely on 64-bit single-copy atomicity for hitless updates,
> no?

Yes, just like the page table does..

I hope that's not a problem or we have a issue with the PTW :)

> > I also don't like this "lot of systems thing". I don't want these
> > powerful capabilities locked up in some giant CSP's proprietary
> > kernel.  I want all the companies in the cloud market to have access
> > to the same feature set. That's what open source is supposed to be
> > driving toward. I have several interesting use cases for this
> > functionality already.
> 
> Sorry, the point here was definitely _not_ about keeping this out of
> tree, nor was I trying to say that this stuff isn't important. But the
> mobile world doesn't give a hoot about KHO and _does_ tend to care about
> the impact of CMO, so we have to find a way to balance the two worlds.

Yes, that make sense.

My argument is that the CMO on STE/CD shouldn't bother mobile, you
could even view it as an micro-optimization because we do occasionally
read-back the STE/CD fields.

But if you say the SMM STE/CD fetch doesn't have to follow the single
copy rules and PTW does, then ok..

And if Samiullah can tackle dma_alloc_coherent then maybe the whole
question is moot.

Jason
