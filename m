Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAB9178372;
	Mon, 24 Nov 2025 21:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764020843; cv=none; b=unpTXJlQ58jssnGRrn41BgKiKwYeMoKHwB/u36hluCvJfY6NPl1l1pEv1jvjHiotQF25+rBKF2F+HKsxkZE9a4s+Pst6vQa3W2cluM+//SUn+G62GyMEN30CgHW8QKMiAcdJIOJFwhB2QLWLSeOCy3KLzfhxjMaTrluxtKzRAuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764020843; c=relaxed/simple;
	bh=m7/o5mHZyAIVDSXHcVUNjqDc6NGLW9bQYFzDWBv1VyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHcePHCyNgsZ6jOMFvp14zoEyBiVpXU96WytIOlE2k42RATEIJQkkO25t1PLi4hJbYvrPSeC4U+/oH5eAgcwvyECWtX38/d8jHPWeiphoGXhhwPQtasMGxQ4OdS7ArQXmxzHXAbnturVkMiXZu4OONP3IohcT8A4M9QDmUBEtoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOw30jQ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOw30jQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1F7C4CEF1;
	Mon, 24 Nov 2025 21:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764020842;
	bh=m7/o5mHZyAIVDSXHcVUNjqDc6NGLW9bQYFzDWBv1VyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOw30jQ1T6Y0XN6tpOg3M3JXqs51nOVasKj9+pAr/4jGr9GPKFJqOT+jcWX+VKt1m
	 NHWOHwO1m25/crXmLf4CEikcEVU89+pZ2Od1n7c1v8e1lKG6ZJBM9Kq1o6c4C4peT1
	 5ZPw+IbSnDqkTcKoIiQVozmZkQ0tva723Du1NDKh8PF2GFd3wzFRzTf4SLRQ/seUMW
	 TqqtuBXOmi28+SINtTrf9zdVCRAR9ie8YuwNbawp2jMsCKduUzFrC9SZGP2z6X4G4o
	 9RJq8U6M8c+RQcHNvvtOXp7mtqUN8x83UCSWDVP4IiX/MvqJ6GEZQNEaXUItkmFTWX
	 3h0mxQOH6PFuQ==
Date: Mon, 24 Nov 2025 21:47:17 +0000
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, kevin.tian@intel.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3-iommufd: Allow attaching nested
 domain for GBPA cases
Message-ID: <aSTSZacbqy3hvKIe@willie-the-truck>
References: <20251103172755.2026145-1-nicolinc@nvidia.com>
 <20251124193435.GL153257@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124193435.GL153257@nvidia.com>

On Mon, Nov 24, 2025 at 03:34:35PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 03, 2025 at 09:27:55AM -0800, Nicolin Chen wrote:
> > A vDEVICE has been a hard requirement for attaching a nested domain to the
> > device. This makes sense when installing a guest STE, since a vSID must be
> > present and given to the kernel during the vDEVICE allocation.
> > 
> > But, when CR0.SMMUEN is disabled, VM doesn't really need a vSID to program
> > the vSMMU behavior as GBPA will take effect, in which case the vSTE in the
> > nested domain could have carried the bypass or abort configuration in GBPA
> > register. Thus, having such a hard requirement doesn't work well for GBPA.
> > 
> > Skip vmaster allocation in arm_smmu_attach_prepare_vmaster() for an abort
> > or bypass vSTE. Note that device on this attachment won't report vevents.
> > 
> > Update the uAPI doc accordingly.
> > 
> > Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> > 
> > Changelog
> > v2
> >  * Add Tested-by from Shameer
> >  * Skip vmaster allocation instead of bypassing vsid=0
> >  * Revise the uAPI doc to note a corner case when CR0.SMMUEN=1
> > 
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 13 ++++++++++++-
> >  include/uapi/linux/iommufd.h                        |  9 +++++++++
> >  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Will, I will grab this in a few days unless you want it in your tree

Sure, go for it.

Will
