Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714C0218582
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728651581; cv=none; b=V1/fizJiCLX0u8FbiF5KI87btLoUgVqPacHlIyQwTmhQ58OWkP24vI0qnYIet2ywxFUiQA1mzo7IKNHVaDFIxkF9CDnfdlzL2hL1BGnWLch7oKpM2dA+Za5VSCyW6MpJHOROvTkp9/lk84JD0TJhLLcmxAtgVAyDE9DYdSmgjX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728651581; c=relaxed/simple;
	bh=GZJ6A/vIL+1uISrRV1LwGKGeOmmHDlvyvMgKUGKWaB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcyXgK7qim0F0Fceggj0UkW7SxZJB0WlFfisPoN9XxX7zw8T6Mb2h8uMu230fN45YWwxA3r3OT08qsLR83eQVLgBVQ2N+Nb0n/etKevAzm6EAtxiycOWmvBDDAJDE2QdGmS5pWetLVv6/zE4uRAuqDh7Ci3wc3jHrBZDJkOW7ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25E94497;
	Fri, 11 Oct 2024 06:00:08 -0700 (PDT)
Received: from [10.57.87.51] (unknown [10.57.87.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C9F83F64C;
	Fri, 11 Oct 2024 05:59:37 -0700 (PDT)
Message-ID: <ec9e47cc-f3c2-4142-8395-3bbb8e055261@arm.com>
Date: Fri, 11 Oct 2024 13:59:36 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Adopt arm_smmu_event in
 handlers
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>,
 iommu@lists.linux.dev
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-3-praan@google.com> <Zvr8xUEHNg1GiA8V@Asurada-Nvidia>
 <ZvxjcpQCFM5SU9P-@google.com> <Zvx+6qBY3og8lRWe@Asurada-Nvidia>
 <Zv8N6yIeNXao_Yqm@google.com> <Zv8gW9KjTcktgve1@Asurada-Nvidia>
 <ZwjZ9txpvqd8kUdS@google.com> <5eda3ba6-c35a-432b-be87-48bd8a0a3bf1@arm.com>
 <ZwkB4OTUChexImZd@google.com> <ZwkGzWSUIpuhHozl@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ZwkGzWSUIpuhHozl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-11 12:06 pm, Pranjal Shrivastava wrote:
> On Fri, Oct 11, 2024 at 10:45:52AM +0000, Pranjal Shrivastava wrote:
>> On Fri, Oct 11, 2024 at 11:21:48AM +0100, Robin Murphy wrote:
>>> On 2024-10-11 8:55 am, Pranjal Shrivastava wrote:
>>>> On Thu, Oct 03, 2024 at 03:53:15PM -0700, Nicolin Chen wrote:
>>>>> On Thu, Oct 03, 2024 at 09:34:35PM +0000, Pranjal Shrivastava wrote:
>>>>>>> The master and master_name are not that necessary to be in the
>>>>>>> arm_smmu_event. I would keep both of them as local variables in
>>>>>>> arm_smmu_handle_evt and pass master_name in to dump().
>>>>>>
>>>>>> Hmm, right or maybe ONLY have the master_name in arm_smmu_event?
>>>>>
>>>>> Just move both out of arm_smmu_event. Keep the master_name as a
>>>>> local variable like the "master". You'd just need to pass it in
>>>>> to the dump(). They both are in that same handle_evt().
>>>>>
>>>>
>>>> Ack.
>>>>
>>>>>>>> Also, shall we rename it to `arm_smmu_read_evt_info` ?
>>>>>>>
>>>>>>> I'd probably use arm_smmu_event_get_from_raw()? Trying to high-
>>>>>>> light struct arm_smmu_event v.s. u64 evt[EVTQ_ENT_DWORDS]. Yet,
>>>>>>> no strong feeling about that.
>>>>>>>
>>>>>>
>>>>>> Ack. How about `read_arm_smmu_event` :)
>>>>>> Unless, we wanna follow the arm_smmu_<func> convention?
>>>>>
>>>>> I think it'd be nicer if we do.
>>>>>
>>>>
>>>> Ack. `arm_smmu_get_evt_from_raw` it is!
>>>
>>> FWIW that sounds needlessly overcomplicated to me - the "raw" event array
>>> should be a member of arm_smmu_event itself, since it seems silly to have
>>> them separate with one pointing to the other when they have the exact same
>>> scope and lifetime anyway. There still shouldn't need to be more than a
>>> single logical step to process an evtq record into a finished
>>> arm_smmu_event, just that that processing is now going to go a bit further
>>> than simply le64_to_cpu().
>>
>> Hmm, are you suggesting something like queue_remove_raw(q, event->raw)?
>> OR do you mean we should have our own queue_parse_evt(q, &event) that
>> parses out the raw event into an `arm_smmu_event` record eliminating the
>> need for the `arm_smmu_read_evt_info` altogether?
>>
>> Because we'd still need to store the raw event anyway since we're still
>> logging the raw event.
>>
>> I think we can go with the former, i.e. queue_remove_raw(q, event->raw)
>> and then use ``arm_smmu_read_evt_info` to populate other `event` fields
> 
> Based on your comment, I was thinking like the attached sample code.
> LMK if you were referring to something like that?

Ah, apologies, it had slipped my mind that queue_read() is already 
buried two layers deep in an abstraction shared with the priq... so 
yeah, rather than start trying to turn that inside-out, I guess the 
neatest approach is to effectively flip this series instead - i.e. start 
with the minor shift to:

	struct arm_smmu_event evt;

	while (!queue_remove_raw(q, evt.raw)) {
		ret = arm_smmu_handle_evt(smmu, &evt);
		...
		dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
		//etc.

and leave arm_smmu_handle_evt() decoding the event as both it and 
arm_smmu_handle_ppr() already do, just now using the new structure 
instead of locals. Then we can come in to factor out and enhance the 
unhandled event report, and anything else specific to that reporting 
beyond the actual SMMU event record, like device names and ratelimiting, 
can remain private to arm_smmu_dump_event().

AFAICS the locking concern seems avoidable as well - we don't actually 
need the whole arm_smmu_master in either case, just the device, so then 
end of arm_smmu_handle_evt() could easily be a little simpler:

	...
	mutex_lock(&smmu->streams_mutex);
	master = arm_smmu_find_master(smmu, sid);
	if (master)
		event->dev = get_device(master->dev);
	mutex_unlock(&smmu->streams_mutex);

	if (!event->dev)
		return -EINVAL;

	return iommu_report_device_fault(event->dev, &fault_evt);

then arm_smmu_dump_event() is safe to use a construct like:

	event->dev ? dev_name(event->dev) : "(unassigned)"

and finally a cleanup in the evtq loop, which by that point probably 
condenses down to something like:

	while (!queue_remove_raw(q, evt.raw)) {
		if (arm_smmu_handle_evt(smmu, &evt))
			arm_smmu_dump_event(&evt);
		put_device(evt.dev);
		cond_resched();
	}

Thanks,
Robin.
