Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB21A4698
	for <iommu@lists.linux.dev>; Tue,  9 Jan 2024 02:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4T8FMv61FSz2LXK8;
	Tue,  9 Jan 2024 10:32:59 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B8D21A0192;
	Tue,  9 Jan 2024 10:34:30 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 10:34:29 +0800
Message-ID: <6030f1aa-6c7f-41d7-e1b8-06cfca22d60b@huawei.com>
Date: Tue, 9 Jan 2024 10:34:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] swiotlb: check alloc_size before the allocation of a new
 memory pool
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
CC: <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<petr.tesarik1@huawei-partners.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>
References: <20240108140005.3355316-1-zhangpeng362@huawei.com>
 <20240108170649.GA11047@lst.de>
From: "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <20240108170649.GA11047@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600020.china.huawei.com (7.193.23.147)

On 2024/1/9 1:06, Christoph Hellwig wrote:

> This looks good, but the surrounding code changed quite a bit in
> the dma-mapping code.  Can you redo it against dma-mapping for-next
> (which should get merged into Linus' tree ASAP as I already sent the
> pull request)

Of course, I'll rebase to the for-next branch in the next version. Thanks!

-- 
Best Regards,
Peng

