Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E34231DD98
	for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769762301; cv=none; b=nymmNi0fQ72JfCnc95DGIJCaMeUe24WscmKSA2J1dZzm9XdhANb6mQK0fLmglomj6ibFwCXLAOQ9dx5ivKpQDD2Dj7wuikmGPW3EalNL93Xp3GYhofo7e1BiH7sL9Gxhd0VBf1CueA/opWRGw/lkSjapiUzUp4+QO+ciHe7RmMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769762301; c=relaxed/simple;
	bh=41PBFqkj7IcTb5d8pWgn3Gi/4GcjOQxMdE67voZlH3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=du/6q/+ndbSFvqnehTaldAD+GGggdI/eUN/nN1C2iZNs0+wV0ufHXXm8HpKN89pPDX/dW3qsnEcB1yKKOpcquIXEv1+kySEtcXiMQqYIL36sTX8zoxUCJXYU1zI0KyGzVu9VE0IM63cOTW3IOIFTJWHxCSIB9nMMMgwb4RpE2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=mwVWUdQQ; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mwVWUdQQ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2tLI+YRniKr10v27hMbgU4oiIukX37VfpHV10PVoijA=;
	b=mwVWUdQQxlDHAWuD++US9sgZmZhHpGHa6SF3mTkSGGjmzyI0xxwJ641r2BL9dAdFEP9tUobdM
	MdSWkNymt7ZO5X6h4IpSNtdw1UrkYCo25oxmtpHBul7hQr81nPcvyRZ7+R1R7cMRGBC3WDtpo9F
	xr1GaT3EYnUTt0LKg710j1A=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4f2Tnf6k23zpSwY;
	Fri, 30 Jan 2026 16:34:14 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id A61F940538;
	Fri, 30 Jan 2026 16:38:16 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Jan 2026 16:38:16 +0800
Message-ID: <4794d927-6de4-4283-b3ee-ee5030941a72@huawei.com>
Date: Fri, 30 Jan 2026 16:38:15 +0800
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
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4zkLF8Si6A0tvFNPGq2VJ8Md-Be=25K65XxSn-JWtCxbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2026/1/26 10:51:11, Barry Song <21cnbao@gmail.com> wrote:
> On Mon, Jan 12, 2026 at 5:34 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>
>> Support for dma_map_sg, add option '-m' to distinguish mode.
>>
>> i) Users can set option '-m' to select mode:
>>     DMA_MAP_BENCH_SINGLE_MODE=0, DMA_MAP_BENCH_SG_MODE:=1
>>     (The mode is also show in the test result).
>> ii) Users can set option '-g' to set sg_nents
>>      (total count of entries in scatterlist)
>>      the maximum number is 1024. Each of sg buf size is PAGE_SIZE.
>>      e.g
>>      [root@localhost]# ./dma_map_benchmark -m 1 -g 8 -t 8 -s 30 -d 2
>>      dma mapping mode: DMA_MAP_BENCH_SG_MODE
>>      dma mapping benchmark: threads:8 seconds:30 node:-1
>>      dir:FROM_DEVICE granule/sg_nents: 8
>>      average map latency(us):1.4 standard deviation:0.3
>>      average unmap latency(us):1.3 standard deviation:0.3
>>      [root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
>>      dma mapping mode: DMA_MAP_BENCH_SINGLE_MODE
>>      dma mapping benchmark: threads:8 seconds:30 node:-1
>>      dir:FROM_DEVICE granule/sg_nents: 8
>>      average map latency(us):1.0 standard deviation:0.3
>>      average unmap latency(us):1.3 standard deviation:0.5
>>
> 
> What happens if m is set to 0 while g is set to 8?
> 
> Thanks
> Barry

Hi Barry!
m set '0' and g set '8', This means that 8 page_sizes are mapped at a
time in single mode.
As the comment for the struct map_benchmark definition says:

  __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */

[root@localhost xqx]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
dma mapping benchmark(SINGLE_MODE): threads:8 seconds:30 node:-1
dir:FROM_DEVICE granule:8
average map latency(us):0.2 standard deviation:0.1
average unmap latency(us):4.3 standard deviation:1.4

======================================================
The newly added sg mode reuses the -g option as sgnents and is described
in the comments:
        /*
         * Set the number of scatterlist entries based on the granule. 
  

         * In SG mode, 'granule' represents the number of scatterlist
entries.
         * Each scatterlist entry corresponds to a single page.
         */

By the way, I've considered testing sgnents of different sizes, but it's
not very easy to set for user parameters, so I set it with each
scatterlist entry corresponds to a single page.

Thanks,
Qinxin

