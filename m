Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713A51B7E4;
	Sat, 13 Jul 2024 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720863184; cv=none; b=mKQ5h9C20swIECGZdU/aekRztUmsbfUpVjX25SgZahf33LRJd3LedvZRYMKlNCVj1RoqQmUIfiEUD9k/GbQ3M/YuNfhAjNtdmMYxFnILufy1GAfozqHwtvKxjl0/8/Q0eY1B8N7CvTVSX3HWIVvnu1+OWqRQUsDYSYNWYS++5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720863184; c=relaxed/simple;
	bh=t3VIcw7sj8uTQS8Fgpb/8cAlZbYWJqSGQ7EmirssRsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNfRPqDkpmaIgvl/EEc2kgpxR1UJVg08nB3vFRdvcjFMAd7RXml9SxB4RASCCdARnyh7Qc707uaJby7R5GsIyEU2UsB+En9nL26wO4X2b7Oz0NiT5WPcHxuiigWrHZsFqXBtpU4Nmpy8IAjHuyFyUmdkKoHfOMm8aQ+2vpI6CG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeFMAumw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeFMAumw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAF1C32781;
	Sat, 13 Jul 2024 09:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720863183;
	bh=t3VIcw7sj8uTQS8Fgpb/8cAlZbYWJqSGQ7EmirssRsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LeFMAumwWjAaBErW333wCOe5yb/VJmlVJPkuLKR+yIXM7t4aIgO35tTWT1OArYGfU
	 tNOHOgkpl+k1+BloqH/+2KPZzsirTT2srEteauT1PlZQQSO/Xpii0uH6aluD1Fiyy3
	 13I75/HL4gq+RjNd9opUo4D77uR0soql8FNLRI5Bgy4BI0vQwwxzAz4q48d+wqnjrl
	 MnO4f7aR7gHwL4Fs6lG7tIiIumTAQJNuM4XXDkwQHqhw2uKW99UUKtIPD+WIXGUK2u
	 IuNjs2fesTuYq6oDsM+KYvwqGV3E6b5FD4u6weIx1HYd6aj1bndGEZRS15MabhiXzN
	 m/Ed5FYkXybhA==
Date: Sat, 13 Jul 2024 12:32:59 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 2/2] dma: Add IOMMU static calls with clear default ops
Message-ID: <20240713093259.GH1815706@unreal>
References: <98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org>
 <f2b699aea8fff5589a674da2a567fd593ed2d386.1720693745.git.leon@kernel.org>
 <28309b7f-9809-452f-95fe-3448c15bdf1b@arm.com>
 <20240711185741.GC1815706@unreal>
 <455ccc97-11bd-456d-92b3-b7c8fe4c8d9a@arm.com>
 <20240712055004.GE1815706@unreal>
 <7ba30992-78aa-49e5-98bb-75c6b7ae8ce9@arm.com>
 <20240713051813.GA25733@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713051813.GA25733@lst.de>

On Sat, Jul 13, 2024 at 07:18:13AM +0200, Christoph Hellwig wrote:
> On Fri, Jul 12, 2024 at 03:21:55PM +0100, Robin Murphy wrote:
> >> This is done to keep layering similar to existing in DMA subsystem. We
> >> have special files and calls to dma-direct, it looks natural to have
> >> special files and call to dma-iommu. It is not nice to call to drivers/iommu
> >> from kernel/dma/mapping.c
> >
> > That's where I firmly disagree. In the DMA API aspect, iommu-dma is exactly 
> > a peer of dma-direct,
> 
> Exactly.
> 
> > however it lives in drivers/iommu for practical 
> > reasons because it's more closely coupled to IOMMU API internals in all 
> > other aspects of its implementation.
> 
> TBH I think kernel/dma/ would be the better place.  But that's really the
> least my concernes at the moment.
> 
> But the important point is that I would really prefer to avoid another
> magic layer - just do direct calls like for dma-direct to keep it
> understandable (and probably faster).

I'll change my patch to be without extra layer, but is it unlikely that
it will make any difference in performance.

Thanks

> 
