Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880B911CA9
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 14:09:51 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-68336d06620so2135963b3a.1
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 07:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690553390; x=1691158190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eapGweuSQSK2m8NgEK0LOKUg2OP0Nt4ZliHClEMC8JE=;
        b=VpMS3d2ZX+qVZ/tCrwu4yjEE/0FcKlCy0GO8fZQNu1e8WizIRGIUm/zqzuuxCC5H2s
         rBg2yyzDlcDUi0DmM8wWqZfTj7GykHbDu0OyuyxvQjKP50TIaGJjbWLSM8xApFMUG69q
         i+557aXvWFHnrfqjfPG9wz1t4Wwgw5deEUD4Pfie/ZEyCnVdhm2vFYGWNP3VTvFz3b3V
         F2xdKOdqbb838aRNlchz0dSkbFR+NRtXfnBNDFwCwbkJxFg6RQn/SE5+ZVNsDWSdSpHQ
         dgZ2r+eEtuPv321QqnfEfXIghkCiybVXAwezM69sx14jzakdviYzXUANzPUlNguP8nQl
         ThfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690553390; x=1691158190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eapGweuSQSK2m8NgEK0LOKUg2OP0Nt4ZliHClEMC8JE=;
        b=l1cYiRd2d+388izaPMDj1pfPD+XC36ZFZra+87N092T+9fwKHicWscHfyeyPRxEF98
         svqwL34EmqeySYmdfhuMK6KauxzXUEcgTFNbXBCceHWtdw2QY+jV+AwVMBtfRgP/v1Ai
         AttYDOuBx/Wr5MZnVjGu66Xqg3X9jKpotQZ9rVIji9JMeRjNU0L+ha4sb40GoTu94MLI
         +SojDV7Vd+pAP0AvMZrJHpWgWjBtLVroowH1AFNdVRZvCujqzy1O06NVBFaGSLDW+SMC
         +isRf+HydKfCXehmHIrbftO20vurijyNMctvWVt3W1CfLQ3xL9txODIKFC4ytdLHJ5TX
         CH0g==
X-Gm-Message-State: ABy/qLZUmVbzBVu5TLbFYNethH8uctuPy9rXfjF75KWpr8FAQrzE4EoQ
	FOL08YNRIVdtMmH8JVrAfr/WWQ==
X-Google-Smtp-Source: APBJJlH8WD02AmX80bFKwgnsN+L7viA6pKn7f6GIdNw9YEQ7/ihqooCQ/wdzEAFC4TnYwfVz4qirpg==
X-Received: by 2002:a05:6a00:1a88:b0:681:142f:e8e3 with SMTP id e8-20020a056a001a8800b00681142fe8e3mr2624532pfv.14.1690553390640;
        Fri, 28 Jul 2023 07:09:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id s8-20020a639248000000b0055c090df2fasm3479848pgn.93.2023.07.28.07.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:09:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qPOA8-001bbM-3x;
	Fri, 28 Jul 2023 11:09:48 -0300
Date: Fri, 28 Jul 2023 11:09:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 06/16] iommu/amd: Introduce helper functions for
 managing GCR3 table
Message-ID: <ZMPMLD9NX3JUI0uS@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-7-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728053609.165183-7-vasant.hegde@amd.com>

On Fri, Jul 28, 2023 at 05:35:59AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Refactor domain_enable_v2() into helper functions for managing GCR3 table
> (i.e. setup_gcr3_table() and get_gcr3_levels()), which will be used in
> subsequent patches. Also re-arrange code and remove forward declaration.

It makes alot of sense to change the name like this
 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 63 ++++++++++++++++++++++-----------------
>  1 file changed, 36 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 09749ad4445c..3c14c49d6d72 100644
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
> @@ -1575,6 +1574,40 @@ static void free_gcr3_table(struct protection_domain *domain)
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
> +	/* Number of GCR3 table levels required */
> +	for ( ; (pasids != 0) && ((pasids - 1) & ~0x1ff); pasids >>= 9)
> +		levels += 1;

This can surely be a closed expression, something like:

DIV_ROUND_UP(get_count_order(pasids), 9)

?

> +
> +	return levels;
> +}
> +
> +/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
> +static int setup_gcr3_table(struct protection_domain *domain, int pasids)
> +{
> +	int levels = get_gcr3_levels(pasids);
> +
> +	if (levels > amd_iommu_max_glx_val)
> +		return -EINVAL;
> +
> +	domain->gcr3_tbl = (void *)get_zeroed_page(GFP_ATOMIC);

I gather it is recommended to just call kzalloc(PAGE_SIZE) now. And
really this shouldn't be PAGE_SIZE but some constant reflecting the
size of the HW's gcr3 levels.

Jason
