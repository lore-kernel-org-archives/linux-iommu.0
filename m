Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC55285C8B;
	Mon, 16 Jun 2025 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750076091; cv=none; b=ado4n/kqRAinDLPUqVxoznQ7OqsuNoOVNlit7Vy4qhkCzL/tw1TqbmgLnXp9W6z1HE0LBJIHeJ0Cra9tl/7b+P01EdPq9pW52FoPn3tBQvK+cJ19zYHNQJRPq9c9LyS8ww4ilNHBd8ppBeX2OLKWloYxcy35yA9BLBJ56l7kTfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750076091; c=relaxed/simple;
	bh=ObbMHiVu4WRzSoOOo12RQA89uLQ+gUKdW/UONw0MTqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrImtKaAm+JxBp45lBsFcfy07oHEiFLCeOt2vFs45JGP8Lv5a4Q+Gq0GyToOeO61eWi2GtDxDztAFlXgzSRVgN2mdwyLOspO/+8+0Ea/zvAaQQV+tn6RXxC7OW4n4fpJikdFz0EgOxDtfz1LmVJiYStAewFjiG+y869zkpbB1qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B042568D05; Mon, 16 Jun 2025 14:14:44 +0200 (CEST)
Date: Mon, 16 Jun 2025 14:14:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mark Brown <broonie@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, James Clark <james.clark@linaro.org>,
	olteanv@gmail.com, oe-kbuild-all@lists.linux.dev, arnd@arndb.de,
	larisa.grigore@nxp.com, Frank.li@nxp.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
Message-ID: <20250616121444.GA25443@lst.de>
References: <202506160036.t9VDxF6p-lkp@intel.com> <20250616111749.316413-1-james.clark@linaro.org> <20250616112927.GA21689@lst.de> <5f1ca0ac-b66c-4b92-8f69-027c2468b117@sirena.org.uk> <20250616120832.GA24959@lst.de> <2d62254e-5cbe-4174-95d8-e80cae4f4543@sirena.org.uk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d62254e-5cbe-4174-95d8-e80cae4f4543@sirena.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 16, 2025 at 01:11:49PM +0100, Mark Brown wrote:
> already tied to a platform that needs DMA needing to add the dependency
> which nobody is going to notice without doing build testing for
> randconfigs or similar non-useful configs - it's not a productive use of
> time.

Stop your unproductive whining and just fix your dependencies.
