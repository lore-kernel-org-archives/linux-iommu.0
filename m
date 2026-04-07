Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861953563DD
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561150; cv=none; b=dn0QPkEjEfnP4jHOFMsC7MTYxVwkdjIG/3G5ROwDpH6r1VlX1cLnRMjgwX8VWC7ZsPKhs3vc2vnw/h/BDlZ7EC+xY5YVtNhiXk0rUgMEFfaChIVPrlTiSAVjGvd+D7rY7NQyHXYSlawHDp/8L7NXWX38W+HkzfF7RhGq8QrsLFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561150; c=relaxed/simple;
	bh=FkONyWkAkz6WrhJw6afrxrztFOvZU3mchf+WabC4/Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1YVaApSf1aVxKW3oEP2ksnk2ickHVeRD8aRBWvzcTZRWNzdnzOy1xeslpoQQvtQeLJgYB9o2eleGdn/qiEyK6HUGeqxzk93rt92Jryk4IkSGWc8rXpGF+bOozqezZQgGtTNDyy4ReX4ldXo0rPMHqZw5UPfbi8ZA5G8MTXIK6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lNqnUbfJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lNqnUbfJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDF011BB0;
	Tue,  7 Apr 2026 04:25:40 -0700 (PDT)
Received: from [10.1.196.85] (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 846883F7D8;
	Tue,  7 Apr 2026 04:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775561146; bh=FkONyWkAkz6WrhJw6afrxrztFOvZU3mchf+WabC4/Ag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lNqnUbfJgeBVinCZwGV/HeW4R34tvIWn1l3By+SL9cynEhaGUo7nUmW00kKz7dwE4
	 V6TqIn9PghBw/vcBDqOH30VM0IsA2BYHb6T5dyJQZpJAr0jOCGqngOT0CLZmv8Jdus
	 hcYg8GKdC2ktaClXl3bqb/lvdwsDlzd7+WjSBb0o=
Message-ID: <1ad94dfb-2fab-41c8-b792-9274f213dfb2@arm.com>
Date: Tue, 7 Apr 2026 12:25:38 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] iommu: Default to lazy DMA mode on ARM64
To: Nafees Ahmed Abdul <nafeabd@amazon.com>, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260402195913.32084-1-nafeabd@amazon.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260402195913.32084-1-nafeabd@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/04/2026 8:59 pm, Nafees Ahmed Abdul wrote:
> ARM64 currently falls through to IOMMU_DEFAULT_DMA_STRICT, while
> X86 defaults to IOMMU_DEFAULT_DMA_LAZY. On ARM64 bare-metal
> systems with the ARM SMMU, strict mode causes synchronous TLBI
> + CMD_SYNC on every DMA unmap, resulting in significant
> throughput degradation for network-intensive workloads.
> 
> Benchmarked on an ARM64 bare-metal system (AWS m8g.metal-24xl)
> running Debian 13 with kernel 6.12.74, using iperf3:
> 
>    STRICT (default): 14.9 Gbps
>    LAZY:             39.8 Gbps
> 
> This is a 2.67x throughput improvement simply by switching the
> IOMMU default domain mode.
> 
> Distributions that do not explicitly override this Kconfig
> choice (e.g., Debian, SLES) silently get STRICT on ARM64,
> causing this regression on bare-metal systems.

It is not a "regression", it has always been this way since the 
beginning of IOMMU support on arm64. For many years, we didn't even have 
such a thing as lazy mode.

> Changing the
> upstream default avoids the need for each distribution to
> independently carry this override.

...while equally *creating* that need for all the distros/users who do 
value security/robustness above performance. Who's to say what matters 
most? Besides, defconfig is never meant to be a distro config; distros 
*should* maintain their own configs, and if they're not delivering the 
options that the majority of their users want, that's between the 
distros and their users.

The numbers game goes both ways too - the sheer quantity of arm64 
systems where strict vs. lazy makes no noticeable performance 
difference, but does offer that small robustness benefit (i.e. 
embedded/mobile) is many orders of magnitude more the number of arm64 
systems capable of 50GbE. Even your own data are suggesting this is 
actually a pretty niche case, if even 10GbE systems would still have 
plenty of headroom to keep up in strict mode - if anything that's 
actually pretty impressive!

> Add ARM64 to the LAZY default to align with X86 behavior.

But the other side of that is that the x86 (and S390) behaviour is a 
20-year-old legacy which arguably only looks more and more anachronistic 
in today's post-Spectre/etc. security-conscious world. Wouldn't an even 
better alignment argument be to start cleaning up such legacy, rather 
than spread it further onto more modern architectures which never even 
had it?

Thanks,
Robin.

> Signed-off-by: Nafees Ahmed Abdul <nafeabd@amazon.com>
> ---
>   drivers/iommu/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index f86262b11..2822aba75 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -96,7 +96,7 @@ config IOMMU_DEBUGFS
>   choice
>   	prompt "IOMMU default domain type"
>   	depends on IOMMU_API
> -	default IOMMU_DEFAULT_DMA_LAZY if X86 || S390
> +	default IOMMU_DEFAULT_DMA_LAZY if X86 || S390 || ARM64
>   	default IOMMU_DEFAULT_DMA_STRICT
>   	help
>   	  Choose the type of IOMMU domain used to manage DMA API usage by

