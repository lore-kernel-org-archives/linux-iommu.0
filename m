Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E875688
	for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 12:52:09 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id BA5AB68AFE; Thu, 20 Apr 2023 14:51:58 +0200 (CEST)
Date: Thu, 20 Apr 2023 14:51:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz
Subject: Re: [PATCH v1 1/1] swiotlb: Omit total_used and used_hiwater if
 !CONFIG_DEBUG_FS
Message-ID: <20230420125158.GA1226@lst.de>
References: <cover.1681984708.git.petr.tesarik.ext@huawei.com> <f7bac7c24c00b0fde0505759af4cd200e7e62740.1681984708.git.petr.tesarik.ext@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7bac7c24c00b0fde0505759af4cd200e7e62740.1681984708.git.petr.tesarik.ext@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied.
