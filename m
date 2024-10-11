Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B5528EB
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642113; cv=none; b=fiNcQd7NOO8XiB6Bnxm4s2s33kLr7Y5kwuPnbqGdtE8dYdZHkOhaHDusoBFAMoMr95GKvQRLYzicTdjov8MnacRK9NPJKHNsMcmQAhDFZxd06VwOl5Wwo59Rx6qKY5uIJCAJ64h26Pa0ypeVx18XGIvjSpbqISDTyE+bFfxptKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642113; c=relaxed/simple;
	bh=v1LGwrMUAzgHqwN0H74YyRTfGUcVhDoKeOH/GcOi/1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdX6yZCZBfT64s3MqY6ysbbqVYyWI/zOBxqytaBdCRNMJB+c4KhK7J5CybNS3N7DvB04d3y7ooeMB5Wo4488yOvbNSu5hrTr6uk2yiA+JIOyZOJBu+sRGsRkXm+SBJ1qdgfj+UrDF9TvjVQEEZANsfGcuihqA+Cp2V/9QiedV+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4276497;
	Fri, 11 Oct 2024 03:22:19 -0700 (PDT)
Received: from [10.57.87.51] (unknown [10.57.87.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36CFF3F73F;
	Fri, 11 Oct 2024 03:21:49 -0700 (PDT)
Message-ID: <5eda3ba6-c35a-432b-be87-48bd8a0a3bf1@arm.com>
Date: Fri, 11 Oct 2024 11:21:48 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Adopt arm_smmu_event in
 handlers
To: Pranjal Shrivastava <praan@google.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-3-praan@google.com> <Zvr8xUEHNg1GiA8V@Asurada-Nvidia>
 <ZvxjcpQCFM5SU9P-@google.com> <Zvx+6qBY3og8lRWe@Asurada-Nvidia>
 <Zv8N6yIeNXao_Yqm@google.com> <Zv8gW9KjTcktgve1@Asurada-Nvidia>
 <ZwjZ9txpvqd8kUdS@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ZwjZ9txpvqd8kUdS@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-11 8:55 am, Pranjal Shrivastava wrote:
> On Thu, Oct 03, 2024 at 03:53:15PM -0700, Nicolin Chen wrote:
>> On Thu, Oct 03, 2024 at 09:34:35PM +0000, Pranjal Shrivastava wrote:
>>>> The master and master_name are not that necessary to be in the
>>>> arm_smmu_event. I would keep both of them as local variables in
>>>> arm_smmu_handle_evt and pass master_name in to dump().
>>>
>>> Hmm, right or maybe ONLY have the master_name in arm_smmu_event?
>>
>> Just move both out of arm_smmu_event. Keep the master_name as a
>> local variable like the "master". You'd just need to pass it in
>> to the dump(). They both are in that same handle_evt().
>>
> 
> Ack.
> 
>>>>> Also, shall we rename it to `arm_smmu_read_evt_info` ?
>>>>
>>>> I'd probably use arm_smmu_event_get_from_raw()? Trying to high-
>>>> light struct arm_smmu_event v.s. u64 evt[EVTQ_ENT_DWORDS]. Yet,
>>>> no strong feeling about that.
>>>>
>>>
>>> Ack. How about `read_arm_smmu_event` :)
>>> Unless, we wanna follow the arm_smmu_<func> convention?
>>
>> I think it'd be nicer if we do.
>>
> 
> Ack. `arm_smmu_get_evt_from_raw` it is!

FWIW that sounds needlessly overcomplicated to me - the "raw" event 
array should be a member of arm_smmu_event itself, since it seems silly 
to have them separate with one pointing to the other when they have the 
exact same scope and lifetime anyway. There still shouldn't need to be 
more than a single logical step to process an evtq record into a 
finished arm_smmu_event, just that that processing is now going to go a 
bit further than simply le64_to_cpu().

Thanks,
Robin.
