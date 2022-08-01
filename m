Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82847F
	for <iommu@lists.linux.dev>; Mon,  1 Aug 2022 18:01:51 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4406D68AFE; Mon,  1 Aug 2022 20:01:47 +0200 (CEST)
Date: Mon, 1 Aug 2022 20:01:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: yf.wang@mediatek.com, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
	wsd_upstream@mediatek.com, Libo Kang <Libo.Kang@mediatek.com>,
	Ning Li <Ning.Li@mediatek.com>, Yong Wu <Yong.Wu@mediatek.com>,
	Miles Chen <miles.chen@mediatek.com>
Subject: Re: [PATCH] dma-debug: Remove warning in dma_debug_entry
Message-ID: <20220801180146.GB17256@lst.de>
References: <20220730085657.31977-1-yf.wang@mediatek.com> <19a0a508-fb39-8b06-ce0f-ce26767ef57f@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19a0a508-fb39-8b06-ce0f-ce26767ef57f@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 01, 2022 at 01:07:10PM +0100, Robin Murphy wrote:
> Furthermore, even for the valid dma-buf import case I'm not convinced that 
> the SKIP_CPU_SYNC check can be dropped either. If one device can import a 
> buffer while another device is already accessing it, there are definitely 
> combinations of parameters which could lead to potential data loss (e.g. a 
> non-coherent DMA_TO_DEVICE mapping during a non-coherent DMA_FROM_DEVICE 
> access, a or non-coherent DMA_FROM_DEVICE mapping during a coherent 
> DMA_TO_DEVICE access).

Yes.  While there is a rare case where double mapping actually works
(exactly the same region, no access to the data between the invidual
mapping and unmapping calls), there is absolutely no good reason to
support it.  The additional cache maintainance operations will still
take some overhead that can be skipped, and it makes the rules very
confusing.  It is much better to fix the upper layers to use
the SKIP_CPU_SYNC flag in case of multiple mappings, which also
clearly documents what is being done there.
