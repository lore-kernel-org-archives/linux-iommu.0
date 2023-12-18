Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF61D14B
	for <iommu@lists.linux.dev>; Mon, 18 Dec 2023 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B00768AFE; Mon, 18 Dec 2023 15:30:05 +0100 (CET)
Date: Mon, 18 Dec 2023 15:30:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	iommu@lists.linux.dev
Subject: Re: dma_sync_sg_for_device/cpu look very inefficient
Message-ID: <20231218143003.GA15735@lst.de>
References: <7166f0da920d494752c89181e6f96688ba8b435e.camel@crapouillou.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7166f0da920d494752c89181e6f96688ba8b435e.camel@crapouillou.net>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 18, 2023 at 01:32:59PM +0100, Paul Cercueil wrote:
> I am manipulating DMABUFs created with the udmabuf driver, that are 64
> MiB each, on a ZedBoard (which should have ~512 KiB of L2 cache IIRC).
> 
> When trying to access them with the CPU, dma_sync_sg_for_cpu() is
> called. What ends up happening, is a cache sync for each one of the (up
> to) 16 thousand pages that back up the DMABUF, which obviously takes a
> huge amount of time, tanking performance.
> 
> My guess (probably very naïve) is that if the total length of the SG is
> equal or bigger than the size of the wider non-coherent cache, it would
> be much better to just flush the whole data cache.

IFF we regularly ѕync huge amount of data a complete flush is probably
going to be more efficient.  But why are we doing that to start with?
Ownership needs to transfer when the data is accessed, and when you
regularly access 16.000 pages you're probably got other performance
problems to start with.
