Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93071E9B3E
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254486; cv=none; b=MbdU7TQy0aovWmuf86iN7y+9Yx4HEVid4WbASKqmx8AaGTCRQZy29YukRQzRwTMLALKWX63zw9xXJK/LZ7ZuqYf6fMAqZMoQ7jlmPCc82491f7pE1/f9ml+2+cldW6HlgCFr/BF854Fq+kIpvs0yusJtUWeaHtAAz0bJQJc6ZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254486; c=relaxed/simple;
	bh=0uGZ0iEsCTDnT+FaNektNo/0yFSJo4zN+5uPqZqam7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RtkH0Md/O4rR3VgVsiJ5bn64QWmGvCPrhL0L4kbGZ1pi2DWWaBVd3ju5nGOQ5Q4QQM+tqmSx/JRgeN+Rfln44R3wzVpPgajYHMRdEDFMu7BiNZY0dbDJwZE0XdY3djfkk5kEjiGG+xumHrYYGlAoQ2jnL4HhlcLV9e6v/71IVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YS9rx0bFCz1W338;
	Tue,  7 Jan 2025 20:50:57 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id AF9FA140137;
	Tue,  7 Jan 2025 20:54:37 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Jan 2025 20:54:37 +0800
Message-ID: <561e07c0-98ba-44ee-abda-778b12438df6@huawei.com>
Date: Tue, 7 Jan 2025 20:54:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/8] fix two bugs related to page_pool
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, <zhangkun09@huawei.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Robin Murphy <robin.murphy@arm.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, IOMMU <iommu@lists.linux.dev>, MM
	<linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
References: <20250106130116.457938-1-linyunsheng@huawei.com>
 <20250106155154.7c349c67@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20250106155154.7c349c67@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/1/7 7:51, Jakub Kicinski wrote:
> On Mon, 6 Jan 2025 21:01:08 +0800 Yunsheng Lin wrote:
>> This patchset fix a possible time window problem for page_pool and
>> the dma API misuse problem as mentioned in [1], and try to avoid the
>> overhead of the fixing using some optimization.
>>
>> From the below performance data, the overhead is not so obvious
>> due to performance variations for time_bench_page_pool01_fast_path()
>> and time_bench_page_pool02_ptr_ring, and there is about 20ns overhead
>> for time_bench_page_pool03_slow() for fixing the bug.
> 
> This appears to make the selftest from the drivers/net target implode.
> 
> [   20.227775][  T218] BUG: KASAN: use-after-free in page_pool_item_uninit+0x100/0x130
> 
> Running the ping.py tests should be enough to repro.

Thanks for reminding.
Something like below seems to fix the use-after-free bug, will enable more
DEBUG config when doing testing.

--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -518,9 +518,13 @@ static void page_pool_items_unmap(struct page_pool *pool)

 static void page_pool_item_uninit(struct page_pool *pool)
 {
-       struct page_pool_item_block *block;
+       while (!list_empty(&pool->item_blocks)) {
+               struct page_pool_item_block *block;

-       list_for_each_entry(block, &pool->item_blocks, list) {
+               block = list_first_entry(&pool->item_blocks,
+                                        struct page_pool_item_block,
+                                        list);
+               list_del(&block->list);
                WARN_ON(refcount_read(&block->ref));
                put_page(virt_to_page(block));
        }

