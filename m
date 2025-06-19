Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A746DF9DA
	for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344391; cv=none; b=D09lh5a13JTy1YkXGpOBf28sQiEiqtKybRd+ca0TxXUVZLSvvEmqNYE21ecrU8+3+82P4FXv3TdJTlEdeI2b2W0sz2vFwtSe6rvRgM6jxNH/zbr8PaqZ1IF6HLPr2aE+ISe3v6jmvbCqOmndp+UxJQDrJwBhx2s/NAOKi/g9eGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344391; c=relaxed/simple;
	bh=FjWTlszoS/nSjiZ3mVeHygOJk11nmAc6LjxOMWHqbvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuIzlNW8bdyQLpaLn07KiOYLJr5+asLux7IEuPib9htrStawQigcNbrk+hysZKRVJTlGu08HW9N8TACAMKsG7P7uawUsm4OKu4ArCMRjE77UsoSnfCmoiwnKEs8EEtZqJuVu1lwjTUCn+fqI3jVj/COn7NyVp0KKugRswjCkxiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1A26113E;
	Thu, 19 Jun 2025 07:46:08 -0700 (PDT)
Received: from e133081.arm.com (e133081.arm.com [10.1.36.98])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C68F63F66E;
	Thu, 19 Jun 2025 07:46:23 -0700 (PDT)
Date: Thu, 19 Jun 2025 15:46:20 +0100
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
Message-ID: <20250619144620.GA30368@e133081.arm.com>
References: <20250617095104.6772-1-miko.lenczewski@arm.com>
 <20250617095104.6772-3-miko.lenczewski@arm.com>
 <aFPu4SorUGlFt-2p@arm.com>
 <20250619115132.GA20673@e133081.arm.com>
 <aFQUmWC1MYhai1fo@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFQUmWC1MYhai1fo@arm.com>

On Thu, Jun 19, 2025 at 02:46:01PM +0100, Catalin Marinas wrote:
> On Thu, Jun 19, 2025 at 12:51:32PM +0100, Mikołaj Lenczewski wrote:
> > On Thu, Jun 19, 2025 at 12:05:05PM +0100, Catalin Marinas wrote:
> > > On Tue, Jun 17, 2025 at 09:51:02AM +0000, Mikołaj Lenczewski wrote:
> > > > +	 * whether the MIDR check passes. This is because we specifically
> > > > +	 * care only about a stricter form of BBML2 (one guaranteeing noabort),
> > > > +	 * and so the MMFR2 check is pointless (all implementations passing the
> > > > +	 * MIDR check should also pass the MMFR2 check).
> > > 
> > > I think there's at least one implementation that behaves as
> > > BBML2-noabort but does not have the ID field advertising BBML2.
> > > 
> > 
> > Yes, I put "should" instead of "will" because of the AmpereOne
> > situation, but I didn't want to "name and shame". Should I explicitly
> > call this out? Or would you like me to soften the vocabulary here to imply
> > that as long as the MIDR passes, the MMFR2 check is not important?
> 
> I missed the "should" part. Anyway, I would just drop the explanation
> from "This is because...".
> 
> -- 
> Catalin

OK, not a problem! Will drop it.

-- 
Kind regards,
Mikołaj Lenczewski
