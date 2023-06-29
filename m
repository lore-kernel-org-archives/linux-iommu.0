Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4C91FC8
	for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 05:12:42 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id B451667373; Thu, 29 Jun 2023 07:12:38 +0200 (CEST)
Date: Thu, 29 Jun 2023 07:12:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v1 0/2] swiotlb: Fix a couple of bugs in sizing areas
Message-ID: <20230629051238.GB16654@lst.de>
References: <cover.1687784289.git.petr.tesarik.ext@huawei.com> <20230626160725.5164ca74@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230626160725.5164ca74@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 26, 2023 at 04:07:25PM +0200, Petr Tesařík wrote:
> As an aside (and not directly related to the bugfixes themselves), I
> wonder why the area size cannot be always equal to IO_TLB_SEGSIZE. Of
> course, we would (usually) end up with more areas, but that should be
> a good thing, shouldn't it? The area structure is quite small, so it
> cannot be because of memory consumption concerns. The overhead of
> taking an uncontended spinlock should also be negligible.

What would be the benefit of this?
