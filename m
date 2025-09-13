Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB6F381AF
	for <iommu@lists.linux.dev>; Sat, 13 Sep 2025 06:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757743953; cv=none; b=ETvVAlGeKd9ct5Vn+HxKNy+xWQi6irNZA0Tr4KdDmch1gqwwqalV+hpyGOFBI9uRy7LyVADvmucVMxust1DJAPwPdBB1DHefRwSOIO+XpjTvFejoe8Ov/9mIrHDLaFIlovM7FJVmcNeCk4qx/nXKR1MW41CRGwnUBwEjE2jvJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757743953; c=relaxed/simple;
	bh=ogFGJhn54T72YI+33/iz2vIQffkJzDpBFjUIdxZ1i/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kj0g6XFvpb+ppxas4/JnMLr+JJ76qcanSncPEOFj8hI7Me4kBlTYCCH6y/WDNoAO0muw/zmNYMqMjSJ93sJTPxc52aGox72iYR+Jx1+akgrfHjVGyG5qPWgsHl5inr3YP9dsoeUXXJAy7ezO2vEgfTUyhicyhh/i3WqSJ6BC1LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=HvWpMksf; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="HvWpMksf"
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 85FBB50666;
	Sat, 13 Sep 2025 08:12:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1757743950;
	bh=ogFGJhn54T72YI+33/iz2vIQffkJzDpBFjUIdxZ1i/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HvWpMksffmj0hvCjs3P7ngupvZdOzqP21UYdTYOofShaLC5pSuph+brZNCEooOdox
	 /su5dSE+WioH3aMXQe0LNtL8cwEhZMSReczlmrTwDtaywQHl5Dh2KvoCcQTp9FVCfM
	 g+K3eAMbpF+gp1tUjaZ1RLz0PKnKg7uajuEAr/2iWDucRW9uVPH2JjdUQV2KRMuftm
	 jrWa/Taz8+AZvwDCmBMfwtNhHsKwViD61CmiLHYcUJ1Oz6ZuUeqNtIQh7gsgHwKX6W
	 ZObKNT627Fk2LOYRfbmNlsVeM450zdYp1eaRLALKtDd5mwxDpGGmN8JMT5vnxNofMO
	 48HYjgCGPY8Pg==
Date: Sat, 13 Sep 2025 08:12:29 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH] iommu/amd: Fix alias device DTE setting
Message-ID: <6mj3o6k2f3a7lvrhvkohigsqu4octq7h6onnlztlidix5qpate@spe6ztnabfax>
References: <20250911131406.633549-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911131406.633549-1-vasant.hegde@amd.com>

On Thu, Sep 11, 2025 at 01:14:06PM +0000, Vasant Hegde wrote:
> Commit 7bea695ada0 restructured DTE flag handling but inadvertently changed
> the alias device configuration logic. This may cause incorrect DTE settings
> for certain devices.
> 
> Add alias flag check before calling set_dev_entry_from_acpi(). Also move the
> device iteration loop inside the alias check to restrict execution to cases
> where alias devices are present.
> 
> Fixes: 7bea695ada0 ("iommu/amd: Introduce struct ivhd_dte_flags to store persistent DTE flags")
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/init.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied for -rc, thanks.
