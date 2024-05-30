Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C641B21350
	for <iommu@lists.linux.dev>; Thu, 30 May 2024 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717084162; cv=none; b=FkUvYZDul43iOyEhUrhhchrWJ3rcgZEiAwUlwca/kQka2RCjBCcoBb9G45/fFTeEbJd0QOR6s0GRfBkzKV1b8CeY23e3PN8ITo5x3sukwzppzHELO7AlxVOJvm+PPpLJ6gppvm/7rGI04FpRELF8tWhODIenuBgIy/vX5+JBjfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717084162; c=relaxed/simple;
	bh=9mFsdyyM3ElhSR7egIawAprRDmxySE5698Uao7l+NK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCwtZUtoyjv+zX5goHCj2CEvJjs6KYLhagxGRbr7B85L/+4NOVcH1zpOAS+LMsoXZStCCJCC9oN16vj0ABdVjrkIZfb0Pl2dSh2lF5JPK8FYheySy3Eig/1NYvk1gHY7oBGuy/j3bdq8Aq7Dsiz5UD533ihAzY9cSkvDqkn4R4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E07D339;
	Thu, 30 May 2024 08:49:44 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F5EB3F792;
	Thu, 30 May 2024 08:49:19 -0700 (PDT)
Message-ID: <32921840-43d6-4ad9-99eb-aac32e67e04c@arm.com>
Date: Thu, 30 May 2024 16:49:17 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: device_def_domain_type documentation header does not match
 implementation
To: Diederik de Haas <didi.debian@cknow.org>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <14311965.TaHA55BQu8@bagend>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <14311965.TaHA55BQu8@bagend>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/05/2024 2:57 pm, Diederik de Haas wrote:
> Hi,
> 
> While looking into ``drivers/iommu/intel/iommu.c::device_def_domain_type``
> function I noticed a discrepancy between the documentation header and the
> implementation.
> 
> ``@startup: true if this is during early boot``
> 0e31a7266508 ("iommu/vt-d: Remove startup parameter from
> device_def_domain_type()")
> removed the ``startup`` function parameter
> 
> returns ``IOMMU_DOMAIN_DMA: device requires a dynamic mapping domain``
> 28b41e2c6aeb ("iommu: Move def_domain type check for untrusted device into
> core")
> moved the possible return of ``IOMMU_DOMAIN_DMA`` to ``drivers/iommu/iommu.c``
> 
> But neither updated the documentation header.

TBH it could probably just be deleted now, since the 
iommu_ops::def_domain_type callback is properly documented in iommu.h, 
so individual implementations shouldn't need to repeat that. It's also 
never been actual kerneldoc either, since it's a regular "/*" comment. 
Feel free to send a patch :)

Thanks,
Robin.
