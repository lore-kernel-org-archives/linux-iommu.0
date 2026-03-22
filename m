Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E926C18050
	for <iommu@lists.linux.dev>; Sun, 22 Mar 2026 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774172485; cv=none; b=MfGOzOE/dbOYpX57VwEfwel4EMs8S7gWIgaEeyo9cEg4liUkb6BkYLtF6emDh+kBk9wVWdl8NTL4+ucGL4qb2XC6/qHJCcB8PgiYqXbp6s/rqUs9gBGl+C4/9nTGrBdmy2BAgkIxBEhFgXfMUIydeEZ4TTB3Z7DwZ0hs+rb/b5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774172485; c=relaxed/simple;
	bh=EozkUR9hJasHXQYFsF9AYzvHEHRQAu0xx+pbMFTVBVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ie4Ku2t6Sd2dD2yXIWqPuof9k/I2a3dUdOH91i8PxgnV0JxjsFku7lG/OIMQbT75OTEAmvVjBd0bMBb7fmDiWbPbu0JkDDjJkL6bWeRgdQg7Y6s9TJIW1/4noZAbVY4bmAF+XDMF4zkSIm7A+YRc+hTp9ioRKplKa40szzkEpoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bs+l0E/y; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bs+l0E/y"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486fb990b9eso88145e9.0
        for <iommu@lists.linux.dev>; Sun, 22 Mar 2026 02:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774172482; x=1774777282; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FQXcszglpRn76zyaD4gcsl+CnRRTNeStc1QZosZqFUw=;
        b=bs+l0E/y8l+7EjgYQIncWUNM+5WYEJNphpVrob5fNyywb19APe5wr1U3301nJlHb/z
         Ya5SVzvboFvkUvZlmw00/SOAgHPF6J8+gkOzohkZ6qTgdG08jHhTaFpDKN5NicKptcJI
         HOkDL/KhZGTkZxa9sK0YTkDkkzyPWVWcZoJruAJiqzUYXuW+HsxHep0RmOszdREzk2IC
         pMqyFZl7P/usOvEBZbjc3A6LxwfcPBxE3H5Yph4uAWtg9vQvQHE/ZrMUfiY8M3fazfy2
         Fc/z45qc6tfQtktnn5FX47FRgy2YjPo/RhuO3CO0VN7+1RN3RAp9i+n8wGypJ77htJZE
         LpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774172482; x=1774777282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQXcszglpRn76zyaD4gcsl+CnRRTNeStc1QZosZqFUw=;
        b=Ea1dud1NZrPNxGzAQxrkdbsuwjHJQa+LmgImBpHSKDV4RRqFG1vcJVDXN4x8mjS0JG
         cxjq+wtuArD+3oJf35NK59vVVWMUkcObpyGZmsvATcYMorZZzmjXiBfY3URTDtwJPLUY
         LZIi/mjjK+wZWCg7CkiFb4uw7EnxSmuG4TKvq4NRFWWsDs4DG9mtGWsfwj5rYPP/VLJR
         GGsNxt2YoCkSWavFXQ1L43SEZXxw/z30zH7Pva6FTI6GH23boYsXmq10J4832rrFvaDa
         camdCRkn4YKEbR/9Xa/ZbGtLQkY8ldIL25RBeyrBJI8GWPaZ9C6GhAN8hDAzwJvSbzC7
         n5Aw==
X-Forwarded-Encrypted: i=1; AJvYcCU+NgLIW1cEecfdf3O0b5PflrFdbcow90bsV5ZkVxH4E8H3tGYDfc49ZVOOomG5f74nUVRHow==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIYgK5rhpMmrunCbDqfdkVUZOcTRWJtcNdcKts6eYvWlYdUwlF
	VG4pt7J6cpfkcnrW2f4LK+CdhXE6xbrdXAo6V2hNUn+eT1yGa75QvJpbC01I3EACrA==
X-Gm-Gg: ATEYQzxAjVa/u71r912UQmnaTuWg58b/IONAZHCsUy4MV9GqHnVG7fPyus7gZWvlaOn
	27m02twHic4SNxaaYGdsdn9d7Ec0vAgTDw4hQEVj2Y9eCG+pN0RK0WOHK3jpwhIA2V/g14zWzPw
	RGKmQxnIzH04w6JumURCJa0hlodryweN2An6mqMuicrm8edlH9oD1fupJ/doV70PGDnrNPLIc7B
	a+fQ22u2m4bwHOPNoRzLb6jUmNT8151WwJDi6HJB8L45fgIda//5pW+zNFoCkqtsbUQoOGd32N8
	m7pU/f7RFfGLpARl0Yj65xXgZyVa1aWKmTzt7yPkwHhGuiHB8UZ93H2g+DmvQ3+cDrDyEKJ81K0
	evUCgzWTODxWCRroxa341jwLokIefZ2A7HQOhPKGjhonxLLpsNFP+MlGPeuWjBK3kKhZBxQ9hWU
	MBfNpggOYniq4TBndhBlpmNec8X3Yu3g96YstIg4KQN64WH/p08bBmmXf0
X-Received: by 2002:a05:600d:640f:20b0:47e:dc0a:8591 with SMTP id 5b1f17b1804b1-487034330d9mr965975e9.2.1774172482001;
        Sun, 22 Mar 2026 02:41:22 -0700 (PDT)
Received: from google.com (54.95.38.34.bc.googleusercontent.com. [34.38.95.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b322d9sm258723025e9.8.2026.03.22.02.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 02:41:21 -0700 (PDT)
Date: Sun, 22 Mar 2026 09:41:17 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	skhawaja@google.com, pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 02/11] iommufd: Move igroup allocation to a function
Message-ID: <ab-5PYF8PGew-Uv_@google.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
 <20260312155637.376854-3-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312155637.376854-3-jacob.pan@linux.microsoft.com>

On Thu, Mar 12, 2026 at 08:56:28AM -0700, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> So it can be reused in the next patch which allows binding to noiommu
> device.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/iommu/iommufd/device.c | 48 +++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 344d620cdecc..54d73016468f 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -30,8 +30,9 @@ static void iommufd_group_release(struct kref *kref)
>  
>  	WARN_ON(!xa_empty(&igroup->pasid_attach));
>  
> -	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
> -		   NULL, GFP_KERNEL);
> +	if (igroup->group)
> +		xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group),
> +			   igroup, NULL, GFP_KERNEL);

Is that a separate fix or perhaps belongs to the next patch making
it possible to have NULL groups.

Thanks,
Mostafa

>  	iommu_group_put(igroup->group);
>  	mutex_destroy(&igroup->lock);
>  	kfree(igroup);
> @@ -56,6 +57,30 @@ static bool iommufd_group_try_get(struct iommufd_group *igroup,
>  	return kref_get_unless_zero(&igroup->ref);
>  }
>  
> +static struct iommufd_group *iommufd_alloc_group(struct iommufd_ctx *ictx,
> +						 struct iommu_group *group)
> +{
> +	struct iommufd_group *new_igroup;
> +
> +	new_igroup = kzalloc(sizeof(*new_igroup), GFP_KERNEL);
> +	if (!new_igroup)
> +		return ERR_PTR(-ENOMEM);
> +
> +	kref_init(&new_igroup->ref);
> +	mutex_init(&new_igroup->lock);
> +	xa_init(&new_igroup->pasid_attach);
> +	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
> +	/* group reference moves into new_igroup */
> +	new_igroup->group = group;
> +
> +	/*
> +	 * The ictx is not additionally refcounted here becase all objects using
> +	 * an igroup must put it before their destroy completes.
> +	 */
> +	new_igroup->ictx = ictx;
> +	return new_igroup;
> +}
> +
>  /*
>   * iommufd needs to store some more data for each iommu_group, we keep a
>   * parallel xarray indexed by iommu_group id to hold this instead of putting it
> @@ -87,25 +112,12 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
>  	}
>  	xa_unlock(&ictx->groups);
>  
> -	new_igroup = kzalloc_obj(*new_igroup);
> -	if (!new_igroup) {
> +	new_igroup = iommufd_alloc_group(ictx, group);
> +	if (IS_ERR(new_igroup)) {
>  		iommu_group_put(group);
> -		return ERR_PTR(-ENOMEM);
> +		return new_igroup;
>  	}
>  
> -	kref_init(&new_igroup->ref);
> -	mutex_init(&new_igroup->lock);
> -	xa_init(&new_igroup->pasid_attach);
> -	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
> -	/* group reference moves into new_igroup */
> -	new_igroup->group = group;
> -
> -	/*
> -	 * The ictx is not additionally refcounted here becase all objects using
> -	 * an igroup must put it before their destroy completes.
> -	 */
> -	new_igroup->ictx = ictx;
> -
>  	/*
>  	 * We dropped the lock so igroup is invalid. NULL is a safe and likely
>  	 * value to assume for the xa_cmpxchg algorithm.
> -- 
> 2.34.1
> 
