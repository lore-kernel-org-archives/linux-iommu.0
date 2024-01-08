Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74D753E36
	for <iommu@lists.linux.dev>; Mon,  8 Jan 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C17D68BFE; Mon,  8 Jan 2024 18:06:49 +0100 (CET)
Date: Mon, 8 Jan 2024 18:06:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Peng Zhang <zhangpeng362@huawei.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	petr.tesarik1@huawei-partners.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
	sunnanyong@huawei.com
Subject: Re: [PATCH] swiotlb: check alloc_size before the allocation of a
 new memory pool
Message-ID: <20240108170649.GA11047@lst.de>
References: <20240108140005.3355316-1-zhangpeng362@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108140005.3355316-1-zhangpeng362@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

This looks good, but the surrounding code changed quite a bit in
the dma-mapping code.  Can you redo it against dma-mapping for-next
(which should get merged into Linus' tree ASAP as I already sent the
pull request)
