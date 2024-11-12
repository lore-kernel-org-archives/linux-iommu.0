Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D53202654
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426930; cv=none; b=I5WNu0TwzuvODuVsd8LJm87RR70iUXVv3ipZ7Ur2OZOez6T5+xIXFGdEBAvk6nVaBiK6R3NHn6OQwAO0w9j2wU6g6CrnI+rzaSnbW43O0scgOtUgxbkdwwH0IA/NqlPtP4Z+KfwMB2pjTSV4nFiTRy3FuSatm79Fx+HFEu4wzlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426930; c=relaxed/simple;
	bh=A5OSnOKgQ1/NZdqMpuahVt5qjI55hR/PC1GnAzNRwg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6hPRbWs8eZjdiCMIwRQbpRibj26r7IlbAs5FDZlMTvTrSZij2EP1ta4EB/ln/fstrSCIV/sen1OvtGjA25rFDhhHW0uVkNmk2NbCL8+dUFDVUlFNoPKu2bhLVIL9b9Ullbl3TGSjqbjOcHtAUSj2zhAjQyF6zHW/zic95UL/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAWIhXjD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAWIhXjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D80C4CECD;
	Tue, 12 Nov 2024 15:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731426930;
	bh=A5OSnOKgQ1/NZdqMpuahVt5qjI55hR/PC1GnAzNRwg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PAWIhXjDNSI58YrPLUOJqJGfoI4EDqMT4XT65E18FXvAr962bVO4vWDzbyYtHGWfi
	 wfCWkBb0cDr9RzS8MPmPzfU/qLcquwJtUTZwVE/7AJBlwtwRfRWrwgKQlvoi3wMiBX
	 MeSp2eFyOGh447VdPPkuynbyGym2wQwTLg5jYGJ7h6y5SUbZ31oIoNZkYSH/NCNuWW
	 mqYWCTqeNOQxZMgvMGEmcdabTG3eU6Yb1Wlmvl8ADfF0996Nb4UaBWAP/TjOpYKqtX
	 xz4F1ZvBJZG7llT3drrSHHQ74MZNORV/B1uU9heXqxVkwEqJ3+/XM6thEhVhVM66I8
	 PBwdakLTcrEPQ==
Date: Tue, 12 Nov 2024 15:55:26 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] iommu/arm-smmu-v3: Clean up iopf queue on probe
 failure
Message-ID: <20241112155525.GB21479@willie-the-truck>
References: <cover.1731088789.git.robin.murphy@arm.com>
 <161cf3bfde2993cc29e82589df947ff23fb82845.1731088789.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161cf3bfde2993cc29e82589df947ff23fb82845.1731088789.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Nov 08, 2024 at 06:30:16PM +0000, Robin Murphy wrote:
> kmemleak noticed that the iopf queue allocated deep down within
> arm_smmu_init_structures() can be leaked by a subsequent error return
> from arm_smmu_device_probe(). Hardly a big deal when probe failure
> represents something much more seriously wrong in the first place,
> but on principle, adopt a dedicated cleanup path for those.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index b7dcb1494aa4..7908fca962fe 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4609,7 +4609,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	/* Initialise in-memory data structures */
>  	ret = arm_smmu_init_structures(smmu);
>  	if (ret)
> -		return ret;
> +		goto free_iopf;
>  
>  	/* Record our private device structure */
>  	platform_set_drvdata(pdev, smmu);
> @@ -4620,22 +4620,27 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	/* Reset the device */
>  	ret = arm_smmu_device_reset(smmu);
>  	if (ret)
> -		return ret;
> +		goto free_iopf;
>  
>  	/* And we're up. Go go go! */
>  	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
>  				     "smmu3.%pa", &ioaddr);
>  	if (ret)
> -		return ret;
> +		goto free_iopf;
>  
>  	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
>  	if (ret) {
>  		dev_err(dev, "Failed to register iommu\n");
> -		iommu_device_sysfs_remove(&smmu->iommu);
> -		return ret;
> +		goto free_sysfs;
>  	}
>  
>  	return 0;
> +
> +free_sysfs:
> +	iommu_device_sysfs_remove(&smmu->iommu);
> +free_iopf:
> +	iopf_queue_free(smmu->evtq.iopf);
> +	return ret;
>  }

Thanks. I think this is correct (and iopf_queue_free() checks for NULL,
so we're good there) but I just wonder whether it would be more
consistent to use devm_add_action_or_reset(), like we do for the MSIs.

Will
