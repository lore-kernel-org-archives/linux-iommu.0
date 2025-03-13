Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D349D12F399
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889323; cv=none; b=If96l41iofBvI6BMtAsfL1FQ40E3KjtzPcx2/K6PRr1T4/cHWcknCA0d61XZNRymoQYdkK7gqfvDclWiIfAuSok3gZKduDYlLoxDWyS6ox02PQJuJmdLRXJ6hOy3qVdNZP/uED9cZ3cxHLZb00rmqlawABtOL2s14ftW2pyyVC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889323; c=relaxed/simple;
	bh=pQGtB9l33v5PfLU1rNDNQq3i+W59p2jIMsURHN1eO7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwDuI6+t2g9LBhgPl3hpf8Zruc8CfF4L16D4rkrhi3Uge5Dm6HymEJhtjQ8uk+TfmYTiK4edYUgDHU5javCN/Z5gYN13XCwE3rfgYKa3HP8Gyik9AlzXOoOFOzmcmk6tXM7dagqdtJkN0tbEEsIBFxsl4m6b3SBW7YnMkFZyf7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 472DD1477;
	Thu, 13 Mar 2025 11:08:50 -0700 (PDT)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECDD53F694;
	Thu, 13 Mar 2025 11:08:35 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:08:33 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: suzuki.poulose@arm.com, yang@os.amperecomputing.com, corbet@lwn.net,
	catalin.marinas@arm.com, will@kernel.org, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, joey.gouly@arm.com, maz@kernel.org,
	james.morse@arm.com, broonie@kernel.org, anshuman.khandual@arm.com,
	oliver.upton@linux.dev, ioworker0@gmail.com, baohua@kernel.org,
	david@redhat.com, jgg@ziepe.ca,
	shameerali.kolothum.thodi@huawei.com, nicolinc@nvidia.com,
	mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v3 1/3] arm64: Add BBM Level 2 cpu feature
Message-ID: <20250313180833.GA40525@mazurka.cambridge.arm.com>
References: <20250313104111.24196-2-miko.lenczewski@arm.com>
 <20250313104111.24196-3-miko.lenczewski@arm.com>
 <ea10caee-59ef-4a00-9b61-37cb0a379411@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea10caee-59ef-4a00-9b61-37cb0a379411@arm.com>

On Thu, Mar 13, 2025 at 04:13:22PM +0000, Ryan Roberts wrote:
> On 13/03/2025 10:41, Mikołaj Lenczewski wrote: 
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index d561cf3b8ac7..b936e0805161 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -2176,6 +2176,76 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
> >  	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
> >  }
> >  
> > +static inline bool bbml2_possible(void)
> > +{
> > +	return !arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_NOBBML2);
> 
> If you're going to keep this helper, I think it really needs to be:
> 
> return IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT) &&
>        !arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_NOBBML2);
> 
> Then you would simplify the caller to remove it's own
> IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT) check.
> 
> But personally I would remove the helper and just fold the test into
> has_bbml2_noabort().
> 
> Thanks,
> Ryan

I was debating folding it into has_bbml2_noabort(), but went ahead and
implemented it separately to match hvhe_possible(), which was another sw
feature helper.

But I agree, folding it will be simpler and read just as easily (if not
easier). Will do so.

> > +}
> > +
> > +static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
> > +{
> > +	/* We want to allow usage of bbml2 in as wide a range of kernel contexts
> > +	 * as possible. This list is therefore an allow-list of known-good
> > +	 * implementations that both support bbml2 and additionally, fulfill the
> > +	 * extra constraint of never generating TLB conflict aborts when using
> > +	 * the relaxed bbml2 semantics (such aborts make use of bbml2 in certain
> > +	 * kernel contexts difficult to prove safe against recursive aborts).
> > +	 *
> > +	 * Note that implementations can only be considered "known-good" if their
> > +	 * implementors attest to the fact that the implementation never raises
> > +	 * TLBI conflict aborts for bbml2 mapping granularity changes.
> > +	 */
> > +	static const struct midr_range supports_bbml2_noabort_list[] = {
> > +		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
> > +		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> > +		{}
> > +	};
> > +
> > +	return is_midr_in_range_list(cpu_midr, supports_bbml2_noabort_list);
> > +}
> > +
> > +static inline unsigned int __cpu_read_midr(int cpu)
> 
> nit: why the double underscrore prefix?

Again copying other helpers I saw that seemed to do similar things.
Didn't know if this was the expected style, so did as other helpers did.
Will remove.

Thank you for the review.

-- 
Kind regards,
Mikołaj Lenczewski
