Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8113618E1F
	for <iommu@lists.linux.dev>; Wed, 10 Sep 2025 02:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473095; cv=none; b=fOnM7WVzIklHDdQ/D5zTxgrYbc6v9WVXTDhjldbYNJ0Lyb4sW7eh2Ieb8K0RMSYggeWFg8Ck0IPSZWeZcBs9U0MErIIMwzRcXmndip/3dU8aKT83OH8bTZY+ZsvmTE4Z3ZyFZS9wLD4tcuJK6WTQlBmVBXytC8t6NeluaGpk6cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473095; c=relaxed/simple;
	bh=ePEOpHUL+Qp/b5wiFTem+vn8fqSOrqAPf4hHF8eTrNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AscRvpWSurmcv/9MN0LKKMUnn4dx7vA5sOP7jNSnrMjkeAOX7fTmCqpfduUgInmGpfbEzCRujoOj+IcGSsW26g2rFM7/gKREqofl/RmA2XI7o0suexaXapR3GGKL3IHTiNrxJvMlgvuJ/1yPSIL6H1Qtfu/igxBv6SzLBZ7r3a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cM4yq0DpHz13N79;
	Wed, 10 Sep 2025 10:54:11 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 126FB140259;
	Wed, 10 Sep 2025 10:58:11 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Sep 2025 10:58:10 +0800
Message-ID: <534119b8-8221-4991-b308-05e8d5918aca@huawei.com>
Date: Wed, 10 Sep 2025 10:58:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/debug: Add IOMMU page table dump debug facility
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<yangyicong@huawei.com>, <wangzhou1@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
References: <20250814093005.2040511-1-xiaqinxin@huawei.com>
 <20250814093005.2040511-2-xiaqinxin@huawei.com>
 <aMAmWQJy_G50xoBf@willie-the-truck>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <aMAmWQJy_G50xoBf@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/9/9 21:06:33, Will Deacon <will@kernel.org> wrote:
> On Thu, Aug 14, 2025 at 05:30:04PM +0800, Qinxin Xia wrote:
>> +/**
>> + * iova_info_dump - dump iova alloced
>> + * @s - file structure used to generate serialized output
>> + * @iovad: - iova domain in question.
>> + */
>> +static int iommu_iova_info_dump(struct seq_file *s, struct iommu_domain *domain)
>> +{
>> +	struct iova_domain *iovad;
>> +	unsigned long long pfn;
>> +	unsigned long i_shift;
>> +	struct rb_node *node;
>> +	unsigned long flags;
>> +	size_t prot_size;
>> +
>> +	iovad = iommu_domain_to_iovad(domain);
>> +	if (!iovad)
>> +		return -ENOMEM;
>> +
>> +	i_shift = iova_shift(iovad);
>> +
>> +	/* Take the lock so that no other thread is manipulating the rbtree */
>> +	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>> +	assert_spin_locked(&iovad->iova_rbtree_lock);
>> +
>> +	for (node = rb_first(&iovad->rbroot); node; node = rb_next(node)) {
>> +		struct iova *iova = rb_entry(node, struct iova, node);
>> +
>> +		if (iova->pfn_hi <= iova->pfn_lo)
>> +			continue;
>> +
>> +		for (pfn = iova->pfn_lo; pfn <= iova->pfn_hi; ) {
>> +			prot_size = domain->ops->dump_iova_prot(s, domain, pfn << i_shift);
>> +			pfn = ((pfn << i_shift) + prot_size) >> i_shift;
>> +		}
>> +	}
>> +
>> +	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> 
> Why is the IOVA rbtree lock sufficient for serialising the page-table
> accesses made by ->dump_iova_prot()? I don't see anything here that
> prevents the walker walking into page-table pages that are e.g. being
> freed or manipulated concurrently.
> 
> Will
> 
  Thank you for catching this critical race condition.I will fix this in
  next version. And,Jason suggests putting io_ptdump on top of iommu pt.
  What do you think?
