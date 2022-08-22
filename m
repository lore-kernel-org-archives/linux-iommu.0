Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A9B7FA
	for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 11:14:57 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6BCEF68AA6; Mon, 22 Aug 2022 13:14:47 +0200 (CEST)
Date: Mon, 22 Aug 2022 13:14:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michal Hocko <mhocko@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dma-pool: limit DMA and DMA32 zone size pools
Message-ID: <20220822111447.GA8935@lst.de>
References: <20220817060647.1032426-1-hch@lst.de> <20220817060647.1032426-4-hch@lst.de> <Yvzk2wE7ta+zSZOQ@dhcp22.suse.cz> <20220821104416.GC30530@lst.de> <YwNBHbYXpatJHD0K@dhcp22.suse.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwNBHbYXpatJHD0K@dhcp22.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 22, 2022 at 10:41:01AM +0200, Michal Hocko wrote:
> ZONE_DMA existance is not runtime controlable (at least on x86).

This is more about ZONE_DMA32 that can disappear if all memory is
inside ZONE_DMA.  That is highly unusual (but still possible) with a
tiny x86-style ZONE_DMA, but can happen with a larger one other
architectures.
