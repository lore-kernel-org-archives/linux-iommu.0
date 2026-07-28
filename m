Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BEE14BF92
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 02:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785205293; cv=none; b=UY1Sa8crJ+mPCf1nKLMFy69a1UxyDxHDGvcCYbyLAKLxreOJhvAlzcGafKmANBRfrBTKmD/tShtHnPdlh7VKSxbjxv3UQ42uPG3MxrrehuFH9gSLFF4S+v25LZ13/BOThQqSBH6gLrutE9AKDd86SpWwOm93kiy8AoSCi9gLMJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785205293; c=relaxed/simple;
	bh=jnt1UMzhz30P1EOmE7DrCxXK/cEEtjun3k91omGvzsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gWqp22LYe7JQOP9576gWhYSP0miLKQ20vTsvV9mC5AnyusK/BDpDs1bpe/K5D7IQx3yLbC9F0JFBlxXuMzr+BXzlNby7AaJvlBSC47ZvgnNc8oYf4C0Ft2kkYtDrUXVjt3XC58Jm64OR5X1aRlH+acuOlViGQP2QyXZ4DQydFZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=AfwlhHKA; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="AfwlhHKA"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0ASOYmyKNB3RgIhGnkeOzdiUBhyogbI5E8BpZDTM+OM=;
	b=AfwlhHKAm+GHhb8SEtnX2XkCsp7MyPl+wZ8e70crIdO7WCacoF+tvKMOFjn+dzgrXTtazz/c9
	YG7l9+PWbVlPVt1tV9epDu0twtXI42z62XqZb2B71zawtqDUhE+OB/cY5vDmHMCNFDrxyfL0tBA
	lq5b6xRpQMhBkAAV190Hixk=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4h8Jqv2syfz1cySC;
	Tue, 28 Jul 2026 10:11:55 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 2EA6F40565;
	Tue, 28 Jul 2026 10:21:20 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Jul 2026 10:21:19 +0800
Message-ID: <4e71a9e4-5e15-4ff7-a137-8ed5b4aba721@huawei.com>
Date: Tue, 28 Jul 2026 10:21:18 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add debugfs support for ARM SMMUv3
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <jpb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<wangzhou1@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <jonathan.cameron@huawei.com>,
	<wuyifan50@huawei.com>, <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20260328101706.3448655-1-xiaqinxin@huawei.com>
 <ahY1tY/KL4ynWghX@Asurada-Nvidia>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <ahY1tY/KL4ynWghX@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2026/5/27 08:07:17, Nicolin Chen <nicolinc@nvidia.com> wrote:
> On Wed, May 20, 2026 at 02:37:06PM +0800, Qinxin Xia wrote:
>> Add a comprehensive debugfs framework to the ARM SMMUv3 driver,
>> providing visibility into internal hardware state for debugging
>> and performance analysis. The debugfs entries are organized under
>> /sys/kernel/debug/iommu/arm_smmu_v3/, with per-SMMU instance directories
>> and per-device stream table entries.
>>
>> Each SMMU instance provides:
>> - capabilities – static SMMU features and queue sizes.
>> - registers – SMMU key registers.
>> - stream_table/ – a directory per device with subdirectories per Stream ID.
>>
>> Each Stream ID subdirectory contains:
>> - ste – the Stream Table Entry in decoded and raw format.
>> - cd – all valid Context Descriptors (Stage 1 translation tables) associated with the device.
>> - a symlink named with the device's BDF/name pointing to its sysfs directory for easy navigation.
>>
>> /sys/kernel/debug/iommu/arm_smmu_v3/smmu0/stream_table/
>>      ├── <sid>/
>>      │   ├── ste
>>      │   ├── cd
>>      │   └── <dev_name>
>>
>> Changes since RFCv2:
>>    Address review comments from Nicolin Chen, kernel test robot, and Sashiko
>>    automated review:
> 
> This seems to reuse the same message ID as RFCv2's?
> 
> So, it ended up with attaching to RFCv2, on my side (mutt).
> 
> Sashiko also failed to review against the new patches:
> https://sashiko.dev/#/patchset/20260328101706.3448655-1-xiaqinxin%40huawei.com
> 
> Nicolin
> 

Sorry for the late reply – I've been juggling a few things and missed 
this update earlier.

I'll fold all the fixes into the next spin. Expect v3 soon.:-)

-- 
Thanks,
Qinxin

