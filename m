Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A9A3BE64A
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284399; cv=none; b=tXwtp6cne4LcyrFPSjEnFHLEpwXIGQfzKm8AMtDdGrpZf5q2RJcJ0jgY0170Q95xlBqWMN+sdwzrA/EjwTRU3oK8mHXpXHAAjzi0/ZHbt276F65lMqTYrcEsJYC1bkAzKSHMrFDcN6VvNH1BXhR5/AaR6LBpwDFDOpRJjq/kG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284399; c=relaxed/simple;
	bh=HKQDceImfXDgLYjADsrp6O76IrFmWlYgSMQDN99+TQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pl6ffUi0vbZz5yJCveqFHG5j8IwJX4s2x7n43ty6Q+mrl4JpxTw/3Nhbhsyn8nHrUf7YmQUEFkCVuN5GfSH2y+KiVL+14iExvGD3K4ZPhD+f/j3XoCXmziCSf20OmO2adWJ0lw+Sg+G4OFw2s+s8lcLGJT5cJGM2wgpB7tjsX8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dKA/9X2k; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dKA/9X2k"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b052562254so4555ad.0
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774284398; x=1774889198; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3cHIDiGHIa38vn3Mqr4bq3z4kncPagusqX2rPGm+Ow=;
        b=dKA/9X2klTPI9+jN1OPNpPUkb1ayp95LssdcGrZCA3ZYbH2NfXO6djmMZwHU0XP0uo
         2Al48KSI9ZqDkVVtuI/JNs3h89wanicjZyUFFZo4Jgo02bS7q2kpUUn5mE0ZhuJIRDol
         Ng03Ad4lAV48m7/9K9eegUNao02sF+VyKDbQHNi20oxEt2cF+5fx/qDgCzyQeP4nPc2M
         StmyT/HEj1Z8vPRzx6Mk4dRufbh+UyPopMN+pIB8YxjSAg6zSnKRzmnFSw7ozok02PRz
         rt/VjskLCmTk1Do8fVOnQzyjM0WcI0N0x8aoQEZLDHPDnaqwGPcPZU23k2f9G9PNFoeT
         tbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774284398; x=1774889198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3cHIDiGHIa38vn3Mqr4bq3z4kncPagusqX2rPGm+Ow=;
        b=kjTJ4GtHRhN1GZohhThxqvyFKBEJnO8hMTYJzlL1QI4C+XHegSROu2seXDrwMcfy/V
         gycTwunE6PVKFNxo//cqj9suqyg3+ycxezPEyGH+tvgI1Fl1muD3QmtXBxdYrASI2pkA
         qprz/WX/Dkd+WhITvPrhaAV4on5XDFu0pUleBxHXBoqBBsaTpyD7EiX7kTxH022a3PLl
         l2sr8S8COJtWXVTudoM8VFfnFKsxQQn16BmI5Fo9u90fnMOh0Nu4E21OMlb5RhK8wX6W
         G0qUtnvX/UsKYQmucnfkC00pEJbrU5Yvl8ztwZLAGoHCm5oDHeFiG56I2+fMitIjEu+r
         mDsg==
X-Forwarded-Encrypted: i=1; AJvYcCWMBc+9wGTngQsrL3DTBgd4rL3TcKw8q2TZzNwhvijnevUUGHv/e+kVcQEZoylIwjZyhprCcw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1iNrCHMSTjU7KAADs99ovcawyFrcV2QG2W4Cc2VI3F0xUWvPr
	RkHWQ4oRsl6C5W2gVUMYpQP1JKvtrcs/qMeM5IFuu0+NpDXL6yYpmE2FyrCrkiCxlA==
X-Gm-Gg: ATEYQzxQHYNZln8+vjuy6SiK3NTCf8zo6AM/0eEx7aaHpNA6yfCJD3+8XmrCglwPjg5
	kZLF1mumCxh5skcOKuYTPHo8YclesJyB+4Y5wEF2eIWa3FAvJPwatC6YUfoZ38m75G++WKH1OIA
	BlFfFr4ttcSfyu9+2Cjm23pkq8GSg7BSrku+edTC2E2yDdmHaUSOvKZdD6b1bY4JqzcVl96c1hS
	CSOvExuc6B+bUlf4ZzAc14rG0ItB7AJWqgL19ZyHL7F57Sp81MFEPp2PiBXgGl9Mq68KZG9nVvd
	KhEISiycT2CHeBS0zSMrTG34xOAKf37jF+enzLtz/FoZJqsc/T/nQz3Yroc/3fUyH7DED1wvWmq
	HwroLYZuccRwqAyTkMc7bmHhCHkTHy/W+duZYMfHenhVM0xOQWWZR8E88KELREHIz9NDdwUKKQ2
	l91zkMfg2HI7rnNQ80oGl2ulY4RC3Lx+8LN0RfAVJQZs4g3ogXsl9HY0BMObs2hw==
X-Received: by 2002:a17:902:f541:b0:2ae:45cc:aeb6 with SMTP id d9443c01a7336-2b08b40ab79mr5435895ad.6.1774284397207;
        Mon, 23 Mar 2026 09:46:37 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da438sm10054500b3a.43.2026.03.23.09.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:46:36 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:46:32 +0000
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
Message-ID: <acFuWXSZiBGnu1vB@google.com>
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
