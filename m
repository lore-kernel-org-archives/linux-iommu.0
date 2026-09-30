Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FED74D7D4C;
	Wed, 30 Sep 2026 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775629; cv=none; b=YiasC9ZJUDP+Om55aHUDA4ylLHvBmSiWABtjsmuDFrtgD1hnIuTPVJEDdHn6HQxEf8LgQjT2eQbVe3rDJ2rhZOASZSMQWxtDqoQLn2vwpwuBPYaLV7jWT6qXJ0jms8ROqOkinrEXP8ANhD+v+vIDIkbLTjcrSRK9FpEjVlLsfG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775629; c=relaxed/simple;
	bh=gXjhnLdf0di1wH+YN9epKiexWhOlfZuDsVWloANcD/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4bFrfFMgSt4kZvglG7d6/b8m0OshBrmjLXi78hoDV9NjllWcOsjtyviF5KKDyyCN6oQoHEJdPU0zvnaxplgTCylRvFoATEQugrrvdvcL6ahxEvcoZF1XuMEHn43OkP25ZJ3VZsjE28AbpTGIKhama2bAZ+7iKa/r01+6IqNW98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ge1pkB74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ge1pkB74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D61D1F00898;
	Wed, 30 Sep 2026 13:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775601;
	bh=xFqLMFXAho7vsZRRn0lFyqFwU98ZhNOqftrzkrRFoC8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ge1pkB74bT/Wcn4MCiLS13cv/WWIgkybItc4pJaNSoeQGHLZEp1GeXvnih86sfDmQ
	 gI9SWzwOPFWN0Qe6w0gb4QeVVIABP8/q9zz5LF/N5s2wNyMCKbUZk2Mr+MhdDn/VqM
	 tGQ4SIXuz7q+43B4g1ur4qsSUxHbBispksRWP2psjje2lyn86DeVIRZuJ0RhWKdk2o
	 QiJRGkt6QFH4E5uANg129CAH9FTS75B6BrIAK9e5H1TX0R7iappJqztzv9QedxiPhV
	 ZEFnTpv9B/WTN1s2GIL2Lnm4I5H3idt6CQN4ZW5/qcGgaML3eh21Rg1SjRBWx9NG0+
	 z/j9HDK2QkQEQ==
Message-ID: <edae0bd0-e580-45f2-953e-dd117791c488@kernel.org>
Date: Wed, 30 Sep 2026 08:39:59 -0500
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/amd: Make PerfOpt compulsory
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>
References: <20260929013423.2313648-1-superm1@kernel.org>
 <bd707bac-26c1-4330-9e29-a8eaec07745b@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <bd707bac-26c1-4330-9e29-a8eaec07745b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/26 04:38, Vasant Hegde wrote:
> Mario,
> 
> On 9/29/2026 7:04 AM, Mario Limonciello (AMD) wrote:
>> PerfOpt is only a feature usable by integrated GPUs and only in identity
>> mode.  Instead of leaving a policy knob in amdgpu, just turn it on when
>> an integrated GPU is in identity.
>>
>> This drops quite a bit of compatibility glue.  There was a refcounting
>> system, exported symbols, and device attach/detach logic.  By just setting
>> it immediately it's a lot more straightforward.
>>
>> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>> v2:
>>   * Move WARN_ON to amd_iommu_perfopt_clear()
>>   * Make amd_iommu_perfopt_clear() void
>>   * Drop unnecessary cleanup/create paths that unset feature
>>   * Enable the feature in IOMMU if supported (per guidance in IVRS spec)
>>   * Use existing check_feature() helper instead
>> ---
> 
> 
> .../...
> 
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index c9b28e5e582ea..a1adb40d5b79d 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2345,6 +2345,35 @@ static void pdom_detach_iommu(struct amd_iommu *iommu,
>>   	spin_unlock_irqrestore(&pdom->lock, flags);
>>   }
>>   
>> +/*
>> + * Program or clear the per-IOMMU PerfOpt enable bit
>> + * This allows a privileged internal GPU to be able to bypass IOMMU when
>> + * in identity mode.
>> + */
>> +int amd_iommu_perfopt_set(struct amd_iommu *iommu, bool enable)
> 
> Please move this to init.c file

Thanks, good suggestion.

> 
>> +{
>> +	u32 old, val, readback;
>> +
>> +	if (!check_feature(FEATURE_PERF_OPT))
>> +		return enable ? -ENODEV : 0;
>> +
>> +	old = readl(iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
>> +	if (old == U32_MAX)
>> +		return -EIO;
>> +
>> +	val = enable ? old | PERF_OPT_EN : old & ~PERF_OPT_EN;
>> +	if (val != old)
>> +		writel(val, iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
>> +	readback = readl(iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
>> +	if (readback == U32_MAX ||
>> +	    (readback & PERF_OPT_EN) != (val & PERF_OPT_EN)) {
>> +		dev_err(iommu->iommu.dev, "Failed to set PerfOpt to %d\n", enable);
>> +		return -EIO;
>> +	}
>> +
> 
> May be check return value before enabling dev_data->perfopt?

I thought about this.

Let me know what you think of the approach of clearing the bit in 
amd_iommu_efr on failures within amd_iommu_perfopt_set().

That would mean that dev_data->perfopt doesn't get enabled later.
