Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795028070;
	b=ggDkOCT84zLJ6MPx6jCTui7JShCN6zv+HLuM+wnIng63LtgjuGRFQMyxnMzi9/slXRUm
	 hPr6cmiw7MSgEl755wNYSziAit788fXlti3bgT8VslbbAGAPlDOeKFJEkAl50kV1nKArG
	 83Z/RcefjBLiXAOdnwzwEIJajndaqk+Ri2Kn5fGLKZ+z+T2UeLwKDS9pn4cz430nrnyTT
	 HxwVEK/Qt6iYkKCIoPNFA9XTTK3WWxPElzGA3g6TrtJCB48X0AgiMrhyybTa4qlbwP60e
	 e6NclSs47N/LnpEma2ZLt5vDGRybeuU9zP3QjJFm0oXqMGdzwFykW/3KsnJvf2j21Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028070;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZPQs9bB5EZrcS0gSU2DORmi4XRfA7RSLq+quDBDfcEo=;
	b=SqnYu3VIYGJsnzT0MYDjgoIqRBIyNl5YqhDiBupiH+wSjZDjjSFARsIshcNlqzyCOlVB
	 XzC4GVWDcN/ywwTqBxPhrhIAQk5m852MounRXhvI0tGHHI48v22NddxcJwMw/npTxVRo4
	 RcTWoNliTnQMEX9gkEiY46qQn//uYNW/Q9vu8R8zaWA+xf5KYAi3Gduy5E7nlbbHvRSpd
	 ZeOrNvBnjqax02uUc14rH8OwTNoyQ2ruVF415xlCKxjkowq/wS5M0tGp/uXrrgBJ4e8dR
	 JhX3rtNGQ5iuPdqMoTprSloNWchsZBg0xu+Qps9V4u/HygLJls/0F5/setbnB+WiaGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l12pjYJ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4420606A320;
	Wed, 18 Nov 2026 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l12pjYJ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0EA1F000C4;
	Wed, 18 Nov 2026 18:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795028069;
	bh=ZPQs9bB5EZrcS0gSU2DORmi4XRfA7RSLq+quDBDfcEo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l12pjYJ/IBU8hubWgNrR4F+qs1zEvIJByKiyPJKUIjWKAYSeN5UbknVL2wdTDMa53
	 kiqEmJCRWakqs4Ch0lPHkS9nzWINjtl28zpU7ON28OzabD09rIk9iY8tG2v88k4b67
	 bekxI9jVxeK+eGdkoq7pigi9eExJmrbR9apvkqslnWaa5n3kA+7kALfSexqIGmnf0H
	 3p5IFMJ+jMItpKmAdBeco9Fx24k9Uduyt2m3o4Y1Zw0DjgknUJVz2e8SLXXXYlN9/U
	 WGoqtdAPpIwsx+tXJTZxaB1TqbujWEYDYBpzUkTe5EZ3fWJ8ttPDiKUXqGdimP0w8y
	 VEpnTGrQI+dIA==
Message-ID: <73224e5f-e47e-49d7-aa41-8bd1338c831c@kernel.org>
Date: Wed, 18 Nov 2026 12:54:23 -0600
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] iommu/amd: Enable PerfOpt automatically for integrated
 GPUs
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20261022-superm1-perf-opt-next-v5-1-dfef0b78b7b9@kernel.org>
 <179502782208.3845434.3028303849229899926.b4-review@b4>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <179502782208.3845434.3028303849229899926.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/26 12:50, Jason Gunthorpe wrote:
>> PerfOpt is usable by integrated GPUs in identity mode. Enable it from
>> the IOMMU driver's domain attachment paths instead of requiring an
>> amdgpu policy knob and exported enable/disable interfaces.
>>
>> Mark supported integrated GPUs as PerfOpt-eligible when selecting their
>> default identity domain. Skip GCR3 setup and ATS/PRI/PASID enablement for
>> these identity attachments, then enable PerfOpt after installing the DTE.
>> Clear PerfOpt before attaching an eligible GPU to a translated or blocked
>> domain, including unmanaged domains used by VFIO. Propagate failures to
>> clear bypass, but keep a completed identity attachment successful if the
>> optional PerfOpt enable fails.
>>
>> Clear inherited PerfOpt state during initialization, including when a crash
>> kernel reuses device tables. Read feature support directly from hardware
>> because cached features may not be available yet, and stop initialization
>> if the initial clear fails.
>>
>> Each IOMMU has at most one PerfOpt-eligible GPU, so track activation with a
>> boolean under the IOMMU lock. Preserve this state while clearing hardware
>> at suspend and shutdown, and restore the bit on resume only where it was
>> active. Do not enable PerfOpt unconditionally during early IOMMU
>> initialization.
>>
>> Remove the amdgpu parameter, driver callbacks, and exported interfaces.
>> Translated attachments retain their normal device capability setup.
>>
>> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>> Changes in v5:
>>   * Enable PerfOpt after identity attachment instead of during early IOMMU init
>>   * Clear PerfOpt before translated or blocked attachments, allowing VFIO use
>>   * Drop require_direct and retain normal capability setup for translated domains
>>   * Replace refcounting with a per-IOMMU activation boolean protected by its lock
>>   * Clear inherited PerfOpt during init, including crash-kernel device-table reuse
>>   * Read hardware feature support before cached features are available and fail
>>     initialization if the initial clear fails
>>   * Preserve activation across suspend and restore it on resume only if active
>>   * Keep identity attachment successful if optional PerfOpt enablement fails
>>   * Link to v4: https://lore.kernel.org/linux-iommu/20261001182410.1525285-1-superm1@kernel.org/
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  50 ------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  12 --
>>   drivers/iommu/amd/amd_iommu.h              |   3 +-
>>   drivers/iommu/amd/amd_iommu_types.h        |   6 +-
>>   drivers/iommu/amd/init.c                   |  91 ++++++-----
>>   drivers/iommu/amd/iommu.c                  | 252 +++++------------------------
>>   include/linux/amd-iommu.h                  |  11 --
>>   8 files changed, 95 insertions(+), 331 deletions(-)
> 
> Vasant are you going to pick this up? It seems good to me
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 

FWIW - it was picked up in b32ecac779bba6e7ac7caeae8c40db4280941634.
