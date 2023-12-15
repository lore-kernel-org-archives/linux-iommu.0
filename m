Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B47250E5
	for <iommu@lists.linux.dev>; Fri, 15 Dec 2023 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4AF4D68B05; Fri, 15 Dec 2023 12:30:30 +0100 (CET)
Date: Fri, 15 Dec 2023 12:30:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	Wangkefeng <wangkefeng.wang@huawei.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH RESEND] swiotlb: reduce area lock contention for
 non-primary IO TLB pools
Message-ID: <20231215113029.GB6479@lst.de>
References: <20231201121352.195-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201121352.195-1-petrtesarik@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to dma-mapping for-next.

