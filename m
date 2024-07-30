Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254D91A2C17
	for <iommu@lists.linux.dev>; Tue, 30 Jul 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352860; cv=none; b=Pbamtvjb2brUTbU0mIiVuss+bRGY1ZHzyUjgRMSoRDpNXWfJ22Zl/pkK/jyWqbKlcIdaqSU2MiGsMY8XjlJRvyjP0XW3eejKhhAtNU0R+hnS22fRTLmk1Ef6bN0Re+clKGHV91vEStyI7Jtoch22hsHUf8khSfiCLLHiPfWZI7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352860; c=relaxed/simple;
	bh=9MsjqnlwB4iMO5J+x2L6EN/c2RJ8lh9zMSIEx75B6OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDALVkU6SN96+YzATSZ637XIiwc8iO2jPKnW++EZq9GkER0BCVj0khuj7JgpFDGNOEi8JX8LQl42PT3yimvAT5Opm65rkq7O04rpWnezZAaM16tkeWR8RIWoZmL9zlg+UsxZwjZURwTDrY3bw+7/KBAJH13dFTTOSdcj4RZQH3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 524AE68AA6; Tue, 30 Jul 2024 17:20:48 +0200 (CEST)
Date: Tue, 30 Jul 2024 17:20:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: remove the dma_set_{max_seg_size,seg_boundary,min_align_mask}
 return value
Message-ID: <20240730152047.GA29765@lst.de>
References: <20240723000604.241443-1-hch@lst.de> <a86ca03d-13ab-4304-879d-ac4cbacabfa5@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a86ca03d-13ab-4304-879d-ac4cbacabfa5@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

I've picked up the first two and plan to send it to Linus before -rc2.
For dma_set_max_seg_size I got a bit of cold feet and plan to send it
out again with patches for ever driver touched and queue it up for
6.12 after -rc2.

