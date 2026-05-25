Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4158256C8B
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 01:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673476; cv=none; b=YDZZKApiT+TaUOPi/zwSxMkbqV1XR8JoIY+mU1lcnq3xmSIsXyCo50VGqTlhSXhg46Ty2hlL4s83YWYW5JFE1jqAh+wuuj0nPIlusSbFQXLOF6AbsQ3HTMDuX4cbtdJeHZGMXzoYfkd3kpr3yhQUQtUKO38l6UIZKMTmJHyof2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673476; c=relaxed/simple;
	bh=4OhGBgvD6OGoZVF3lLeNnsSiTy5VQOqUYYCB8ifQoy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vCI1H8rDwaeCr87VH9rsiDzfheV+tY6G5CQvp9i99Q8Ok10afiRJWZS11hzG6GmhVTNiOgZkki3t0VVgMav0vA7nfMeeQi8FoTRDJJ/Uc+AI/s2eimOuSz4nhtXrld3sN7C2UcTrG7D40U2LoBxE0N1Niqs6nH4KiR+Um01V/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ozM+dfj4; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ozM+dfj4"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=c5UnwZfbob35NRAcBY0bNVXeS0BLzVenLLZuGT6X0kY=;
	b=ozM+dfj4gH9lKjwj458i9AHI660QzSvUxBmeoRr/bGNVzT+VUQBvTzjCVT/SybdvCwyvmV1ft
	8V5bmwZTsbU8pDTLFHvORGwomoReu66FY8j78Kmzf/GO/80Il5XVJ3qFdW83cWQ8BmNce8ZOuRQ
	aGGFmlolJIpUHlf9GWapaMI=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gNz4S3nXHz12LDh;
	Mon, 25 May 2026 09:36:24 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FDD140537;
	Mon, 25 May 2026 09:44:25 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 May 2026 09:44:24 +0800
Message-ID: <e873ad08-7feb-453e-a74f-e4e87a06d40b@huawei.com>
Date: Mon, 25 May 2026 09:44:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma/dma_map_benchmark: fix fd leak on error and exit
To: David Laight <david.laight.linux@gmail.com>, <2564278112@qq.com>
CC: Barry Song <baohua@kernel.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Wang Jiang <jiangwang@kylinos.cn>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <tencent_E7BC2E2BDB10173E11B0FD519A84D414E509@qq.com>
 <20260521103236.747dceef@pumpkin>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <20260521103236.747dceef@pumpkin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2026/5/21 17:32:36, David Laight <david.laight.linux@gmail.com> wrote:
> On Thu, 21 May 2026 16:02:41 +0800
> 2564278112@qq.com wrote:
> 
>> From: Wang Jiang <jiangwang@kylinos.cn>
>>
>> Close the file descriptor when ioctl fails and on normal exit
>> to fix file descriptor leak.
> 
> There isn't a leak, it is all tidied up by the kernel.
> 
> -- David
> 
>>
>> Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
>> ---
>>   tools/dma/dma_map_benchmark.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/dma/dma_map_benchmark.c b/tools/dma/dma_map_benchmark.c
>> index eab0ac611a23..bdb8a837f020 100644
>> --- a/tools/dma/dma_map_benchmark.c
>> +++ b/tools/dma/dma_map_benchmark.c
>> @@ -130,6 +130,7 @@ int main(int argc, char **argv)
>>   
>>   	if (ioctl(fd, cmd, &map)) {
>>   		perror("ioctl");
>> +		close(fd);
>>   		exit(1);
>>   	}
>>   
>> @@ -140,5 +141,6 @@ int main(int argc, char **argv)
>>   	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",
>>   			map.avg_unmap_100ns/10.0, map.unmap_stddev/10.0);
>>   
>> +	close(fd);
>>   	return 0;
>>   }
> 

Thanks for the patch, but as David said, the kernel cleans up on exit,
so no leak. I'd prefer to leave it as is. :-)

-- 
Thanks,
Qinxin

