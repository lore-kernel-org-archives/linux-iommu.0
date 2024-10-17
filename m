Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B616D1DDA24
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173279; cv=none; b=u1XdxoBpemS4uwjHYfFAi1KUmKPAdZWqzOIPprZWVkv++wwlsWoe9Ji/erJRq+vLhb7A+QpD0zwej2DSgK20XzjeiIovst1tSEll/PITh3VqRjyJTDhkda7zg3+50gW6bdwc8fcGa6dC1JexmrSLB9E6EGzpy3CKCZH2bcgGOfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173279; c=relaxed/simple;
	bh=dR1/iF0hamAmACkYIu6ORSod6DVPZnh+qVKWQ1c6eVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YINjmg7lWX84DTKuvA+JpWuYOBpGP+vXjAVtZrNbxtL0LolHNeTdd8FQ0D2xTBuQAvzqr2FjG5lIpgV3WW0g204gVE9w5HB87Qj/7jY8CcQVBAPDBEbXin//Z4Y3cqHaAV/dTnMNqry6F7GVc0LOFS9223IzK+MQnjCZj3T0Nhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5ACCDA7;
	Thu, 17 Oct 2024 06:55:03 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD09A3F528;
	Thu, 17 Oct 2024 06:54:31 -0700 (PDT)
Message-ID: <3925d2f0-3b1f-4200-acc4-8f991616ec0f@arm.com>
Date: Thu, 17 Oct 2024 14:54:29 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/arm-smmu: Defer probe of clients after smmu
 device bound
To: Pratyush Brahma <quic_pbrahma@quicinc.com>, will@kernel.org
Cc: joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com,
 robdclark@chromium.org, quic_c_gdjako@quicinc.com,
 dmitry.baryshkov@linaro.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 quic_charante@quicinc.com, stable@vger.kernel.org,
 Prakash Gupta <quic_guptap@quicinc.com>
References: <20241004090428.2035-1-quic_pbrahma@quicinc.com>
 <d4a52579-0e2a-4df3-a1fa-e8e154ff1e90@quicinc.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <d4a52579-0e2a-4df3-a1fa-e8e154ff1e90@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/10/2024 2:31 pm, Pratyush Brahma wrote:
> 
> On 10/4/2024 2:34 PM, Pratyush Brahma wrote:
>> Null pointer dereference occurs due to a race between smmu
>> driver probe and client driver probe, when of_dma_configure()
>> for client is called after the iommu_device_register() for smmu driver
>> probe has executed but before the driver_bound() for smmu driver
>> has been called.
>>
>> Following is how the race occurs:
>>
>> T1:Smmu device probe        T2: Client device probe
>>
>> really_probe()
>> arm_smmu_device_probe()
>> iommu_device_register()
>>                     really_probe()
>>                     platform_dma_configure()
>>                     of_dma_configure()
>>                     of_dma_configure_id()
>>                     of_iommu_configure()
>>                     iommu_probe_device()
>>                     iommu_init_device()
>>                     arm_smmu_probe_device()
>>                     arm_smmu_get_by_fwnode()
>>                         driver_find_device_by_fwnode()
>>                         driver_find_device()
>>                         next_device()
>>                         klist_next()
>>                             /* null ptr
>>                                assigned to smmu */
>>                     /* null ptr dereference
>>                        while smmu->streamid_mask */
>> driver_bound()
>>     klist_add_tail()
>>
>> When this null smmu pointer is dereferenced later in
>> arm_smmu_probe_device, the device crashes.
>>
>> Fix this by deferring the probe of the client device
>> until the smmu device has bound to the arm smmu driver.
>>
>> Fixes: 021bb8420d44 ("iommu/arm-smmu: Wire up generic configuration 
>> support")
>> Cc: stable@vger.kernel.org
>> Co-developed-by: Prakash Gupta <quic_guptap@quicinc.com>
>> Signed-off-by: Prakash Gupta <quic_guptap@quicinc.com>
>> Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
>> ---
>> Changes in v2:
>>   Fix kernel test robot warning
>>   Add stable kernel list in cc
>>   Link to v1: 
>> https://lore.kernel.org/all/20241001055633.21062-1-quic_pbrahma@quicinc.com/
>>
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index 723273440c21..7c778b7eb8c8 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -1437,6 +1437,9 @@ static struct iommu_device 
>> *arm_smmu_probe_device(struct device *dev)
>>               goto out_free;
>>       } else {
>>           smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
>> +        if (!smmu)
>> +            return ERR_PTR(dev_err_probe(dev, -EPROBE_DEFER,
>> +                        "smmu dev has not bound yet\n"));
>>       }
>>       ret = -EINVAL;
> 
> 
> Hi
> Can someone please review this patch? Let me know if any further 
> information is required.

This really shouldn't be leaking into drivers... :(

Honestly, I'm now so fed up of piling on hacks around the fundamental 
mis-design here, I think it's finally time to blow everything else off 
and spend a few days figuring out the most expedient way to fix it 
properly once and for all. Watch this space...

Thanks,
Robin.
