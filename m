Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E929D19A
	for <iommu@lists.linux.dev>; Fri, 23 Dec 2022 14:39:42 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id ACF4E68AA6; Fri, 23 Dec 2022 15:39:38 +0100 (CET)
Date: Fri, 23 Dec 2022 15:39:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Igor Klochko <igor.klochko@gmail.com>
Cc: hch@lst.de, iommu@lists.linux.dev, robin.murphy@arm.com,
	m.szyprowski@samsung.com
Subject: Re: [PATCH] arch/arm/mm/dma-mapping.c: fix __alloc_from_pool
 returning a dirty buffer
Message-ID: <20221223143938.GA29147@lst.de>
References: <14dccd8c-e29a-fe93-5d4c-f0c3ff4f2430@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14dccd8c-e29a-fe93-5d4c-f0c3ff4f2430@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 23, 2022 at 03:15:47PM +0100, Igor Klochko wrote:
> 
> Hi, 
> 
> A small patch for __alloc_from_pool to clean the buffer before returning.

This does look correct.  The "normal" allocators seems to do the
memset through __dma_clear_buffer, but the __alloc_from_pool seems to be
missing it.  Please write a proper changelog with a signoff, and
preferably a Fixes tag if you can find what introduced this.  Also
the ARM code needs to go to the ARM maintainer and arm mailing list.
