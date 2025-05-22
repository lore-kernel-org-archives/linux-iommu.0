Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305C02980AC;
	Thu, 22 May 2025 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747927410; cv=none; b=glG6adjdGUVyb0xfOYow9n7ZhYm8qjhOYvmWFuvdpG24QJ6r9CtMAk+GknLQbHHaunPOw1yENg1e9WSzRgmLVQfWZKhisojStlueoDRxgHjwVL+gCZSU5Gz2FL0EqmpkTfhf3TWRiHdsmlkS6ESUp/2YESM0JOAfBodSGfw5CnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747927410; c=relaxed/simple;
	bh=NJA+KbkwdUlL42lU1s09oYb2KetRDGsXFK9VBEfPQPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMrLmVHoA3V9dMArwDpYZyAJBNaKzWLC2OvCnUN121dFQI8YPfR0t8mmBirtOpGGIQu8uoyriw8aXtfde/5Ome9StJowrKHPPgh9OfV3mSMELBRLXBXjaWYJqCXcFy5u0XoOeUTcIk7+lK9OHYzRJJSB662CaDPXtRC5qzUSsMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4979C4CEE4;
	Thu, 22 May 2025 15:23:24 +0000 (UTC)
Date: Thu, 22 May 2025 16:23:22 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	yang@os.amperecomputing.com, corbet@lwn.net,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	akpm@linux-foundation.org, paulmck@kernel.org, mark.rutland@arm.com,
	joey.gouly@arm.com, maz@kernel.org, james.morse@arm.com,
	broonie@kernel.org, oliver.upton@linux.dev, baohua@kernel.org,
	david@redhat.com, ioworker0@gmail.com, jgg@ziepe.ca,
	nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
	smostafa@google.com, kevin.tian@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [RESEND PATCH v6 1/3] arm64: Add BBM Level 2 cpu feature
Message-ID: <aC9BajxkIv0UxWLq@arm.com>
References: <78fec33d-fe66-4352-be11-900f456c9af3@arm.com>
 <20250509134904.GA5707@willie-the-truck>
 <aB4nqtMJuvvp7Vwm@arm.com>
 <015746d7-ca46-4978-a441-09fba781fdd4@arm.com>
 <4709ff5a-f89c-426e-ae95-f8356808f4f5@arm.com>
 <99079d56-428b-4bc4-b20a-dc10032f2a2f@arm.com>
 <aCIiwrA_MOeVhFre@arm.com>
 <c5a74dfe-68e2-48f1-9bbb-06db8e62ffea@arm.com>
 <aCSHESk1DzShD4vt@arm.com>
 <0a909fc1-af17-4704-90b3-23359a00482d@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a909fc1-af17-4704-90b3-23359a00482d@arm.com>

Hi Suzuki,

Thanks for looking at this.

On Mon, May 19, 2025 at 10:45:31AM +0100, Suzuki K Poulose wrote:
> On 14/05/2025 13:05, Catalin Marinas wrote:
> > On Tue, May 13, 2025 at 10:15:49AM +0100, Suzuki K Poulose wrote:
> > > On 12/05/2025 17:33, Catalin Marinas wrote:
> > > > Stepping back a bit, we know that the MIDR allow-list implies
> > > > BBML2_NOABORT (and at least BBML2 as in the ID regs). In theory, we need
> > > 
> > > Please be aware that BBML2_NOABORT midr list may not always imply BBLM2 in
> > > ID registers (e.g., AmpereOne. But the plan is to fixup the per cpu
> > > ID register - struct cpuinfo_arm64 - for such cores at early boot,
> > > individually, before it is used for sanitisation of the system wide
> > > copy).
> > 
> > Ah, good point. We can then ignore BBML2 ID regs and only rely on MIDR
> > (and some future BBML3).
> > 
> > > > So how about we introduce a WEAK_BOOT_CPU_FEATURE which gets enabled by
> > > > the boot CPU if it has it _but_ cleared by any secondary early CPU if it
> > > > doesn't (and never enabled by secondary CPUs). When the features are
> > > > finalised, we know if all early CPUs had it. In combination with
> > > > PERMITTED_FOR_LATE_CPU, we'd reject late CPUs that don't have it.
> > > 
> > > That could work, but it introduces this "clearing" a capability, which
> > > we don't do at the moment.
> > > 
> > > We had an offline discussion about this some time ago, with Mark
> > > Rutland. The best way to deal with this is to change the way we compute
> > > capabilities. i.e.,
> > > 
> > > 
> > > 1. Each boot CPU run through all the capabilities and maintain a per-cpu
> > >     copy of the state.
> > > 2. System wide capabilities can then be constructed from the all early
> > >     boot CPU capability state (e.g., ANDing all the state from all CPUs
> > >     for SCOPE_SYSTEM or ORing for LOCAL_CPU).
> > > 
> > > But this requires a drastic change to the infrastructure.
> > 
> > I think it's a lot simpler to achieve the ANDing - set the (system)
> > capability if detected on the boot CPU, only clear it if missing on
> > subsequent CPUs. See below on an attempt to introduce this. For lack of
> > inspiration, I called it ARM64_CPUCAP_GLOBAL_CPU_FEATURE which has both
> > SCOPE_LOCAL and SCOPE_SYSTEM. It's permitted for late CPUs but not
> > optional if already enabled. The advantage of having both local&system
> > is that the match function will be called for both scopes. I added a
> > mask in to cpucap_default_scope() when calling matches() since so far
> > no cap had both.
> 
> Thanks, the change below does the trick. I am reasoning with the way
> the scope has been defined (hacked ;-)).
> 
> SCOPE_LOCAL_CPU && SCOPE_SYSTEM
> 
> 1. SCOPE_LOCAL_CPU : Because you need to run this on all the (early) CPUs.
> 
> 2. SCOPE_SYSTEM: To check if the capability holds at the end of the
> smp boot.
> 
> While, we really "detect" it on SCOPE_BOOT_CPU and only run the
> cap checks, if that is available. But put another way, BOOT_CPU
> is only used as an easy way to detect if this CPUs is the first
> one to run the check vs at least one CPU has run and cleared the
> cap.

Yes, we start with boot CPU and keep 'and-ing' new values onto it.

> I wonder if we could use some other flag to indicate the fact that,
> a non-boot CPU is allowed to clear the capability explicitly, rather than
> implying it with SCOPE_SYSTEM && SCOPE_LOCAL_CPU. Or may be make
> it explicit that the capability must be matched on ALL cpus and
> finalized at the end ?

I had such variant locally but then decided to reuse the SCOPE_SYSTEM
for this, more of a way to indicate that we want something system-wide
but checked per-CPU. We could add a new flag, though I was wondering
whether we can have a property that's checked both per-CPU and once more
system-wide. That's what actually happens with the above, then the probe
function can tell whether it was called in the CPU or system scope.

Alternatively, we can leave the local/system combining for later and
only add a flag to tell how they compose - "any" (default) vs "all".

> /*
>  * When paired with SCOPE_LOCAL_CPU, all CPUs must satisfy the
>  * condition. This is different from SCOPE_SYSTEM, where the check
>  * is performed only once at the end of SMP boot. But SCOPE_SYSTEM
>  * may not be sufficient in cases where the capability depends on
>  * properties that are not "sanitised" (e.g., MIDR_EL1) and must be
>  * satisfied by all the early SMP boot CPUs.
>  */
> #define ARM64_CPUCAP_MATCH_ALL_EARLY_CPUS	((u16)BIT(7))
> 
> statici inline bool cpucap_match_all_cpus(struct arm64_capability *cap)
> {
> 	return !!(cap->type & ARM64_CPUCAP_MATCH_ALL_EARLY_CPUS);
> }

Yes, something like this would work.

> Also, we already go through the capablity list to report the ones
> with "cpumask" separately, and we could use that to also report
> the ones with MATCH_ALL_CPUs. Something like:
> 
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9c4d6d552b25..14cbae51d802 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -3769,10 +3769,15 @@ static void __init setup_system_capabilities(void)
>         for (int i = 0; i < ARM64_NCAPS; i++) {
>                 const struct arm64_cpu_capabilities *caps = cpucap_ptrs[i];
> 
> -		if (caps && caps->cpus && caps->desc &&
> -			cpumask_any(caps->cpus) < nr_cpu_ids)
> +		if (!caps || !caps->desc)
> +			continue;
> +
> +		if (caps->cpus && cpumask_any(caps->cpus) < nr_cpu_ids)
> 			pr_info("detected: %s on CPU%*pbl\n",
> 				caps->desc, cpumask_pr_args(caps->cpus));
> +
> +		/* Report capabilities that had to be matched on all CPUs */
> +		if (capcpucap_match_all_cpus(caps) && cpus_have_cap(caps))
> +			pr_info("detected: %s\n", caps->desc);
>         }

Yeah, I hacked something similar with the 'global' proposal based on
SCOPE_SYSTEM.

> > ---------------------8<-----------------------------------------
> > diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> > index c4326f1cb917..0b0b26a6f27b 100644
> > --- a/arch/arm64/include/asm/cpufeature.h
> > +++ b/arch/arm64/include/asm/cpufeature.h
> > @@ -331,6 +331,15 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
> >   #define ARM64_CPUCAP_BOOT_CPU_FEATURE                  \
> >   	(ARM64_CPUCAP_SCOPE_BOOT_CPU | ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU)
> > +/*
> > + * CPU feature detected at boot time based on all CPUs. It is safe for a late
> > + * CPU to have this feature even though the system hasn't enabled it, although
> > + * the feature will not be used by Linux in this case. If the system has
> > + * enabled this feature already, then every late CPU must have it.
> > + */
> > +#define ARM64_CPUCAP_GLOBAL_CPU_FEATURE			
> 
> #define ARM64_CPUCAP_MATCH_ALL_CPU_FEATURE ?
> 
> \
> > +	 (ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_SYSTEM_FEATURE)
> 
>   (ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_MATCH_ALL_EARLY_CPUS)
> 
> 
> > +
> >   struct arm64_cpu_capabilities {
> >   	const char *desc;
> >   	u16 capability;
> > @@ -391,6 +400,11 @@ static inline int cpucap_default_scope(const struct arm64_cpu_capabilities *cap)
> >   	return cap->type & ARM64_CPUCAP_SCOPE_MASK;
> >   }
> > +static inline bool cpucap_global_scope(const struct arm64_cpu_capabilities *cap)
> 
> May be call it cpucap_match_all_cpus() ?

I can respin, the alternative looks good to me.

Now, we discussed offline of a different approach: for AmpereOne we'll
have to check MIDR early (as an erratum) and pretend it has BBML2,
populate the sanitised cpuid regs accordingly. We could do something
similar for the other CPUs, pretend it's something like BBML3 and get
the architects to commit to it (but this would delay the patchset).

TBH, I'd rather not hack this and only rely on the MIDR for BBM_NOABORT
(without any level) and the above MATCH_ALL_CPUS. My proposal is to
respin this with a MATCH_ALL_CPUS flag that only checks the MIDR. We can
later add a SCOPE_SYSTEM to the same capability that would 'or' in the
BBML3 cap (or just use two capabilities, though we end up with two many
branches or NOPs in the patched alternatives).

-- 
Catalin
