Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD3820F9
	for <iommu@lists.linux.dev>; Thu, 13 Oct 2022 16:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665678802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=258B5dvfB770baVruwTSi3C+iVLJewGHOe6aI0MzdOY=;
	b=WS58EZaSxnAXquVaZA8pRMd/MPFIQbZ60CBn7dqQnd/ectqDi4KWa/9spGWLpKZFg3V0vV
	vQC2sf9kPq2m5/wN6U6DXRZ5znrg6SzOmcK7Oyi46/Qi3h0unoopXib7py6u9CyEt/mjFY
	LVfd0PgAAzcGOKFbu5yMJPbJNeeg/e0=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-339-CCJWqPyBN5CdSVTulEp0Tw-1; Thu, 13 Oct 2022 12:33:21 -0400
X-MC-Unique: CCJWqPyBN5CdSVTulEp0Tw-1
Received: by mail-oi1-f200.google.com with SMTP id v73-20020acaac4c000000b00354b0d77a16so964605oie.0
        for <iommu@lists.linux.dev>; Thu, 13 Oct 2022 09:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=258B5dvfB770baVruwTSi3C+iVLJewGHOe6aI0MzdOY=;
        b=i7+ZU0w+2cG5sOClfuuenx5erw2hbB2oZp7tGVWO3keq3fdBeKxMMQrCoUcF4Z+u5h
         Mv63jXFXQ+w3F7EjnNI3oobYy6n+Qqe8hvmm6rM7pykbgS2x1G1FwGohKZ6nhPV1a7kr
         YlNfaOLGoR/L89k+jq0cwKFuTitpUd89WJOn2jEA1p2UI2dacm4MxN+iNtCZ1wA9Fn9+
         cvibt4jEq/lKrqHLZXtiSLs4PVu2AnPHfuAynkCyQB1jQ7vSca0/a456hlF/dbwaNiE2
         hIBY5Zjn5853mnRI8uR8/ovC1YH2NUcLVXKn7hJlJM3+NXos9N9r1IE1t868Kh+rs5i+
         09mw==
X-Gm-Message-State: ACrzQf1WlqBwjhWhlYhXyKEX9TuTAYFKIgAzU1lYIP9B3nTsTIXIBpyI
	HK8Y3jgAc2d/t+F6A/z583qafqnd+GPp5wQ8l19DWE5DfrGhFZ2aK4Q45XJF3xAzSdb4MxSYJCu
	c0qfrVMXDxHNc6FvzGV13sDrmfUHItvmdh4DewSGFFiaUDdgaq9BVJIGAgW3cTAG0Ssk=
X-Received: by 2002:a05:6808:ab3:b0:354:939b:2cee with SMTP id r19-20020a0568080ab300b00354939b2ceemr5076849oij.184.1665678799659;
        Thu, 13 Oct 2022 09:33:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6JuHSuXN3NCTH9AZ16U7Xkb+Q97H7KlKMUyPGSFXHsGClZ2sPSt5OAXujOmppNyLfSSaSpfg==
X-Received: by 2002:a05:6808:ab3:b0:354:939b:2cee with SMTP id r19-20020a0568080ab300b00354939b2ceemr5076832oij.184.1665678799358;
        Thu, 13 Oct 2022 09:33:19 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id s20-20020a056808209400b0035179b87ba5sm16723oiw.20.2022.10.13.09.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 09:33:18 -0700 (PDT)
Date: Thu, 13 Oct 2022 09:33:17 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Add sanity check to
 iommu_sva_bind_device()
Message-ID: <20221013163317.pgcsvmktotdtkduf@cantor>
References: <20221013153355.2365865-1-jsnitsel@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20221013153355.2365865-1-jsnitsel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

And I apparently had vt-d on the brain, which should be dropped
from the summary.

On Thu, Oct 13, 2022 at 08:33:55AM -0700, Jerry Snitselaar wrote:
> iommu_sva_bind_device() should only be called if
> iommu_dev_enable_feature() succeeded. There has been one case already
> where that hasn't been the case, which resulted in a null pointer
> deref in dev_iommu_ops(). To avoid that happening in the future if
> another driver makes that mistake, sanity check dev->iommu and
> dev->iommu->iommu_dev prior to calling dev_iommu_ops().
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
> drivers/iommu/iommu.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4893c2429ca5..20ec75667529 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2746,7 +2746,15 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
>  {
>  	struct iommu_group *group;
>  	struct iommu_sva *handle = ERR_PTR(-EINVAL);
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +	const struct iommu_ops *ops;
> +
> +	if (!dev->iommu || !dev->iommu->iommu_dev) {
> +		dev_warn(dev, "%s called without checking succes of iommu_dev_enable_feature?\n",
> +			__func__);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	ops = dev_iommu_ops(dev);
>  
>  	if (!ops->sva_bind)
>  		return ERR_PTR(-ENODEV);
> -- 
> 2.37.2
> 

