Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB156C2C6
	for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727061019; cv=none; b=attdCSySSNiFxBZK5zBlUWAXtasXYV4pV7O6vCSXaeL/F2ESkGihOq6+SqS3TNnicL5aA2Iz6EI349lBw5J/WcyKuk8Q1+45Tb7sgLCcH6BCy5K6nXpQV4HpArnvf+aGlsehrPfGAGc9ryenbdGnBowOEUuWx1uhNqZiM+z/iu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727061019; c=relaxed/simple;
	bh=/d31PSOPr0RsVly3ijRCrupc38aH6Gm8vUS22l59aGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VM2JtVRE2knyi9ZscIT1PSiv9CvMXfIkYOPgpWCSmLeEpWef0AvwijerQOh2gnDLNzdB9F8MN6yGuhmArRtSYYK4XhNq6nOT6n6pacG3ISXKHEip1AEiySahVcjPkM7n5KAnpyxZkp37Dt6DM5TgybHXGA2enQlUD3I6emY+U68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T+1WDA0Y; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T+1WDA0Y"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a045f08fd6so608545ab.0
        for <iommu@lists.linux.dev>; Sun, 22 Sep 2024 20:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727061016; x=1727665816; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IzUtqJjmty9wVx5yKerwbO2p6grMR3z7edk2LwQv0Vw=;
        b=T+1WDA0YIJmCs57TCHgOklL/TKOmwcR4QZE07c5genJkIQjdkQJIgy99tZFbW9k+8O
         QaM+MTnAKmEpSKQx3UITOwg+CHKgeznd3vt+BiNyaBdf/6PtUD0qn58w3BM6hCKGNz+K
         BJ6dm6A9WTcCPxwTCm8Kllu7koVGIzFtqIaLQrMaLOsUg7FptLEz6UBUwqr1ZhjWvY6m
         2l89Drl3+t16KfBDUrbdI8rJcmAanzhG6WpAWbfP3N1+GMCoWwIhjpcJEd9RrEym251H
         A2reoHSAq3Hb6q8ffDM6xfaDXOjkQOQ9PWd1wWGzmlW5YB1SMA1caDcrmDY/rzzENqFM
         MEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727061016; x=1727665816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzUtqJjmty9wVx5yKerwbO2p6grMR3z7edk2LwQv0Vw=;
        b=RGIk736fm+jbM1zA9ULNh6zPaPzo5t1a6YLvBxBvCCoS9RJ0cf7zAN9Swztt0tf5Js
         Dm5i0In++HILFEHFwvXqjGVIJegMtRDV4J9ZEgZ4OQ8UfpSugA20wiQzfLtmF5gOtiw/
         MiMgrVYF+HTSgB/CBXga5DHdTk3bg1mvUACJqn0UrVNjWYHvcRFL9HZ7hzdh5d9tXALM
         +apkM7Z6bmwucSF86pJJEabYuI/JjfGOBwLaO38yk9HeEwWMzg3bqd5ksvawBRaxOTgn
         Md+/ION0d+/iyzRWokTi2uIQc4sgrl5HttaNDLWEIEQBXHq0tOOTogSFXw478b14EHIx
         vqiw==
X-Forwarded-Encrypted: i=1; AJvYcCXaR9scYusU+Z3lq16i5UpkVCc3Z35cCQSLFUyIeuxO270GDG/4GVE+AaF5YtY19lCfxMD89Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgbYCeH+Nba7WXhv3gvUDotmS4Bqu7BRT80Mq4zTrC0G7TpCnQ
	Ze6ySssP3GS64Qnvz+0hMYQOBXWmvIocwsxOgXsO7I7B4TIL0vSonDF1Nhk6IQ==
X-Google-Smtp-Source: AGHT+IEwsVm3Qzc9hp+i5gAkymfFTBQJmEMGtLHZj6/ElZzuHZFcBIjTnNj27NumbPM/W2PkBv+lHg==
X-Received: by 2002:a05:6e02:12c9:b0:3a0:b0dc:abfc with SMTP id e9e14a558f8ab-3a192d3bd1cmr4622315ab.7.1727061016347;
        Sun, 22 Sep 2024 20:10:16 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079472e15esm124635595ad.244.2024.09.22.20.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 20:10:15 -0700 (PDT)
Date: Mon, 23 Sep 2024 03:10:08 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: iommu:  Replace null pointer check with IS_ERR
 in arm_smmu_domain_alloc_user()
Message-ID: <ZvDcEFXhpMo3K-Zd@google.com>
References: <20240922155621.49432-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922155621.49432-1-kdipendra88@gmail.com>

On Sun, Sep 22, 2024 at 03:56:20PM +0000, Dipendra Khadka wrote:
> The smatch reported following:
> '''
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3065 arm_smmu_domain_alloc_user() warn: 'smmu_domain' is an error pointer or valid
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3068 arm_smmu_domain_alloc_user() error: 'smmu_domain' dereferencing possible ERR_PTR()
> '''
> 
> The function arm_smmu_domain_alloc() handles the null pointer after
> kzalloc and returns ERR_PTR(-ENOMEM).
> 
> Replacing condition check !smmu_domain with IS_ERR(smmu_domain) and
> returning smmu_domain.

Hi Dipendra,

Thanks for looking into the code. However, I think this was fixed last
month by Dan's patch [1] and has been merged in the master branch.
Please pull the latest. :)

[1]
 https://lore.kernel.org/linux-arm-kernel/172381875518.1794999.1134549433569030700.b4-ty@kernel.org/T/

> 
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a31460f9f3d4..19c53c6f7578 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3062,8 +3062,8 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>  		return ERR_PTR(-EOPNOTSUPP);
>  
>  	smmu_domain = arm_smmu_domain_alloc();
> -	if (!smmu_domain)
> -		return ERR_PTR(-ENOMEM);
> +	if (IS_ERR(smmu_domain))
> +		return smmu_domain;

Quick note, using something like `ERR_CAST` is better in such cases.

>  
>  	smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
>  	smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
> -- 
> 2.43.0
> 
> 

Thanks,
Pranjal
