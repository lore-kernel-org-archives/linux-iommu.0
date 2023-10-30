Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE327494
	for <iommu@lists.linux.dev>; Mon, 30 Oct 2023 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id 42D546732A; Mon, 30 Oct 2023 14:31:13 +0100 (CET)
Date: Mon, 30 Oct 2023 14:31:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Christoph Hellwig <hch@lst.de>,
	Petr Tesarik <petrtesarik@huaweicloud.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	Wangkefeng <wangkefeng.wang@huawei.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH] swiotlb: check dynamically allocated TLB address
 before decrypting
Message-ID: <20231030133112.GA22143@lst.de>
References: <20231026095123.222-1-petrtesarik@huaweicloud.com> <20231028192414.637bf4fd@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028192414.637bf4fd@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

I'm trying to review it properly this week.  It was defintively too big
to just rush it into 6.6 in the last few days.

