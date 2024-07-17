Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D59D20DC3;
	Wed, 17 Jul 2024 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721206041; cv=none; b=DE7CR+bEYzq2FJl+AYj89ZQ16q61I7Cv7cyug+SiVgsQgPavyIX0bci3NHaMaMgW+qxI1shLA3LngHdDf7DEQ3QghCLfCPHs0Kf0ncJhrOwDjav8I1T1Q5tvgER0kCvk8AAhR4j0ltY756jy8JqHjAmKjyvb4256TfXSjh3akHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721206041; c=relaxed/simple;
	bh=L65yk+aTaNpw/49H65EyAuulRA+8r2f/Auq+QlOgUE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4WV0xcXJBzVwCc+f8Ibq+Uzvf8XwtxMD1dM46zmyxVVN7kMmgk7MQ4PnugwXFhCmdunHoXUWC37Al08/aeH7XoZYCtPWj49pwH2FNKlEpw0qTEH00IxtCZT638xZw7pGNF0fASBXHVuJeMGDml61HwjLVY2ZJGEYY4Kmjf8Zu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lewUu5sV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lewUu5sV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1D5C32782;
	Wed, 17 Jul 2024 08:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721206041;
	bh=L65yk+aTaNpw/49H65EyAuulRA+8r2f/Auq+QlOgUE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lewUu5sVmk2/bTj3R/VTSfA0Ziz4ZFx1aucdrEhBNWZZY8XXZwQ5NivxhPTTyCMPD
	 UXw+Lcp+ogPEsd+Mc9skJlN1VgtVMxX8xTmQ0MD6TzRzAdXVVmYE5q+eSaJtfxKA75
	 bLsSVT2WGJWYwjLCNj45meFxjtUk3sPzaOAJVJHCgHMqBqCEXOplJ1gcmYqf2Vd1At
	 jWt8aG33mvDPKXeeZRknuPeKqFr1WPjMvL2Fo8zuZ1vXKQvY1UE12iIO01skrQcwe5
	 Yqa2IsL9Ieojo8QQhKa2MtUSubYDzwB2ldtx/DpNJvzKeplhpLbXWx0CRXx5BO/YHc
	 UMgfRFKxoh/Vw==
Date: Wed, 17 Jul 2024 11:47:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v1 2/2] dma: Add IOMMU static calls with clear default ops
Message-ID: <20240717084713.GG5630@unreal>
References: <cover.1721041611.git.leon@kernel.org>
 <7758cbe20bfd34506d943bb93097565b9c4dced4.1721041611.git.leon@kernel.org>
 <20240717082145.GA15484@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717082145.GA15484@lst.de>

On Wed, Jul 17, 2024 at 10:21:45AM +0200, Christoph Hellwig wrote:
> dma_is_default_iommu still looks a bit odd to me - basically we have
> the ops structure just to say to bypass it.  Why not add a single-bit
> dma_iommu field to struct device next to dma_ops_bypass to skip it?

It will cause to the situation where "struct device" memory footprint
will increase, while we still need to keep dma_ops for archs that don't
want to use default IOMMU.

Because dma_ops pointer exists anyway and has already specific flags. I
decided to take evolutive approach and add a new flag to it, instead of
revolutionary approach and add a new field to struct device.

> Then IOMMU_DMA also does not need to select DMA_OPS any more, which
> would be kinda silly with the direct calls.

I didn't know how far to go with that, as default IOMMU .flags are
unique and can be removed if dma_iommu bit is set.

Thanks
