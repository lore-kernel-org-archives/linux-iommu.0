Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215B31F80AC
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729022642; cv=none; b=INmV8e8RbE+OkD6DGBEOVkpn8kLL6V6B6hveDN7N16JIRzO2EqEd5icXjG7cUHaD3gDa82o7MMJyQtdnrx411MueYGdXcNtJFRsHwfS40unXvenzrK/458qE1doSnIVvdMGjkyadGJ6xAcqpBE72bFyQCS2yqybfXExbO6ZNWto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729022642; c=relaxed/simple;
	bh=ZbTXm1Omn0jSRIuahYNZMh7N/M0D0GnsWyqMc563uC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Db3gcMCLCXJYqIE6xFdv7Uip6GhVYOBhBsd1mx1E9d5/KMYb3pZUJr04oPk0qJf5/tfDG+SUOEerZ35ghsk8U+K3+i5aPil8uxHxR8M/chLcxWHHrQZzAyw2ICoatk7cgyDIOMIISdfO4qz3X6PXxjTmIqqQh6+jWeutEWUODoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9AF7FEC;
	Tue, 15 Oct 2024 13:04:27 -0700 (PDT)
Received: from [10.57.87.12] (unknown [10.57.87.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B64F63F71E;
	Tue, 15 Oct 2024 13:03:56 -0700 (PDT)
Message-ID: <cac41a3d-b5fc-4269-8a87-a70cf33f410b@arm.com>
Date: Tue, 15 Oct 2024 21:03:54 +0100
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
References: <Zvr8xUEHNg1GiA8V@Asurada-Nvidia> <ZvxjcpQCFM5SU9P-@google.com>
 <Zvx+6qBY3og8lRWe@Asurada-Nvidia> <Zv8N6yIeNXao_Yqm@google.com>
 <Zv8gW9KjTcktgve1@Asurada-Nvidia> <ZwjZ9txpvqd8kUdS@google.com>
 <5eda3ba6-c35a-432b-be87-48bd8a0a3bf1@arm.com> <ZwkB4OTUChexImZd@google.com>
 <ZwkGzWSUIpuhHozl@google.com> <ec9e47cc-f3c2-4142-8395-3bbb8e055261@arm.com>
 <Zw61rP2F0sm_eDiK@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Zw61rP2F0sm_eDiK@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-15 7:34 pm, Pranjal Shrivastava wrote:
> Just a few things before I respin,
> On Fri, Oct 11, 2024 at 01:59:36PM +0100, Robin Murphy wrote:
>> On 2024-10-11 12:06 pm, Pranjal Shrivastava wrote:
>>> On Fri, Oct 11, 2024 at 10:45:52AM +0000, Pranjal Shrivastava wrote:
>>>> On Fri, Oct 11, 2024 at 11:21:48AM +0100, Robin Murphy wrote:
>>>>> On 2024-10-11 8:55 am, Pranjal Shrivastava wrote:
>>>>>> On Thu, Oct 03, 2024 at 03:53:15PM -0700, Nicolin Chen wrote:
>>>>>>> On Thu, Oct 03, 2024 at 09:34:35PM +0000, Pranjal Shrivastava wrote:
>>>>>>>>> The master and master_name are not that necessary to be in the
>>>>>>>>> arm_smmu_event. I would keep both of them as local variables in
>>>>>>>>> arm_smmu_handle_evt and pass master_name in to dump().
>>>>>>>>
>>>>>>>> Hmm, right or maybe ONLY have the master_name in arm_smmu_event?
>>>>>>>
>>>>>>> Just move both out of arm_smmu_event. Keep the master_name as a
>>>>>>> local variable like the "master". You'd just need to pass it in
>>>>>>> to the dump(). They both are in that same handle_evt().
>>>>>>>
>>>>>>
>>>>>> Ack.
>>>>>>
>>>>>>>>>> Also, shall we rename it to `arm_smmu_read_evt_info` ?
>>>>>>>>>
>>>>>>>>> I'd probably use arm_smmu_event_get_from_raw()? Trying to high-
>>>>>>>>> light struct arm_smmu_event v.s. u64 evt[EVTQ_ENT_DWORDS]. Yet,
>>>>>>>>> no strong feeling about that.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Ack. How about `read_arm_smmu_event` :)
>>>>>>>> Unless, we wanna follow the arm_smmu_<func> convention?
>>>>>>>
>>>>>>> I think it'd be nicer if we do.
>>>>>>>
>>>>>>
>>>>>> Ack. `arm_smmu_get_evt_from_raw` it is!
>>>>>
>>>>> FWIW that sounds needlessly overcomplicated to me - the "raw" event array
>>>>> should be a member of arm_smmu_event itself, since it seems silly to have
>>>>> them separate with one pointing to the other when they have the exact same
>>>>> scope and lifetime anyway. There still shouldn't need to be more than a
>>>>> single logical step to process an evtq record into a finished
>>>>> arm_smmu_event, just that that processing is now going to go a bit further
>>>>> than simply le64_to_cpu().
>>>>
>>>> Hmm, are you suggesting something like queue_remove_raw(q, event->raw)?
>>>> OR do you mean we should have our own queue_parse_evt(q, &event) that
>>>> parses out the raw event into an `arm_smmu_event` record eliminating the
>>>> need for the `arm_smmu_read_evt_info` altogether?
>>>>
>>>> Because we'd still need to store the raw event anyway since we're still
>>>> logging the raw event.
>>>>
>>>> I think we can go with the former, i.e. queue_remove_raw(q, event->raw)
>>>> and then use ``arm_smmu_read_evt_info` to populate other `event` fields
>>>
>>> Based on your comment, I was thinking like the attached sample code.
>>> LMK if you were referring to something like that?
>>
>> Ah, apologies, it had slipped my mind that queue_read() is already buried
>> two layers deep in an abstraction shared with the priq... so yeah, rather
>> than start trying to turn that inside-out, I guess the neatest approach is
>> to effectively flip this series instead - i.e. start with the minor shift
>> to:
>>
>> 	struct arm_smmu_event evt;
>>
>> 	while (!queue_remove_raw(q, evt.raw)) {
>> 		ret = arm_smmu_handle_evt(smmu, &evt);
>> 		...
>> 		dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
>> 		//etc.
>>
>> and leave arm_smmu_handle_evt() decoding the event as both it and
>> arm_smmu_handle_ppr() already do, just now using the new structure instead
>> of locals. Then we can come in to factor out and enhance the unhandled event
>> report, and anything else specific to that reporting beyond the actual SMMU
>> event record, like device names and ratelimiting, can remain private to
>> arm_smmu_dump_event().
> 
> Quick clarification, the ratelimiting here was ONLY for logs or to limit
> the number of thread / loop executions?

Yes, the ratelimit is purely for the printks, so once those are factored 
out into a dedicated function it can move with them. The cond_resched() 
is what keeps the loop itself well-behaved if there's a giant flood of 
events; we never want to skip trying to handle any of them.

>>
>> AFAICS the locking concern seems avoidable as well - we don't actually need
>> the whole arm_smmu_master in either case, just the device, so then end of
>> arm_smmu_handle_evt() could easily be a little simpler:
>>
>> 	...
>> 	mutex_lock(&smmu->streams_mutex);
>> 	master = arm_smmu_find_master(smmu, sid);
>> 	if (master)
>> 		event->dev = get_device(master->dev);
>> 	mutex_unlock(&smmu->streams_mutex);
>>
>> 	if (!event->dev)
>> 		return -EINVAL;
> 
> Thinking about this a little more, I guess there are a few paths that
> may return before we even get to the `mutex_lock(&smmu->streams_mutex)`
> For example: if (!event->stall) return -ENOTSUPP; and the default case
> return from the switch case. Which has the following implications:
> 
> 1. We might return from `arm_smmu_handle_evt` before logging the event
> 2. Even if we move the logging out of `arm_smmu_handle_evt` as presented
>     by Robin's snippet above, event->dev might still be NULL.

The point is that it *can* be NULL in general, and the logging must 
expect that. Just move the arm_smmu_find_master() stanza to the top of 
arm_smmu_handle_evt() to grab the device reference before any of the 
actual handling may start wanting to bail out - same as you'll want to 
do for all the other decoding as well - then we know it's either valid 
(and stable) or NULL for the lifetime of the event through all 
subsequent processing. AFAICS calling iommu_report_device_fault() under 
streams_mutex isn't meaningful in itself, right now it just seems to be 
about protecting the inline "master->dev" dereference against "master" 
going away.

We can still have multiple returns as appropriate in the actual handling 
*after* collecting all the arm_smmu_event data, which is a big part of 
why I've suggested keeping the same effective structure as currently - 
we have one function to decode and try to handle the event, and based on 
the final outcome of that function, we may then want to report if it 
wasn't handled (subject to other constraints like ratelimiting). There's 
absolutely no need to tie the control flow in knots attempting to 
nano-optimise that into a tail call - using the returned value in the 
returned-to scope is natural, simple and obvious.

Thanks,
Robin.
