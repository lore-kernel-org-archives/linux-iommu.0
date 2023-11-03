Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B65C187D
	for <iommu@lists.linux.dev>; Fri,  3 Nov 2023 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6825F68AA6; Fri,  3 Nov 2023 09:35:35 +0100 (CET)
Date: Fri, 3 Nov 2023 09:35:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>, patchwork@huawei.com,
	Wangkefeng <wangkefeng.wang@huawei.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz,
	miaoxie@huawei.com, weiyongjun1@huawei.com, guohanjun@huawei.com,
	huawei.libin@huawei.com, yuehaibing@huawei.com,
	johnny.chenyi@huawei.com, leijitang@huawei.com, ming.fu@huawei.com,
	zhujianwei7@huawei.com, linuxarm@huawei.com, stable@vger.kernel.org,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v2 1/1] swiotlb: do not free decrypted pages if dynamic
Message-ID: <20231103083535.GA17432@lst.de>
References: <20231102071821.431-1-petrtesarik@huaweicloud.com> <20231102071821.431-2-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102071821.431-2-petrtesarik@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, applied.
