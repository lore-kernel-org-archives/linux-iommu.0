Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175887B
	for <iommu@lists.linux.dev>; Sun, 16 Apr 2023 06:26:43 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0A13267373; Sun, 16 Apr 2023 08:26:40 +0200 (CEST)
Date: Sun, 16 Apr 2023 08:26:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Claire Chang <tientzu@chromium.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH] swiotlb: Relocate PageHighMem test away from
 rmem_swiotlb_setup
Message-ID: <20230416062639.GC6195@lst.de>
References: <20230414212926.2336072-1-f.fainelli@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414212926.2336072-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to the dma-mapping for-next tree.
