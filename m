Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D7B6AB9
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3D98568AFE; Mon, 27 Nov 2023 08:14:30 +0100 (CET)
Date: Mon, 27 Nov 2023 08:14:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCH] kernel: dma: let dma use vmalloc area
Message-ID: <20231127071430.GA28214@lst.de>
References: <20231127030930.1074374-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127030930.1074374-1-zhaoyang.huang@unisoc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 27, 2023 at 11:09:30AM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> memremap within dma_init_coherent_memory will map the given phys_addr
> into vmalloc area if the pa is not found during iterating iomem_resources,
> which conflict the rejection of vmalloc area in dma_map_single_attrs.

I can't parse this sentence.

> IMO, it is find to let all valid virtual address be valid for DMA as the
> user will keep corresponding RAM safe for transfer.

No, vmalloc address can't be passed to map_single.  You need to pass
the page to dma_map_page, and explicitly mange cache consistency
using the invalidate_kernel_vmap_range and flush_kernel_vmap_range
helpers.

