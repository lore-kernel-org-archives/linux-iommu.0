Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8352D7818;
	Mon, 21 Jul 2025 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104040; cv=none; b=XJ4Rx9DSs6Eq0IVPoRhCbuBZXXikZ91CNdkAVhTd+HeDhjGUmGDHh7y3D+gAjs0z+sU3DzOSO2KlrH8nLGMWsFc8Un3glEZUuEKejsZyPBP1BTwlhb9bZDQkPokfij5he8BVG7el9v/Blw4jaar9QagO51kRB7B8/d/NoMsEtJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104040; c=relaxed/simple;
	bh=EKbMumgPxG3mrRXVfqq22nRZqrgaafXKtjd5p3sdBnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0L110tZ+1WNijzgp2UYRqSiPlwraSvA02mjKn/WCA1SIJTlzeCWErNgzbVfwgr/Ry1h6n+XdAReb0lKlf2/9WvxF2EAr24sq+serE25HhML+Em9BZAP1mMc7dy5lBOPs0KotOMrjLIkmlY93xNQgDijM71NAWJQGYrJWzW5zdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bg/8mIA/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bg/8mIA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1ADFC4CEF6;
	Mon, 21 Jul 2025 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753104040;
	bh=EKbMumgPxG3mrRXVfqq22nRZqrgaafXKtjd5p3sdBnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bg/8mIA/+RhenAyCWnlw2Omth29e2SMqxc1KgdP24WpiBEKYxI2FABFubp29ut4Nh
	 AICjk3+4LS/z7KdfIpS0Ow8SOMgC5VsGm17zpL65dHcyJ2q/TV6bFPpP7ln4xKehGp
	 w4XwLoFGnmUP9tcy9CG56K3aYBrmu72CVOYcQECiBw4TzKoyjwbkaJVoQMnJSrSxJ3
	 eazPeGqRTQEZNjUeB7+q/+gbMYPa0IWXah6MRcNO3O2YVGo4gEsj5ct2rmeFYgujLn
	 Y07ktCaiiIES3T8tFweeV1KgFxdHKptkXzVkEWHqUqcXgIDQbX48fsZUieZ01n8r5w
	 xsSDALGAjtP+w==
Date: Mon, 21 Jul 2025 14:20:35 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with
 get_viommu_size
Message-ID: <aH4-o8Y99YTnNzss@willie-the-truck>
References: <20250718234822.1734190-1-nicolinc@nvidia.com>
 <20250718234822.1734190-3-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718234822.1734190-3-nicolinc@nvidia.com>

On Fri, Jul 18, 2025 at 04:48:22PM -0700, Nicolin Chen wrote:
> It's more flexible to have a get_viommu_size op. Replace static vsmmu_size
> and vsmmu_type with that.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |  8 ++------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  3 +--
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     | 14 ++++++++++++--
>  3 files changed, 15 insertions(+), 10 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
