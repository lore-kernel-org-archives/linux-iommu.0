Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EC026159E
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787680922; cv=none; b=iMuwu0lDNzpiogBYptijHdray+FOq51Vo5ztYikTL7baLw+gUTOvOeTtD1R/R1vxQTjYOcOPrQ0h/Otjkkordt1cDGUxNMiqjD6k1eakSdXIJECBxzjh4FrGGHsa4SkcnA31E1m6x3eVcidCcZQnRVkB1hkzggF0/q+lDux9PwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787680922; c=relaxed/simple;
	bh=TxvyN2/6tNNhZtLo9iTCb6Bfz3yCgxfvtZWMfhEcWko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNNbfikew6gA7qU0arSCy4IOKcx5Gj4yBVekKhEoaB6WjfdrjOZm+V7R0UwLrn4yopYX7640ETvivsqC9pH8wX65Vnlx/CRDVA7KUubPfPDEyUueBUnniP2qPlIvWEGnUguaPGhN33H04R0bjfNARQEVHickV3JZoJXocWob+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q6efspCF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6efspCF"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d3b445a84fso11845ad.1
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787680920; x=1788285720; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S8PQY6l3u9FoMeM1xa6ObUvdNLOTfPI6J/sabdi+AtE=;
        b=Q6efspCFvf8Rh1XzKQ1RHmI5u7TSrVa0zG57WGNrY+hWMgMSIl89+ocFf9YBeQP34h
         5XCY3OIjkmC0m1LZZ7/KPn+lK8tX1qnBoDW7kgsFZt7hsnqVyq1jwqznGRgs+Mi6IE+u
         P02hY3IpVOfKhMGAax/ppJRguoJXcoZKtU4oUW7HE18/DBXe8PBLTCMTt491VG9N8BLw
         B2d1PQvuOzPkt1UDneRyOwwlZDBLUZKkmn8CU5q1F0KgzvFwu00CBG+q5Vm2yaV+JpN8
         6PSmJZQIS3ubL06a9llm+nLPyAGlritXgyYzzK3aHYfuxOOsDUezeEIIv2Y6wnW3FElG
         kuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787680920; x=1788285720;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S8PQY6l3u9FoMeM1xa6ObUvdNLOTfPI6J/sabdi+AtE=;
        b=CVfa8LhniGbQdNwVXd+27/MG9cjQw2PP8GrlG/mM5y3p4wiCy0Nbif9BMQ3lpfkD3Y
         lgRi3neNwkepbiiSHOG+WY8TRz1IJIQITNDwKsYeN2cY7DNoP1w2oGF1Q/9s4HDYmrZi
         fOjYtU1kCZ0qNgPGoAz6HaHVNIUap20n8MQhRwsO40r2yn9AM4SPiIi/4rYaZp0aURWl
         iYWGLzcc1e35na42H5N4gF5ZJ7WxgBPItMkKopB8x+9u5BaPDvEeCw9T2lg/O++r+W82
         mx1huCm++Pid/TIG76fgXcCusk2cBvvCLQey1jmDE9wS3CFDr3726TFubdG3u2ebmP3U
         GY+w==
X-Gm-Message-State: AFuF++k6vhzeA/YRiuuJGSvCYNV7xnc/sJDKSmxBT/7FgIVfhesyOmy/
	e4QL2kblo5R0zbN0vpcPGYR0Lgpky+8UOWwBtHU8cmt+QCtobo3e04vU9M0q4ufe8w==
X-Gm-Gg: AR+sD13xClkhGPkAoSyTkra8HyOkrFGZNV0+O35ZvROjlWeSwdtHOyS+7c5Gbx4jkAi
	JpLEKyhqudLK/ij8oDi+ZIneOQZTEXCcIUUiCkfDr2JPAN6jjnqXfYNVrej/FCPJDzW9AvqrKTD
	GPHgljzAzqDvZerqmExfubWOaOYDEOisl0pbn4P/oEilGaxvNN5VJdT/kF9xn4ZgKs17uSEFcUH
	3S+GduipCfrS4hlgl0CqNfDU4esqDLtdvxha/+ahnG+tLfDk/z4I1QCotPinIWyddMTjocHwbVM
	8zBp9ngJKtrwyIdm+yCybgMJVX/hxMoVAZS1WtwaAVStKnqUeel+bhKtPGQP233Bp/X6Ue4/HIK
	A1qYuhcNFfpe8G8RfCaio6koG92b3O60DSu2MApMMET3nS3OycYlbzEKFbRCiUbcb/3NV+tVUJd
	5ckzyAZ8lO5ejk71b6OtdkzgKrdDxYNthDCNusI+5ZJCXjQh7nEnDiFbqRy+daCqCnNeyJoISzG
	Z6l8QkI+5q7GIcOrPv/0p9+UA==
X-Received: by 2002:a17:903:15c8:b0:2d5:db3d:1a45 with SMTP id d9443c01a7336-2d6e07a752fmr8586785ad.18.1787680919397;
        Tue, 25 Aug 2026 11:01:59 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1beb0f15dsm39129a12.9.2026.08.25.11.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:01:58 -0700 (PDT)
Date: Tue, 25 Aug 2026 18:01:53 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 05/12] iommu/arm-smmu-v3: Cache and restore MSI config
Message-ID: <ao3YkfLnCwbhC1A7@google.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260728210928.1050849-6-praan@google.com>
 <178767577112.3356902.7778967514008843854.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178767577112.3356902.7778967514008843854.b4-review@b4>

On Tue, Aug 25, 2026 at 01:36:11PM -0300, Jason Gunthorpe wrote:
> > [ ... 37 lines skipped ... ]
> > +static void arm_smmu_resume_msi(struct arm_smmu_device *smmu,
> > +				unsigned int irq, const char *name)
> > +{
> > +	struct msi_desc *desc;
> > +	struct msi_msg msg;
> > +
> > +	if (!irq)
> > +		return;
> > +
> > +	desc = irq_get_msi_desc(irq);
> > +	if (!desc) {
> > +		dev_err(smmu->dev, "Failed to resume msi: %s", name);
> > +		return;
> > +	}
> > +
> > +	get_cached_msi_msg(irq, &msg);
> > +	arm_smmu_write_msi_msg(desc, &msg);
> > +}
> 
> I'd really rather the irq core do this than open coding it like this,
> it should be fairly common for any driver doing power management and
> platform_device_msi stuff?
> 
> So maybe:
> 
>         platform_device_msi_rewrite(dev, irq, arm_smmu_write_msi_msg);
> 
> ?

I guess it does make sense to add another irq core helper like:

void platform_device_msi_rewrite(struct device *dev, unsigned int irq,
                 irq_write_msi_msg_t write_msi_msg)
{
    struct msi_desc *desc = irq_get_msi_desc(irq);
    struct msi_msg msg;

    if (!desc)
        return;

    __get_cached_msi_msg(desc, &msg);
    write_msi_msg(desc, &msg);
}
EXPORT_SYMBOL_GPL(platform_device_msi_rewrite);

> 
> 
>  [Severity: Medium]
>  Will this correctly detect if we have fallen back to wired irqs?
> 
>  When setting up MSIs, if the allocation fails, the driver gracefully falls
>  back to wired irqs without clearing the MSI feature flag:
> 
>  arm_smmu_setup_msis() {
>      ...
>      ret = platform_device_msi_init_and_alloc_irqs(...)
>      if (ret) {
>          dev_warn(dev, "failed to allocate MSIs - falling back to wired irqs\n");
>          return;
>      }
>      ...
>  }
> 
>  Does this mean the resume checks here will still pass during a fallback,
>  causing irq_get_msi_desc() to return NULL and trigger a spurious dev_err()
>  for each irq on every resume?
> 
> Seems believable..

Ack. Yes, I think in this case we should be ideally clearing that
feature: smmu->features &= ~ARM_SMMU_FEAT_MSI; before return.

Thanks,
Praan
