Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2565FA23
	for <iommu@lists.linux.dev>; Sun, 16 Apr 2023 06:30:33 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 26E9067373; Sun, 16 Apr 2023 08:30:29 +0200 (CEST)
Date: Sun, 16 Apr 2023 08:30:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, hch@lst.de,
	m.szyprowski@samsung.com, robin.murphy@arm.com
Subject: Re: [RFC PATCH] dma: coherent: respect to device 'dma-coherent'
 property
Message-ID: <20230416063028.GA6276@lst.de>
References: <20230414080307.35114-1-Zhiqiang.Hou@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414080307.35114-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 14, 2023 at 04:03:07PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Currently, the coherent DMA memory is always mapped as writecombine
> and uncached, ignored the 'dma-coherent' property in device node,
> this patch is to map the memory as writeback and cached when the
> device has 'dma-coherent' property.

What is the use case here?  The somewhat misnamed per-device coherent
memory is intended for small per-device pools of sram or such
used for staging memory.
