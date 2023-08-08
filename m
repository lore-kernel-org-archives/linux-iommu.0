Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A55B14F6D
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 17:36:53 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 86BBE67373; Tue,  8 Aug 2023 19:36:43 +0200 (CEST)
Date: Tue, 8 Aug 2023 19:36:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jianxiong Gao <jxgao@google.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Subject: Re: [PATCH v1] swiotlb: move slot allocation explanation comment
 where it belongs
Message-ID: <20230808173643.GA18873@lst.de>
References: <20230802163034.1410-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802163034.1410-1-petrtesarik@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, applied.

