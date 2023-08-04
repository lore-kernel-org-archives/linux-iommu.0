Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D065FC124
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 13:17:53 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-40398ccdaeeso13288051cf.3
        for <iommu@lists.linux.dev>; Fri, 04 Aug 2023 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691155072; x=1691759872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UvI+z6a+Du3NSuq7i68YY7hMILr0K31TIp3D8EqBCfo=;
        b=JvWtOXGJr9j1teBB2MflpfJCi6ONKYcQQnql4RNvl2zcViH46bNOfk42H/jGVAMtl5
         DLypFlmaHcMFoL4+BE9ZYM2ZB8Uopxgx/9m+n3op9ZNd8zg+SCizlq2DSEKwJNlkNJQs
         a7K2MzG7tZA8Sz+48sGO+7DMAPsp4IV22NkXQ2AbxUZ8D076WHa9UvtCKm4ZiBP1UfB+
         IgPrjr/Z5ePbr1jOQdJ/mTuPtNie51joUq7nHBUJMdw3Uv+g2HYgctCRV4wex8hgYuYP
         GW2D5vDGQtfpPcFfbTCfJRR777CSyx1o08g58gGwdFeYRwlpjsNrVFKtSSlfHq6PQcMr
         hoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691155072; x=1691759872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvI+z6a+Du3NSuq7i68YY7hMILr0K31TIp3D8EqBCfo=;
        b=MPrFCjG7upDLCEsreadbLyF8uCVHfPxI20FmsJuoHs1Zk02q00NsEsO++QhvxuDIt9
         yflqg9j//MJKLgygEkUX+q06aplclyX/iNebuhn23kSJC3EWucMM0VwUPbxR0GZ416ss
         FuvJeiL33PFoOKhamfUSSAd8AkJHBKFi1gYiUPRo7NbnKNNBUfBRaNe0E+cyeaLTBbLe
         eE5X6fcvquaK0MBjW00CgXQbkCIzXErOzAlt9nYxVJ41VdDxPDfWFiZap9S74enhAQqc
         qSdd8tTv9i1ztpJiEkBhhQxU8xFEjclFoKmK0TTefttaxldGOpikvcYLnqYSlnwEXUl+
         9C1Q==
X-Gm-Message-State: AOJu0YzAt7H4IImAedlpOfg28QuujI2kb3IJkNuyTRcQoq1MJhsi4/zB
	S7XuN14D77pYJQT0oX106n62AA==
X-Google-Smtp-Source: AGHT+IGf2N51iZNpyOo8eHFXOleFvsNaxjZ6S6DGysgzyIZiI8RNNXhxLVe7pn+V17DvpP+tqUaDtA==
X-Received: by 2002:ac8:5804:0:b0:3ff:3110:bb5e with SMTP id g4-20020ac85804000000b003ff3110bb5emr1730898qtg.30.1691155072476;
        Fri, 04 Aug 2023 06:17:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a126800b0076c84240467sm626021qkl.52.2023.08.04.06.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:17:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qRugh-003ifi-8d;
	Fri, 04 Aug 2023 10:17:51 -0300
Date: Fri, 4 Aug 2023 10:17:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 06/16] iommu/amd: Introduce helper functions for
 managing GCR3 table
Message-ID: <ZMz6fyAtKhuTk7HZ@ziepe.ca>
References: <20230804064216.835544-1-vasant.hegde@amd.com>
 <20230804064216.835544-7-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804064216.835544-7-vasant.hegde@amd.com>

On Fri, Aug 04, 2023 at 06:42:06AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Refactor domain_enable_v2() into helper functions for managing GCR3 table
> (i.e. setup_gcr3_table() and get_gcr3_levels()), which will be used in
> subsequent patches. Also re-arrange code and remove forward declaration.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 66 +++++++++++++++++++++++----------------
>  1 file changed, 39 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index d5569eec0fe9..135fa087ce47 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -77,7 +77,6 @@ struct iommu_cmd {
>  struct kmem_cache *amd_iommu_irq_cache;
>  
>  static void detach_device(struct device *dev);
> -static int domain_enable_v2(struct protection_domain *domain, int pasids);
>  
>  /****************************************************************************
>   *
> @@ -1575,6 +1574,43 @@ static void free_gcr3_table(struct protection_domain *domain)
>  	free_page((unsigned long)domain->gcr3_tbl);
>  }
>  
> +static int get_gcr3_levels(int pasids)
> +{
> +	int levels = 0;
> +
> +	if (pasids == -1)
> +		return amd_iommu_max_glx_val;
> +
> +	/*
> +	 * Number of GCR3 table levels required. Level must be 4-Kbyte
> +	 * page and can contain upto 512 entries.
> +	 */
> +	for ( ; get_count_order(pasids) >= 9; pasids >>= 9)
> +		levels += 1;
> +
> +	return levels;

You missed to use the DIV_ROUND_UP

Jason
