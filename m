Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BBD560AA8
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092361; cv=none; b=Cjb2Zo/ERpMZjB17JDPePjCNuKt74GnEwBZwZzlX3TDiZ/6IGPWegVttWeFFp2IBJ+oqPigjGuqEKq2ZWgg9g0bPZijFk+5o0XB3BSO7+sOXOuYAZf+YEwam/6zHLHn3WgMS8j+t2qn1lh9aJpbxy21One46wI30/KSrUW+IpOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092361; c=relaxed/simple;
	bh=QXkqCPySi5pz7XgdaRzbBeXXq0xzGh50Y6EVmcAY8zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sl5cfPJaJjmsAFDisLjG2Bz5psNS/CghwQ1SSo5k2G327rKPq0l/dqnFtcPV+gjfiVVIbuZCZCLmvbbkFiAqvMqOAeGDAzSlIeQ2ic2e2wqvxFEeDq69ztWlhgVukQ3HrZzZ/UoCWZDt0ysDB06rljk5/6wRwgXYvytsuovAfRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oZix9XUP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oZix9XUP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6D231576;
	Tue, 22 Sep 2026 08:52:34 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39CF83F86F;
	Tue, 22 Sep 2026 08:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790092358; bh=QXkqCPySi5pz7XgdaRzbBeXXq0xzGh50Y6EVmcAY8zY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oZix9XUP55kqOWVW+bfYG9UjgcMAazDK3HOVVEbFE3DS3uNXTOXe520r1mUw6E6lo
	 20jvGUvIZtXOrhSY+gykvbq9ah2h0pYuQyUF+IHtdmoHFiK2hXDtWVL34VCdra+7Xz
	 jzeycyKKbWFEKl6P58faJ33saYp+8eGTfCsMCwYk=
Message-ID: <31be5621-92f6-4101-898f-806335d56155@arm.com>
Date: Tue, 22 Sep 2026 16:52:35 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/4] iommu/arm-smmu-v3: Support shared SIDs in
 insert/remove_master
To: Peng Fan <peng.fan@oss.nxp.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, joro@8bytes.org, jpb@kernel.org, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, peng.fan@nxp.com
References: <20260921-smmu-shared-sid-v2-0-4b656ce68178@nxp.com>
 <20260921123846.1663580-1-peng.fan@oss.nxp.com> <arG6hmng3NddGEHm@nvidia.com>
 <arKNJH2YWQT9KL7x@shlinux89>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <arKNJH2YWQT9KL7x@shlinux89>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/09/2026 3:13 pm, Peng Fan wrote:
> On Mon, Sep 21, 2026 at 04:15:18PM -0700, Nicolin Chen wrote:
>> On Mon, Sep 21, 2026 at 08:38:46PM +0800, Peng Fan (OSS) wrote:
>>> @@ -976,6 +976,24 @@ struct arm_smmu_device {
>>>   struct arm_smmu_stream {
>>>   	u32				id;
>>>   	struct arm_smmu_master		*master;
>>> +	/*
>>> +	 * ref_count > 1 means multiple masters share this SID.  Protected by
>>> +	 * smmu->streams_mutex.
>>> +	 */
>>> +	unsigned int			ref_count;
>>> +	/*
>>> +	 * When ref_count > 1 the STE has already been written by the first
>>> +	 * master; subsequent masters must skip the write.
>>> +	 */
>>> +	bool				ste_installed;
>>> +	/*
>>> +	 * Links all arm_smmu_stream objects that share the same SID across
>>> +	 * different masters.  The canonical (XArray-stored) entry is the list
>>> +	 * head; non-owning sharers are linked into it.  Used to transfer
>>> +	 * XArray ownership when the current owner is removed.
>>> +	 * Protected by smmu->streams_mutex.
>>> +	 */
>>> +	struct list_head		shared_link;
>>>   };
>>
>> SID-sharing masters still allocate their own streams. Though the
>> SIDs are the same number, they own duplicated streams linked via
>> that "shared_link" list.
>>
>>   master_a->stream[0] --> stream (SID=X) --|
>>                                       shared_link
>>   master_b->stream[0] --> stream (SID=X) --|
>>
>> But maybe they could share the stream structure directly? I.e.
>>
>>   master_a->stream[0] --|
>>                         |--> shared stream (SID=X)
>>   master_b->stream[0] --|
>>
>>
>> The stream structure would still need a list for shared_masters:
>>
>> struct arm_smmu_stream {
>> [...]
>> 	/* Every sharing master, ->master included. Empty unless shared */
>> 	struct list_head shared_masters;
>> };
>>
>> ref_count could be simply !list_empty(&stream->shared_masters).
> 
> Agree.
> 
>>
>>
>> Does i.MX need to support SID-sharing with multi-SD device? If not,
>> the master could have only a simple shared_masters_elm:
> 
> For i.MX, there is no need to support SID sharing for multi-SID device for now.
> Not sure, in future there are cases that needs SID sharing for multi-SID device.

I have a system meeting those conditions :)

Specifically, I have a physical PCIe-to-PCI bridge board with a couple 
of ancient cards plugged into it (such that they each end up with their 
own RID plus the common bridge alias RID) just in case I ever got round 
to looking at this myself...

(And for added fun, one of the cards only supports 31-bit DMA and the 
machine doesn't have any RAM low enough for it to work without the SMMU 
at all)

Cheers,
Robin.

> 
> I could update in V3 following your suggestion.
> 
> Thanks,
> Peng
> 
>>
>> struct arm_smmu_master {
>> [....]
>> 	/* Supports num_streams == 1 only. Empty if SID is not shared */
>> 	struct list_head shared_masters_elm;
>> };
>>
>>> @@ -1024,6 +1042,11 @@ struct arm_smmu_master {
>>>   	bool				ste_ats_enabled : 1;
>>>   	bool				stall_enabled;
>>>   	bool				ats_always_on;
>>> +	/*
>>> +	 * True when at least one of this master's SIDs is shared with another
>>> +	 * master.  SVA, stall and IOPF are disabled for such masters.
>>> +	 */
>>> +	bool				shared_sid;
>>
>> Then, this could be !list_empty(&master->shared_masters_elm).
>>
>> Nicolin
>>
>>

