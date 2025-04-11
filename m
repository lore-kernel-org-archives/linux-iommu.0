Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5CE23A9AC
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744395422; cv=none; b=I2M7OuFr9AJMUMJI48o8YvXllucVvAkHlBOOMcbqrf34ipbJ8GsqHDnX6bzWNWlioPKZgGgCXoLg4uqC7SsBvr5dZqbl5y9S72ap5ox/wyoshLkO/ZwRKCYvyrxmSjTnGlOHUTBGkoxExIwfLzO+ZLK6/c4rkKGJ2m6s2GevVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744395422; c=relaxed/simple;
	bh=8UwE/2hW6cCnfyOWnIQacvFPV78drDKtZ5NqzHUymfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6byICNBwcCJCg2EZGYt4KOCYiGe1R/XfbUhVnm4LX6nVm2OvRgt3O4U/S1gAi1h/yK8zsnkjenG73uia+IK64wQ1wRsT0A0mNLW68ZAUQOmlv9McF4n10zC1VUVzWrfr4rX1XWFGFJj5IKiolSQ8He+twaQxeR9qTd0aRV6Vto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 159DA106F;
	Fri, 11 Apr 2025 11:16:59 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CD963F694;
	Fri, 11 Apr 2025 11:16:58 -0700 (PDT)
Message-ID: <9ed7aba6-4d0d-4cfb-a85b-ca943c7e031a@arm.com>
Date: Fri, 11 Apr 2025 19:16:57 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fail aliasing StreamIDs more
 gracefully
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, nicolinc@nvidia.com
References: <39d54e49c8476efc4653e352150d44b185d6d50f.1744380554.git.robin.murphy@arm.com>
 <20250411152122.GF8423@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250411152122.GF8423@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/2025 4:21 pm, Jason Gunthorpe wrote:
> On Fri, Apr 11, 2025 at 03:09:14PM +0100, Robin Murphy wrote:
>> We've never supported StreamID aliasing between devices, and as such
>> they will never have had functioning DMA, but this is not fatal to the
>> SMMU itself. Although aliasing between hard-wired platform device
>> StreamIDs would tend to raise questions about the whole system, in
>> practice it's far more likely to occur relatively innocently due to
>> legacy PCI bridges, where the underlying StreamID mappings are still
>> perfectly reasonable.
>>
>> As such, return a more benign -ENODEV when failing probe for such an
>> unsupported device (and log a more obvious error message), so that it
>> doesn't break the entire SMMU probe now that bus_iommu_probe() runs in
>> the right order and can propagate that error back. The end result is
>> still that the device doesn't get an IOMMU group and probably won't
>> work, same as before.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index b4c21aaed126..c06459f7077b 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -3400,9 +3400,9 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>>   		/* Insert into SID tree */
>>   		if (rb_find_add(&new_stream->node, &smmu->streams,
>>   				arm_smmu_streams_cmp_node)) {
>> -			dev_warn(master->dev, "stream %u already in tree\n",
>> +			dev_warn(master->dev, "Aliasing StreamID 0x%x unsupported, expect DMA to be broken\n",
>>   				 sid);
>> -			ret = -EINVAL;
>> +			ret = -ENODEV;
>>   			break;
> 
> I don't think we should dillute the meaning of ENODEV here. It is
> supposed to mean that the driver does not recognize the device and
> this IOMMU instance doesn't translate for it.

There are already numerous other examples, nothing's being diluted more 
than it already is. TBH I don't see it being particularly valuable 
anyway to try to infer anything more from ENODEV than "this IOMMU 
instance is not providing IOMMU API functionality for this device" - 
there are just as many cases where a driver doesn't even know whether 
it's supposed to be responsible for a given device at a given time, so 
in general it's never going to be possible to be exhaustively accurate. 
That then only leaves a pretty narrow range of conditions where some 
drivers might be able to tell when something's a bit wrong, but not 
terminally so.

> That is different from the iommu instance owning the device but being
> unable to probe it for some reason. The failure recovery in the core
> code should be different.

Perhaps, but right now this is a trivial, obvious fix using the 
mechanisms that we already have and that other drivers are already using 
similarly, that can effectively restore the exact same overall behaviour 
as 6.14 with zero risk.

Nothing in this two-line patch precludes coming back and doing more 
later. In fact in hindsight I wish I'd thought about this a bit more, 
realised it was so simple, and already sent this very patch back with 
the other SMMU-probe-failure fixes back in December, because guess how I 
was triggering those failures? :) Annoyingly I chose to kick the can 
down the road because I know I'm deliberately using a quirky unsupported 
hardware setup...

> IMHO it makes more sense to change this and related:
> 
> static int bus_iommu_probe(const struct bus_type *bus)
> {
> 	struct iommu_group *group, *next;
> 	LIST_HEAD(group_list);
> 	int ret;
> 
> 	ret = bus_for_each_dev(bus, NULL, &group_list, probe_iommu_group);
> 	if (ret)
> 		return ret;
> 
> So that recognized, but failed, devices are contained to only effect
> that device and do not fail the entire iommu or bus registration,
> which is more like how things used to work when the probe path would
> ignore the per-driver failure codes.
> 
> I can't think of a reason why we'd want any per-device failure to also
> abort the whole iommu registration??

Errors which occur during .probe_device clearly don't have to be 
specific to the device - e.g. OOM - but even device-adjacent conditions 
may be sufficiently catastrophic to indicate that it's probably not 
worth continuing - for instance if the arm_smmu_sid_in_range() check 
were to fail then it's clear firmware is giving us bad data, at which 
point we can't necessarily trust *anything* it's said about the SMMU at all.

> It would be nice if the dev->iommu would record that the struct device
> is inoperable and then we can fail
> iommu_device_use_default_domain()/etc in a contained way.

Maybe, but what would the nature of that containment be? I mean, after 2 
years even the blocking domain stuff we already have still isn't any 
closer to doing anything "nice". And if an IOMMU driver has already 
reported some unexpected condition with a device that it can't handle, 
what can the core code actually expect to do? It's not like it can ask 
the same IOMMU driver to then block the device that it couldn't probe. I 
don't see that there's really much the core code can do to "recover" 
from unexpected driver errors, other than leave the user to pick up the 
pieces, and often the best chance for that *is* going to be to give up 
entirely, fail and disable the IOMMU, because otherwise blocking I/O 
might prevent the user seeing anything at all.

And for any remaining niche cases of "expected" errors like this one 
where the driver could in principle support the thing but doesn't due to 
its own limitation, honestly don't spend effort on gold-plating that 
limitation in core code, just spend it on making the driver support the 
thing instead.

Thanks,
Robin.
