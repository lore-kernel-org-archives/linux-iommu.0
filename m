Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C06025D549
	for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323438; cv=none; b=n0mpeHQ0HwHbafAM4N7fmqos45mujON8Jw7KScFlcrl8+ALHhwWg2qm6aPrn20MO9A92aCs0zdx6dWh8LASQ1LjFeDWiQLvPCg1atuh8HeMuIkojnCG+i7qsxiEeKJOhfAhSVLrvU5VQfUgGKgrGS2GZQTowl8xBd5s9jMdpaYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323438; c=relaxed/simple;
	bh=QM1fFUybAdVeapSsOuNYeOoAcCaPlkTxn+ouYihOWqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9XAB1D9YIUv+94crFQzsLo0cH94iEPpj3kFHj+NyMc6r5AHSzCAISqDiCrujjR0PJq9IMBuyr9xlD8Rn2Oez5C8g0PuFpWwaJsBQwvPaub6c16PRRTCD7XEHX4IzibJLr+1f3+i57JfJGA58AP7tIbewc0kb0xOiCB+0cavHiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D6A5113E;
	Thu, 19 Jun 2025 01:56:50 -0700 (PDT)
Received: from e133081.arm.com (e133081.arm.com [10.1.32.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43C523F58B;
	Thu, 19 Jun 2025 01:57:05 -0700 (PDT)
Date: Thu, 19 Jun 2025 09:57:01 +0100
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: yang@os.amperecomputing.com, catalin.marinas@arm.com, will@kernel.org,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	james.morse@arm.com, broonie@kernel.org, ardb@kernel.org,
	baohua@kernel.org, suzuki.poulose@arm.com, david@redhat.com,
	jgg@ziepe.ca, nicolinc@nvidia.com, jsnitsel@redhat.com,
	mshavit@google.com, kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v7 2/4] arm64: Add BBM Level 2 cpu feature
Message-ID: <20250619085701.GA10805@e133081.arm.com>
References: <20250617095104.6772-1-miko.lenczewski@arm.com>
 <20250617095104.6772-3-miko.lenczewski@arm.com>
 <e40989e9-9521-4915-9bae-eb7be1d4e056@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e40989e9-9521-4915-9bae-eb7be1d4e056@arm.com>

On Wed, Jun 18, 2025 at 03:07:41PM +0100, Ryan Roberts wrote:
> On 17/06/2025 10:51, Mikołaj Lenczewski wrote:
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
> 
> Is there a reason you have removed the .desc from this? Without it, the kernel
> won't print a "detected" line when it enables the feature. Previously you had:
> 
> 		.desc = "BBM Level 2 without conflict abort",
> 
> > +	},
> >  	{
> >  		.desc = "52-bit Virtual Addressing for KVM (LPA2)",
> >  		.capability = ARM64_HAS_LPA2, 
>

Damn it! I completely forgot to birng that back. Yet another remenant of
the NO_BBML2_NOABORT version we had discussed in v6, because a
description field would have been confusing due to the double negation:

https://lore.kernel.org/all/83d1f7af-3dc7-45f9-94f3-8a0917c051d2@arm.com/

Thank you very much for spotting this Ryan! Ill return the description,
and respin on Monday (unless it is possible to do this as a RESEND or
similar, but I doubt it since this is technically a functional change) :/

-- 
Kind regards,
Mikołaj Lenczewski
