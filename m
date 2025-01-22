Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29E5214219
	for <iommu@lists.linux.dev>; Wed, 22 Jan 2025 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737557003; cv=none; b=Rzvj6lNZMhbanAcZwAaEiJAaiiNW3p1aXUDNU8wit3QzNmOqto+OZeI4YN8t2ksczjVWzqurfJRYWxc/GM8oO7USrTVpT20yp0yv3hWlTNw8VrP23NNU/gYwmWfqNNeq30wpof1aQnARDfD36+t7nDEoy6YvjoGXxzA4XMQWzF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737557003; c=relaxed/simple;
	bh=KYiDTkybzkJ32uZc1+ww1Y5A+sPiA3XTOkdu1QslXEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxTVIVlXOnHhyb0JC2i4CjGk2IR0D3btvBiAZcXzmJTWnfHgVoTOBZt4/Y4q+NC/WHJbaX6IPJTaXBuIrljaAuw3rTCyqn/I/7Mq/UuU7Abcn0HTciSmFnDsMvOGvEL8a5Fh73o4+T/uysggevoDd4ezK8ZYFoQqdQIJ+ah71w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A46A1007;
	Wed, 22 Jan 2025 06:43:48 -0800 (PST)
Received: from [10.57.6.202] (unknown [10.57.6.202])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3FB93F738;
	Wed, 22 Jan 2025 06:43:18 -0800 (PST)
Message-ID: <deb6f541-a09d-457f-a5e3-8302e57cc332@arm.com>
Date: Wed, 22 Jan 2025 14:43:17 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] iommu: fix wrong DMA ops for iommu device
To: Charan Teja Kalla <quic_charante@quicinc.com>,
 Will Deacon <will@kernel.org>
Cc: joro@8bytes.org, jgg@ziepe.ca, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241213150415.653821-1-quic_charante@quicinc.com>
 <91d15d11-ec53-4ca2-a385-9fa69d861f2c@quicinc.com>
 <20250103153434.GC3816@willie-the-truck>
 <e8fa02bb-96b7-4010-92c9-7e1eb485a551@quicinc.com>
 <20250107113126.GA6932@willie-the-truck>
 <cb2db54e-37e8-495d-916a-4e63c67019bb@arm.com>
 <acc57f57-6eb5-4d55-bc36-33624051eec9@quicinc.com>
 <0a0a576e-dd4d-402a-a0ea-43eede4e7cd8@arm.com>
 <d1838296-0131-47ac-8a2e-eec8935c5960@quicinc.com>
 <3caf4418-8ee2-4a61-b9ff-74b24155e436@quicinc.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <3caf4418-8ee2-4a61-b9ff-74b24155e436@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-01-22 5:39 am, Charan Teja Kalla wrote:
> 
> 
> On 1/20/2025 5:45 PM, Charan Teja Kalla wrote:
>>> ----->8-----
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index d1af0547f553..8d90d196e38d 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -3120,6 +3120,11 @@ int iommu_device_use_default_domain(struct device
>>> *dev)
>>>           return 0;
>>>   
>>>       mutex_lock(&group->mutex);
>>> +    /* We may race against bus_iommu_probe() finalising groups here */
>>> +    if (!group->default_domain) {
>>> +        ret = -EPROBE_DEFER;
>>> +        goto unlock_out;
>>> +    }
>> Please lmk If I can submit this as V2 patch, with your name as Suggested-by?
> I missed to mention that this patch is fixing the problem we are
> seeing..Thanks.

Ah, that's good. I did spend most of an afternoon digging through git
history to write up this patch the other day, and was planning to send
it properly soon (probably after the merge window now) - as noted, it
also turns out not to be quite right for 6.6LTS as-is, so I figured I'd
save worrying about backports until it lands.

Thanks,
Robin.

----->8-----
Subject: [PATCH] iommu: Handle race with default domain setup

It turns out that deferred default domain creation leaves a subtle
race window during iommu_device_register() wherein a client driver may
asynchronously probe in parallel and get as far as performing DMA API
operations with dma-direct, only to be switched to iommu-dma underfoot
once the default domain attachment finally happens, with obviously
disastrous consequences. Even the wonky of_iommu_configure() path is at
risk, since iommu_fwspec_init() will no longer defer client probe as the
instance ops are (necessarily) already registered, and the "replay"
iommu_probe_device() call can see dev->iommu_group already set and so
think there's nothing to do either.

Fortunately we already have the right tool in the right place in the
form of iommu_device_use_default_domain(), which just needs to ensure
that said default domain is actually ready to *be* used. Deferring the
client probe shouldn't have too much impact, given that this only
happens while the IOMMU driver is probing, and thus due to kick the
deferred probe list again once it finishes.

Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
Fixes: 98ac73f99bc4 ("iommu: Require a default_domain for all iommu drivers")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

Note this fixes tag is rather nuanced - historically there was a more
general issue before deac0b3bed26 ("iommu: Split off default domain
allocation from group assignment") set the basis for the current
conditions; 1ea2a07a532b ("iommu: Add DMA ownership management
interfaces") is then the point at which it becomes logical to fix the
current race this way; however only from 98ac73f99bc4 can we rely on all
drivers supporting default domains and so avoid false negatives, thus
even though this might apply to older kernels without conflict it would
not be functionally correct. Furthermore given the other locking and API
flow changes which also happened over that time, it's not clear how long
this race has actually been exposed. LTS fixes are going to be fiddly...
---
  drivers/iommu/iommu.c | 5 +++++
  1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 851fd5aeccf5..9969531ad4ed 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3097,6 +3097,11 @@ int iommu_device_use_default_domain(struct device *dev)
  		return 0;
  
  	mutex_lock(&group->mutex);
+	/* We may race against bus_iommu_probe() finalising groups here */
+	if (!group->default_domain) {
+		ret = -EPROBE_DEFER;
+		goto unlock_out;
+	}
  	if (group->owner_cnt) {
  		if (group->domain != group->default_domain || group->owner ||
  		    !xa_empty(&group->pasid_array)) {
-- 
2.39.2.101.g768bb238c484.dirty


