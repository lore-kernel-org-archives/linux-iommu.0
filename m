Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC831D63C0
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994851; cv=none; b=BHYq1VJfmR+xMHkskVWzZq1deJsIIiL4N2h6s59S0RUHKVHFjajs0y6GBggJeDMDyK4hz4pOibRgmj9EjSPVYBfeEyHttjHEtxodgbHqLXPy2ZSEWMvY98F9WInMzvbmyIuy3WfSNOKcbzT5dw/dXTQ2V4OgeovyrmOMkZkCrIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994851; c=relaxed/simple;
	bh=xJHjaRKydhZZ7SiqrNhR8fRWLsb8uvJalNw0Vd/ti9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqDwsKu4N0v6zmVXf2jRGjKPBDKEffsXuqtzwNQFBfJY65vsrD7mjBzZAoSvx3FZVTMhdzMzT5ad0/lg5SvSjQ1nUQIHEGsuU8PgtzWbT02Aslj3RRWavOLfIUCZdax/gNlE3vROsybzgznjhtbe+aR1Nl1ha97HpDWkbLrm4rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE35F113E;
	Mon,  3 Mar 2025 01:41:02 -0800 (PST)
Received: from e133081.arm.com (unknown [10.57.37.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 822EA3F66E;
	Mon,  3 Mar 2025 01:40:45 -0800 (PST)
Date: Mon, 3 Mar 2025 09:40:34 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: ryan.roberts@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	will@kernel.org, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, joey.gouly@arm.com, oliver.upton@linux.dev,
	james.morse@arm.com, broonie@kernel.org, maz@kernel.org,
	david@redhat.com, akpm@linux-foundation.org, jgg@ziepe.ca,
	nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
	smostafa@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 1/4] arm64: Add BBM Level 2 cpu feature
Message-ID: <20250303094022.GA13345@e133081.arm.com>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-3-miko.lenczewski@arm.com>
 <c572a93f-0899-4fc7-9764-d3e76e9fe6d1@os.amperecomputing.com>
 <223a817b-66dd-4182-838f-a186b059fe41@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <223a817b-66dd-4182-838f-a186b059fe41@os.amperecomputing.com>

On Fri, Feb 28, 2025 at 06:45:38PM -0800, Yang Shi wrote:
> 
> 
> 
> On 2/28/25 5:29 PM, Yang Shi wrote:
> > 
> > 
> > 
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index 940343beb3d4..baae6d458996 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -2057,6 +2057,17 @@ config ARM64_TLB_RANGE
> > >         The feature introduces new assembly instructions, and they were
> > >         support when binutils >= 2.30.
> > >   +config ARM64_ENABLE_BBML2_NOABORT
> > > +    bool "Enable support for Break-Before-Make Level 2 detection
> > > and usage"
> > > +    default y
> > > +    help
> > > +      FEAT_BBM provides detection of support levels for
> > > break-before-make
> > > +      sequences. If BBM level 2 is supported, some TLB maintenance
> > > requirements
> > > +      can be relaxed to improve performance. We additonally require the
> > > +      property that the implementation cannot ever raise TLB
> > > Conflict Aborts.
> > > +      Selecting N causes the kernel to fallback to BBM level 0
> > > behaviour
> > > +      even if the system supports BBM level 2.
> > > +
> > >   endmenu # "ARMv8.4 architectural features"
> > >     menu "ARMv8.5 architectural features"
> > > diff --git a/arch/arm64/include/asm/cpucaps.h
> > > b/arch/arm64/include/asm/cpucaps.h
> > > index 0b5ca6e0eb09..2d6db33d4e45 100644
> > > --- a/arch/arm64/include/asm/cpucaps.h
> > > +++ b/arch/arm64/include/asm/cpucaps.h
> > > @@ -23,6 +23,8 @@ cpucap_is_possible(const unsigned int cap)
> > >           return IS_ENABLED(CONFIG_ARM64_PAN);
> > >       case ARM64_HAS_EPAN:
> > >           return IS_ENABLED(CONFIG_ARM64_EPAN);
> > > +    case ARM64_HAS_BBML2_NOABORT:
> > > +        return IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT);
> > >       case ARM64_SVE:
> > >           return IS_ENABLED(CONFIG_ARM64_SVE);
> > >       case ARM64_SME:
> > > diff --git a/arch/arm64/include/asm/cpufeature.h
> > > b/arch/arm64/include/asm/cpufeature.h
> > > index e0e4478f5fb5..108ef3fbbc00 100644
> > > --- a/arch/arm64/include/asm/cpufeature.h
> > > +++ b/arch/arm64/include/asm/cpufeature.h
> > > @@ -866,6 +866,11 @@ static __always_inline bool
> > > system_supports_mpam_hcr(void)
> > >       return alternative_has_cap_unlikely(ARM64_MPAM_HCR);
> > >   }
> > >   +static inline bool system_supports_bbml2_noabort(void)
> > > +{
> > > +    return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOABORT);
> > > +}
> > 
> > Hi Miko,
> > 
> > I added AmpereOne mdir on top of this patch. I can see BBML2 feature is
> > detected via dmesg. But system_supports_bbml2_noabort() returns false.
> > The warning in the below debug patch is triggered:
> > 
> > diff --git a/arch/arm64/kernel/cpufeature.c
> > b/arch/arm64/kernel/cpufeature.c
> > index faa9094d97dd..a70829ae2bd0 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -3814,6 +3814,9 @@ void __init setup_system_features(void)
> >  {
> >         setup_system_capabilities();
> > 
> > +       if (!system_supports_bbml2_noabort())
> > +               WARN_ON_ONCE(1);
> > +
> >         kpti_install_ng_mappings();
> > 
> >         sve_setup();
> > 
> > I thought it may be too early. But it seems other system features work
> > well, for example, MPAM. I didn't figure out why. It is weird.
> 
> I just figured out the problem It is because the wrong kconfig name is used
> in cpucaps.h. The code is:
> 
> +    case ARM64_HAS_BBML2_NOABORT:
> +        return IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT);
> 
> But the kconfig name actually is:
> 
> +config ARM64_ENABLE_BBML2_NOABORT
> 
> IMHO, the "ENABLE" in kconfig name sounds unnecessary.
> 
> Thanks,
> Yang
> 
> 

Hi Yang,

Thank you for the review, and apologies for the slight delay.

Thanks again for the spot, I agree that `ENABLE` is probably redundant
(and clearly, caused an issue here). Will remove this. Please let me
know if there are any other issues with rebasing your patches on top of
mine.

-- 
Kind regards,
Mikołaj Lenczewski
