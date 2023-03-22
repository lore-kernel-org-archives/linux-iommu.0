Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326CC1FB1
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 08:05:25 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id E8B4567373; Wed, 22 Mar 2023 09:05:11 +0100 (CET)
Date: Wed, 22 Mar 2023 09:05:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jianxiong Gao <jxgao@google.com>,
	David Stevens <stevensd@chromium.org>,
	Joerg Roedel <jroedel@suse.de>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz
Subject: Re: [PATCH v1 0/2] swiotlb: Cleanup and alignment fix
Message-ID: <20230322080511.GA21440@lst.de>
References: <cover.1679382779.git.petr.tesarik.ext@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679382779.git.petr.tesarik.ext@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

I've applied this to the for-linus branch with minor cosmetic tweaks.
