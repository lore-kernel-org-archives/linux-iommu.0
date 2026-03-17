Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5521B341050
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 01:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773711895; cv=none; b=d5cuY/+fiYjutfzV1Sm1eEguKA6PdT++CIhTHH0RXAZC5U8zOVgU5rnvEfv+UtkpP9pcPIAjM1CzG42Csqj9z1XNe6j8cYgPhfugfKEKMOZSxquaW20klw/4zi5DJ3DH2c2i/8Rp3UwiFQgXpd10eo1nLfD4h0vm7PblQwD713o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773711895; c=relaxed/simple;
	bh=Vbq1ws/jbQLGHr0X9zXe3914N3Caum6ZmPuQlaSH6mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jvrDp4Z4bs8oTFTVZ+H/Nw+47Hmj4awlAWcbZwiSbOP5JFaxxkm1cDSZeY69h8T9P1eAdOMPmJ9LIcoCZo/5Lfr518JeKcVAz280SV5XnrvMSpfzLb5xlOcmJWIaoLz92HHGAjSO7JMmilI7BcwjQj6YwFip+zvrXdJqw74K3ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=i6ffHD+1; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="i6ffHD+1"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=npqisdMt8oIKpuDnHDNfunqQp27m9oVGG0vr418yV5k=;
	b=i6ffHD+14XlPe5Pv5++xvp1Ty2yClbmxmpXdPj/is9aq+rbv9pJ0tTZxZxW3+4/Rvqrp4H9wm
	YqAsA27kc5Jh/B/EMs47veicFGoxy2IHfEjCe8MIdlic3v0uuGnEyuaofSPsbm83fgyvmb8up4i
	eT5t6z4fLDWcKReiY3mIl2c=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fZZQK11kjz1K96t;
	Tue, 17 Mar 2026 09:39:53 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 95CF740562;
	Tue, 17 Mar 2026 09:44:49 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 17 Mar 2026 09:44:49 +0800
Message-ID: <7bf4849c-b220-4bd9-b3a8-f7a16c7acec6@huawei.com>
Date: Tue, 17 Mar 2026 09:44:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] iommu/arm-smmu-v3: Add register display to
 debugfs
To: Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>, <jpb@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<wangzhou1@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
References: <20260313104351.3502293-1-xiaqinxin@huawei.com>
 <20260313104351.3502293-3-xiaqinxin@huawei.com>
 <68add41b-bafa-4884-be70-c03d6ce851eb@arm.com>
 <1a42d502-a2c4-4c41-ba7e-4dc115159ed6@huawei.com>
 <e2fb2f38-2a31-473e-9ab2-efae8e7a0303@arm.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <e2fb2f38-2a31-473e-9ab2-efae8e7a0303@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2026/3/17 00:26:00, Robin Murphy <robin.murphy@arm.com> wrote:
> On 2026-03-16 3:35 pm, Qinxin Xia wrote:
>>>> +    /* 32-bit control registers */
>>>> +    seq_printf(seq, "CR0: 0x%08x [%s%s%s]\n",
>>>> +           readl_relaxed(base + ARM_SMMU_CR0),
>>>> +           readl_relaxed(base + ARM_SMMU_CR0) & CR0_SMMUEN ?
>>>> +           "Enabled " : "Disabled ",
>>>> +           readl_relaxed(base + ARM_SMMU_CR0) & CR0_EVTQEN ?
>>>> +           "EventQ " : "",
>>>> +           readl_relaxed(base + ARM_SMMU_CR0) & CR0_CMDQEN ?
>>>> +           "CmdQ " : "");
>>>
>>> There's really no point printing these extra strings, since if any of 
>>> those were *not* enabled then we'd have already failed probe and 
>>> never created the debugfs entry. And if anyone ever were to be trying 
>>> to change the driver behaviour at that level, I'd very much expect 
>>> them to be able to be able to read the bottom 4 bits of a CR0 value 
>>> in hex anyway ;)
>>>
>>> Thanks,
>>> Robin.
>>>
>>
>> Since Kunpeng supports ECMDQ(have not been submitted upstream), the
>> intention was to check whether the SMMU supports ECMDQ, and the logging
>> for other queues was added incidentally. The prints for the event queue
>> and command queue indeed seem unnecessary. I will remove them in the
>> next version.
> OK, I would make a similar argument that even then, it wouldn't make 
> sense to expose debugfs entries for ECMDQ_PROD registers that don't 
> exist or we aren't using. Thus their enabled state should similarly be 
> inherent in the files being present at all (but again either way, if a 
> developer couldn't tell the significance of 0x80xxxxxx vs. 0x00xxxxxx 
> already then I'd have to question their capability to usefully debug any 
> more subtle ECMDQ behaviour...)
> 
> Thanks,
> Robin.
> 

You're right.
-- 
Thanks,
Qinxin

