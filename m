Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573344E61B
	for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1317268BFE; Mon, 11 Dec 2023 18:40:21 +0100 (CET)
Date: Mon, 11 Dec 2023 18:40:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Christoph Hellwig <hch@lst.de>,
	Petr Tesarik <petrtesarik@huaweicloud.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	Wangkefeng <wangkefeng.wang@huawei.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH RESEND] swiotlb: reduce area lock contention for
 non-primary IO TLB pools
Message-ID: <20231211174020.GA28041@lst.de>
References: <20231201121352.195-1-petrtesarik@huaweicloud.com> <20231211140111.5dbb74c0@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231211140111.5dbb74c0@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 11, 2023 at 02:01:11PM +0100, Petr Tesařík wrote:
> Hi Christoph,
> 
> just a friendly ping about the following patch. Does it need more time
> to review, or has it gone lost?

I've just been a bit too busy.  I'll do a run on dma-related things
this week.

