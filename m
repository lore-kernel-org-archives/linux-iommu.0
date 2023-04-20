Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57173539D
	for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 09:52:11 +0000 (UTC)
Received: from frapeml500002.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q2Cb10mrTz67LmL;
	Thu, 20 Apr 2023 17:50:53 +0800 (CST)
Received: from [10.81.207.102] (10.81.207.102) by
 frapeml500002.china.huawei.com (7.182.85.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 11:52:01 +0200
Message-ID: <66a67d9e-70ce-9e2c-3b23-2d49447c4f24@huawei.com>
Date: Thu, 20 Apr 2023 11:52:00 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 00/13] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to
 8
To: Catalin Marinas <catalin.marinas@arm.com>, Isaac Manjarres
	<isaacmanjarres@google.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann
	<arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, Marc Zyngier
	<maz@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, Ard Biesheuvel <ardb@kernel.org>, Saravana
 Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>, Daniel
 Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>, Mark Brown
	<broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<linux-mm@kvack.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
 <ZBNiN9CR2F/fvUTh@google.com> <ZEARbKMfMS8KdkhJ@arm.com>
Content-Language: en-US
From: Petr Tesarik <petr.tesarik.ext@huawei.com>
In-Reply-To: <ZEARbKMfMS8KdkhJ@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.207.102]
X-ClientProxiedBy: frapeml500004.china.huawei.com (7.182.85.22) To
 frapeml500002.china.huawei.com (7.182.85.205)
X-CFilter-Loop: Reflected

On 4/19/2023 6:06 PM, Catalin Marinas wrote:
> On Thu, Mar 16, 2023 at 11:38:47AM -0700, Isaac Manjarres wrote:
>[...]>> Given this, I don't think there's anything blocking this series from
>> being merged. The requirement for SWIOTLB to get to the minimum
>> kmalloc alignment down to 8 bytes shouldn't prevent this series from
>> being merged, as the amount of memory that is allocated for SWIOTLB
>> can be configured through the commandline to minimize the impact of
>> having SWIOTLB memory. Additionally, even if no SWIOTLB is present,
>> this series still offers memory savings on a lot of ARM64 platforms
>> by using the cache line size as the minimum alignment for kmalloc.
> 
> Actually, there's some progress on the swiotlb front to allow dynamic
> allocation. I haven't reviewed the series yet (I wasn't aware of it
> until v2) but at a quick look, it limits the dynamic allocation to
> bouncing buffers of at least a page size. Maybe this can be later
> improved for buffers below ARCH_DMA_MINALIGN.

Indeed. My patch allocates dynamic bounce buffers with
dma_direct_alloc_pages() to keep things simple for now, but there is no
real reason against allocating less than a page with another suitable
allocator.

However, I'd be interested what the use case is, so I can assess the
performance impact, which depends on workload, and FYI it may not even
be negative. ;-)

Petr Tesarik

