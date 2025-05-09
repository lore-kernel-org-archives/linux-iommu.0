Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899DD2918CF;
	Fri,  9 May 2025 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798556; cv=none; b=qT7P+jReVIUO1vQXd1nzNmEAXfLhBc5mdTEJWa8fTA2EfhG7zx0Pgt8BgDUgMERqUlc1c/6eoukwBLQdcauEsTdAkCcrd2IIdhLgqxxGk4hlOeehhYdlLQ1gB4dxWJrvqqKURxxpxVaVa8cAr8czEuZowka0g45pVv5Q5ODNnCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798556; c=relaxed/simple;
	bh=ddxFekODOqJy1oQlp1NZDYc/Pj9lvlATNoTbz761B5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtCWacSf4WlHBRYgY4YJaeZeC19kEz+VzGjDeQovep4jafz/9aJDJT2yudrFwsfZt8OyqFct1Nx+uM/Y+v+UtUZa8HNRh/vss6EU6MTNJFM3W+p+jh59c8wVxUyHY5Q57FOXjixhpLPrVRVvWFKu4YvtnDfCA4aYxYgGPv+Q1Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQ+uoXUp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQ+uoXUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF75C4CEE4;
	Fri,  9 May 2025 13:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746798553;
	bh=ddxFekODOqJy1oQlp1NZDYc/Pj9lvlATNoTbz761B5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pQ+uoXUpmF/3twCcIi3Lai3o3xk3GzjXh4Vtzef2xl+XK5lS7fyBbQ0UFZzYOkYpV
	 dUtfTp8YyM+m1uCBcNG1HQvDk6Nf7/h0n9vLEZ88nS1jLaw3kZC+MJWQAs8/6JfmCW
	 GLX/BJFBUp0BoBJxFAMpMHQQxyx062Ra3vAXfp7i5GUtnfWbItEAT9nUXEUdmY+WZG
	 QaS5XlRufjGUUzac2Gdf4KQVW4gTJmD7URMBqCpPwQgEQkWKKaXQtwRRvrcbUiQUCW
	 JAx1/diS1biH2qZn4t9dRTFqD8Klqp6AjFPQ8OnLTIf9OgIEOCwF0ak/GgLb9J7aoh
	 g4HQFuPfD/y3w==
Date: Fri, 9 May 2025 14:49:05 +0100
From: Will Deacon <will@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	suzuki.poulose@arm.com, yang@os.amperecomputing.com, corbet@lwn.net,
	catalin.marinas@arm.com, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
	paulmck@kernel.org, mark.rutland@arm.com, joey.gouly@arm.com,
	maz@kernel.org, james.morse@arm.com, broonie@kernel.org,
	oliver.upton@linux.dev, baohua@kernel.org, david@redhat.com,
	ioworker0@gmail.com, jgg@ziepe.ca, nicolinc@nvidia.com,
	mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
	kevin.tian@intel.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [RESEND PATCH v6 1/3] arm64: Add BBM Level 2 cpu feature
Message-ID: <20250509134904.GA5707@willie-the-truck>
References: <20250428153514.55772-2-miko.lenczewski@arm.com>
 <20250428153514.55772-4-miko.lenczewski@arm.com>
 <20250506142508.GB1197@willie-the-truck>
 <78fec33d-fe66-4352-be11-900f456c9af3@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78fec33d-fe66-4352-be11-900f456c9af3@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, May 06, 2025 at 03:52:59PM +0100, Ryan Roberts wrote:
> On 06/05/2025 15:25, Will Deacon wrote:
> > On Mon, Apr 28, 2025 at 03:35:14PM +0000, Mikołaj Lenczewski wrote:
> >> The Break-Before-Make cpu feature supports multiple levels (levels 0-2),
> >> and this commit adds a dedicated BBML2 cpufeature to test against
> >> support for, as well as a kernel commandline parameter to optionally
> >> disable BBML2 altogether.
> >>
> >> This is a system feature as we might have a big.LITTLE architecture
> >> where some cores support BBML2 and some don't, but we want all cores to
> >> be available and BBM to default to level 0 (as opposed to having cores
> >> without BBML2 not coming online).
> >>
> >> To support BBML2 in as wide a range of contexts as we can, we want not
> >> only the architectural guarantees that BBML2 makes, but additionally
> >> want BBML2 to not create TLB conflict aborts. Not causing aborts avoids
> >> us having to prove that no recursive faults can be induced in any path
> >> that uses BBML2, allowing its use for arbitrary kernel mappings.
> >> Support detection of such CPUs.
> >>
> >> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> >> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  .../admin-guide/kernel-parameters.txt         |  3 +
> >>  arch/arm64/Kconfig                            | 19 +++++
> >>  arch/arm64/include/asm/cpucaps.h              |  2 +
> >>  arch/arm64/include/asm/cpufeature.h           |  5 ++
> >>  arch/arm64/kernel/cpufeature.c                | 71 +++++++++++++++++++
> >>  arch/arm64/kernel/pi/idreg-override.c         |  2 +
> >>  arch/arm64/tools/cpucaps                      |  1 +
> >>  7 files changed, 103 insertions(+)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >> index d9fd26b95b34..2749c67a4f07 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -449,6 +449,9 @@
> >>  	arm64.no32bit_el0 [ARM64] Unconditionally disable the execution of
> >>  			32 bit applications.
> >>  
> >> +	arm64.nobbml2	[ARM64] Unconditionally disable Break-Before-Make Level
> >> +			2 support
> > 
> > Hmm, I'm not sure we really want this. It opens up the door for folks to
> > pass 'id_aa64mmfr2.bbm=2' without updating the allow-list which feels
> > like it's going to make crashes harder to reason about.
> > 
> > Is there a compelling reason to add this right now?
> 
> I don't think there is a *compelling* reason. This came about from Suzuki's
> feedback at [1]. He was keen to have a mechanism to disable BBML2 in case issues
> were found.
> 
> But simpler is usually better; I'd be ok with removing.

We can always add it back if we really need it, but adding an allowlist
*and* a mechanism to override the allowlist at the same time seems overly
pessimistic to me :)

> >> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> >> index 9c4d6d552b25..7a85a1bdc6e9 100644
> >> --- a/arch/arm64/kernel/cpufeature.c
> >> +++ b/arch/arm64/kernel/cpufeature.c
> >> @@ -2200,6 +2200,70 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
> >>  	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
> >>  }
> >>  
> >> +static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
> >> +{
> >> +	/*
> >> +	 * We want to allow usage of bbml2 in as wide a range of kernel contexts
> >> +	 * as possible. This list is therefore an allow-list of known-good
> >> +	 * implementations that both support bbml2 and additionally, fulfill the
> >> +	 * extra constraint of never generating TLB conflict aborts when using
> >> +	 * the relaxed bbml2 semantics (such aborts make use of bbml2 in certain
> >> +	 * kernel contexts difficult to prove safe against recursive aborts).
> >> +	 *
> >> +	 * Note that implementations can only be considered "known-good" if their
> >> +	 * implementors attest to the fact that the implementation never raises
> >> +	 * TLBI conflict aborts for bbml2 mapping granularity changes.
> >> +	 */
> >> +	static const struct midr_range supports_bbml2_noabort_list[] = {
> >> +		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
> >> +		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> >> +		{}
> >> +	};
> >> +
> >> +	return is_midr_in_range_list(cpu_midr, supports_bbml2_noabort_list);
> > 
> > This doesn't compile against latest mainline as is_midr_in_range_list()
> > no longer takes the midr.
> 
> Will ask Miko to fix.

Cheers. v6.15-rc1 is probably the right base to use as that's what I've
based for-next/mm on.

> >> +static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int scope)
> >> +{
> >> +	if (!IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT))
> >> +		return false;
> >> +
> >> +	if (scope & SCOPE_SYSTEM) {
> >> +		int cpu;
> >> +
> >> +		/*
> >> +		 * We are a boot CPU, and must verify that all enumerated boot
> >> +		 * CPUs have MIDR values within our allowlist. Otherwise, we do
> >> +		 * not allow the BBML2 feature to avoid potential faults when
> >> +		 * the insufficient CPUs access memory regions using BBML2
> >> +		 * semantics.
> >> +		 */
> >> +		for_each_online_cpu(cpu) {
> >> +			if (!cpu_has_bbml2_noabort(cpu_read_midr(cpu)))
> >> +				return false;
> >> +		}
> > 
> > This penalises large homogeneous systems and it feels unnecessary given
> > that we have the ability to check this per-CPU. Can you use
> > ARM64_CPUCAP_BOOT_CPU_FEATURE instead of ARM64_CPUCAP_SYSTEM_FEATURE
> > to solve this?
> 
> We are trying to solve for the case where the boot CPU has BBML2 but a secondary
> CPU doesn't. (e.g. hetrogeneous system where boot CPU is big and secondary is
> little and does not advertise the feature. I can't remember if we proved there
> are real systems with this config - I have vague recollection that we did but my
> memory is poor...).
> 
> My understanding is that for ARM64_CPUCAP_BOOT_CPU_FEATURE, "If the boot CPU
> has enabled this feature already, then every late CPU must have it". So that
> would exclude any secondary CPUs without BBML2 from coming online?

Damn, yes, you're right. However, it still feels horribly hacky to iterate
over the online CPUs in has_bbml2_noabort() -- the cpufeature framework
has the ability to query features locally and we should be able to use
that. We're going to want that should the architecture eventually decide
on something like BBML3 for this.

What we have with BBML2_NOABORT seems similar to an hwcap in that we only
support the capability if all CPUs have it (rejecting late CPUs without it
in that case) but we can live without it if not all of the early CPUs
have it. Unlikely hwcaps, though, we shouldn't be advertising this to
userspace and we can't derive the capability solely from the sanitised
system registers.

I wonder if we could treat it like an erratum in some way instead? That
is, invert things so that CPUs which _don't_ have BBML2_NOABORT are
considered to have a "BBM_CONFLICT_ABORT" erratum (which we obviously
wouldn't shout about). Then we should be able to say:

  - If any of the early CPUs don't have BBML2_NOABORT, then the erratum
    would be enabled and we wouln't elide BBM.

  - If a late CPU doesn't have BBML2_NOABORT then it can't come online
    if the erratum isn't already enabled.

Does that work? If not, then perhaps the cpufeature/cpuerrata code needs
some surgery for this.

> How do you see this working with ARM64_CPUCAP_BOOT_CPU_FEATURE? Or do you just
> think that all systems will always be homogeneous with respect to FEAT_BBM?

That's probably wishful thinking, sadly :(

Will
