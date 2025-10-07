Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6C1194137;
	Tue,  7 Oct 2025 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830095; cv=none; b=tBsJy1dBydJMWsB2OkLcVwN8vIeEafk99mDCCjXrM1HJzssrMk3pMmjJ8rZEtDrXWFDMir3Rl7BgjeeHpSCn9FG/q+A8JjMf/ZjjzjSAFm8+IY2cgD9yMDac/AJNI4nYpDss9tSBJnu8+zSt0Q32EFLrDFEOiT1ayYlQthEhy2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830095; c=relaxed/simple;
	bh=FgrLW6bEKzltqWslwCLOsA3qHXCfdjnBglSNfQbawZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rngyQHY1ROaPQiQ/OfbdRgAubmDXOZCMMCeeDoBV132k0A8Xe8mrQBXJvsFXne895+ZptbUuct5DBRkAnll3HW5ilxE+4K88NUOamAYArM1JGQh+xu5JR+AtRxLPA6v8kvAnSK39Zmu3zcisEOiBKIE7n9+9zTHjFxZ0Ho+nT+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quQL3+Wg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quQL3+Wg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F65C4CEF1;
	Tue,  7 Oct 2025 09:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759830094;
	bh=FgrLW6bEKzltqWslwCLOsA3qHXCfdjnBglSNfQbawZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=quQL3+WgEN6zdXO19wv47c0eHt4guqj56XoppdjXAxkYsd/3TciPCMlrlXP5Gnb1b
	 8iYZtAX934P/lvIFVFbPHo8/1PObbnluenytXWH7gpivurue70zhQknTrOxqxnv3wr
	 5BmVfxyCohGTyK2GmRRnVZ46H8w3fWLio5UdoOMc/jcmEOmNIJkHIlKSJAitjDSmpJ
	 5WJQG2RCLd19hMQ1fSmXqe54CIt8u6tSfb/bPsKA251Z2+DiQYr86YKkCD6yUl0sCK
	 Qb7pAgPPywh6QD7huPk3WqVuetEbYsiZMgOVLizzPZT8YPoMLB9nMl8vXKsyuppL4v
	 enzaXrDNbe7cA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v64CK-00000000310-1BkN;
	Tue, 07 Oct 2025 11:41:32 +0200
Date: Tue, 7 Oct 2025 11:41:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] iommu: fix device leaks
Message-ID: <aOTgTEAqDd4gyk6u@hovoldconsulting.com>
References: <20250925122756.10910-1-johan@kernel.org>
 <20250930182158.GS2695987@ziepe.ca>
 <aNzxWZlWmQMokLd_@hovoldconsulting.com>
 <20251001160132.GX2695987@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001160132.GX2695987@ziepe.ca>

On Wed, Oct 01, 2025 at 01:01:32PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 01, 2025 at 11:16:09AM +0200, Johan Hovold wrote:
> 
> > This seems to be more a case of developers not reading documentation and
> > copying implementations from existing drivers.
> 
> IMHO the drivers are mis-using of_xlate, it shouldn't be looking up
> drvdata at all.

Ok, but that would in any case be a separate issue.

> > > IDK if it is worth fixing like this, or if more effort should be put
> > > to make the drivers use of_xlate properly - the arm smmu drivers show
> > > the only way to use it..
> > 
> > As Robin pointed out, those drivers just drop the reference as they
> > should (even if I'd drop the reference after looking up the driver
> > data).
> 
> So I wrote the series to clean this up and drop the calls to
> of_find_device_by_node() and so on.
> 
> I left dart, exynos, msm and omap as-is, so I suggest you trim this
> series to only those drivers and rely on my version to fix the rest.

Looks like there's some room for unification and code reuse, but that
can be done on top of these fixes.

Johan
