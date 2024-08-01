Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4911513D520
	for <iommu@lists.linux.dev>; Thu,  1 Aug 2024 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519241; cv=none; b=a6OiTgnEiW88YoXrHJvaHMHEGihov/wSNWdfYcL52LVrSkyWeftfcs4zps3OrYIYyZUVqEdMmHllB0XUkXlNjFOhShpBazVAl+Qpe/4Gdnpbbg0DQoQfs9tflkkSaL4bO1QiuUk1zFcTGJgBq5wI1USOEDzGaNU6D1PQbNPqEF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519241; c=relaxed/simple;
	bh=Gy2xjS18iAkuVybjbqW5d0pU1TCukawNQV3tJdkSI6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwaTHuPqePl9Y3ES6bsTofOsFJeAUYr/L7cfx2Hv87FA2nxZC4oMyE+YlmvkZkOJ13gWwxzFNfSQ4faj8sbZgnjN94J/S54W9IfDjUAbU5NmT3RuSjDOHu8KTKj+LlRVs56N1NDEtkNQxbRetK5aNAJAaJ/V8IbBp4DFxZFrtGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BDEB368D0A; Thu,  1 Aug 2024 15:33:53 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:33:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dma-mapping: don't return errors from
 dma_set_seg_boundary
Message-ID: <20240801133353.GA1846@lst.de>
References: <20240723000604.241443-1-hch@lst.de> <CGME20240723000611eucas1p10986fd51e848a1ee948e71608c26192b@eucas1p1.samsung.com> <20240723000604.241443-3-hch@lst.de> <5895603b-945f-4b05-991c-76b590094354@samsung.com> <d54f486d-36ae-4668-b314-27137bc4d832@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d54f486d-36ae-4668-b314-27137bc4d832@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Aug 01, 2024 at 01:36:01PM +0100, Robin Murphy wrote:
> I guess I assumed that the old block layer bodges in this area had been 
> cleaned up already - perhaps it *is* high time for whatever's left to grow 
> a proper understanding of whether a block device actually does its own DMA 
> or not.

Can you point to a discussion on that?  The concepts here don't make
quite sense to me.

