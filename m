Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6956E13D53B
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234798; cv=none; b=DqunvcyUT+GeP45+fPz4yCCVs9M2Jl2rVHUbnNjdO6DEkOIyfUJlDOUMcsnVwWM763H+ED1I+B0pIj6Kbvn8Wn+P4INdwyHgfQ9lqrcsIhTc/kaazGB0H/2to0K3RVPyVgpda0+IeXEp4RkqWxhEoXhLuYq7PgwWXyBzb3wUzBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234798; c=relaxed/simple;
	bh=oyCpXt6yAyYTSwcQwAZ4p92sZK6DCxmgRGJ7KSlqaNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R773D2O4g86w7bZ0qc+yT/ysj7g+53LRUGqvV26AdkmYB6un2bsKEfIoCybL7W/zMqpqgBGF4aHMHjWkyHTpeZD8l4G7jQDGoL0a3/+5l/Tx9JnQdSK2KC+DpFwqXMDpXSvJCplkbLv31NTnHsLuXJ5sTRM7AZygd+x3kjhfaXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4W77ZW3XFGz1SDbN;
	Mon, 24 Jun 2024 21:08:51 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 1941214037B;
	Mon, 24 Jun 2024 21:13:13 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 kwepemf500003.china.huawei.com (7.202.181.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 24 Jun 2024 21:13:12 +0800
Message-ID: <0322849d-dc1f-4e1c-a47a-463f3c301bdc@huawei.com>
Date: Mon, 24 Jun 2024 21:13:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/iova: Bettering utilizing cpu_rcaches in no-strict
 mode
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<john.g.garry@oracle.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240624083952.52612-1-zhangzekun11@huawei.com>
 <5149c162-cf38-4aa4-9e96-27c6897cad36@arm.com>
From: "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <5149c162-cf38-4aa4-9e96-27c6897cad36@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500003.china.huawei.com (7.202.181.241)


在 2024/6/24 18:56, Robin Murphy 写道:
> On 2024-06-24 9:39 am, Zhang Zekun wrote:
>> Currently, when iommu working in no-strict mode, fq_flush_timeout()
>> will always try to free iovas on one cpu. Freeing the iovas from all
>> cpus on one cpu is not cache-friendly to iova_rcache, because it will
>> first filling up the cpu_rcache and then pushing iovas to the depot,
>> iovas in the depot will finally goto the underlying rbtree if the
>> depot_size is greater than num_online_cpus().
> 
> That is the design intent - if the excess magazines sit in the depot 
> long enough to be reclaimed then other CPUs didn't want them either. 
> We're trying to minimise the amount of unused cached IOVAs sitting 
> around wasting memory, since IOVA memory consumption has proven to be 
> quite significant on large systems.

Hi, Robin,

It does waste some memory after this change, but since we have been 
freeing iova on each cpu in strict-mode for years, I think this change 
seems reasonable to make the iova free logic identical to strict-mode.
This patch try to make the speed of allcating and freeing iova roughly 
same by better utilizing the iova_rcache, or we will more likely enter 
the slowpath. The save of memory consumption is actually at the cost of 
performance, I am not sure if we need such a optimization for no-strict 
mode which is mainly used for performance consideration.

> 
> As alluded to in the original cover letter, 100ms for IOVA_DEPOT_DELAY 
> was just my arbitrary value of "long enough" to keep the initial 
> implementation straightforward - I do expect that certain workloads 
> might benefit from tuning it differently, but without proof of what they 
> are and what they want, there's little justification for introducing 
> extra complexity and potential user ABI yet.
> 
>> Let fq_flush_timeout()
>> freeing iovas on cpus who call dma_unmap* APIs, can decrease the overall
>> time caused by fq_flush_timeout() by better utilizing the iova_rcache,
>> and minimizing the competition for the iova_rbtree_lock().
> 
> I would have assumed that a single CPU simply throwing magazines into 
> the depot list from its own percpu cache is quicker, or at least no 
> slower, than doing the same while causing additional contention/sharing 
> by interfering with other percpu caches as well. And where does the 
> rbtree come into that either way? If an observable performance issue 
> actually exists here, I'd like a more detailed breakdown to understand it.
> 
> Thanks,
> Robin.
> 

This patch is firstly intent to minimize the chance of softlock issue in 
fq_flush_timeout(), which is already dicribed erarlier in [1], which has 
beed applied in a commercial kernel[2] for years.

However, the later tests show that this single patch is not enough to 
fix the softlockup issue, since the root cause of softlockup is the 
underlying iova_rbtree_lock. In our softlockup scenarios, the average
time cost to get this spinlock is about 6ms.

[1] https://lkml.org/lkml/2023/2/16/124
[2] https://gitee.com/openeuler/kernel/tree/OLK-5.10/

Thanks,
Zekun
