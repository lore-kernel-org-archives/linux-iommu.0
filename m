Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AE126158B;
	Tue, 11 Feb 2025 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739306236; cv=none; b=UYmVgL/GPLYSg2GQNB2k8jvw9VAZsXI721WrD7Y/7L86leMwr+RXsKZlyHKciAyFPVdB34jDITtduFwfqoBltpyMWftSPm02UiajPZUHrGXf2ae1K3BZReml8Pnr972FfDuwfrR/YDiVbnf+qPJoj57G4Ejap+bVjQSfVRnP1yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739306236; c=relaxed/simple;
	bh=EGMrDk2bhCdtV8HADA1cGzyp9kGWh2DKKQLh8djgqMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hK7Ru4/OWiFWnGVSFo3yeHeLu4tFg4N6wcTqgk6CO4TMZCC6yVMThmYyou0pfuTqR0F2jivdUMj5VtC18XOtqYCqIEyMs3TlBlCz8QHKMR/seBc9jzYk/NHh7RYE7AWkORlV848EKuIVMRpmItNhxLBYgRDTbO0NSRaMr4pbw3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAEEF1D14;
	Tue, 11 Feb 2025 12:37:34 -0800 (PST)
Received: from [10.57.35.63] (unknown [10.57.35.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27A223F5A1;
	Tue, 11 Feb 2025 12:37:10 -0800 (PST)
Message-ID: <c4c54243-d25b-45d7-97d5-837d02cfa2dd@arm.com>
Date: Tue, 11 Feb 2025 20:37:08 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] iommu/dart: Set DMA domain for locked DARTs
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
 <20250210-locked-dart-v1-3-5d97fe247f35@rosenzweig.io>
 <1d6b3fe7-9376-422b-a2e6-ebaed7b6cd75@arm.com> <Z6uZhQtPAE8Ck_b0@blossom>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Z6uZhQtPAE8Ck_b0@blossom>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-11 6:40 pm, Alyssa Rosenzweig wrote:
> Hi Robin,
> 
>>> This is required.
>>
>> Now that we can, I'd really rather do this properly and not offer an
>> identity domain in the first place when it's not available.
> 
> I'm reading through iommu.c but I don't see a way to avoid offering an
> identity domain without the DMA override here, just reading through the
> logic of iommu_get_default_domain_type. Could you point me to what you
> have in mind?

Since we finished cleaning up the domain allocation paths, it's finally 
safe to have per-instance ops, so you can mix and match some with an 
identity domain and some without, as s390 will be doing[1].

Cheers,
Robin.

[1] 
https://lore.kernel.org/linux-iommu/20250207205335.473946-5-mjrosato@linux.ibm.com/

> Thanks,
> Alyssa
> 
>>> --- a/drivers/iommu/apple-dart.c
>>> +++ b/drivers/iommu/apple-dart.c
>>> @@ -941,6 +941,8 @@ static int apple_dart_def_domain_type(struct device *dev)
>>>    		return IOMMU_DOMAIN_IDENTITY;
>>>    	if (!cfg->stream_maps[0].dart->supports_bypass)
>>>    		return IOMMU_DOMAIN_DMA;
>>> +	if (cfg->stream_maps[0].dart->locked)
>>> +		return IOMMU_DOMAIN_DMA;
>>>    	return 0;
>>>    }
>>>
>>

