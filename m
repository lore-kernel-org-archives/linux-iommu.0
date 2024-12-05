Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F1A218AC2
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733408625; cv=none; b=j+mdS65DI8LjR/Pd2ye7Du3/Cmlo1OBNQjIWqyv2XqM6JNSN7Nd6B10Mcg0iSqbUh1+yzUMnaB/cu6V+qDNeDJCaFnMElqFTdiDDIV64KxACg8n9tP7KQ7q/OE/v3P1WDnq6EF8tFLw2zzLmuhXRxjB3/UnR7AiiCwG6mbm84js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733408625; c=relaxed/simple;
	bh=4Eq+2aAjnFxe5lX/XGzJfW9qaZEcHbRfX/Ql8ZTqdio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGPe5asuXZZ9g5R7a1dhzkgB1mAhfJ5tn8y9R5QuxFvMfkYBVCGkaCXVuNs8V8EYAz1tmeT2CTvq67zyfTs4Et1SApzmJM93QF+rXaqP3pHPLbTHGogA34CBhCgEZFyEoCC2hzgNdRgvE/FzSGCA3CkA+QrH8aGIX4VrI38Wg+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B0281063;
	Thu,  5 Dec 2024 06:24:10 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE54B3F5A1;
	Thu,  5 Dec 2024 06:23:40 -0800 (PST)
Date: Thu, 5 Dec 2024 14:23:35 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, catalin.marinas@arm.com, joro@8bytes.org,
	jean-philippe@linaro.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, joey.gouly@arm.com,
	ryan.roberts@arm.com, broonie@kernel.org
Subject: Re: [PATCH 2/2] arm64: cpufeature: Add GCS to cpucap_is_possible()
Message-ID: <Z1G3Z9C9efBkVKjR@J2N7QTR9R3>
References: <68a37b00a720f0827cac0e4f40e4d3a688924054.1733406275.git.robin.murphy@arm.com>
 <416c7369fcdce4ebb2a8f12daae234507be27e38.1733406275.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416c7369fcdce4ebb2a8f12daae234507be27e38.1733406275.git.robin.murphy@arm.com>

On Thu, Dec 05, 2024 at 01:48:10PM +0000, Robin Murphy wrote:
> Since system_supports_gcs() ends up referring to cpucap_is_possible(),
> teach the latter about GCS for consistency with similar features.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Looking around, we should probably do the same for HAFT.

Mark.

> ---
>  arch/arm64/include/asm/cpucaps.h    | 2 ++
>  arch/arm64/include/asm/cpufeature.h | 3 +--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index 201a46efd918..cbbf70e0f204 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -44,6 +44,8 @@ cpucap_is_possible(const unsigned int cap)
>  		return IS_ENABLED(CONFIG_ARM64_TLB_RANGE);
>  	case ARM64_HAS_S1POE:
>  		return IS_ENABLED(CONFIG_ARM64_POE);
> +	case ARM64_HAS_GCS:
> +		return IS_ENABLED(CONFIG_ARM64_GCS);
>  	case ARM64_UNMAP_KERNEL_AT_EL0:
>  		return IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0);
>  	case ARM64_WORKAROUND_843419:
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index b64e49bd9d10..8b4e5a3cd24c 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -847,8 +847,7 @@ static inline bool system_supports_poe(void)
>  
>  static inline bool system_supports_gcs(void)
>  {
> -	return IS_ENABLED(CONFIG_ARM64_GCS) &&
> -		alternative_has_cap_unlikely(ARM64_HAS_GCS);
> +	return alternative_has_cap_unlikely(ARM64_HAS_GCS);
>  }
>  
>  static inline bool system_supports_haft(void)
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 
