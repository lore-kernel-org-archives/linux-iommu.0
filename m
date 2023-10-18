Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B921818E0B
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 23:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0UP9bKg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697671775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DRIEsucDzfc4+5QaKl7PpFIFrSK46xQTHzvy5XznJOQ=;
	b=K0UP9bKgoA19rp2ZvGFaWlAUKHOgHyqHz4gCcvUq3wE1gO47C/TGRL13GF7HYtiklbECiW
	NC1BUXjKFT7Ph32Oz/rscSxS6uI4PxiJUFMGNk/Q6HylrE6nP6/+TW3FsBFIjWdZ3exZZJ
	uMOHEU2f9ypn3/WinoBvV8btQBMhWBE=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-OaEoQMfrPQmNNufXGp9n8g-1; Wed, 18 Oct 2023 19:29:31 -0400
X-MC-Unique: OaEoQMfrPQmNNufXGp9n8g-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b2e44c8664so2706017b6e.3
        for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 16:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697671770; x=1698276570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRIEsucDzfc4+5QaKl7PpFIFrSK46xQTHzvy5XznJOQ=;
        b=fzkqSya5rJlivroYwyiYP3dac0T/yL2PLLzkRV0jUuu2DVwzcN5sJFHzWRPPJmpYvB
         9G7pi/R9zWoKwU9Td6QEsgDPMJqofum2pUpnnREstT6xnzekEJVGD+3wOiFfV4VVO1W9
         8DOdyaUFXjTAtBMELsFikriqNnRCj1WGnZr9+KF0ghas/6vPvhvxr65PZ0BdTTITFEFq
         JDmuQi3N93RB3bxgCGWQGClW6bZHgnZYmeUlpm4B3xlRyy3D8UM+DukZatgOr00ciZOb
         z+hv+JbyQlsOivTfXj3AsIsN8MBXTn7/5rEMdOeLWtGY2g6nVXVeKEzp3NWY6hQ+ClBY
         0OWA==
X-Gm-Message-State: AOJu0YzHxrLWdEVwkio3ULBf9is0VnSGfHVz0uCGBQjTm/rzaZfVO67m
	Z0sldIckhpx7UAhEWsdj6q3l/T/D3XFkFwrF6LJs0V1LQ+lEiNNloUzU3cpDWXBpFOqLN+84tMu
	X7oEGhrR0JsTSiwA=
X-Received: by 2002:a54:440e:0:b0:3a4:298f:b2e0 with SMTP id k14-20020a54440e000000b003a4298fb2e0mr645532oiw.26.1697671770796;
        Wed, 18 Oct 2023 16:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx26w5otXYju9J5g7hJH0oM90D/ndOaZWJ/zsUkrwM4XB6dkxyGvfp4EUqanYeiF63KRz1yw==
X-Received: by 2002:a54:440e:0:b0:3a4:298f:b2e0 with SMTP id k14-20020a54440e000000b003a4298fb2e0mr645519oiw.26.1697671770567;
        Wed, 18 Oct 2023 16:29:30 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id bt19-20020ad455d3000000b006616fbcc077sm318229qvb.129.2023.10.18.16.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:29:30 -0700 (PDT)
Date: Wed, 18 Oct 2023 16:29:28 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/7] iommu/arm-smmu: Don't register fwnode for legacy
 binding
Message-ID: <2aigsq5n3q2qqwlctn7dqorusslpwpptgogzcrymxzxeertqvn@7aua3vzzszt7>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <3a5cd62dd21ed58f337bb9a389d301054e503dc3.1697047261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <3a5cd62dd21ed58f337bb9a389d301054e503dc3.1697047261.git.robin.murphy@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 11, 2023 at 07:14:52PM +0100, Robin Murphy wrote:
> When using the legacy binding we bypass the of_xlate mechanism, so avoid
> registering the instance fwnodes which act as keys for that. This will
> help __iommu_probe_device() to retrieve the registered ops the same way
> as for x86 etc. when no fwspec has previously been set up by of_xlate.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index d6d1a2a55cc0..4b83a3adacd6 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2161,7 +2161,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
> +	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops,
> +				    using_legacy_binding ? NULL : dev);
>  	if (err) {
>  		dev_err(dev, "Failed to register iommu\n");
>  		iommu_device_sysfs_remove(&smmu->iommu);
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

