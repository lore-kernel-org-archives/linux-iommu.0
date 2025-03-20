Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B74F22155C
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742490838; cv=none; b=fAMZnddkFTVl97x6J/x3+tJcSdxhNCAJe3+QDqQXrGjxWG/2wIba+0PedJnGts+Qjz13i2d+rzK076/bg5ahqFy44O40ViHlE0wcot5dn4iSsNNKXGgt2pPO2sVO+hHjD0Ltt26RI1VFNtIP082nC61WWRN23R8JUcTeYF2b7W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742490838; c=relaxed/simple;
	bh=zB2IwDZ51pPE+pv8LlcV5Dy+qMvyYCTBZV5CBy3Loro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBor84kLxeb1vt+TV3KvmE3mOy3Gb3Vgw+Dk47U9dElfxzlKUZTecRI8eJ1E7zqs9AmKVd3iG5LkNmukpuPHxfCxSAto8Jv461UIP0ZvAaovjDqX82W07OlvWFaOvG/YjkGuOsNhPenA55khmTI21iLD7JrR+MPu9ubZwwQFI/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06E6A113E;
	Thu, 20 Mar 2025 10:14:03 -0700 (PDT)
Received: from e133081.arm.com (unknown [10.57.15.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91C333F673;
	Thu, 20 Mar 2025 10:13:50 -0700 (PDT)
Date: Thu, 20 Mar 2025 17:13:47 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: ryan.roberts@arm.com, yang@os.amperecomputing.com, corbet@lwn.net,
	catalin.marinas@arm.com, will@kernel.org, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
	ardb@kernel.org, mark.rutland@arm.com, joey.gouly@arm.com,
	maz@kernel.org, james.morse@arm.com, broonie@kernel.org,
	oliver.upton@linux.dev, baohua@kernel.org, david@redhat.com,
	ioworker0@gmail.com, jgg@ziepe.ca, nicolinc@nvidia.com,
	mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v4 1/3] arm64: Add BBM Level 2 cpu feature
Message-ID: <20250320171347.GA494995@e133081.arm.com>
References: <20250319150533.37440-2-miko.lenczewski@arm.com>
 <20250319150533.37440-3-miko.lenczewski@arm.com>
 <f9c5839e-5d55-497e-9df3-ab778c4eae72@arm.com>
 <20250320170936.GB487465@e133081.arm.com>
 <952cc3ea-ca11-43a3-a8f4-36e3bbb1fa84@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <952cc3ea-ca11-43a3-a8f4-36e3bbb1fa84@arm.com>

On Thu, Mar 20, 2025 at 05:11:25PM +0000, Suzuki K Poulose wrote:
> On 20/03/2025 17:09, Mikołaj Lenczewski wrote:
> > On Thu, Mar 20, 2025 at 01:24:25PM +0000, Suzuki K Poulose wrote:
> > > On 19/03/2025 15:05, Mikołaj Lenczewski wrote:
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > index fb8752b42ec8..3e4cc917a07e 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -453,6 +453,9 @@
> > > >    	arm64.no32bit_el0 [ARM64] Unconditionally disable the execution of
> > > >    			32 bit applications.
> > > > +	arm64.nobbml2	[ARM64] Unconditionally disable Break-Before-Make Level
> > > > +			2 support
> > > > +
> > > >    	arm64.nobti	[ARM64] Unconditionally disable Branch Target
> > > >    			Identification support
> > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > index 940343beb3d4..49deda2b22ae 100644
> > > > --- a/arch/arm64/Kconfig
> > > > +++ b/arch/arm64/Kconfig
> > > > @@ -2057,6 +2057,17 @@ config ARM64_TLB_RANGE
> > > >    	  The feature introduces new assembly instructions, and they were
> > > >    	  support when binutils >= 2.30.
> > > > +config ARM64_BBML2_NOABORT
> > > > +	bool "Enable support for Break-Before-Make Level 2 detection and usage"
> > > > +	default y
> > > > +	help
> > > > +	  FEAT_BBM provides detection of support levels for break-before-make
> > > > +	  sequences. If BBM level 2 is supported, some TLB maintenance requirements
> > > > +	  can be relaxed to improve performance. We additonally require the
> > > > +	  property that the implementation cannot ever raise TLB Conflict Aborts.
> > > > +	  Selecting N causes the kernel to fallback to BBM level 0 behaviour
> > > > +	  even if the system supports BBM level 2.
> > > 
> > > minor nit: Should we mention that the feature can be disabled at runtime
> > > using a kernel parameter ?
> > 
> > Yes, this sounds very reasonable, I should have thought of that. Will
> > mention the commandline parameter in the kconfig option documentation.
> 
> And also may be mention this in the patch description and may be also
> add the rationale for providing this tunable.
> 
> Cheers
> Suzuki
> 

Will do! :)

-- 
Kind regards,
Mikołaj Lenczewski
