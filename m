Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD8F1A585
	for <iommu@lists.linux.dev>; Tue, 19 Dec 2023 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 13F2968C4E; Tue, 19 Dec 2023 14:46:38 +0100 (CET)
Date: Tue, 19 Dec 2023 14:46:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: hch@lst.de, m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-debug: make dma_debug_add_bus take a const pointer
Message-ID: <20231219134637.GA28824@lst.de>
References: <2023121941-dejected-nugget-681e@gregkh>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023121941-dejected-nugget-681e@gregkh>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 19, 2023 at 02:41:42PM +0100, Greg Kroah-Hartman wrote:
> The driver core now can handle a const struct bus_type pointer, and the
> dma_debug_add_bus() call just passes on the pointer give to it to the
> driver core, so make this pointer const as well to allow everyone to use
> read-only struct bus_type pointers going forward.

This looks good to me.  Do you want me to queue it up or take it with
the other constification patches?

