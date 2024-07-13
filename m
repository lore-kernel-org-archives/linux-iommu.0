Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A2B18E1F
	for <iommu@lists.linux.dev>; Sat, 13 Jul 2024 05:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720847906; cv=none; b=WLriB8eUHc51TQ3fNONM+MZgmUEvyd9YMI2Dj6OJW+fGTdxq2f1KRBVTymopMT0KTTBwkYUSqOY41vibVCK4JYfcd3MDNwa224CEu7xsPY0/8ZlA5oQepYSBJuFW6X2SxyvXIktnhnUolwSbwj43zZLpmHnOHmZoQDuXTsRLnIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720847906; c=relaxed/simple;
	bh=m4EUI3VRrm8sQtbn52uqRbft7Jp8IZZIpwGOl5SJUo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMY4Jm97oeoC4UD0mud2jOxhyzFqDcXsvQhYa0c8xqQ3+y9mpDs4tK7mnIyze0tciAWSRRki+rnKLyfjJQGFkKhx/s8pt8QfAWJr1rb3/rGg6PGMV9C9y4VuGVRTF2InyM6Z+qVuu2rIdVo1Tpa58bT6d5cFNNl8aE8q9HtYxUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ECA8368B05; Sat, 13 Jul 2024 07:18:13 +0200 (CEST)
Date: Sat, 13 Jul 2024 07:18:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 2/2] dma: Add IOMMU static calls with clear default ops
Message-ID: <20240713051813.GA25733@lst.de>
References: <98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org> <f2b699aea8fff5589a674da2a567fd593ed2d386.1720693745.git.leon@kernel.org> <28309b7f-9809-452f-95fe-3448c15bdf1b@arm.com> <20240711185741.GC1815706@unreal> <455ccc97-11bd-456d-92b3-b7c8fe4c8d9a@arm.com> <20240712055004.GE1815706@unreal> <7ba30992-78aa-49e5-98bb-75c6b7ae8ce9@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ba30992-78aa-49e5-98bb-75c6b7ae8ce9@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 12, 2024 at 03:21:55PM +0100, Robin Murphy wrote:
>> This is done to keep layering similar to existing in DMA subsystem. We
>> have special files and calls to dma-direct, it looks natural to have
>> special files and call to dma-iommu. It is not nice to call to drivers/iommu
>> from kernel/dma/mapping.c
>
> That's where I firmly disagree. In the DMA API aspect, iommu-dma is exactly 
> a peer of dma-direct,

Exactly.

> however it lives in drivers/iommu for practical 
> reasons because it's more closely coupled to IOMMU API internals in all 
> other aspects of its implementation.

TBH I think kernel/dma/ would be the better place.  But that's really the
least my concernes at the moment.

But the important point is that I would really prefer to avoid another
magic layer - just do direct calls like for dma-direct to keep it
understandable (and probably faster).

