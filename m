Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCFA1DDD4
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 12:13:45 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9B3D068AA6; Wed, 13 Sep 2023 14:13:35 +0200 (CEST)
Date: Wed, 13 Sep 2023 14:13:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik.ext@huawei.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH] swiotlb: Use the calculated number of areas
Message-ID: <20230913121335.GA4544@lst.de>
References: <20230911103251.572558-1-ross.lagerwall@citrix.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911103251.572558-1-ross.lagerwall@citrix.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, applied.

