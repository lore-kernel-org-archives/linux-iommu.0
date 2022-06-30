Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105416D19
	for <iommu@lists.linux.dev>; Thu, 30 Jun 2022 14:31:27 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id AF95368AA6; Thu, 30 Jun 2022 16:31:16 +0200 (CEST)
Date: Thu, 30 Jun 2022 16:31:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ren Zhijie <renzhijie2@huawei.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	mathieu.poirier@linaro.org, mark-pk.tsai@mediatek.com,
	iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dma-mapping: Fix build error unused-value
Message-ID: <20220630143116.GA6198@lst.de>
References: <20220630123528.251181-1-renzhijie2@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630123528.251181-1-renzhijie2@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID: <20220630143116.MTO_7n5hcowZDRpyHLMQ1-AZhoeT1HYyM8c9MqXGgzM@z>

Thanks, this looks good with a minor nit below:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Mathieu, can you pick this up through your tree as that is where the
offending commit was merged through?

> Fixes: e61c451476e6("dma-mapping: Add dma_release_coherent_memory to DMA API")

missing space before the opening brace here.
