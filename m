Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03357C
	for <iommu@lists.linux.dev>; Thu, 18 Aug 2022 08:37:57 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VMZx3Mr_1660811864;
Received: from 30.178.80.93(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VMZx3Mr_1660811864)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 16:37:46 +0800
Message-ID: <dfd23dfd-e0dc-7329-261c-946b179d9bc5@linux.alibaba.com>
Date: Thu, 18 Aug 2022 16:37:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: [PATCH v2] mm/dmapool.c: avoid duplicate memset within
 dma_pool_alloc
To: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
 akpm@linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <1658125690-76930-1-git-send-email-liusong@linux.alibaba.com>
 <CGME20220816123958eucas1p1b03a5efa1f5804245a5c1a9b27529015@eucas1p1.samsung.com>
 <1dbe63ff-5575-745b-653a-a992ae53e1aa@samsung.com>
 <413d8666-7a82-efd7-6716-13658016ca10@arm.com>
 <20220817053628.GA28747@lst.de>
From: Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20220817053628.GA28747@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A helper function "use_dev_coherent_memory" is introduced here to

>>>> determine whether the memory is allocated by "dma_alloc_from_dev_coherent".
>>>>
>>>> And use "get_dma_ops" to determine whether the memory is allocated by
>>>> "dma_direct_alloc".
> WTF?  get_dma_ops is privat to the DMA API layer, and dmapool has no
> business even using that.  Even independent of this particular case,
> consumers of an API never have any business looking at the implementation
> of the API, that is the whole point of the abstraction.
>
>> It's not even that, the change here is just obviously broken, since it ends
>> up entirely ignoring want_init_on_alloc() for devices using dma-direct.
>> Sure, the memory backing a dma_page is zeroed *once* by its initial
>> dma-coherent allocation, but who says we're not not reallocating pool
>> entries from an existing dma_page?
> And yes, in addition to that it also is completely broken.

After reading everyone's comments, I found that fixing this patch will

make the code look strange, so the benefits of the changes will be

dispensable, so I also agree to discard this patch.

Sorry for this trouble again.


Thanks


