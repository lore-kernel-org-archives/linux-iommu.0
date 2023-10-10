Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D72A1400B
	for <iommu@lists.linux.dev>; Tue, 10 Oct 2023 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id BBE5968B05; Tue, 10 Oct 2023 09:48:16 +0200 (CEST)
Date: Tue, 10 Oct 2023 09:48:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jia He <justin.he@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma-mapping: fix dma_addressing_limited if
 dma_range_map can't cover all system RAM
Message-ID: <20231010074816.GA9082@lst.de>
References: <20231010020835.3678-1-justin.he@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010020835.3678-1-justin.he@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

dma_addressing_limited is called for every dma (direct) map, and this
new code is way to heavy for that.  We'll need to cache the information
somehow.

