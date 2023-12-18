Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38823A1C6
	for <iommu@lists.linux.dev>; Mon, 18 Dec 2023 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 739F02F4;
	Mon, 18 Dec 2023 07:17:15 -0800 (PST)
Received: from [10.57.86.174] (unknown [10.57.86.174])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CF003F5A1;
	Mon, 18 Dec 2023 07:16:29 -0800 (PST)
Message-ID: <d1bd5a14-63ae-42dd-89fb-12291bc3a6f6@arm.com>
Date: Mon, 18 Dec 2023 15:16:28 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dma_sync_sg_for_device/cpu look very inefficient
Content-Language: en-GB
To: Paul Cercueil <paul@crapouillou.net>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Nuno Sa <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, iommu@lists.linux.dev
References: <7166f0da920d494752c89181e6f96688ba8b435e.camel@crapouillou.net>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <7166f0da920d494752c89181e6f96688ba8b435e.camel@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-12-18 12:32 pm, Paul Cercueil wrote:
> Hi,
> 
> I am manipulating DMABUFs created with the udmabuf driver, that are 64
> MiB each, on a ZedBoard (which should have ~512 KiB of L2 cache IIRC).
> 
> When trying to access them with the CPU, dma_sync_sg_for_cpu() is
> called. What ends up happening, is a cache sync for each one of the (up
> to) 16 thousand pages that back up the DMABUF, which obviously takes a
> huge amount of time, tanking performance.
> 
> My guess (probably very naïve) is that if the total length of the SG is
> equal or bigger than the size of the wider non-coherent cache, it would
> be much better to just flush the whole data cache.

In addition to the points already raised, not all architectures have a 
notion of "the whole data cache", so while this is something that 
individual arch implementations could potentially consider, it's not 
necessarily possible (or at least reasonable) to do at the generic DMA 
API level, nor in common implementations like dma-direct or iommu-dma.

Thanks,
Robin.
