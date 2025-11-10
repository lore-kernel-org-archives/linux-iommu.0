Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EF62FE045;
	Mon, 10 Nov 2025 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766057; cv=none; b=KZaP1dmT6uFJpaSvXVyVqjJvEpbt22zsVtDPN+iFg5nu+jmCQrRk+Rmg0ifEdMqWkG5WqD4gUN1le+esJGPE9896SsRBsSrcVkYtbYmPHtWKIBAltmLvmaD+jr2UdSBxCrVsRVNmnVM+1NNWbncrRKcZoTm2cvkfdQDTGajVwv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766057; c=relaxed/simple;
	bh=TSzf9gtEscKmLMkFqIrtQq5zPwAvv690aIMF1B0z9Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMuId7KsydyB9ZIX6rvXaZRLDKomwk1YiAWwFEh4NqgR+W/bmpY6ZGhA6/7ZTH+sqEO8UFpWMGgWKfVFLX/kED5qj7FYlRx6d1k0ynGDhD4WmrD/Shp6cDVOH50GkD2QEwlVyTDtS6cgr+7rzNSBXpWe9S6DPyvcQxxQNF85oPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScSKpRKZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScSKpRKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99764C2BC9E;
	Mon, 10 Nov 2025 09:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762766057;
	bh=TSzf9gtEscKmLMkFqIrtQq5zPwAvv690aIMF1B0z9Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ScSKpRKZ4EJjOhqwq2nysSqIJoXUNjpfDf/fZsvKqpkhN4oX0/RnIteeA9bNqxvIC
	 6KAvY5WlTrSMaCzHkVWkGQJjHdw4kifrIvcNRHSzwHNsCuZGzHqC40BlV2JPraJlbH
	 qSBJCiN4runUQXDz0tCOxQ+mwRQtKLB09y4K3nlbDjUU4XdbWMacqsFXnvSw11+1/d
	 pdTVVA5MxTR1oJIQlzIfEKM2YgG2dDT9TWOgAps/3H5A4eWfzIYD/OQta1rOl3qAZc
	 7HnLU6Wi3TsUncoEgjEXTRCvjz+iQZgbcdlHTlbR49othCyWVi1hdXoh782+AIYIgD
	 zJ0mNvctDdcFQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vINyb-000000008G2-1t5j;
	Mon, 10 Nov 2025 10:14:17 +0100
Date: Mon, 10 Nov 2025 10:14:17 +0100
From: Johan Hovold <johan@kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@kernel.org>,
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
Subject: Re: [PATCH v3 00/14] iommu: fix device leaks
Message-ID: <aRGs6Xu9BvKaHE9N@hovoldconsulting.com>
References: <20251020045318.30690-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020045318.30690-1-johan@kernel.org>

On Mon, Oct 20, 2025 at 06:53:04AM +0200, Johan Hovold wrote:
> This series fixes device leaks in the iommu drivers, which pretty
> consistently failed to drop the reference taken by
> of_find_device_by_node() when looking up iommu platform devices.
> 
> Included are also a couple of related cleanups.

> Changes in v3
>  - fix mediatek use-after-free on probe deferral
>  - add acks and reviewed-bys from Marek, Yong and Thierry
> 
> Changes in v2
>  - drop omap reference sooner; remove unused pointer
>   - amend exynos commit message with reference to partial fix
>    - amend tegra commit message with reference to partial fix
>     - add Robin's ack
> 
> 
> Johan Hovold (14):
>   iommu/apple-dart: fix device leak on of_xlate()
>   iommu/qcom: fix device leak on of_xlate()
>   iommu/exynos: fix device leak on of_xlate()
>   iommu/ipmmu-vmsa: fix device leak on of_xlate()
>   iommu/mediatek: fix device leak on of_xlate()
>   iommu/mediatek: fix use-after-free on probe deferral
>   iommu/mediatek: simplify dt parsing error handling
>   iommu/mediatek-v1: fix device leak on probe_device()
>   iommu/mediatek-v1: fix device leaks on probe()
>   iommu/mediatek-v1: add missing larb count sanity check
>   iommu/omap: fix device leaks on probe_device()
>   iommu/omap: simplify probe_device() error handling
>   iommu/sun50i: fix device leak on of_xlate()
>   iommu/tegra: fix device leak on probe_device()

Can these be picked up for 6.19?

Johan
