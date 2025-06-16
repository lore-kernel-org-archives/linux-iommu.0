Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8022D38FB0;
	Mon, 16 Jun 2025 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079991; cv=none; b=dKMEko1GA0iOBMURuemc6z5KbPOUq20Dw3zsrW4AVH+Of0lJKkaifBi8LDeKH9G2m365PhjyGeGWkPhe9bs3q0VAGgJeut6blEkbV+Qd1Ztay3ior3/Lyt6r9NJ9Lm0M/YI5cHFka2wcnUjDoQU14kLQuRi3orgTn+ZurrbmKks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079991; c=relaxed/simple;
	bh=j83uEkut/IUacfVpKQoQfNEnac5UYtvjf4AmXzaWfRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duBxJU2xfpMKi7hdEVOnVKSkPoeUDEHS4zQ5pWTGAqtQnyBHLJbBdpqboOZfFtMZw7j5M8Q3dYfm8g7aiRPZtEZYAN6BzQd+OP+9ngmcquR7M9H+rrmKFIz9IZ7Jxtj8tM7SYoqWeV5ArB5B39m9E446PvYfajGlObRiNkROTIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B8C2467373; Mon, 16 Jun 2025 15:19:44 +0200 (CEST)
Date: Mon, 16 Jun 2025 15:19:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: James Clark <james.clark@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Mark Brown <broonie@kernel.org>,
	olteanv@gmail.com, oe-kbuild-all@lists.linux.dev, arnd@arndb.de,
	larisa.grigore@nxp.com, Frank.li@nxp.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
Message-ID: <20250616131944.GA30260@lst.de>
References: <20250616111749.316413-1-james.clark@linaro.org> <20250616112927.GA21689@lst.de> <5f1ca0ac-b66c-4b92-8f69-027c2468b117@sirena.org.uk> <20250616120832.GA24959@lst.de> <2d62254e-5cbe-4174-95d8-e80cae4f4543@sirena.org.uk> <20250616121444.GA25443@lst.de> <7cfcf919-3c7d-4f0c-911f-697ea3141080@linaro.org> <20250616131346.GB29838@lst.de> <83855c1a-c128-4762-9d6b-e17f2c4c8820@linaro.org> <d16bdc40-20d6-49db-bf41-18bb9b8e01fd@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d16bdc40-20d6-49db-bf41-18bb9b8e01fd@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 16, 2025 at 02:15:56PM +0100, James Clark wrote:
>> Yes it does, it has a few modes that don't require it. Presumably we can't 
>> just add a depends into the kconfig for all devices because they might not 
>> be using DMA.
>
> *for all the different variants of spi-fsl-dpsi devices I mean

This is drivers/spi/spi-fsl-dspi.c?

Yes, looks like it is one of those rare devices supporting a DMA and
non-DMA mode.  But everything seems nicely guarded off using
"dspi->devtype_data->trans_mode == DSPI_DMA_MODE" checks there.  So
wrap them into a little helper using IS_ENABLED(CONFIG_HAS_DMA) and
everything should be sorted out.
