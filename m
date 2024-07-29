Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1172F5A
	for <iommu@lists.linux.dev>; Mon, 29 Jul 2024 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273326; cv=none; b=VsAfSxuOXszloUEysoFWZBp0tFZCzW6ONmMMS1yzZ8OnFjlljwVeDVRcDo8CnR1iW5oGYYbQ0TJ1q5TthtkRCsXUJ4218ZhDuBMYT5AuTM5bTnlvZrL4wdwPiLgbAtxHypPsR8VW94BMyIUGvFx7P2j2xqkAWy9d88qdNvJPpiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273326; c=relaxed/simple;
	bh=I/Pf0qhphQz3a8Uxwsw3bLotpIYhF1Ti6zwoGHtMV2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDhGlA+Ttzz+GrApM2BF6Ym5joc/0RuC9CH6PZY4sR3v7az4Xkku8BalNeJNa47pGOD50X3pCwRAPdRjBc5dBbj/Mfd5TwzqSbspJKvuZfi9B1yLC95G6XA2Y1mmBEc4tI5Oyh6OxbZscsn24hkweRvE4lZnLlUhTMgS41xMoH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 594FB68B05; Mon, 29 Jul 2024 19:15:19 +0200 (CEST)
Date: Mon, 29 Jul 2024 19:15:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mostafa Saleh <smostafa@google.com>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 2/2] dma: add IOMMU static calls with clear default
 ops
Message-ID: <20240729171518.GB31388@lst.de>
References: <cover.1721219730.git.leon@kernel.org> <dd34bf3ecef252b4910d70aa21ff5273b5e8b19b.1721219730.git.leon@kernel.org> <ZqeN6MP4o2JNLcUz@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqeN6MP4o2JNLcUz@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 29, 2024 at 12:41:12PM +0000, Mostafa Saleh wrote:
> Just out of curiosity, is there any observed improvement from that?
> As from my experience the DMA-IOMMU path is quite dense so it won't
> be senstive to such micro-optimizations.

We are trying to gradually fix this.   Part of that is adding not even
more indirect calls for the next generation map API.  But another totally
unrelated part is that we can compile out the dma ops entirely for
common configs, which I really want because people are badly abusing it.

