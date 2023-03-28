Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11F07E6
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 01:36:27 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 742D468AA6; Tue, 28 Mar 2023 03:36:23 +0200 (CEST)
Date: Tue, 28 Mar 2023 03:36:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	roberto.sassu@huaweicloud.com
Subject: Re: [PATCH] dma-direct: cleanup parameters to
 dma_direct_optimal_gfp_mask
Message-ID: <20230328013623.GA22651@lst.de>
References: <20230220150622.454-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220150622.454-1-petrtesarik@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to the dma-mapping for-next tree.
