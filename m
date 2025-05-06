Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF9F24728D
	for <iommu@lists.linux.dev>; Tue,  6 May 2025 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520580; cv=none; b=ZniWFns6wGNaT670jvN2jpCKLwxH1umw6d5mS469n4YrePQWZEDRHwQ03F/13zn9r4NYbiVm7v+vGDs8CqBGPgKaHT82MgDA/JISoFkHfhoZ7wg9Cvhm158NOzJR0ghkiK2lStgEeIddxSpKu3QyYqQKmIOfogI9TylzBAY2kTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520580; c=relaxed/simple;
	bh=7cxYL+OKy7RZGTgDCki9YAxC/O5/TwbW3Uwnyo/G258=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8MCyxRNln/9u7LubljEUCYV/gaMCXxpcEpUR2GF07OeFVJ2iwO2bXLYSLHnkBaXLYLu70avBCPrEQh/E/1Ahqa2en4A57CBDsKgu34+ndH6WObQKBtNeWHAbT0bbigtbwxGW1ASmwpdkiWTPqMOfI+jAAeNcweaS/s0zRsaFCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A1E4113E;
	Tue,  6 May 2025 01:36:07 -0700 (PDT)
Received: from e133081.arm.com (unknown [10.57.75.88])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E8EC3F673;
	Tue,  6 May 2025 01:36:10 -0700 (PDT)
Date: Tue, 6 May 2025 09:36:07 +0100
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: ryan.roberts@arm.com, suzuki.poulose@arm.com,
	yang@os.amperecomputing.com, corbet@lwn.net,
	catalin.marinas@arm.com, will@kernel.org, jean-philippe@linaro.org,
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
Message-ID: <20250506083607.GA45762@e133081.arm.com>
References: <20250428153514.55772-2-miko.lenczewski@arm.com>
 <20250428153514.55772-4-miko.lenczewski@arm.com>
 <d03d2ea6-323b-490e-b53c-d2e6d9c31b6f@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d03d2ea6-323b-490e-b53c-d2e6d9c31b6f@oracle.com>

Hi Alok,

Apologies for the delay.

On Mon, Apr 28, 2025 at 11:25:07PM +0530, ALOK TIWARI wrote:
> 
> 
> On 28-04-2025 21:05, Mikołaj Lenczewski wrote:
> > +config ARM64_BBML2_NOABORT
> > +	bool "Enable support for Break-Before-Make Level 2 detection and usage"
> > +	default y
> > +	help
> > +	  FEAT_BBM provides detection of support levels for break-before-make
> > +	  sequences. If BBM level 2 is supported, some TLB maintenance requirements
> > +	  can be relaxed to improve performance. We additonally require the
> 
> typo additonally  -> additionally
Yes, had missed this. Will fix.

> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 9c4d6d552b25..7a85a1bdc6e9 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -2200,6 +2200,70 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
> >   	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
> >   }
> > +static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
> > +{
> > +	/*
> > +	 * We want to allow usage of bbml2 in as wide a range of kernel contexts
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
> 
> use bbml2 -> BBML2 to maintain consistency
> 
OK, will go through and use BBML2 throughout for consistency.

-- 
Kind regards,
Mikołaj Lenczewski
