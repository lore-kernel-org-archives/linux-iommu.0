Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD8D33C5
	for <iommu@lists.linux.dev>; Thu, 13 Oct 2022 15:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665675453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZC8ZhODybW3HN+Dzjja+AX4is7YURzcPSRS/gTWg/mU=;
	b=XRQ9eg8YGwvmIOjLbbdoV+JSzEedsPiRB/jbdIbJaMtuo0Fz21DIKxxVDNE+hiQ0F94Xgf
	1Y1CZbXhy+pmWsf8hKfbPMrl/i3bXDR2a4WdPfjmPuMmN4w9q737FN3GMx/OdpSaJuWYda
	W2L5IaG8e3H6OHptH1zZVF/wPJu/uts=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-672-LMOYoQ8jO7al9QqZIIngeA-1; Thu, 13 Oct 2022 11:37:33 -0400
X-MC-Unique: LMOYoQ8jO7al9QqZIIngeA-1
Received: by mail-oo1-f72.google.com with SMTP id a11-20020a4a80cb000000b004805cba57f1so1131701oog.11
        for <iommu@lists.linux.dev>; Thu, 13 Oct 2022 08:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZC8ZhODybW3HN+Dzjja+AX4is7YURzcPSRS/gTWg/mU=;
        b=fk/M1pF1fPe+nYOxVXRv7ZEum2jN2qqSDbr2eGEsIYag25u885Pgveu/YBslAcrhGA
         1dz8Ph6BBEJ25dCjIZ9iwRxzbORhDLWfwtFggKa6duf/BAgfa+1EQSP0p+MqZCKs967W
         p3ZDVDL0U8oWUuDuk8zTJn0JDsTxrae/SmJYJPM0mAWLsPk2fwOqQ70hD2HBK8NNv2yG
         p8bMlVPXtCZTbTiBalBP4p+Mnm2Lg0b9rYURr7NYkUO2LuBGYSIIWOuhNRNmy1wIubEz
         NmokhfRc44D5Yw0/Jx8lQBUqPkKUxBj281u4bOXGg29D36FlR/uelmXczn3nMjj+opr0
         3yUQ==
X-Gm-Message-State: ACrzQf0tvaNbKtHCe8FxwPbjaJMb5hrvCj3H3j/Op2VUCzSg7eQa6YtK
	b4KawSu6EsWk15GebpIx50xNhpXPAgWE7ALdEWixZmGa3drL37GBCHHaNUXS+J/OwCN+KNNczdy
	egnrCLhiO0qRFoMsMNvKlOqcmpGGTBSJO4LL9xwb3rPni9bZXd7QuRza7t/7jKZwo+xY=
X-Received: by 2002:a05:6808:1b12:b0:354:a089:1998 with SMTP id bx18-20020a0568081b1200b00354a0891998mr150719oib.9.1665675452126;
        Thu, 13 Oct 2022 08:37:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6yjHx5WKkTxDmnf9BkOTj1JV+8H3boJ42+MTYhu1d27xRvNYYoqWqfZtJP/7wopOxXoTlmHw==
X-Received: by 2002:a05:6808:1b12:b0:354:a089:1998 with SMTP id bx18-20020a0568081b1200b00354a0891998mr150697oib.9.1665675451855;
        Thu, 13 Oct 2022 08:37:31 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id r2-20020a4a83c2000000b004809c78083asm872774oog.25.2022.10.13.08.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:37:31 -0700 (PDT)
Date: Thu, 13 Oct 2022 08:37:30 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Add sanity check to
 iommu_sva_bind_device()
Message-ID: <20221013153730.rwtukjgpdgwgfodv@cantor>
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

I don't know how many other drivers there will be in the future,
so quite possibly a non-issue. It did happen with the idxd driver
though, and I was thinking about that this morning so thought I
would send a patch to avoid it in the future.

Regards,
Jerry

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

