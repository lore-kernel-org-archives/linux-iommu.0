Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9C4322E
	for <iommu@lists.linux.dev>; Sun, 22 Sep 2024 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727015539; cv=none; b=cM0yz6KTxcwvuRboiUldLNlp8Ot5PKch1RuHAgpVTjS1OGJJLOflYQ7oDZ9kOJB4Ou4aOZJmAyAAbDpzeo+7ekIg5yJAjorKerxB7XyWLcTV9sdQ+SVjF0L5FHjs8PCprhztF8Z3hY0DQkrNRh7s980F665rAKu8Q3unIRxJoBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727015539; c=relaxed/simple;
	bh=m0B+X7cLqwZJrIHWspGSysoED75fGxwhICmPpNa6jyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5CVS+TW2HCSyKIb7EdkO5O00YVn1uJhH3KJZ8ANh2KOt9NCycbOjVsTLPbh11D/2KXj/HKtIiz8hSK3PAtJOmZhl4UxYXppQESmopdNPliIapk/broNBq3KWD2rKcyfXOMt/kAfdvhceFMuE3r9cOJnAM6Q5AFZJ1h2t7OvM3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 281BC68AFE; Sun, 22 Sep 2024 16:32:06 +0200 (CEST)
Date: Sun, 22 Sep 2024 16:32:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH 2/2] iommu/dma: remove most stubs in iommu-dma.h
Message-ID: <20240922143206.GA16843@lst.de>
References: <20240922140743.1596763-1-hch@lst.de> <20240922140743.1596763-3-hch@lst.de> <20240922142819.GD11337@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922142819.GD11337@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Sep 22, 2024 at 05:28:19PM +0300, Leon Romanovsky wrote:
> On Sun, Sep 22, 2024 at 04:07:35PM +0200, Christoph Hellwig wrote:
> > The direct calls from mapping.c all guarded by use_dma_iommu(), so don't
> > bother to provide stubs, but instead just expose the prototypes
> > unconditionally.
> 
> I was afraid to do such a change because of fear that some compiler will
> call to the !CONFIG_IOMMU_DMA functions without checking the condition.

The kernel relies on this style of dead code elimination in many
places.  The IS_ENABLED() macro could not exist without it.
