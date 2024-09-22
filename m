Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37C92581
	for <iommu@lists.linux.dev>; Sun, 22 Sep 2024 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727017369; cv=none; b=L5tQAmvhl/qqHlNBRgQRoPryKdYSh0e0EpRtHaTdgdjVgFxYjDGubjdTXalMUWLb9vnmXd0iB+2sOukPGV0mLPAzzIbeDgpI23SgonwbkqDzVdxXg7N1Y0AZqYOgD0GZmM6vc6HF4ZOvqQQOQVxlMCU9fuxT8H0vIRM1w1MuwMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727017369; c=relaxed/simple;
	bh=Q/RC40pMfl56VozCL24fdBw+6JPA88/CAtC1/VfzJbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFyYQTDXnyqABiIQrY6NfT0dr1DgGQEaIYjxdWh04ZlPslKmOLD31H0HSXPCEWovurJQdxQNF025PSMyeD1W1uhqoSTHPseFr/fSaTMKcgVow5E8sbwxRkERH1N9V6z3nj9od58UvGuacE8t+6IMKkHFsvtue8ah47mqlPhD9j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3LylbwS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3LylbwS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FEAC4CEC3;
	Sun, 22 Sep 2024 15:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727017368;
	bh=Q/RC40pMfl56VozCL24fdBw+6JPA88/CAtC1/VfzJbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3LylbwSyq3KdA3n1QvzOm6M3EkmgelC87OnCiOX4WMBc3squQhONAxUw/kbpR2Ps
	 jOTE0DR31GhIXcioPHe4gbv6i7LAsnUyia5biaKQagSoUHQfxlFcozNa8QMbSfhLN5
	 RTRwpZN+2Ovvw3qScUHPH4tqLonMOTWRjC3LLeKHmlgXf/IIJhPi3/jTQ6Abbg0fO7
	 RJ8msHknYHNTweB0EBKeN3+E0s8KkkdpYmK9Oq0ZbqtxvR54AsBHA/IDh8XYpMTIcb
	 kGebRUmkqX4n+t04lYAz+u6ta+1XVC0rY9G4344SUd8ivYqCG/F3rM5SvkGXcE/c7G
	 arnq/FHq36QxQ==
Date: Sun, 22 Sep 2024 18:02:22 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH 2/2] iommu/dma: remove most stubs in iommu-dma.h
Message-ID: <20240922150222.GF11337@unreal>
References: <20240922140743.1596763-1-hch@lst.de>
 <20240922140743.1596763-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922140743.1596763-3-hch@lst.de>

On Sun, Sep 22, 2024 at 04:07:35PM +0200, Christoph Hellwig wrote:
> The direct calls from mapping.c all guarded by use_dma_iommu(), so don't
> bother to provide stubs, but instead just expose the prototypes
> unconditionally.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/iommu-dma.h | 108 +++-----------------------------------
>  1 file changed, 8 insertions(+), 100 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>
