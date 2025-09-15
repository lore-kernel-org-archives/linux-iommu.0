Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402DB281352
	for <iommu@lists.linux.dev>; Mon, 15 Sep 2025 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757918147; cv=none; b=cH6njKxbJ5p3Q/FjkG3nStrsH7fvUHNeetVyCCEfFn8lSLzPY3Gb+FsWYTLTdSpXhug1xRSYRWjWdoU0E0FxGBAUQvU2fqbIPMwIAqCyMgoqJ5gnYWkw0mup5p+HZNPNmVYZUcIhE2oA7rUGAOmoBpIl0uiPzHH3sn8PpEku5v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757918147; c=relaxed/simple;
	bh=hjCkwdOxYVtkhykhsXs1cSCCfz5wOauaPPcpRqr8P10=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rLffVXjLZ0A5kOETcAdH5ANJKgIyNVFmNUBIlMoXiitTH/sN/jtJ2N9d2/2a/L4M3jRas3sQKpvmA5W6CvRx4rz4BAudb8noxY4dmd6AmJW5zWJ8gC7GaaPotDqqHBN/KkYKl1Q7QiVLygLdoBD0UbMGS6vWeVH+EjMWhJ+BMvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZf2wb/i; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZf2wb/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757918145; x=1789454145;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=hjCkwdOxYVtkhykhsXs1cSCCfz5wOauaPPcpRqr8P10=;
  b=NZf2wb/iXesolVwdNOe7LyaIIvR2QqSlt2cCGUSx3UYL8sSKhmHa9CND
   8r5d70KiYzfoGUz7wx1f9HyPXpqJGmhwFPEq2vvjVJQ7UDqQVlN2JUZWK
   ni4cg55pHKbBiz1DeJys2Atmnd2w0+weDLtjcMTfN9YSwPIs+zMNuBqZg
   VqotFWRXqA6crIxD7m8Qu0hGWClCMTo0gumbdSIX33cF3vBk4yNVJSgLV
   0112cgtzHW/f7Azh+THJGFWh1ixTFlPq7yhTpkMb7Ji3k5MeM3rM9A5XG
   TjD4Kk9EiwFsibX4hmhTTOKSHs/Z9d5W7BruvVYKgGR5HKiEB2K5uIBzl
   g==;
X-CSE-ConnectionGUID: u3x0mmE/R9abUDVEnHqyWA==
X-CSE-MsgGUID: Mtl8TnGCSGGB0KuT9abZ4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="71260184"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="71260184"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 23:35:44 -0700
X-CSE-ConnectionGUID: K9MqikIxQpOQ/LaLYfoQgg==
X-CSE-MsgGUID: T2oRoRDsSlCth5dpSUdxVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="175324562"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 23:35:31 -0700
Message-ID: <d07be614-6186-42a2-a0cf-2a73b7ab186b@linux.intel.com>
Date: Mon, 15 Sep 2025 14:32:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel/vt-d: Send Page Request Drain only if supported
From: Baolu Lu <baolu.lu@linux.intel.com>
To: Joel Granados <joel.granados@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250909-jag-pds-v1-1-ad8cba0e494e@kernel.org>
 <e82c300e-9d68-4270-a4ea-10bea20b1169@linux.intel.com>
Content-Language: en-US
In-Reply-To: <e82c300e-9d68-4270-a4ea-10bea20b1169@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/12/25 10:35, Baolu Lu wrote:
> On 9/9/25 16:58, Joel Granados wrote:
>> The intel_iommu_drain_pasid_prq function sends QI_OPT_WAIT_DRAIN to
>> hardware without verifying Page Request Drain Support (PDS). According
>> to VT-d specification section 6.5.2.8, PRQ drain functionality should
>> only be used when PDS (bit 42) is set in the extended capability
>> register. Add ecap_pds() check to conditionally use QI_OPT_WAIT_DRAIN
>> based on hardware capability.
>>
>> Signed-off-by: Joel Granados<joel.granados@kernel.org>
>> ---
>>   drivers/iommu/intel/prq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
>> index 
>> 52570e42a14c05b7492957909568805dc9c7b6ef..f89916de31a3439866f059f5400e45fb362a6a7d 100644
>> --- a/drivers/iommu/intel/prq.c
>> +++ b/drivers/iommu/intel/prq.c
>> @@ -119,7 +119,7 @@ void intel_iommu_drain_pasid_prq(struct device 
>> *dev, u32 pasid)
>>       }
>>   qi_retry:
>>       reinit_completion(&iommu->prq_complete);
>> -    qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
>> +    qi_submit_sync(iommu, desc, 3, ecap_pds(iommu->ecap) ? 
>> QI_OPT_WAIT_DRAIN : 0);
> 
> I'm afraid that draining page requests and responses won't work as
> expected without the PDS capability. We should perhaps fail to enable
> IOPF if the PDS capability isn't supported.
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9c3ab9d9f69a..ca6a6eaea62c 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3983,6 +3983,10 @@ int intel_iommu_enable_iopf(struct device *dev)
>          if (!info->pri_enabled)
>                  return -ENODEV;
> 
> +       /* PDS is required to drain page requests and responses. */
> +       if (!ecap_pds(iommu->ecap))
> +               return -ENODEV;
> +
>          /* pri_enabled is protected by the group mutex. */
>          iommu_group_mutex_assert(dev);
>          if (info->iopf_refcount) {
> 
> At the same time, qi_submit_sync() should not set PD bit in the wait
> descriptor as the spec Section 6.5.2.9 "Invalidation Wait Descriptor"
> states:
> 
>   Page-request Drain (PD): Remapping hardware implementations reporting
>   Page-request draining as not supported (PDS = 0 in ECAP_REG) treats
>   this field as reserved.
> 
> therefore,
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index ec975c73cfe6..e38af2274032 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1427,7 +1427,7 @@ int qi_submit_sync(struct intel_iommu *iommu, 
> struct qi_desc *desc,
> 
>          wait_desc.qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
>                          QI_IWD_STATUS_WRITE | QI_IWD_TYPE;
> -       if (options & QI_OPT_WAIT_DRAIN)
> +       if ((options & QI_OPT_WAIT_DRAIN) && !WARN_ON_ONCE(! 
> ecap_pds(iommu->ecap)))
>                  wait_desc.qw0 |= QI_IWD_PRQ_DRAIN;
>          wait_desc.qw1 = virt_to_phys(&qi->desc_status[wait_index]);
>          wait_desc.qw2 = 0;
> 
> ?

I submitted a fix patch for this. Feel free to comment on it there.

https://lore.kernel.org/linux-iommu/20250915062946.120196-1-baolu.lu@linux.intel.com/

Thanks,
baolu
