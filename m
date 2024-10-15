Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027AB20EB
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981891; cv=none; b=CFidtV77DcAcBjFfvdLR+UYqWCHuhM4RsHS2Qsii8lJ5f1oAX/MA/Xx2thDY8ylWYTmNTVzSV1SdfXwH+N+QncycVgzQnMHdYqqkw1B/40VLaMP34479vdBIwXy8sz5wdzR214RJM22XAwuEGds3t0Eb0LB5G3RSOZB5J01OEOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981891; c=relaxed/simple;
	bh=2n17S4uMeZi8kcNhkN/2e2l1QpvIasOKiYamk0qCxQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFt26v2QjBUy//38V1/Q+Ii/nsZzyNQHYYsS5jw+UcrFcTo6bIjEs/Ag2833x6JnOKCiimEHXPhgzqo0llgO2Nlo7ww0XfljEQi5SxW6P2vc8BbcTfJk2c4QTv0Pf1edyOsqPUlhSuPk7WveWTfOP1BLqfKLeD38LcBkWfnSYrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=kqlc31QW; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="kqlc31QW"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D0BD32A6C15;
	Tue, 15 Oct 2024 10:44:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1728981888;
	bh=2n17S4uMeZi8kcNhkN/2e2l1QpvIasOKiYamk0qCxQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqlc31QWHcx8edADPI2Dx9+w+TZKBElA8wtBcCI8BCeFhH94GrM/SvC8C3uQQezFa
	 tTFPKkJ087H2xKN1K4hJqlBvXlkYlA8cze9i4xh/PZguRxa+wyZ6JRcXHicDD2f2fv
	 umeKoX3Dk+ca8xWBQaQ4sXdjY5deENuMMHwwZc39wshKKcnpNjNfnpZh1cvhHE4gb+
	 lxzhPuk6unOHpkuaPEzZ+cDTksMDm5yTUR8S0btqt+8jlu+kMDYz3SSOd/zd41Hj7a
	 bAmNRRmUBLP0PKrfB2PQhJwkjSyPsr5EuuIoG6p1Ja61qhi48GlDK86J3ZMCA/Dg81
	 KZ0O5ulvMxz/w==
Date: Tue, 15 Oct 2024 10:44:47 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v2 09/10] iommu/amd: Reorder attach device code
Message-ID: <Zw4rfyNCm6tgjdYI@8bytes.org>
References: <20240910065812.6091-1-vasant.hegde@amd.com>
 <20240910065812.6091-10-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910065812.6091-10-vasant.hegde@amd.com>

On Tue, Sep 10, 2024 at 06:58:11AM +0000, Vasant Hegde wrote:
> Previous patch converted dev_data lock to mutex. Move PCI device capability
> enablement (ATS, PRI, PASID) and IOPF enablement code inside the lock. Also
> in attach_device(), update 'dev_data->domain' at the end so that error
> handling becomes simple.

This patch description lacks the 'Why?' part.

> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 65 +++++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 0f83e1b3fb0c..e7fc59e30387 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2086,6 +2086,7 @@ static int attach_device(struct device *dev,
>  {
>  	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>  	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
> +	struct pci_dev *pdev;
>  	int ret = 0;
>  
>  	mutex_lock(&dev_data->mutex);
> @@ -2095,10 +2096,6 @@ static int attach_device(struct device *dev,
>  		goto out;
>  	}
>  
> -	/* Update data structures */
> -	dev_data->domain = domain;
> -	list_add(&dev_data->list, &domain->dev_list);
> -
>  	/* Do reference counting */
>  	ret = pdom_attach_iommu(iommu, domain);
>  	if (ret)
> @@ -2113,6 +2110,28 @@ static int attach_device(struct device *dev,
>  		}
>  	}
>  
> +	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
> +	if (pdev && pdom_is_sva_capable(domain)) {
> +		pdev_enable_caps(pdev);
> +
> +		/*
> +		 * Device can continue to function even if IOPF
> +		 * enablement failed. Hence in error path just
> +		 * disable device PRI support.
> +		 */
> +		if (amd_iommu_iopf_add_device(iommu, dev_data))
> +			pdev_disable_cap_pri(pdev);
> +	} else if (pdev) {
> +		pdev_enable_cap_ats(pdev);
> +	}
> +
> +	/* Update data structures */
> +	dev_data->domain = domain;
> +	list_add(&dev_data->list, &domain->dev_list);
> +
> +	/* Update device table */
> +	dev_update_dte(dev_data, true);
> +
>  out:
>  	mutex_unlock(&dev_data->mutex);
>  
> @@ -2127,7 +2146,6 @@ static void detach_device(struct device *dev)
>  	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>  	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
>  	struct protection_domain *domain = dev_data->domain;
> -	bool ppr = dev_data->ppr;
>  
>  	mutex_lock(&dev_data->mutex);
>  
> @@ -2140,13 +2158,15 @@ static void detach_device(struct device *dev)
>  	if (WARN_ON(!dev_data->domain))
>  		goto out;
>  
> -	if (ppr) {
> +	/* Remove IOPF handler */
> +	if (dev_data->ppr) {
>  		iopf_queue_flush_dev(dev);
> -
> -		/* Updated here so that it gets reflected in DTE */
> -		dev_data->ppr = false;
> +		amd_iommu_iopf_remove_device(iommu, dev_data);
>  	}
>  
> +	if (dev_is_pci(dev))
> +		pdev_disable_caps(to_pci_dev(dev));
> +
>  	/* Clear DTE and flush the entry */
>  	dev_update_dte(dev_data, false);
>  
> @@ -2166,14 +2186,6 @@ static void detach_device(struct device *dev)
>  
>  out:
>  	mutex_unlock(&dev_data->mutex);
> -
> -	/* Remove IOPF handler */
> -	if (ppr)
> -		amd_iommu_iopf_remove_device(iommu, dev_data);
> -
> -	if (dev_is_pci(dev))
> -		pdev_disable_caps(to_pci_dev(dev));
> -
>  }
>  
>  static struct iommu_device *amd_iommu_probe_device(struct device *dev)
> @@ -2450,7 +2462,6 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
>  	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>  	struct protection_domain *domain = to_pdomain(dom);
>  	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
> -	struct pci_dev *pdev;
>  	int ret;
>  
>  	/*
> @@ -2483,24 +2494,6 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
>  	}
>  #endif
>  
> -	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
> -	if (pdev && pdom_is_sva_capable(domain)) {
> -		pdev_enable_caps(pdev);
> -
> -		/*
> -		 * Device can continue to function even if IOPF
> -		 * enablement failed. Hence in error path just
> -		 * disable device PRI support.
> -		 */
> -		if (amd_iommu_iopf_add_device(iommu, dev_data))
> -			pdev_disable_cap_pri(pdev);
> -	} else if (pdev) {
> -		pdev_enable_cap_ats(pdev);
> -	}
> -
> -	/* Update device table */
> -	dev_update_dte(dev_data, true);
> -
>  	return ret;
>  }
>  
> -- 
> 2.31.1
> 
