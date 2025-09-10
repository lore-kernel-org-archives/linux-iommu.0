Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E0E258EEB
	for <iommu@lists.linux.dev>; Wed, 10 Sep 2025 03:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757474419; cv=none; b=IAUUQW+SDMUPsmhvuqRqyS+eBqaBvNWfcY8mWyFHBxkSKcK5jtib16QApdXGz0F2uH7hIRQJxsPcDY0x1PmffAky2nJBTFpDGRxHMUs2fvEOQtHJAr0JWxL2H9E6WfZW17M63iQswuWvtano3+fxbcpo4suQneEg01RerV7oIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757474419; c=relaxed/simple;
	bh=wo2bpcyVXWavSZ21w2gQftxl1jhlZnTJtgw9TEbuk9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E8z06SnidqpUZey4XAkYEwTanYFCD+U1jY5wilG64p4LPsbB7fWt3i1SwT4H7w1XYDV/S2142T5pas2ZY+wgMSLLPfI6GVB4gHH1O7hFsBWAdTSsoJJZFK5xlK5RK78zLUpOvzhOtsW9zIgwegNrvzjI6JG6ZBnTTV5d8GgoKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cM5T141kzz2TT8k;
	Wed, 10 Sep 2025 11:16:53 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 2631D14027A;
	Wed, 10 Sep 2025 11:20:09 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Sep 2025 11:20:08 +0800
Message-ID: <f2720f17-5e81-4f69-aaf5-791b47973178@huawei.com>
Date: Wed, 10 Sep 2025 11:20:08 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iommu: Add io_ptdump debug interface for iommu
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<yangyicong@huawei.com>, <wangzhou1@hisilicon.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>, <fanghao11@huawei.com>,
	<jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
References: <20250814093005.2040511-1-xiaqinxin@huawei.com>
 <20250902161028.GC184112@ziepe.ca>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <20250902161028.GC184112@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/9/3 00:10:28, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Thu, Aug 14, 2025 at 05:30:03PM +0800, Qinxin Xia wrote:
>> This patch supports the iopgtable_dump function (similar to kernel_page_dump).
>> The IOMMU page table dump debugging function is added to the framework layer.
>> Different architectures only need to provide the implemented dump ops.
>> It also provides the implementation of ARM SMMUv3 and io-pgtable-arm.
>>
>> Qinxin Xia (2):
>>    iommu/debug: Add IOMMU page table dump debug facility
>>    iommu/io-pgtable: Add ARM SMMUv3 page table dump support
> 
> I'd prefer we do this on top of iommu pt please, I don't want to
> further deeping the hole of changing all the page table code in all
> drivers for debugfs.
> 
> Jason
Ok, I see, my colleague Wang Zhou also released a version of io_ptdump
a long time ago, which is implemented in smmu debugfs. Will recommends 
that io_ptdump be implemented in a way similar to CPU page table dump. 
Using debugfs to expose the data and using format-specific callbacks to 
implement specific data dumps, I'll talk to him about this as well.

