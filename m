Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A9248F73
	for <iommu@lists.linux.dev>; Thu, 24 Jul 2025 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349721; cv=none; b=dqysp+EpeScD1kxfKlqyzQBsIPQ6rUDhjqgtp/XGNLXscb5wrqy+039tOxz9C0Ku5T2bJec2v2v8ccqJjYyXk1dFdZ86a9lPai5YF3BDTBYIrrkX34z9MZ/N5aGmIFgD+t8mJg6vTrGGFS5xfzLn1/AZ+d7eiwB4Owik5wEpalc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349721; c=relaxed/simple;
	bh=MwYzkwplxjT8TFeYLLWOUaBok/od1wayyWGfll2r4bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qsYPK7uuPxtii7DGMVlEGhRg5+Pzwjsn/sq8nI0JzjfB7btttsehSfGVk+FXARfJ7eL2Dw7nUWKNhcjkTUvCFXnEtZOgabdwkQ9hDWFI4l9/J8HHl+NFn8K3CfdgCmAuqCXlxRHdyZXinaFv8Yh3lSDHH9rGWaPtmnVqAffTqsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bnm4h4SPtz1R8kk;
	Thu, 24 Jul 2025 17:32:36 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BD09140109;
	Thu, 24 Jul 2025 17:35:17 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Jul 2025 17:35:16 +0800
Message-ID: <c7f7d9b3-2ab3-4ebd-99fb-071733573291@huawei.com>
Date: Thu, 24 Jul 2025 17:35:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dma-mapping: benchmark: Add padding to ensure uABI
 remained consistent
To: Barry Song <21cnbao@gmail.com>, <m.szyprowski@samsung.com>
CC: <robin.murphy@arm.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<iommu@lists.linux.dev>
References: <20250724085600.4101321-1-xiaqinxin@huawei.com>
 <20250724085600.4101321-3-xiaqinxin@huawei.com>
 <CAGsJ_4zVR3R7erGP57vxM8vKBARG8BttA=FsCVFjy4QtswcsQw@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4zVR3R7erGP57vxM8vKBARG8BttA=FsCVFjy4QtswcsQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/7/24 17:07:08, Barry Song <21cnbao@gmail.com> wrote:
> On Thu, Jul 24, 2025 at 4:56 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>
>> The padding field in the structure was previously reserved to
>> maintain a stable interface for potential new fields, ensuring
>> compatibility with user-space shared data structures.
>> However,it was accidentally removed by tiantao in a prior commit,
>> which may lead to incompatibility between user space and the kernel.
>>
>> This patch reinstates the padding to restore the original structure
>> layout and preserve compatibility.
>>
>> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header file for map_benchmark definition")
>> Cc: stable@vger.kernel.org
>> Acked-by: Barry Song <baohua@kernel.org>
>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> 
> I don’t think these two patches should be part of the same series. This
> one is a bug fix and should be handled separately—ideally picked up on
> its own and backported to stable.
> 
> Also, the subject should not say "Add"—it should be "Restore". I assume
> Marek can handle it?
> 
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
> 
> Thanks
> Barry

Ok, I will send a new version to fix it.
Thanks
