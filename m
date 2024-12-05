Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA132F85C
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413265; cv=none; b=dOXvKPNpmTxF/PFidQobr+NznxMV4rDbgLdNfMjGHqPvbOkKDjymqpPiFWsydLOWyvbjCHxqdu41vBPseAjHlkLbIdjgdZneKZdWMrqgGexUYkdKlAdLEFhVvkd/AlqB/9US2YmsoK9ljIiTgMPpo+y1SXtzY5sH0CzQXOFMbvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413265; c=relaxed/simple;
	bh=QHmcqPVUEEGJAwookK/wyaPuWpyv9k6ON5M9SRD1dQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZHjK8qeDbiVYAL2/Cx0AEWOwHVFWgroZSc78GDeEmayU1skgm8YoTyvgVX9nJEyeP/VxUq4LLuKKrdvUpGp5m+L9MyrMOyxBRpqfzRnl6M29wS3e8Dq+TI6kPk4Z6I4OIfVNEJYjUeR3pkMIyDCLZKR5mIYjvc76lcOMX7PZww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 430181063;
	Thu,  5 Dec 2024 07:41:30 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 449D83F71E;
	Thu,  5 Dec 2024 07:41:00 -0800 (PST)
Date: Thu, 5 Dec 2024 15:40:57 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
	catalin.marinas@arm.com, joro@8bytes.org, jean-philippe@linaro.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	joey.gouly@arm.com, ryan.roberts@arm.com
Subject: Re: [PATCH 2/2] arm64: cpufeature: Add GCS to cpucap_is_possible()
Message-ID: <Z1HJiUg60kZP4zPb@J2N7QTR9R3>
References: <68a37b00a720f0827cac0e4f40e4d3a688924054.1733406275.git.robin.murphy@arm.com>
 <416c7369fcdce4ebb2a8f12daae234507be27e38.1733406275.git.robin.murphy@arm.com>
 <051c017c-a60f-48a7-b09f-07f0f32e48e3@sirena.org.uk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <051c017c-a60f-48a7-b09f-07f0f32e48e3@sirena.org.uk>

On Thu, Dec 05, 2024 at 03:04:11PM +0000, Mark Brown wrote:
> On Thu, Dec 05, 2024 at 01:48:10PM +0000, Robin Murphy wrote:
> >  static inline bool system_supports_gcs(void)
> >  {
> > -	return IS_ENABLED(CONFIG_ARM64_GCS) &&
> > -		alternative_has_cap_unlikely(ARM64_HAS_GCS);
> > +	return alternative_has_cap_unlikely(ARM64_HAS_GCS);
> >  }
> 
> Ah, this is bitrot since the series was on the list for so long.  As
> well as HAFT which Rutland mentioned it looks like _bti_kernel(),
> _irq_prio_masking() and possibly others have the same thing.

In <asm/cpufeature.h>, only system_supports_gcs() and
system_supports_haft() don't use cpucap_is_possible(); all the other
IS_ENABLED() checks are for additional dependent properties, and rely on
the base case being handled in cpucap_is_possible().

In <asm/cpucaps.h> we have:

	static __always_inline bool
	cpucap_is_possible(const unsigned int cap)
	{
		...
		switch (cap) {
		...
		case ARM64_HAS_PAN:
			return IS_ENABLED(CONFIG_ARM64_PAN);
		...
		case ARM64_BTI:
			return IS_ENABLED(CONFIG_ARM64_BTI);
		...
		case ARM64_HAS_GIC_PRIO_MASKING:
			return IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI);
		...
		}
	}

In <asm/cpufeature.h> we have:

	// base case
	static inline bool system_uses_hw_pan(void)
	{
		return alternative_has_cap_unlikely(ARM64_HAS_PAN);
	}

	// additional dependent property
	static inline bool system_uses_ttbr0_pan(void)
	{
		return IS_ENABLED(CONFIG_ARM64_SW_TTBR0_PAN) &&
		       !system_uses_hw_pan();
	}

	...

	// base case
	static __always_inline bool system_uses_irq_prio_masking(void)
	{
		return alternative_has_cap_unlikely(ARM64_HAS_GIC_PRIO_MASKING);
	}

	// additional dependent property
	static inline bool system_has_prio_mask_debugging(void)
	{
		return IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING) &&
		       system_uses_irq_prio_masking();
	}

	...

	// base case
	static inline bool system_supports_bti(void)
	{
		return cpus_have_final_cap(ARM64_BTI);
	}

	// additional dependent property
	static inline bool system_supports_bti_kernel(void)
	{
		return IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) &&
			cpus_have_final_boot_cap(ARM64_BTI);
	}

> Ideally we'd have no uses of IS_ENABLED() in these functions so it's a
> bit more obvious.

For the three cases above we can't do that without additional cpucaps,
and I think that'd be worse. I don't see anything we can practically do
other than add comments, and I suspect that's not going to help either.

Mark.
