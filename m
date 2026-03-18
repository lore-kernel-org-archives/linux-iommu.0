Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E463377EC8
	for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859186; cv=none; b=L6hIrrcOav/8fvdndjJuY3KNWX6gcwHg6CanmjPWvjx6Pxu+bdDxOpKSC8W/nDsC59RPErC6pDafxEktMBhV4A1wgRYHWeGtGovKBXFN5TFGkw1mG35Gq4UJBG1PZHs4/VKufpX0fmutDtmc4BKS8EZS5EMRxnH46rSqzufME/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859186; c=relaxed/simple;
	bh=i7Z7BF+ComiZGkbeFzkQ/Ss2FktQJH5//MVZdkKxR0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Km4ifxIxQeXcahzcmgS66T8qwKJapXkg/5Z7Krwz9m9owXwl6CUVz3j4TrBF16BcxCkrcRzhUuBdx0laueFu1Q78qv3D16/aLy5JeZftZ0NysRos8PUmgOlT5lcysNNcnt2kvFQX8aY6yCzZ7Ec2CLZVAhGeKDK0xMdYRXAm4iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sKI4RoX+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sKI4RoX+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so12785ad.0
        for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773859184; x=1774463984; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PUvTjxGjBip13gOAImg7DvrqpmVJiE6Xpjign68Hlwo=;
        b=sKI4RoX+S2WwZGPAsOutic7VQd1fth7B4rMTLjjYkHeceA1bMnOfO3R1PmMIKRBnoF
         pC50qUmLVAfIq9RYEiFziRfxwDenFAsOwaZW8TUWhN6VNTV0dwY9smBaDEfc+KUndtcV
         jphSe3AJgwzi81Q622KoAKhflqIR4Wtrv90XMk/oPuv6IYHJvGutOcYtnNPtaz2WF9Yz
         Q5MnYuwTKtlSOHLfNiOpMvqIDlN2e77zhAJ1vzPmFy1cQ6mz02E6KyqEM2Iej8/ifqTJ
         0C1f0VJ0fZAyIxmFPGnecLyrDkPwQTV27INdHgGDGxYbFCTZkCAnJ8BOV5Zi00mF53+R
         NmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773859184; x=1774463984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUvTjxGjBip13gOAImg7DvrqpmVJiE6Xpjign68Hlwo=;
        b=kO77LIE44ixLvevlMNaLQkP81bghVydPZwT/SDEYAnVpBsknCeFDMKjs3o5I6kQGjy
         rLbz81SA036hj6zH5XnuRtT0h3spfAyJn7YC+/tUiJTTXYjqNvp+NuFqpiCFwxF5gwuh
         JsK3KWRoRTwte2cPHlkefHBD6kh2GTooPpFDwuHjRBn9euU+l4zsq/vTK4c+fMwmlpB6
         V0gAeWmVRP/Ia5N9M2GPtnGBrm4wyvRJ4Qac3+QOAIbyB3lgyCEQt/q42IOYELqwxM6v
         69CVgyBElWQEbEpncKCuXJg2U0Iw7Ln5/bCTe5KioQ+AZnaoIgSiV27zMEGtVKlH9nb0
         f01w==
X-Forwarded-Encrypted: i=1; AJvYcCXGEteJesQ2dR3IhllQVfGNq9hDAldckI4ObF7aWVuiLDKtlZFe7fA8QPp79BjVuxFASZN3iA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmYEFilLCvsUmdsMzE2QiZY5Rf/uCJxnEIW26et2437EPyaRn5
	pYUykS5Nj/fl9SIcCEq5nXC2nS+EXW889X6VQHTUDfpSEDo/RvoDKpkKU1DWm0L1eQ==
X-Gm-Gg: ATEYQzy2ZDpmtlG7tSaS9OccYezEtwldfHZWdDlAPc54rZjPV+Y4Rs224fSeVAMtTq9
	MhAuymiIgaHJMOR5cCnBClpGM4Jec4lKc/PvtFsss6lC5n09DxCrgmzWM0+DgAzVzdOG0ZOzLst
	uv8pfYphffUlbT7MAAjs3mqpMC1+AlV4bwZRliuh6pTXl77ASate9+puOop8oAUBut0XsekqE7I
	e8Ma3tv6emtUJAp4ibs9ZNl7EK9CZgn9cgjW+UqDRDyNYcLYio9mUqYqDTIMyrjjNEpGE9NfQFo
	e8+2HyklbpJtn96uRiuxL6bV9tw3hnA5zEZwy3LArsnJnKlmUtQACj6hi6j3JoO4K0YFcjwAn7X
	fJguE3fjGhfyp3J26FqInLzyGbEMLxfmPWQTjvZT80EXnMW/JYgyy+DchR7Jv1ZsKAdb1MequuN
	2eP/0HrjuYxAJo0XebKa8Q1dA5c/x8ZgVCCoHpkigs/SqD6hgOFF8xcTAuoOqpQw==
X-Received: by 2002:a17:903:3003:b0:2b0:5e19:1862 with SMTP id d9443c01a7336-2b077f16cb7mr250545ad.5.1773859184178;
        Wed, 18 Mar 2026 11:39:44 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e6314c5sm33123665ad.79.2026.03.18.11.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 11:39:43 -0700 (PDT)
Date: Wed, 18 Mar 2026 18:39:39 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, 
	David Matlack <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, 
	Yi Liu <yi.l.liu@intel.com>, pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>, 
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 02/11] iommufd: Move igroup allocation to a function
Message-ID: <abrxQbpOQAtHM9qu@google.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
 <20260312155637.376854-3-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260312155637.376854-3-jacob.pan@linux.microsoft.com>

On Thu, Mar 12, 2026 at 08:56:28AM -0700, Jacob Pan wrote:
>From: Jason Gunthorpe <jgg@nvidia.com>
>
>So it can be reused in the next patch which allows binding to noiommu
>device.
>
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
>---
> drivers/iommu/iommufd/device.c | 48 +++++++++++++++++++++-------------
> 1 file changed, 30 insertions(+), 18 deletions(-)
>
>diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>index 344d620cdecc..54d73016468f 100644
>--- a/drivers/iommu/iommufd/device.c
>+++ b/drivers/iommu/iommufd/device.c
>@@ -30,8 +30,9 @@ static void iommufd_group_release(struct kref *kref)
>
> 	WARN_ON(!xa_empty(&igroup->pasid_attach));
>
>-	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
>-		   NULL, GFP_KERNEL);
>+	if (igroup->group)
>+		xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group),
>+			   igroup, NULL, GFP_KERNEL);
> 	iommu_group_put(igroup->group);
> 	mutex_destroy(&igroup->lock);
> 	kfree(igroup);
>@@ -56,6 +57,30 @@ static bool iommufd_group_try_get(struct iommufd_group *igroup,
> 	return kref_get_unless_zero(&igroup->ref);
> }
>
>+static struct iommufd_group *iommufd_alloc_group(struct iommufd_ctx *ictx,
>+						 struct iommu_group *group)
>+{
>+	struct iommufd_group *new_igroup;
>+
>+	new_igroup = kzalloc(sizeof(*new_igroup), GFP_KERNEL);
>+	if (!new_igroup)
>+		return ERR_PTR(-ENOMEM);
>+
>+	kref_init(&new_igroup->ref);
>+	mutex_init(&new_igroup->lock);
>+	xa_init(&new_igroup->pasid_attach);
>+	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
>+	/* group reference moves into new_igroup */
>+	new_igroup->group = group;
>+
>+	/*
>+	 * The ictx is not additionally refcounted here becase all objects using
>+	 * an igroup must put it before their destroy completes.
>+	 */
>+	new_igroup->ictx = ictx;
>+	return new_igroup;
>+}
>+
> /*
>  * iommufd needs to store some more data for each iommu_group, we keep a
>  * parallel xarray indexed by iommu_group id to hold this instead of putting it
>@@ -87,25 +112,12 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
> 	}
> 	xa_unlock(&ictx->groups);
>
>-	new_igroup = kzalloc_obj(*new_igroup);
>-	if (!new_igroup) {
>+	new_igroup = iommufd_alloc_group(ictx, group);
>+	if (IS_ERR(new_igroup)) {
> 		iommu_group_put(group);
>-		return ERR_PTR(-ENOMEM);
>+		return new_igroup;
> 	}
>
>-	kref_init(&new_igroup->ref);
>-	mutex_init(&new_igroup->lock);
>-	xa_init(&new_igroup->pasid_attach);
>-	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
>-	/* group reference moves into new_igroup */
>-	new_igroup->group = group;
>-
>-	/*
>-	 * The ictx is not additionally refcounted here becase all objects using
>-	 * an igroup must put it before their destroy completes.
>-	 */
>-	new_igroup->ictx = ictx;
>-
> 	/*
> 	 * We dropped the lock so igroup is invalid. NULL is a safe and likely
> 	 * value to assume for the xa_cmpxchg algorithm.
>-- 
>2.34.1
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

Thanks,
Sami
