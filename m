Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9E3646
	for <iommu@lists.linux.dev>; Sun, 21 Aug 2022 10:44:20 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id B819267373; Sun, 21 Aug 2022 12:44:16 +0200 (CEST)
Date: Sun, 21 Aug 2022 12:44:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michal Hocko <mhocko@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dma-pool: limit DMA and DMA32 zone size pools
Message-ID: <20220821104416.GC30530@lst.de>
References: <20220817060647.1032426-1-hch@lst.de> <20220817060647.1032426-4-hch@lst.de> <Yvzk2wE7ta+zSZOQ@dhcp22.suse.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvzk2wE7ta+zSZOQ@dhcp22.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 17, 2022 at 02:53:47PM +0200, Michal Hocko wrote:
> Yes this is much more reasonable estimation. Especially for the DMA
> zone. I still believe some downscaling would make sense but as said
> earlier nothing to really insist on. Also you likely want to have
> pr_warn for non-poppulated DMA zone as pointed in other thread[1].

So I think the warning would be useful, but how do we detect that the
zone should exist and is empty vs the case where it doesn't even
exist based on a runtime decision?
