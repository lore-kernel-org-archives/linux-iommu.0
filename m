Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698B7BA30
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8A9206732D; Mon,  6 Nov 2023 08:36:56 +0100 (CET)
Date: Mon, 6 Nov 2023 08:36:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jia He <justin.he@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH v4 0/2] fix dma_addressing_limited() if dma_range_map
Message-ID: <20231106073656.GA17712@lst.de>
References: <20231028102059.66891-1-justin.he@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028102059.66891-1-justin.he@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

this looks good to me, and I've applied this with two tweaks to the
dma-apping tree.
