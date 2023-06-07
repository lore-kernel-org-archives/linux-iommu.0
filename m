Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059088839
	for <iommu@lists.linux.dev>; Wed,  7 Jun 2023 13:07:37 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id BC4C368BEB; Wed,  7 Jun 2023 15:07:34 +0200 (CEST)
Date: Wed, 7 Jun 2023 15:07:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, petr@tesarici.cz
Subject: Re: [PATCH v1 1/1] swiotlb: use the atomic counter of total used
 slabs if available
Message-ID: <20230607130734.GB19066@lst.de>
References: <20230607090418.653-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607090418.653-1-petrtesarik@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to for-next.
