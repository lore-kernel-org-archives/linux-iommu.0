Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D71D26B975
	for <iommu@lists.linux.dev>; Fri,  9 May 2025 06:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746773005; cv=none; b=fCuTucMXshhOQ+WckgLQe3TWuEA2bjmBo968wG3wBBqx4gAplFfSBl7gm53qIeSDOtk9KMNca+VZUoLmzYsf0MaG//NPXy0uarkz9qKBLUMseWAYyclxvrZ3Yeqp3jkS+mcaVDn8tdXBbRv82cy2w8CNxp3sATEvkClIDIAx89k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746773005; c=relaxed/simple;
	bh=I7dVhn7yVkNmKHQ/VobzVVMUVb7PrY8kt5IydB/Sqac=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PaZ7f96KvNrHSyimGpwiOU7KAy3tsv/DfgzxuNwO/Z8gyEfQAmr4WTfN4/gdbaW6B5a4glQ6jWKc9InJJqCfapgG59rjJ6eb/kGHUo1KHWSDuE27pTUUqATNe29v5upVS0yN3vPoYMy5HnR+uOnCju4qKcW7zpZ5QDxous/D9C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Ztzvc3WMdzsSgn;
	Fri,  9 May 2025 14:42:36 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 055B218001B;
	Fri,  9 May 2025 14:43:14 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 9 May 2025 14:43:13 +0800
Message-ID: <ab9c5f52-4648-42c4-8dd1-79c3bb0ce971@huawei.com>
Date: Fri, 9 May 2025 14:43:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dma-mapping: benchmark: Add padding to ensure uABI
 remained consistent
To: Barry Song <21cnbao@gmail.com>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
CC: <yangyicong@huawei.com>, <hch@lst.de>, <iommu@lists.linux.dev>,
	<jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
	<fanghao11@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <stable@vger.kernel.org>
References: <20250509020238.3378396-1-xiaqinxin@huawei.com>
 <20250509020238.3378396-2-xiaqinxin@huawei.com>
 <CAGsJ_4zrCiugrAPw-aExgSMZXYBBUqLyyWbcpKH8RdhKnHxj9g@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4zrCiugrAPw-aExgSMZXYBBUqLyyWbcpKH8RdhKnHxj9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemj200003.china.huawei.com (7.202.194.15)


On 2025/5/9 11:31:09, Barry Song <21cnbao@gmail.com> wrote:
> On Fri, May 9, 2025 at 2:02 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
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
>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> +Marek, +Robin
>
> Acked-by: Barry Song <baohua@kernel.org>
OK!
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

Thanks

Qinxin

