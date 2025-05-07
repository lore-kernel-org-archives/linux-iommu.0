Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CFE230BC6
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609022; cv=none; b=YN6igFhp3fxHkT+fWzJx9hsnHTaISC/S5KY8jCM3AE3Q4Rfut9EabG6FLIysIDJ/7RRpkVu4ai7h1AlqarIPKICfYs884XrAeNzkv6S/t+ark+XpkNRysR3yXF28x2yVTBIT3UhOe+EOX2oDV3BNfT9KEsZQLhsr+7kQTSmSyG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609022; c=relaxed/simple;
	bh=IyixUg/lsFyrvjt0sM7ct7uXKaFuYiSCGYEqiC9kvhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cgW2U1+aYsXw2XMFtCEyYhToMSYyO4je+8wuvLn53SjI7J53VAigZFvgFbgBvHPWF+w52kAMOff9pJ4/NXCBadc+obDqH623EvQsPmb1EY2sFOaKynutAmQvMekuwuKx61z+kyBgSyihsWHCYKUjOudGbVQ0Erqr2yYjZf0tRE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZsqBn70zCz12LXL;
	Wed,  7 May 2025 17:06:41 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id D10951402C7;
	Wed,  7 May 2025 17:10:17 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 May 2025 17:10:17 +0800
Message-ID: <4bac8132-db37-47a2-ad5a-22bde865b8e8@huawei.com>
Date: Wed, 7 May 2025 17:10:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dma-mapping: benchmark: Add padding to ensure uABI
 remained consistent
To: Barry Song <21cnbao@gmail.com>
CC: <yangyicong@huawei.com>, <hch@lst.de>, <iommu@lists.linux.dev>,
	<jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
	<fanghao11@huawei.com>, <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <20250506030100.394376-1-xiaqinxin@huawei.com>
 <20250506030100.394376-2-xiaqinxin@huawei.com>
 <CAGsJ_4zBz0oZGpP3dTzsjmw0oJbWm=vkKRS_kjBso7cvKJGjuQ@mail.gmail.com>
 <CAGsJ_4yEmSGGKFxCT_wioEOaLxAzxNiryR42_hW9-vbu8WgBUg@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4yEmSGGKFxCT_wioEOaLxAzxNiryR42_hW9-vbu8WgBUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemj200003.china.huawei.com (7.202.194.15)


在 2025/5/7 10:08, Barry Song 写道:
> On Wed, May 7, 2025 at 1:52 PM Barry Song <21cnbao@gmail.com> wrote:
>> On Tue, May 6, 2025 at 3:01 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>> Fix a problem about commit (8ddde07a3d285a0f3cec, "dma-mapping:benchmark:
>>> extract a common header file for map_benchmark definition") accidentally
>>> removed that padding, which has completely broken the ABIs.
>>>
>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>> Please add Fixes tags and cc stable.
> We are *NOT* adding any field.
>
> Also, the subject and changelog are not appropriate. They should be something
> like the following:
>
> Previously, we had a padding field in this structure to allow for future
> extension without breaking compatibility with user-space shared data
> structures. In other words, the padding was reserved to maintain a stable
> interface for potential new fields.
>
> However, in one of the commits, tiantao accidentally removed this padding,
> which could lead to incompatibility issues between user space and the
> kernel.
>
> This patch restores the padding to bring back the original structure layout
> and ensure compatibility is preserved.
Okay, thank you for your advice.
>>> ---
>>>   include/linux/map_benchmark.h | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
>>> index 62674c83bde4..2ac2fe52f248 100644
>>> --- a/include/linux/map_benchmark.h
>>> +++ b/include/linux/map_benchmark.h
>>> @@ -27,5 +27,6 @@ struct map_benchmark {
>>>          __u32 dma_dir; /* DMA data direction */
>>>          __u32 dma_trans_ns; /* time for DMA transmission in ns */
>>>          __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
>>> +       __u8 expansion[76];     /* For future use */
>>>   };
>>>   #endif /* _KERNEL_DMA_BENCHMARK_H */
>>> --
>>> 2.33.0
>>>
> Thanks
> Barry
