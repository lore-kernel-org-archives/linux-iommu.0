Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F421F5F6
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608979; cv=none; b=VQuYpp7PGJzrMVMqehm6gczOQvO/6hwF4tdjt0xeDLZ9070JpXJYJrNjm8WF8FT1r6MFAMWq5cXGstinIU/ubKWP8sPxqudmz7Zi2LA4cgMeI2+1TU7OSpXh2Fde19FY31ZCoErj7u3GyPKZ2rHL5HmxEuZWMVCPiMFWVObOouY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608979; c=relaxed/simple;
	bh=xhpVtqTmyu116PdwzpOt++AfkbGG1kORlRIwfzWQGNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C7VxVTlxKVxF0EDmVGKo9RFdjwsKnmwQ6zLUEq6Cm2OquTg7mYnU5jMewNF3fAvhEjPt78FzBNEp5B1bay6/sb7F2Pi7NHhe/49t67qpvIlY0/vU79uKQLGVL9qEbhESwo6ahkeIBHvmm8a7poMdF+hZEV9Oyie9kOL61ysLkZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZsqFR3Lt1z26gsm;
	Wed,  7 May 2025 17:08:59 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 67B63140113;
	Wed,  7 May 2025 17:09:33 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 May 2025 17:09:32 +0800
Message-ID: <556f4076-08f5-471f-872b-a2384dcad494@huawei.com>
Date: Wed, 7 May 2025 17:09:25 +0800
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
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4zBz0oZGpP3dTzsjmw0oJbWm=vkKRS_kjBso7cvKJGjuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemj200003.china.huawei.com (7.202.194.15)


在 2025/5/7 9:52, Barry Song 写道:
> On Tue, May 6, 2025 at 3:01 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>> Fix a problem about commit (8ddde07a3d285a0f3cec, "dma-mapping:benchmark:
>> extract a common header file for map_benchmark definition") accidentally
>> removed that padding, which has completely broken the ABIs.
>>
>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> Please add Fixes tags and cc stable.

Okay, I'll fix it in the next version.

Thanks!

>> ---
>>   include/linux/map_benchmark.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
>> index 62674c83bde4..2ac2fe52f248 100644
>> --- a/include/linux/map_benchmark.h
>> +++ b/include/linux/map_benchmark.h
>> @@ -27,5 +27,6 @@ struct map_benchmark {
>>          __u32 dma_dir; /* DMA data direction */
>>          __u32 dma_trans_ns; /* time for DMA transmission in ns */
>>          __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
>> +       __u8 expansion[76];     /* For future use */
>>   };
>>   #endif /* _KERNEL_DMA_BENCHMARK_H */
>> --
>> 2.33.0
>>
> Thanks
> Barry
