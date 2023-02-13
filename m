Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F72C23A5;
	Mon, 13 Feb 2023 09:35:51 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guorui.yu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VbZAMby_1676280947;
Received: from 30.221.130.243(mailfrom:GuoRui.Yu@linux.alibaba.com fp:SMTPD_---0VbZAMby_1676280947)
          by smtp.aliyun-inc.com;
          Mon, 13 Feb 2023 17:35:49 +0800
Message-ID: <36c2bc37-714b-2251-942f-1d02f4b77d5a@linux.alibaba.com>
Date: Mon, 13 Feb 2023 17:35:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] swiotlb: fix the deadlock in swiotlb_do_find_slots
To: kernel test robot <lkp@intel.com>, hch@lst.de, m.szyprowski@samsung.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 xiaokang.hxk@alibaba-inc.com
References: <20230213063604.127526-1-GuoRui.Yu@linux.alibaba.com>
 <202302131748.pa5NGbb9-lkp@intel.com>
From: Guorui Yu <GuoRui.Yu@linux.alibaba.com>
In-Reply-To: <202302131748.pa5NGbb9-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/2/13 17:28, kernel test robot 写道:
> Hi GuoRui.Yu",
> 
> Thank you for the patch! Perhaps something to improve:
> 
>     654		spin_lock_irqsave(&area->lock, flags);
>     655		if (unlikely(nslots > mem->area_nslabs - area->used))
>     656			goto not_found;
>     657	
>     658		slot_base = area_index * mem->area_nslabs;
>     659		index = wrap = wrap_area_index(mem, ALIGN(area->index, stride));
index_nowrap should be initialized to "index" here, and I will add this 
in v2.

I have done some stress tests locally to check if they can avoid the 
deadlock but they did not reveal this problem, I will pay more attention 
next time.
>     660	
>     661		do {

Guorui
