Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0181E51EE
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890035; cv=none; b=IpZDoN+mC0g162K7KI7I5E5qKZ60kQXOLIAYA7FeeRd7f89GOth/TXIf2pP7GQ6SMQy8M+02bMFjm4Yug1H3H3qYQYJuI7o6BOrUWFusuvix4GnHOmqIB8KETp0m4uC+m/1K82bQpe33uH0oJH9nfsiFinIrRgOgxWKF265FidA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890035; c=relaxed/simple;
	bh=2/a1E6NTa4Yd6rjAYXtT3N/admFYhKeGgDS1P5Zqbco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjWL2Vnr2BJ9cCVxMx1Uuqq1lJveeEhFIOow8Wi22bKF6rulfzHbohOdAOyP77pxjge+5/TQ3qWd/RkFpMubTZVrIFYcgUDbQ5go+aAJbUi81b8ybilDc/obWItC07vQ9XblnDoQUvvl+c89er1TZgvG59/+WyBXDae3Q9x3i/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E97E1477;
	Thu, 13 Mar 2025 11:20:43 -0700 (PDT)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E6463F694;
	Thu, 13 Mar 2025 11:20:28 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:20:26 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: ryan.roberts@arm.com, suzuki.poulose@arm.com,
	yang@os.amperecomputing.com, corbet@lwn.net,
	catalin.marinas@arm.com, will@kernel.org, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, joey.gouly@arm.com, james.morse@arm.com,
	broonie@kernel.org, anshuman.khandual@arm.com,
	oliver.upton@linux.dev, ioworker0@gmail.com, baohua@kernel.org,
	david@redhat.com, jgg@ziepe.ca,
	shameerali.kolothum.thodi@huawei.com, nicolinc@nvidia.com,
	mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v3 1/3] arm64: Add BBM Level 2 cpu feature
Message-ID: <20250313182026.GC40525@mazurka.cambridge.arm.com>
References: <20250313104111.24196-2-miko.lenczewski@arm.com>
 <20250313104111.24196-3-miko.lenczewski@arm.com>
 <86ikocomvd.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86ikocomvd.wl-maz@kernel.org>

On Thu, Mar 13, 2025 at 05:34:46PM +0000, Marc Zyngier wrote:
> On Thu, 13 Mar 2025 10:41:10 +0000,
> Mikołaj Lenczewski <miko.lenczewski@arm.com> wrote:
> > 
> > diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
> > index c6b185b885f7..9728faa10390 100644
> > --- a/arch/arm64/kernel/pi/idreg-override.c
> > +++ b/arch/arm64/kernel/pi/idreg-override.c
> > @@ -209,6 +209,7 @@ static const struct ftr_set_desc sw_features __prel64_initconst = {
> >  		FIELD("nokaslr", ARM64_SW_FEATURE_OVERRIDE_NOKASLR, NULL),
> >  		FIELD("hvhe", ARM64_SW_FEATURE_OVERRIDE_HVHE, hvhe_filter),
> >  		FIELD("rodataoff", ARM64_SW_FEATURE_OVERRIDE_RODATA_OFF, NULL),
> > +		FIELD("nobbml2", ARM64_SW_FEATURE_OVERRIDE_NOBBML2, NULL),
> >  		{}
> >  	},
> >  };
> > @@ -246,6 +247,7 @@ static const struct {
> >  	{ "rodata=off",			"arm64_sw.rodataoff=1" },
> >  	{ "arm64.nolva",		"id_aa64mmfr2.varange=0" },
> >  	{ "arm64.no32bit_el0",		"id_aa64pfr0.el0=1" },
> > +	{ "arm64.nobbml2",		"arm64_sw.nobbml2=1" },
> 
> Why is that a SW feature? This looks very much like a HW feature to
> me, and you should instead mask out ID_AA64MMFR2_EL1.BBM, and be done
> with it. Something like:
> 
> diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
> index c6b185b885f70..803a0c99f7b46 100644
> --- a/arch/arm64/kernel/pi/idreg-override.c
> +++ b/arch/arm64/kernel/pi/idreg-override.c
> @@ -102,6 +102,7 @@ static const struct ftr_set_desc mmfr2 __prel64_initconst = {
>  	.override	= &id_aa64mmfr2_override,
>  	.fields		= {
>  		FIELD("varange", ID_AA64MMFR2_EL1_VARange_SHIFT, mmfr2_varange_filter),
> +		FIELD("bbm", ID_AA64MMFR2_EL1_BBM_SHIFT, NULL),
>  		{}
>  	},
>  };
> @@ -246,6 +247,7 @@ static const struct {
>  	{ "rodata=off",			"arm64_sw.rodataoff=1" },
>  	{ "arm64.nolva",		"id_aa64mmfr2.varange=0" },
>  	{ "arm64.no32bit_el0",		"id_aa64pfr0.el0=1" },
> +	{ "arm64.nobbml2",		"id_aa64mmfr2.bbm=0" },
>  };
>  
>  static int __init parse_hexdigit(const char *p, u64 *v)
> 
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

Thanks for the review.

I think part of this confusion is due to me not including a changelog
(definitely something for the next respin!), but the discussion this
change is based on is found here:

https://lore.kernel.org/all/b46dc626-edc9-4d20-99d2-6cd08a01346c@os.amperecomputing.com/

Essentially, this is a SW feature because we do not check the
id_aa64mmfr2.bbm register as part of the has_bbml2_noabort() cpucap
matches filter. This is because certain hardware implementations
do not actually declare bbml2 via the hardware feature register, despite
implementing our bbml2_noabort feature, and certain hypervisor setups
might result in issues so we want to have an override to allow
potentially disabling the feature for generic kernels.

-- 
Kind regards,
Mikołaj Lenczewski
