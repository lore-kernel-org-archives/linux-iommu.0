Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BFA946B
	for <iommu@lists.linux.dev>; Tue, 10 Oct 2023 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A606D1FB;
	Tue, 10 Oct 2023 02:41:27 -0700 (PDT)
Received: from [10.57.69.45] (unknown [10.57.69.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19A553F762;
	Tue, 10 Oct 2023 02:40:45 -0700 (PDT)
Message-ID: <39d5aabd-4c09-4135-a3d7-00f6da7a1684@arm.com>
Date: Tue, 10 Oct 2023 10:40:44 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-mapping: fix dma_addressing_limited if
 dma_range_map can't cover all system RAM
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, Jia He <justin.he@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231010020835.3678-1-justin.he@arm.com>
 <20231010074816.GA9082@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231010074816.GA9082@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-10-10 08:48, Christoph Hellwig wrote:
> dma_addressing_limited is called for every dma (direct) map, and this
> new code is way to heavy for that.  We'll need to cache the information
> somehow.

But is it? That was my instinctive reaction as well, but AFAICS it is 
only actually used by drivers in setup paths, either directly or via 
dma_max_mapping_size(). The dma_capable() check which we *do* use for 
every actual mapping still just checks whether the given physical 
address exists in the range map. I believe the underlying problem here 
is when dma_capable() say the mapping needs bouncing, but then it's too 
big for that to succeed, since dma_max_mapping_size() gave the wrong 
answer to start with.

Thanks,
Robin.
