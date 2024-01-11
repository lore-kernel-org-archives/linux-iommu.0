Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE4F101CF
	for <iommu@lists.linux.dev>; Thu, 11 Jan 2024 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F67668CFE; Thu, 11 Jan 2024 09:35:10 +0100 (CET)
Date: Thu, 11 Jan 2024 09:35:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Peng Zhang <zhangpeng362@huawei.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	petr.tesarik1@huawei-partners.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
	sunnanyong@huawei.com
Subject: Re: [PATCH v2] swiotlb: check alloc_size before the allocation of
 a new memory pool
Message-ID: <20240111083510.GA13211@lst.de>
References: <20240109024547.3541529-1-zhangpeng362@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109024547.3541529-1-zhangpeng362@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, applied.
