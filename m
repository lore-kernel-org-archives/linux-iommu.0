Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09481218E83
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412323; cv=none; b=qJmoxnBn2S3YzzWd+wSRJqqx1rvqsfh/CloNNkCfA54u5fTNJsnaMT+nhVg6MWrvCJSKdoeBRbYLqnMXeCvYIvFwyp2uhfNjCZA40l6o8D/3J1K4hkZDzFoFcSWedsrE9MdpxDumzlEFr5bFfh7XB5zNuxirGIysd7/Y8KuAIow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412323; c=relaxed/simple;
	bh=xun7uNPcGyCFpJZvtcrP0Xz1iEmFzPFerPKrrv3DKnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYBqUhODXEoJGqQJSTO6qaqbsWjnmZ5QpBvm9LIuMveyv8WzIxdnF1mjb5Kw2Wto17JGzOG5bkYJiy9FU8FnTdkl5WrUfo1Ou/MZ8AGs+NjaVd+0Mag9y2v2wV7WCdSl3kWajRbj9Jp8j3jAzD7ViZrjMLTChH9gK/sTihSty2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A8DC4CEDD;
	Thu,  5 Dec 2024 15:25:20 +0000 (UTC)
Date: Thu, 5 Dec 2024 15:25:18 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
	jean-philippe@linaro.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
	joey.gouly@arm.com, ryan.roberts@arm.com
Subject: Re: [PATCH 2/2] arm64: cpufeature: Add GCS to cpucap_is_possible()
Message-ID: <Z1HF3i-mAAXDHKUP@arm.com>
References: <68a37b00a720f0827cac0e4f40e4d3a688924054.1733406275.git.robin.murphy@arm.com>
 <416c7369fcdce4ebb2a8f12daae234507be27e38.1733406275.git.robin.murphy@arm.com>
 <051c017c-a60f-48a7-b09f-07f0f32e48e3@sirena.org.uk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <051c017c-a60f-48a7-b09f-07f0f32e48e3@sirena.org.uk>

On Thu, Dec 05, 2024 at 03:04:11PM +0000, Mark Brown wrote:
> On Thu, Dec 05, 2024 at 01:48:10PM +0000, Robin Murphy wrote:
> > Since system_supports_gcs() ends up referring to cpucap_is_possible(),
> > teach the latter about GCS for consistency with similar features.
> 
> Not clear why this is part of a series, there's no obvious relationship
> with patch 1?

No, probably Robing forgot to pass --no-thread to git.

> >  static inline bool system_supports_gcs(void)
> >  {
> > -	return IS_ENABLED(CONFIG_ARM64_GCS) &&
> > -		alternative_has_cap_unlikely(ARM64_HAS_GCS);
> > +	return alternative_has_cap_unlikely(ARM64_HAS_GCS);
> >  }
> 
> Ah, this is bitrot since the series was on the list for so long.  As
> well as HAFT which Rutland mentioned it looks like _bti_kernel(),
> _irq_prio_masking() and possibly others have the same thing.  Ideally
> we'd have no uses of IS_ENABLED() in these functions so it's a bit more
> obvious.  In any case
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

Thanks. This patch will go in via the arm64 tree. I'll leave the other
for the smmu tree.

-- 
Catalin
