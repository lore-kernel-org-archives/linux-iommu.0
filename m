Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAD933FE
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 05:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731563017; cv=none; b=KOq7u+3lpD9MF5FjYU1IR/d3HFXKrybDXo4+ahMQ6pgHKGEKHatV6Kf8xaktTwxz4q+WlDXSIrfgkQXv8hRsjdhc+w+1QLENJOdv+4VWIrwo6I3RWPoroCS+ZeH5L3Ai8gvFT2ArAW5Fom/ioqOAF5uYD3hP67RFJfp4mkwPgSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731563017; c=relaxed/simple;
	bh=a2lkZ9j+uMNMCTPC6Tte/JNlAXvP65iDwlzc/dyXrjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toPMXM9/SsLCguoyPhAdfW8A8xBcu1GDSVNX/Q1mhCjZ7FB3BW85RVv0Usluv+iHTI24UbpSALzziLqe8h1D8dYlpB5IKOgSV4LfvqbUjF8QGZ1Ts/RdCCheaVXdOl3VxpeDjFPZjCGL05k1pUElj+/Nxxs3eTJOODq4SbTdM5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8DB1268C7B; Thu, 14 Nov 2024 06:43:31 +0100 (CET)
Date: Thu, 14 Nov 2024 06:43:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Oreoluwa Babatunde <quic_obabatun@quicinc.com>,
	Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: Save base/size instead of pointer to
 shared DMA pool
Message-ID: <20241114054331.GA10817@lst.de>
References: <f8cef6845a6141f0277e31a71fe153612daae776.1731436631.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8cef6845a6141f0277e31a71fe153612daae776.1731436631.git.geert+renesas@glider.be>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks Geert,

I've applied the patch to the dma-mapping for-next tree.

