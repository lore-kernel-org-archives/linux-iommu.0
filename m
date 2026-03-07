Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BA8229B32
	for <iommu@lists.linux.dev>; Sat,  7 Mar 2026 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772869612; cv=none; b=FhmhdXLcLOTGCX3unfIRrRQbrKF4m4VnJ1nloLqZJ+nUJaTA0I84zScc4h6+GWvt2H/FXHiMDfcoeYSgkQQGgQejrCVPTyo1E4p9k7yoEbo/t9qhLkapdKFMb6Lrdeia5t06/sRjQVOZqkFaPi2126/JuAzu4rqcOQ98Bhf1jJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772869612; c=relaxed/simple;
	bh=bPpi0Ac1dTXFTtdR7uIbt2TUoFrKuXxslz+hrO+SujA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QO2neYedwTozwwa2ddQ+l8pL/yZ9RpyZc2wo9s+4RksA/F0O6+xkYa8Ku2GsA0UR749Up0BZtW8v9T9eoS8fO2EWwCxAPMiv5LEYWzSKbKehmDF7TSb9/LZi8Ocr4YrJYlYr+xh1DI422DdjeX/FBf+wLNlIUadyPGWCkrMCmmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hw3u5z4b; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hw3u5z4b"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=k0QEdgjhJkm/CMI479cw5fiGJIjNaAVlkS2BTDuWhwA=;
	b=hw3u5z4bDYPzQunjt4AOQOx1aNaLBO0iYeWToN3fAHRcha0xO/1AyxTs3hmC39YVw8vI3Cxfn
	hZ7Fi1nKWyn1HO+GOzQmSz2VSNDUxaBttpxB4mY6k5gkeVnLAaIvGoFKORMYHrbSCkRkdMfnV1V
	sv4iBVrvjCCP6F71NKYytNg=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fSZw054Npzcb0l;
	Sat,  7 Mar 2026 15:41:20 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 995F8404AD;
	Sat,  7 Mar 2026 15:46:39 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 7 Mar 2026 15:46:39 +0800
Message-ID: <2030b7da-8638-4f61-a4c0-193975da858f@huawei.com>
Date: Sat, 7 Mar 2026 15:46:38 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] dma-mapping: benchmark: Add support for dma_map_sg
To: Marek Szyprowski <m.szyprowski@samsung.com>, <21cnbao@gmail.com>,
	<jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>
CC: <iommu@lists.linux.dev>, <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <20260225093800.3625054-1-xiaqinxin@huawei.com>
 <CGME20260306085057eucas1p176a39f28514d3c7481f5813d597086ca@eucas1p1.samsung.com>
 <a55de232-4355-4fae-85c6-b4bbebdf345d@samsung.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <a55de232-4355-4fae-85c6-b4bbebdf345d@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2026/3/6 16:50:56, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> dma mapping benchmark(SG_MODE): threads:8 seconds:30 node:-1 dir:FROM_DEVICE granule/sg_nents: 8
>> average map latency(us):1.4 standard deviation:0.3
>> average unmap latency(us):1.3 standard deviation:0.3
>> [root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
>> dma mapping benchmark(SINGLE_MODE): threads:8 seconds:30 node:-1 dir:FROM_DEVICE granule/sg_nents: 8
>> average map latency(us):1.0 standard deviation:0.3
>> average unmap latency(us):1.3 standard deviation:0.5
> Applied to dma-mapping-next. Thanks! Next time please CC: me directly.
Thank you for applying the patch. I apologize for not CC-ing you
directly earlier; I'll make sure to do so next time.:-)

-- 
Thanks,
Qinxin

