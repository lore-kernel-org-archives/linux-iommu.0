Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F9763CC
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4D49C67373; Mon, 27 Nov 2023 10:32:10 +0100 (CET)
Date: Mon, 27 Nov 2023 10:32:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Subject: Re: [PATCH] kernel: dma: let dma use vmalloc area
Message-ID: <20231127093210.GA3662@lst.de>
References: <20231127030930.1074374-1-zhaoyang.huang@unisoc.com> <20231127071430.GA28214@lst.de> <CAGWkznFf5hdFRomLXDzoxEKVgiKY--DFbHjRLAMvgvodA01EFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznFf5hdFRomLXDzoxEKVgiKY--DFbHjRLAMvgvodA01EFw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 27, 2023 at 04:56:45PM +0800, Zhaoyang Huang wrote:
> Sorry for the confusion, please find below codes for more information.
> dma_init_coherent_memory
>     memremap
>         addr = ioremap_wt(offset, size);
> What I mean is addr is a vmalloc address, which is implicitly mapped
> by dma's framework and not be aware of to the driver.

Yes.  And it is only returned from dma_alloc_coherent, which should
never be passed to dma_map_<anything>.

> Please correct me if I am wrong. According to my understanding, cache
> consistency could be solved inside dma_map_page via either
> dma_direct_map_page(swio/arch_sync_dma_for_device) or ops->map_page.
> The original thought of rejecting vmalloc is that this pa is not safe
> as this mapping could go in any time. What I am suggesting is to let
> this kind of va be enrolled.

But that only works for the direct mapping.  It does not work for the
additional aliases created by vmap/ioremap/memremap.  Now that only
matters if the cache is virtually indexed, which is rather unusual
these days.
