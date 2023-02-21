Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0DE4C60
	for <iommu@lists.linux.dev>; Tue, 21 Feb 2023 14:17:02 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9AA4168AFE; Tue, 21 Feb 2023 15:16:52 +0100 (CET)
Date: Tue, 21 Feb 2023 15:16:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: patchwork@huawei.com, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>, roberto.sassu@huawei.com
Subject: Re: [PATCH] swiotlb: remove unnecessary function
 swiotlb_max_segment()
Message-ID: <20230221141652.GA28922@lst.de>
References: <20230221140609.386-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221140609.386-1-petrtesarik@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

I've got an equivalent patch already queue up in dma-mapping-for-next.
