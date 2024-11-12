Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C6A20127A
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426244; cv=none; b=uj/LqyMStFgn+4eT2xbnkBeThTlesdjllBfMjXve43GrpiJGhnt20oQ+oc1GmoGf0lNxn6XVyPInWYupI1TE8/Ri/2EKJycyRb594WSiqWo22l/65Ej5fKA3XtVPCz2oMdKXVZCfgV1bGub3SeHatnKsdzSl324+1PQsGnc8xdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426244; c=relaxed/simple;
	bh=RWbFSkRwUfOAIWE/dWO3OuIoKs6Ba942vCIh+QcEl9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxnXu6/mFexVk2czNDIrS1BqOdvrD+WHJgaVvw7IrO1GtRxyrWY8jJQTVU620h9u7Uryyl8MvVthtJF3eTK9k7gon2E8jDKwM2xu1gpa91+7zzIU76GX3ROnKuF9xiiQNLRsZ7qh+fY3UOUb98hzya4GU+sEzmYhfC05lcIzK3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W133iUhA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W133iUhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C96C4CECD;
	Tue, 12 Nov 2024 15:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731426243;
	bh=RWbFSkRwUfOAIWE/dWO3OuIoKs6Ba942vCIh+QcEl9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W133iUhAXaQgeRjeCR+PpubsmgTOlhZSgfHnmjnT8hpu9zNSB81u2y1ykfLFaySrg
	 y9EPBAt2b8wUHecg30ttVHBr1B6ofqAOpPNMVtDSXUIekKGpV5AOUKE+DzyIHoM22r
	 gNSZIvDodxT05KkgceFEgjw9LwT1SZ02J2nlRWmVtK5BKtZMhigLYvK79NfLMFclnp
	 4kp3SvfBtsa/c7RXQI+8PAa6m+L3odgZHfEai5GcrBWpMWDGLw5ekSuJVINmMXMLOC
	 Q6xuSgIkzzoMddlLNBqvntq+xC9oSIhImRk3ShAgL++O2yDz1MMR5eMq6E7pqpBsws
	 VZ4uoJjBbC4Og==
Date: Tue, 12 Nov 2024 15:43:59 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] iommu/arm-smmu: Make instance lookup robust
Message-ID: <20241112154358.GA21479@willie-the-truck>
References: <cover.1731088789.git.robin.murphy@arm.com>
 <9d2ec624a640c421e97334deff537a2e899356c7.1731088789.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d2ec624a640c421e97334deff537a2e899356c7.1731088789.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Nov 08, 2024 at 06:30:15PM +0000, Robin Murphy wrote:
> Relying on the driver list was a cute idea for minimising the scope of
> our SMMU device lookups, however it turns out to have a subtle flaw. The
> SMMU device only gets added to that list after arm_smmu_device_probe()
> returns success, so there's actually no way the iommu_device_register()
> call from there could ever work as intended, even if it wasn't already
> hampered by the fwspec setup not happening early enough.
> 
> Switch both arm_smmu_get_by_fwnode() implementations to use a platform
> bus lookup instead, which *will* reliably work. Also make sure that we
> don't register SMMUv2 instances until we've fully initialised them, to
> avoid similar consequences of the lookup now finding a device with no
> drvdata. Moving that code is also a perfect excuse to give it a little
> dev_err_probe() tidyup as well.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> This should in theory replace 229e6ee43d2a ("iommu/arm-smmu: Defer
> probe of clients after smmu device bound"), or at least allow it to be
> reverted going forward.

Let's revert that as part of this series, then?

>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  4 +--
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 31 ++++++++++-----------
>  2 files changed, 16 insertions(+), 19 deletions(-)

[...]

> @@ -2255,6 +2240,18 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	arm_smmu_device_reset(smmu);
>  	arm_smmu_test_smr_masks(smmu);
>  
> +	err = iommu_device_sysfs_add(&smmu->iommu, smmu->dev, NULL,
> +				     "smmu.%pa", &smmu->ioaddr);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to register iommu in sysfs\n");
> +
> +	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops,
> +				    using_legacy_binding ? NULL : dev);
> +	if (err) {
> +		iommu_device_sysfs_remove(&smmu->iommu);
> +		return dev_err_probe(dev, err, "Failed to register iommu\n");

Why is dev_err_probe() better here? I've not seen it before, so I was
trying to figure out what it does. It mainly looks to be handling
the EPROBE_DEFER case, but after your other changes to use
bus_find_device_by_fwnode() I'm wondering whether we actually hit that
(particularly in iommu_device_sysfs_add())?

I'm not saying there's a problem, just that I'm not sure why
dev_err_probe() is tidier than dev_err().

Will
