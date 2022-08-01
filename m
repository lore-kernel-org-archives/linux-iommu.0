Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8457F
	for <iommu@lists.linux.dev>; Mon,  1 Aug 2022 17:57:55 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 27E2768AA6; Mon,  1 Aug 2022 19:57:45 +0200 (CEST)
Date: Mon, 1 Aug 2022 19:57:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: yf.wang@mediatek.com
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
	wsd_upstream@mediatek.com, Libo Kang <Libo.Kang@mediatek.com>,
	Ning Li <Ning.Li@mediatek.com>, Yong Wu <Yong.Wu@mediatek.com>,
	Miles Chen <miles.chen@mediatek.com>,
	jianjiao zeng <jianjiao.zeng@mediatek.com>
Subject: Re: [PATCH] dma-debug: Fix overflow issue in bucket_find_contain
Message-ID: <20220801175744.GA17256@lst.de>
References: <20220730114146.32669-1-yf.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730114146.32669-1-yf.wang@mediatek.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	unsigned int shift = (1 << HASH_FN_SHIFT);

Please just add a constant for that right nxt to the HASH_FN_SHIFT
definition.
