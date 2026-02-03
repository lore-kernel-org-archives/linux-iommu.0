Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3903AEACE
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 02:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770086763; cv=none; b=nEsQFd7FKf7G9kOyHf/57nMmDcwvB7y1UYXvhIeoX3zCccqngclgOBbhtdrEZb+Xe7IAqPYNtR1NtScMWVK2j0joUmiGWvt01c/vjuNE3RkLwBYVwbsLhlxh/RIwzcvACmHq8M2NIu7T7S7/cF2jkqRoQpi4jr1R9nuWcKSYGTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770086763; c=relaxed/simple;
	bh=xYIFA7+qgKiLnoHxrrkDrzbWLV+rDOcs4irzsQErTj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pzBtgfL5vuDFtgRCqJWrWqhP6Z01bs1JPEA7L1E0zrN2xrPekbwVsYYaAuJG/ZwMsEX/CUJz7t/CMtFzJgBsAzTBsAkHaYyrL1dupoB1bL/NMSn9OHG9/slYobGRInK5PSH+YS4xck5jTbulDjBIaSBtRtuNwJZKiLkAmYiLLpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LmHRe59Z; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LmHRe59Z"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6bjEk5JUmELWq+tMTXx95f0a6ECWnFKoP+FBE0MQGo0=;
	b=LmHRe59Zabw+x9waMDbd2Nii7poAB62g6zdDNsfuClaOIIo0/vmw0d1mif9x+jw6ZOzGcr/Be
	zYGJcKcJv26XgrWr1LJ1tI1O3o1Hjtsz2ONKYNeqmimOXjJKQHw4Sjzco5KUeUjiFuscMR7J1Lz
	ESK2tpdNnhKWw5c5TL5B72U=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4f4nnW4G4bz12LCl;
	Tue,  3 Feb 2026 10:42:07 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 8880440561;
	Tue,  3 Feb 2026 10:45:58 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Feb 2026 10:45:58 +0800
Message-ID: <cb1f418d-5c3e-4368-b13c-792b07b49087@huawei.com>
Date: Tue, 3 Feb 2026 10:45:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] tools/dma: Add dma_map_sg support
To: Barry Song <21cnbao@gmail.com>
CC: <jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
	<iommu@lists.linux.dev>, <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <20260112093436.3456315-1-xiaqinxin@huawei.com>
 <20260112093436.3456315-4-xiaqinxin@huawei.com>
 <CAGsJ_4zkLF8Si6A0tvFNPGq2VJ8Md-Be=25K65XxSn-JWtCxbA@mail.gmail.com>
 <4794d927-6de4-4283-b3ee-ee5030941a72@huawei.com>
 <CAGsJ_4xERKq4=iQPjP6+=7p4vdCUpfKB7hp7_QDOwUxn+viG5A@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4xERKq4=iQPjP6+=7p4vdCUpfKB7hp7_QDOwUxn+viG5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2026/1/30 17:16:08, Barry Song <21cnbao@gmail.com> wrote:
> On Fri, Jan 30, 2026 at 4:38 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>
>>
>>
>> On 2026/1/26 10:51:11, Barry Song <21cnbao@gmail.com> wrote:
>>> On Mon, Jan 12, 2026 at 5:34 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>>>
>>>> Support for dma_map_sg, add option '-m' to distinguish mode.
>>>>
>>>> i) Users can set option '-m' to select mode:
>>>>      DMA_MAP_BENCH_SINGLE_MODE=0, DMA_MAP_BENCH_SG_MODE:=1
>>>>      (The mode is also show in the test result).
>>>> ii) Users can set option '-g' to set sg_nents
>>>>       (total count of entries in scatterlist)
>>>>       the maximum number is 1024. Each of sg buf size is PAGE_SIZE.
>>>>       e.g
>>>>       [root@localhost]# ./dma_map_benchmark -m 1 -g 8 -t 8 -s 30 -d 2
>>>>       dma mapping mode: DMA_MAP_BENCH_SG_MODE
>>>>       dma mapping benchmark: threads:8 seconds:30 node:-1
>>>>       dir:FROM_DEVICE granule/sg_nents: 8
>>>>       average map latency(us):1.4 standard deviation:0.3
>>>>       average unmap latency(us):1.3 standard deviation:0.3
>>>>       [root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
>>>>       dma mapping mode: DMA_MAP_BENCH_SINGLE_MODE
>>>>       dma mapping benchmark: threads:8 seconds:30 node:-1
>>>>       dir:FROM_DEVICE granule/sg_nents: 8
>>>>       average map latency(us):1.0 standard deviation:0.3
>>>>       average unmap latency(us):1.3 standard deviation:0.5
>>>>
>>>
>>> What happens if m is set to 0 while g is set to 8?
>>>
>>> Thanks
>>> Barry
>>
>> Hi Barry!
>> m set '0' and g set '8', This means that 8 page_sizes are mapped at a
>> time in single mode.
>> As the comment for the struct map_benchmark definition says:
>>
>>    __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
>>
>> [root@localhost xqx]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
>> dma mapping benchmark(SINGLE_MODE): threads:8 seconds:30 node:-1
>> dir:FROM_DEVICE granule:8
>> average map latency(us):0.2 standard deviation:0.1
>> average unmap latency(us):4.3 standard deviation:1.4
>>
>> ======================================================
>> The newly added sg mode reuses the -g option as sgnents and is described
>> in the comments:
>>          /*
>>           * Set the number of scatterlist entries based on the granule.
>>
>>
>>           * In SG mode, 'granule' represents the number of scatterlist
>> entries.
>>           * Each scatterlist entry corresponds to a single page.
>>           */
>>
>> By the way, I've considered testing sgnents of different sizes, but it's
>> not very easy to set for user parameters, so I set it with each
>> scatterlist entry corresponds to a single page.
> 
> This is a bit odd. Ideally, we shouldn’t have a mixed definition
> for a single variant, but since this is just a tool, it may be
> acceptable.
> 
> That said, the documentation should at least be updated in
> patches 2/3 and 3/3. As it stands, it still says:
> 
>      __u32 granule; /* how many PAGE_SIZE are mapped or unmapped
>                       at a time */
> 
> 
>>
>> Thanks,
>> Qinxin
>>
OK, I will update the documentation in the next version.
Do you have any other suggestions for this series?
-- 
Thanks,
Qinxin

