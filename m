Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32B93368A8
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678367; cv=none; b=L7PR6+TrCf5e8ln386BUOrklye2kf7kbpMNTiF0jbH768EZ9U9MLtM2NDMIKtVdvFsjcVQHnkBlk6wW3mbJ7OhT7J2kZrcmXbRvEtnL2FpUMbVnZ3gL5dwy7vutvRTtwsVEGCdg49kHRTNL5pL75v3fYwQehls6lCT0gyvABbzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678367; c=relaxed/simple;
	bh=danjYofLdQduplStXzmplN2Gi7ayXqHyB8lzlIAADpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjX+V2TlFvmKfwVTrwaYYkiVNH+X51GJyRbBH5CpGimgv6vbj7sPhboSQxBhHEjMXOzcMXb3R/tndMQrngUVV8nh7nyKSM6SFYOCjPWQMV3/9Z3nRpEVm8TspNThhWDzBpXamZ/JiMf8mpkziwVweCrsG5yzPdfSr6ku9ocC10c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 245681477;
	Mon, 16 Mar 2026 09:25:59 -0700 (PDT)
Received: from [10.57.61.116] (unknown [10.57.61.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D61F33F73B;
	Mon, 16 Mar 2026 09:26:02 -0700 (PDT)
Message-ID: <e2fb2f38-2a31-473e-9ab2-efae8e7a0303@arm.com>
Date: Mon, 16 Mar 2026 16:26:00 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] iommu/arm-smmu-v3: Add register display to
 debugfs
To: Qinxin Xia <xiaqinxin@huawei.com>, will@kernel.org, jpb@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 wangzhou1@hisilicon.com, prime.zeng@hisilicon.com, fanghao11@huawei.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com
References: <20260313104351.3502293-1-xiaqinxin@huawei.com>
 <20260313104351.3502293-3-xiaqinxin@huawei.com>
 <68add41b-bafa-4884-be70-c03d6ce851eb@arm.com>
 <1a42d502-a2c4-4c41-ba7e-4dc115159ed6@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <1a42d502-a2c4-4c41-ba7e-4dc115159ed6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-03-16 3:35 pm, Qinxin Xia wrote:
>>> +    /* 32-bit control registers */
>>> +    seq_printf(seq, "CR0: 0x%08x [%s%s%s]\n",
>>> +           readl_relaxed(base + ARM_SMMU_CR0),
>>> +           readl_relaxed(base + ARM_SMMU_CR0) & CR0_SMMUEN ?
>>> +           "Enabled " : "Disabled ",
>>> +           readl_relaxed(base + ARM_SMMU_CR0) & CR0_EVTQEN ?
>>> +           "EventQ " : "",
>>> +           readl_relaxed(base + ARM_SMMU_CR0) & CR0_CMDQEN ?
>>> +           "CmdQ " : "");
>>
>> There's really no point printing these extra strings, since if any of 
>> those were *not* enabled then we'd have already failed probe and never 
>> created the debugfs entry. And if anyone ever were to be trying to 
>> change the driver behaviour at that level, I'd very much expect them 
>> to be able to be able to read the bottom 4 bits of a CR0 value in hex 
>> anyway ;)
>>
>> Thanks,
>> Robin.
>>
> 
> Since Kunpeng supports ECMDQ(have not been submitted upstream), the
> intention was to check whether the SMMU supports ECMDQ, and the logging
> for other queues was added incidentally. The prints for the event queue
> and command queue indeed seem unnecessary. I will remove them in the
> next version.
OK, I would make a similar argument that even then, it wouldn't make 
sense to expose debugfs entries for ECMDQ_PROD registers that don't 
exist or we aren't using. Thus their enabled state should similarly be 
inherent in the files being present at all (but again either way, if a 
developer couldn't tell the significance of 0x80xxxxxx vs. 0x00xxxxxx 
already then I'd have to question their capability to usefully debug any 
more subtle ECMDQ behaviour...)

Thanks,
Robin.
