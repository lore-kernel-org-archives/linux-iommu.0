Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA70B2557A
	for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 04:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724300422; cv=none; b=aquZjkio2vxi9KjsqGEd/BNxc3gnnPu4qnubPEzWcJCyatN136F1UCIM96TtccKZ/3Op19Hzowdhjd53K3Td2ff54biYnw651mZrEPlln7Yb8ycTyFsshaa7e3nXE1SkdmmWnr7MZRZ5lT2GnFJOdRATM6JPawsd9F+Umx4SV7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724300422; c=relaxed/simple;
	bh=gXRfD58AoMzuXIUOA858EyC/2La4WaatvnvDUClV6EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOVuc86XtPo3iEV/4JRbb/vukCRULOPv1oLAoJKaxAEaA90zGipu7UynKguj53S1ne20EhRRzL6JQLq5qGmlw9AcdMla+jdwoeuMZfNxSpRgCPlkGkckqvDEafYcltfJ225v+tmMS66u1zrZqKkEjelLGhTQnidiHfvI1LoOHhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DAD4A227A8E; Thu, 22 Aug 2024 06:20:17 +0200 (CEST)
Date: Thu, 22 Aug 2024 06:20:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: Trace dma_map/unmap_page
Message-ID: <20240822042017.GA889@lst.de>
References: <20240812204358.3587730-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812204358.3587730-1-sean.anderson@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 12, 2024 at 04:43:57PM -0400, Sean Anderson wrote:
> When debugging drivers, it can often be useful to trace when memory gets
> (un)mapped for DMA (and can be accessed by the device). Add some
> tracepoints for this purpose. While there are many other interesting DMA
> functions, this is a useful start for simpler drivers.

Just dma_map/unmap_page seems a bit too limited and asymmetric.  Can
you please also add tracing for ->map/unmap_sg and ->map/unmap_resoure
so that we at least cover all the dyanmic DMA mapping interfaces?

