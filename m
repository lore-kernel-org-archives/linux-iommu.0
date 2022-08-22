Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231127FA
	for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 12:28:03 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id DDAB568C7B; Mon, 22 Aug 2022 14:27:59 +0200 (CEST)
Date: Mon, 22 Aug 2022 14:27:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michal Hocko <mhocko@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dma-pool: limit DMA and DMA32 zone size pools
Message-ID: <20220822122759.GA14932@lst.de>
References: <20220817060647.1032426-1-hch@lst.de> <20220817060647.1032426-4-hch@lst.de> <Yvzk2wE7ta+zSZOQ@dhcp22.suse.cz> <20220821104416.GC30530@lst.de> <YwNBHbYXpatJHD0K@dhcp22.suse.cz> <20220822111447.GA8935@lst.de> <YwNx6Q+FSwpKUOQ2@dhcp22.suse.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwNx6Q+FSwpKUOQ2@dhcp22.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 22, 2022 at 02:09:13PM +0200, Michal Hocko wrote:
> OK, so you are worried about configurations that lack ZONE_DMA32 because
> that memory range is covered by ZONE_DMA? I thought though simply do not
> have CONFIG_ZONE_DMA32. Or am I wrong here?

Zones can disappear when they are empty.  Normally that affects
ZONE_NORMAL and ZONE_HIGHMEM, but it can also happen to ZONE_DMA32
when there is not enough memory.
