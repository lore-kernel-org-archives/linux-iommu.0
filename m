Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B3264FBD
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 20:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470276; cv=none; b=oTo4f38oE1AILnjlGdcCZQvI1n4sX5JanWgDoDtFjljNIIQPo5mC5OXmx+oK5ekoWL+zJLaRe19zA6prFJ7KJP8bTliq+sV0NiHkZwh6EFeIFOgkrglupvk7Hvn4nwLRXcGOr5pM0IMz9Gp6ODGc39reNJv1Qgqf0eFcPvNr/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470276; c=relaxed/simple;
	bh=DYvje2FoIho5ps5m5xxWUnNXzs0jagNYsnTUHNm0hls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Snk29GuwswhyHjjeC0bg+V+9mjv5YjRpfOqwFJDTbjuJj7kGOcFjSl4tD6WzROJlwa8FhC/wIwA4y/Is2MLPKS7bpKSk1Cx/Fc4p5xK4mUNurJWxJUlyEZkge6dA/Se6nO+12EBSC4sMSMUeu83vOyaWU+ZH0YrGemd9sflWu9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pwONNeku; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pwONNeku"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b0b260d309so6235ad.1
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 13:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774470274; x=1775075074; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cd13UlKNCcUyqY4tTtGEjc2CPeu8xCNqWeWEmMFV/5Q=;
        b=pwONNekuRsCKwJsE86disusHOm6JAzkUJFxM+RreRv5nt/1uCIhxSEABOkxjTrBGJL
         awViRHA0MOSuaaD1nGLNf5Dkpo9HTn0/qe0K7vKuzTIPXk9KXDj4CqbxUUTcHw16oSdM
         O6AuSl77a4N65p22GlrdfojKwkJoD06uvzQPSq/tpRyQueXTJFtvUiKoZNrl6aASVBYq
         CHWE8e+bT25rSNW58XyePVAjaMQBaCyTfiVWXECOJ1Tmr0wdyAywFmCvhvqykPrC8Jlf
         LtkVu6wuO2kiSku51dJo7IbyYkzji4E+R20hain6m6vQQpOywJk+3LRera4JM2TTVgSl
         2Y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774470274; x=1775075074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cd13UlKNCcUyqY4tTtGEjc2CPeu8xCNqWeWEmMFV/5Q=;
        b=ghkdb0d54rIcOitx/uklZGORRPqLNkWEduXsT+rpmnK5ZqS41UWip1QD+E9nsS0pBh
         EckWdR4snPXZEZk9ArfEGmfCaYsWVyc8s06b1ePweOoNibeZ9A/4tzfocatpkK32Af50
         V6HhIeviqVXG861sgBbuKERBbknYiLOtoHXxvufEpEyyRTqO7cO+kQYWLdnBC8KJHd/l
         vDutyNMYDTfVzgKNQUZ0mjBLYaU9I3+TU3iQ3jbtLZ1RN9enXaJga5GfrbAat0zBAg/h
         8d2W3laachsGRjCl7tXWP6xdLlSxMy7xoEl3i7DGHIqJ9nN4uI3FhNdJm9PxXy59NM3t
         UP2w==
X-Forwarded-Encrypted: i=1; AJvYcCWiIturm0W3udlZvUesXZKDoDYpJP6MSpMgHAFqETTWDeFvj1gER2cs+C116Ifrax1uzboh9A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzd5ElzkzIT6LMUgPNyaiYSp1Nnp9MIKMyPzEM4vV+y2n2bwG7I
	IkcsoS7howIkmQ4EI71isnn6Ssi+h5N0E/IS/CLDUdlf6D/9XYPVTLHnvExDz0Roiw==
X-Gm-Gg: ATEYQzzI3vU2C/pOu5kLYtDmEsbhZMK3FlAgG/Stt1+bx9HLSTSb3EKdUoV+PTPRp5f
	GRadea+00B5Xkv+OsK9ljt1Hhe3TzOzipDPp9znyzPN9YZoln/ozm5rLpOlM62qexmMuAUnNJ1J
	G9zNrVCaBki8Ttm72Ff7Ck+8+EL7Ayq3QKjbW+/S+T9OrEvDI3m/5eRXvoxSX8bVo/tbYJ7zraZ
	g0NWslzkvX5nMZJBljSbhr97H/O5g1KBk+9oLzkN/9+ugAXKN4Eo3n08eERJeoefxDIq53XnqDb
	kaUW0BDcrt3lu9TWrW8tlgXmzX8XR1M7p+CuzWLQruDQb7dMubt0KMsMOzBTBf5rjZW5kPuTEPY
	Ce/tLTbPEH99iSF6fRjMhm8GrmzrEi9SZSUQKEFb+Rodz4EKFqKbkq6TUB00tFyRs+S5WgTrwH7
	e4lxZX98vSA8G6+Wd++pqYTpapGRu55yFek9vfA3gpUXMnIHdV9qvGVku1NQ==
X-Received: by 2002:a17:902:ce88:b0:2b0:5fb4:c1a3 with SMTP id d9443c01a7336-2b0bfedac62mr339855ad.15.1774470273769;
        Wed, 25 Mar 2026 13:24:33 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76be40sm7135815ad.8.2026.03.25.13.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:24:33 -0700 (PDT)
Date: Wed, 25 Mar 2026 20:24:24 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 12/14] iommufd: Add APIs to preserve/unpreserve a vfio
 cdev
Message-ID: <acREeKQJlSrd2kZS@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-13-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-13-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:46PM +0000, Samiullah Khawaja wrote:
> Add APIs that can be used to preserve and unpreserve a vfio cdev. Use
> the APIs exported by the IOMMU core to preserve/unpreserve device. Pass
> the LUO preservation token of the attached iommufd into IOMMU preserve
> device API. This establishes the ownership of the device with the
> preserved iommufd.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/iommufd/device.c | 69 ++++++++++++++++++++++++++++++++++
>  include/linux/iommufd.h        | 23 ++++++++++++
>  2 files changed, 92 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 4c842368289f..30cb5218093b 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
>   */
>  #include <linux/iommu.h>
> +#include <linux/iommu-lu.h>
>  #include <linux/iommufd.h>
>  #include <linux/pci-ats.h>
>  #include <linux/slab.h>
> @@ -1661,3 +1662,71 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
>  	iommufd_put_object(ucmd->ictx, &idev->obj);
>  	return rc;
>  }
> +
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +int iommufd_device_preserve(struct liveupdate_session *s,
> +			    struct iommufd_device *idev,
> +			    u64 *tokenp)
> +{
> +	struct iommufd_group *igroup = idev->igroup;
> +	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct iommufd_hw_pagetable *hwpt;
> +	struct iommufd_attach *attach;
> +	int ret;
> +
> +	mutex_lock(&igroup->lock);
> +	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);

By explicitly looking up IOMMU_NO_PASID, we skip any PASID attachments
the device might have. Since PASID live update is NOT supported in this
series, should we check if the pasid_attach xarray contains anything 
other than IOMMU_NO_PASID and return -EOPNOTSUPP? 

Otherwise, we silently fail to preserve those domains without informing
the VMM?

> +	if (!attach) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	hwpt = attach->hwpt;
> +	hwpt_paging = find_hwpt_paging(hwpt);
> +	if (!hwpt_paging || !hwpt_paging->lu_preserve) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = liveupdate_get_token_outgoing(s, idev->ictx->file, tokenp);
> +	if (ret)
> +		goto out;
> +
> +	ret = iommu_preserve_device(hwpt_paging->common.domain,
> +				    idev->dev,
> +				    *tokenp);
> +out:
> +	mutex_unlock(&igroup->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_device_preserve, "IOMMUFD");
> +
> +void iommufd_device_unpreserve(struct liveupdate_session *s,
> +			       struct iommufd_device *idev,
> +			       u64 token)
> +{
> +	struct iommufd_group *igroup = idev->igroup;
> +	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct iommufd_hw_pagetable *hwpt;
> +	struct iommufd_attach *attach;
> +
> +	mutex_lock(&igroup->lock);
> +	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
> +	if (!attach) {
> +		WARN_ON(-ENOENT);

WARN_ON takes a condition.. if we want this to be printed always, why
not WARN_ON(1, "...") ? What's the significance of having -ENOENT as a
condition?

> +		goto out;
> +	}
> +
> +	hwpt = attach->hwpt;
> +	hwpt_paging = find_hwpt_paging(hwpt);
> +	if (!hwpt_paging || !hwpt_paging->lu_preserve) {
> +		WARN_ON(-EINVAL);

Same here for -EINVAL?

> +		goto out;
> +	}
> +
> +	iommu_unpreserve_device(hwpt_paging->common.domain, idev->dev);
> +out:
> +	mutex_unlock(&igroup->lock);
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_device_unpreserve, "IOMMUFD");
> +#endif

[ ----- >8 ----- ]

Thanks,
Praan
