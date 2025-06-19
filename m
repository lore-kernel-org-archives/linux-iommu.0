Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBA7221704
	for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750333902; cv=none; b=fz46y//c3jXzQP+PIbReUxBU1D7WbBObKslinwUt4n8oH+XNBVcHhgco7liDB2SxnREROfdZe+hhABQCV/bVRnvnKtgIG5a+4tPSdUR+5MjTDaC2kyDIl1JE1fVD5B3E/mtViNVq/tIoII+7EGnl18LN0ovcPnEmUL2Lw0dCKEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750333902; c=relaxed/simple;
	bh=cV46gl3pjPGt2Sftob+tBt5M1wyyalH/s2Lx039lCQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2fRRsU2xOhWb54b+meulAwhrjaANvdWTFjYvqlEbif2dxmAbCwtmLnDFoTtNdtgXTpHP8MdIbow6VXpZhyEKdurwr+DwMak7ZGupsAGirrbsUuvjqOD2mxvJ7buqF3QE+kJiYKzNsop1Q2wi9drkywYyi2KWb2Yg1L0BGTxzcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0570A106F;
	Thu, 19 Jun 2025 04:51:20 -0700 (PDT)
Received: from e133081.arm.com (unknown [10.1.28.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95C8D3F66E;
	Thu, 19 Jun 2025 04:51:35 -0700 (PDT)
Date: Thu, 19 Jun 2025 12:51:32 +0100
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: ryan.roberts@arm.com, yang@os.amperecomputing.com, will@kernel.org,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	james.morse@arm.com, broonie@kernel.org, ardb@kernel.org,
	baohua@kernel.org, suzuki.poulose@arm.com, david@redhat.com,
	jgg@ziepe.ca, nicolinc@nvidia.com, jsnitsel@redhat.com,
	mshavit@google.com, kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v7 2/4] arm64: Add BBM Level 2 cpu feature
Message-ID: <20250619115132.GA20673@e133081.arm.com>
References: <20250617095104.6772-1-miko.lenczewski@arm.com>
 <20250617095104.6772-3-miko.lenczewski@arm.com>
 <aFPu4SorUGlFt-2p@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFPu4SorUGlFt-2p@arm.com>

On Thu, Jun 19, 2025 at 12:05:05PM +0100, Catalin Marinas wrote:
> On Tue, Jun 17, 2025 at 09:51:02AM +0000, Mikołaj Lenczewski wrote:
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index f9c947166322..2e80ff237b96 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -2213,6 +2213,41 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
> >  	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
> >  }
> >  
> > +static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int scope)
> > +{
> > +	/*
> > +	 * We want to allow usage of BBML2 in as wide a range of kernel contexts
> > +	 * as possible. This list is therefore an allow-list of known-good
> > +	 * implementations that both support BBML2 and additionally, fulfill the
> > +	 * extra constraint of never generating TLB conflict aborts when using
> > +	 * the relaxed BBML2 semantics (such aborts make use of BBML2 in certain
> > +	 * kernel contexts difficult to prove safe against recursive aborts).
> > +	 *
> > +	 * Note that implementations can only be considered "known-good" if their
> > +	 * implementors attest to the fact that the implementation never raises
> > +	 * TLBI conflict aborts for BBML2 mapping granularity changes.
> 
> s/TLBI/TLB/
> 

ACK

> > +	 */
> > +	static const struct midr_range supports_bbml2_noabort_list[] = {
> > +		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
> > +		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> > +		{}
> > +	};
> > +
> > +	/* Does our cpu guarantee to never raise TLB conflict aborts? */
> > +	if (!is_midr_in_range_list(supports_bbml2_noabort_list))
> > +		return false;
> > +
> > +	/*
> > +	 * We currently ignore the AA64_ID_MMFR2 register, and only care about
> 
> s/AA64_ID_MMFR2/ID_AA64MMFR2_EL1/
> 

ACK

> > +	 * whether the MIDR check passes. This is because we specifically
> > +	 * care only about a stricter form of BBML2 (one guaranteeing noabort),
> > +	 * and so the MMFR2 check is pointless (all implementations passing the
> > +	 * MIDR check should also pass the MMFR2 check).
> 
> I think there's at least one implementation that behaves as
> BBML2-noabort but does not have the ID field advertising BBML2.
> 

Yes, I put "should" instead of "will" because of the AmpereOne
situation, but I didn't want to "name and shame". Should I explicitly
call this out? Or would you like me to soften the vocabulary here to imply
that as long as the MIDR passes, the MMFR2 check is not important?

> > +	 */
> > +
> > +	return true;
> > +}
> > +
> >  #ifdef CONFIG_ARM64_PAN
> >  static void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
> >  {
> > @@ -2980,6 +3015,11 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
> >  		.matches = has_cpuid_feature,
> >  		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
> >  	},
> > +	{
> > +		.capability = ARM64_HAS_BBML2_NOABORT,
> > +		.type = ARM64_CPUCAP_EARLY_LOCAL_CPU_FEATURE,
> > +		.matches = has_bbml2_noabort,
> > +	},
> >  	{
> >  		.desc = "52-bit Virtual Addressing for KVM (LPA2)",
> >  		.capability = ARM64_HAS_LPA2,
> > diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> > index 10effd4cff6b..2bd2bfaeddcd 100644
> > --- a/arch/arm64/tools/cpucaps
> > +++ b/arch/arm64/tools/cpucaps
> > @@ -45,6 +45,7 @@ HAS_LPA2
> >  HAS_LSE_ATOMICS
> >  HAS_MOPS
> >  HAS_NESTED_VIRT
> > +HAS_BBML2_NOABORT
> >  HAS_PAN
> >  HAS_PMUV3
> >  HAS_S1PIE
> 
> Otherwise it looks fine.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Kind regards,
Mikołaj Lenczewski
