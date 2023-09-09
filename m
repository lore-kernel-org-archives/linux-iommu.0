Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57A110E1
	for <iommu@lists.linux.dev>; Sat,  9 Sep 2023 08:40:55 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4236868B05; Sat,  9 Sep 2023 10:40:45 +0200 (CEST)
Date: Sat, 9 Sep 2023 10:40:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
	robin.murphy@arm.com, petr.tesarik.ext@huawei.com,
	iommu@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] swiotlb: add the missing dynamic swiotlb check in
 is_swiotlb_buffer
Message-ID: <20230909084045.GA10357@lst.de>
References: <20230905064441.127588-1-hch@lst.de> <20230908144418.3f078dea@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230908144418.3f078dea@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Sep 08, 2023 at 02:44:18PM +0200, Petr Tesařík wrote:
> 
> Not quite. This code is not SMP safe. I believe that:
> 
> 1. the value must be read with a READ_ONCE(),
> 2. the memory barrier must precede the read operation.
> 
> Do you want to send a v2, or should I send my version instead?

As I'm travelling right now I'd love you to take care of it.  It's
probably a new thing and not a v2 so feel free to take full credit.

