Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498321A239D
	for <iommu@lists.linux.dev>; Wed,  8 Jan 2025 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736339879; cv=none; b=gPv1mFSHhHBDI87KmwgdWfdNC6eMCBCVGbALzkXXY+HfB4J8qQ61UBkzI3d/Y7I5lOUvK1V9OKuACAZgDwCVRHOocdi71xv3osKUd6su8JB6aQdjh3aBHsNwfrVR6nEndzMQqS4YS84wsFsQDYGzQ642FplJDbK3JJgGPOQX1fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736339879; c=relaxed/simple;
	bh=yb9EUqn7WZ0y1MaeoScWpJbB8IISrvkIkI2rXiU3t8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfO97uK6eQF6Ba7To5zxXeC6XX1MYsVM7lQxIO6MqDubHAhAWHv4e3aiw27t/TwC6fr+0tswEIOUZ5VnYwhby05rEotT4HDals4TyBuq+F1uT+tpP7A/GIJhV+hrJjZED98ISlYDmnkoTSKSHe5mE7kzzxIhvuzP67HMXyhOt2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B94FD12FC;
	Wed,  8 Jan 2025 04:38:23 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D1DD3F66E;
	Wed,  8 Jan 2025 04:37:54 -0800 (PST)
Message-ID: <cb2db54e-37e8-495d-916a-4e63c67019bb@arm.com>
Date: Wed, 8 Jan 2025 12:37:30 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] iommu: fix wrong DMA ops for iommu device
To: Will Deacon <will@kernel.org>,
 Charan Teja Kalla <quic_charante@quicinc.com>
Cc: joro@8bytes.org, jgg@ziepe.ca, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241213150415.653821-1-quic_charante@quicinc.com>
 <91d15d11-ec53-4ca2-a385-9fa69d861f2c@quicinc.com>
 <20250103153434.GC3816@willie-the-truck>
 <e8fa02bb-96b7-4010-92c9-7e1eb485a551@quicinc.com>
 <20250107113126.GA6932@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250107113126.GA6932@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/01/2025 11:31 am, Will Deacon wrote:
> On Mon, Jan 06, 2025 at 06:46:08PM +0530, Charan Teja Kalla wrote:
>> On 1/3/2025 9:04 PM, Will Deacon wrote:
>>> On Thu, Jan 02, 2025 at 04:09:46PM +0530, Charan Teja Kalla wrote:
>>>> On 12/13/2024 8:34 PM, Charan Teja Kalla wrote:
>>>>> Race between smmu device probe and iommu device probe is resulting into
>>>>> wrong DMA ops used for the device.
>>>>>
>>>>> bus_iommu_probe(P1)                  of_iommu_configure(P2)
>>>>> (from iommu_device_register)        (from insmod of a driver)
>>>>> --------------------------         --------------------------
>>>>> 1) probe_iommu_group()
>>>>> (Fills just dev->iommu_group
>>>>> under iommu_probe_device_lock)
>>>>> 				2) iommu_probe_device():
>>>>> 				  (acquires the iommu_probe_device_lock,
>>>>> 				   but since dev->iommu_group is already
>>>>> 				   set, it just returns without
>>>>> 				   allocating the domain.)
>>>>>
>>>>> 				3) of_dma_configure_id()->
>>>>> 				   arch_setup_dma_ops() gets called for
>>>>> 				   this device, but returns with the
>>>>> 				   error message:
>>>>> 				   "Failed to set up IOMMU for device;
>>>>> 				    retaining platform DMA ops"
>>>>>
>>>>> 				4) device probe is succeeded where it
>>>>> 				   can now setup iommu mappings using
>>>>> 				   wrong ->dma_ops
>>>>>
>>>>> 5) domain will be allocated later
>>>>> and fills iommu_group->domain.
>>>>>
>>>>> Step 3) and 4) denies iommu device from using 'iommu_dma_ops'.
>>>>>
>>>>> This issue does exists on 6.6 because of commit f188056352bc ("iommu:
>>>>> Avoid locking/unlocking for iommu_probe_device()") without which 2)
>>>>> returns only after filling the domain under group->mutex, thus no issue.
>>>>>
>>>>> With commit b5c58b2fdc42("dma-mapping: direct calls for dma-iommu"),
>>>>> ->iommu_dma_ops is removed altogether and iommu api are directly being
>>>>> called under "use_dma_iommu(): return dev->dma_iommu". Again,
>>>>> ->dma_iommu flag is set only after domain allocation. So, If
>>>>> there is a sufficient delay between steps 4) and 5), issue is still
>>>>> exists but that seems very narrow to me.
>>>>>
>>>>> I am thinking, setup of the domain before returning from step2) is the
>>>>> way to fix this issue. Can you please help if you have any suggestions?
>>>>>
>>>>> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
>>>>> ---
>>>>>   drivers/iommu/iommu.c | 26 +++++++++++++++++++++++++-
>>>>>   1 file changed, 25 insertions(+), 1 deletion(-)
>>>>
>>>> Just a quick ask if you have any comments for the below. BTW, in
>>>> internal tests, when we revert the commit f188056352bc ("iommu: Avoid
>>>> locking/unlocking for iommu_probe_device()", it is helping.
>>>>
>>>> I can share more details If the below is not sufficient.
>>>>
>>>> Thanks in advance...
>>>
>>> Can you reproduce the issue on 6.13-rc5? We bodged some of the probe
>>> code recently:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=229e6ee43d2a160a1592b83aad620d6027084aad
>>>
>>> and a better set of fixes are queued in -next.
>>
>> Yes, we did try a better patch from Robin[1] and the issue is still
>> reproducible.
> 
> Did you try the -EPROBE_DEFER hack that got merged?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=229e6ee43d2a160a1592b83aad620d6027084aad
> 
> Otherwise, you can try the stack queued for 6.14 in iommu/linux.git:
> 
> 46b3df8eb9bd iommu: Manage driver probe deferral better
> fcbd62156742 iommu/arm-smmu-v3: Clean up more on probe failure
> 97cb1fa02726 iommu/arm-smmu: Retire probe deferral workaround
> 7d835134d4e1 iommu/arm-smmu: Make instance lookup robust
> 
>> IIUC, these patches are trying to get valid smmu device, during the
>> probe of an smmu client device, by traversing proper 'klist_devices'
>> happening from iommu_init_device(). Please CMIW.
> 
> Well, they're fixing a race between the IOMMU probing and its client
> devices attaching.
> 
>> But this bug makes iommu_init_device() to completely gets skipped.
>>
>> static int __iommu_probe_device(struct device *dev, ...)
>> {
>> 	/* Device is probed already if in a group */
>>          if (dev->iommu_group)
>>                  return 0;  --> driver call returns from here.
>>
>>          ret = iommu_init_device(dev, ops);
>>          if (ret)
>>                  return ret;
>>
>>
>> }
>>
>> Regarding the testing, we work on Android that is on LTS kernels, so, it
>> may not be possible for us to try the thing on 6.13 and this seems a bug
>> on LTS 6.6 kernel.
> 
> We need to fix 6.13 before we fix 6.6 unless you can show that 6.13 is
> unaffected (in which case, we can backport the fix(es)).

Certainly the reasoning can't apply to mainline as given, since 
arch_setup_dma_ops() stopped touching IOMMU stuff at all back in 6.10 
(and indeed iommu_dma_ops itself no longer exists since 6.12).

Robin.
