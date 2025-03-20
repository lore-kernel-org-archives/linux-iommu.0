Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DB71ADC9B
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742476934; cv=none; b=Qrf/qSMTAJurUv1GuDEwCE6PoVNKNSiYyRGm9XvwZ3wEWqbQW6Ba70JqL/i76hcPJkqDPL1SO8tLTn4teeaQXQBCn58oU7j0dZ5qYOsn/nGMpr0SYR9ErtLj1y6BGpoHs6nq3/b+cDoys5Gok0jm1w+8FebEODMi3XIDye7g7nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742476934; c=relaxed/simple;
	bh=9MdgXfypFL/q6EJm7XxyslBJMM+huqYGPgf5rXf/lNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFj8H5rRcrNxKffOVTfdAx8ck1HWluGN71GxGveNd8MY2N07lRLaMkZhc8Ji6ETyrl1nItlttQeTxDdSjGju4fUkNNyiMhvVGXMpQT1eHZS7ZY4kAHOWV10tYCjvpTjHTEFX/dHqABP+iXSkoSfvOx26by07fWzBkz8/sgFayNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BB38113E;
	Thu, 20 Mar 2025 06:22:18 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C3913F63F;
	Thu, 20 Mar 2025 06:22:09 -0700 (PDT)
Message-ID: <121319f7-2af4-4a3a-955b-9bbae09aa92c@arm.com>
Date: Thu, 20 Mar 2025 13:22:07 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
To: Jason Gunthorpe <jgg@ziepe.ca>, Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>,
 Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-6-praan@google.com> <20250319120404.GD10600@ziepe.ca>
 <Z9vCwLbwwjn-gVJ9@google.com> <20250320125421.GJ126678@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250320125421.GJ126678@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2025 12:54 pm, Jason Gunthorpe wrote:
> On Thu, Mar 20, 2025 at 07:25:20AM +0000, Pranjal Shrivastava wrote:
> 
>> I agree, that we can elide TLBIs if the smmu is asleep (powered-off),
>> the main reason to wake up the hw is because `arm_smmu_write_ste` issues
>> a prefetch CMD. Again, it is possible that the smmu sleeps after this op
>> and the prefetch has no real benefit.
> 
> Does any HW caching survive the power off? I was assuming no.
> 
> So it is pointless to issue a prefetch and then immediately power off
> the SMMU and throw away the STE cache.
> 
> IOW if you don't know that the SMMU will stay powered up after the
> attach there is no reason to do a prefetch.

And even if the caches don't lose state in hardware, we'll explicitly 
clear them on resume anyway. Furthermore I'm not aware of any current 
SMMU implementations where the prefetch command does anything meaningful 
anyway, so right now this is absolutely a non-issue.

>> Anyway, having *any* rpm implementation that causes us to lose TLB
>> content, will cause a hit on the performance, so maybe this
>> micro-optimization isn't worth at all?
> 
> Right, it was my assumption that you loose the caches. I would guess
> keeping all the cache SRAM powered is a big part of the power budget...
> 
>> Also, while we're at it, should we have a feature switch for users who'd
>> like to disable runtime PM for performance reasons? I don't think that
>> relying on the `power-domain` being present alone is sufficient.
> 
> I'm worried about how much this will hurt server workloads. Optimizing
> invalidation is a worry and you've gone and put in some more atomic
> write traffic on shared cache lines. Not great :\

Indeed, that was the reason for wrapping the RPM calls in explicit 
pm_runtime_enabled() checks in SMMUv2 - see the comment in 
arm_smmu_device_probe() - on the assumption that servers wouldn't 
advertise a power domain for the SMMU (not least because we've no 
support for such a thing under ACPI anyway).

Thanks,
Robin.
