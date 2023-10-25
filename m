Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACBF29D05
	for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id 05CA968AFE; Wed, 25 Oct 2023 16:27:15 +0200 (CEST)
Date: Wed, 25 Oct 2023 16:27:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	Wangkefeng <wangkefeng.wang@huawei.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz,
	Ben Greear <greearb@candelatech.com>
Subject: Re: [PATCH] swiotlb: Do not try to allocate a TLB bigger than
 MAX_ORDER pages
Message-ID: <20231025142714.GA19315@lst.de>
References: <20231025084426.2739-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025084426.2739-1-petrtesarik@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to the dma-mapping tree for Linux 6.6.
