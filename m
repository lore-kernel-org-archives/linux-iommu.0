Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2A646
	for <iommu@lists.linux.dev>; Sun, 21 Aug 2022 10:43:25 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5B49B67373; Sun, 21 Aug 2022 12:43:21 +0200 (CEST)
Date: Sun, 21 Aug 2022 12:43:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dma-pool: limit DMA and DMA32 zone size pools
Message-ID: <20220821104321.GB30530@lst.de>
References: <20220817060647.1032426-1-hch@lst.de> <20220817060647.1032426-4-hch@lst.de> <04790bd9-4f20-4d51-b988-ad4b44eeee98@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04790bd9-4f20-4d51-b988-ad4b44eeee98@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 17, 2022 at 01:50:09PM +0100, Robin Murphy wrote:
>>   +#if defined(CONFIG_ZONE_DMA) || defined(CONFIG_ZONE_DMA32)
>
> This #ifdeffery seems horribly clunky - I think it would be much nicer to 
> mark this __maybe_unused, and preserve the has_managed_dma/IS_ENABLED logic 
> below.

>>   static int __init dma_atomic_pool_init(void)
>>   {
>> +	unsigned long nr_zone_dma_pages, nr_zone_dma32_pages;
>
> ...otherwise, I expect the buildbots will be along shortly with unused 
> variable warnings for these :)

Amazingly they haven't complained yet, even if they should.  But
simple IS_ENABLED won't work either as the ZONE_DMA / ZONE_DMA32
constants are not defined unless the corresponding config options
are set.  I'll see what I can do here using helpers.
