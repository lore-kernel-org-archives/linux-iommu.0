Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84815236
	for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id B15A668BFE; Mon, 23 Oct 2023 08:04:00 +0200 (CEST)
Date: Mon, 23 Oct 2023 08:03:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Yan Zhao <yan.y.zhao@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] swiotlb: Rewrite comment explaining why the source
 is preserved on DMA_FROM_DEVICE
Message-ID: <20231023060359.GA11876@lst.de>
References: <20231020154215.2191840-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020154215.2191840-1-seanjc@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to the dma-mapping tree for Linux 6.7.
