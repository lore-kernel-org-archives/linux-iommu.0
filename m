Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C3B2E64E
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E4yqj/91"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6707401e22eso31080096d6.2
        for <iommu@lists.linux.dev>; Mon, 06 Nov 2023 09:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699292404; x=1699897204; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4YyL088BtFmq5vdHJeYCtuPM1mq63cx8krfNjM5SFY=;
        b=E4yqj/91kcrzKhQkPfUzsCFWe4eIypYmki1mpV0XsgEERugoma+pdXySIEqzX6jr1R
         7wem8CiXZ4O1gW+X6UILkjMwun74TgvyzbbVHD8EDUvdRYx17K2CuFtmFnwpRd5Rk4mK
         Yk+Lr3OWSJJ7TTfEdHCnqX56bTi94O/MM7hii489mJXMrXWowzBtA1YncAEOGtLMsWZG
         2JVMWYVgSnP8fqZx4i/vcKypO9ak97FKP7ChZYoW5WHbtwKF+zu9z7I0XVL06iTGFuSS
         xV3fHZh8y6W81gMhbzJrBZ7IBhPjK6+dPIDu6qX7FL53e6ZGJKaQla57qN64pQng7GRJ
         S/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699292404; x=1699897204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4YyL088BtFmq5vdHJeYCtuPM1mq63cx8krfNjM5SFY=;
        b=qCijZEYT+2txZo6/QjxwRknYdxufcP+adKEkYjvGBCbjuBv2GeFHCKRnt7+dnhEcWv
         cX6vHezV4aw/wjNioGMWSDu1X0EiWu+93xdnIrLM78yrshD2OjhgJPl/KdtTFlK6Uu/k
         A5RUkNEaW3tqPSjQC8U4YQGskcqVD+z7Pb8y5KFqxN4cTtxbNwCqluGd7Ep0ZCwiKcGk
         srgT3NWdafVYmB2HOL0TuR2FDR/EJuQKUwZtIkDQN+ADWz7ehkOMlgKVv/W3iL4Bccuh
         cfmKUWlxVX67DJm2MkBY+QmuQe+XViOyuZhhHNtJa0K5YDO41EhNlBxb/4KwGQSl4u63
         raOA==
X-Gm-Message-State: AOJu0YwvLslWV9k22A5jg9oe9kUeVBizX1idbeIwIz/ylLhWjV0MkF9u
	3bX2wH2zz/A6PrHRPhCQ0jAuPA==
X-Google-Smtp-Source: AGHT+IHKWL/gqdr15f9YK6PMxZ3iq/G8qzMM9VY6wq/G6zhM84Lb4fdxhH7HMNrsLvNH15gtj1sTWA==
X-Received: by 2002:a05:6214:411c:b0:66d:373f:32d4 with SMTP id kc28-20020a056214411c00b0066d373f32d4mr31884272qvb.16.1699292404715;
        Mon, 06 Nov 2023 09:40:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id po2-20020a05620a384200b00774309d3e89sm3486437qkn.7.2023.11.06.09.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 09:40:03 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r03Zz-001PDM-BY;
	Mon, 06 Nov 2023 13:40:03 -0400
Date: Mon, 6 Nov 2023 13:40:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 12/13] iommu/amd: Refactor GCR3 table helper functions
Message-ID: <20231106174003.GP4634@ziepe.ca>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-13-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013151652.6008-13-vasant.hegde@amd.com>

On Fri, Oct 13, 2023 at 03:16:51PM +0000, Vasant Hegde wrote:
> -static void free_gcr3_table(struct protection_domain *domain)
> +static void free_gcr3_table(struct iommu_dev_data *dev_data)
>  {
> -	if (domain->glx == 2)
> -		free_gcr3_tbl_level2(domain->gcr3_tbl);
> -	else if (domain->glx == 1)
> -		free_gcr3_tbl_level1(domain->gcr3_tbl);
> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
> +
> +	if (gcr3_info->glx == 2)
> +		free_gcr3_tbl_level2(gcr3_info->gcr3_tbl);
> +	else if (gcr3_info->glx == 1)
> +		free_gcr3_tbl_level1(gcr3_info->gcr3_tbl);
>  	else
> -		BUG_ON(domain->glx != 0);
> +		WARN_ON_ONCE(gcr3_info->glx != 0);
> +
> +	gcr3_info->glx = 0;
> +
> +	set_dte_entry(iommu, dev_data);
> +	clone_aliases(iommu, dev_data->dev);
> +	device_flush_dte(dev_data);

This looks super wonky. We free some of the gcr3 memory and *then*
update the DTE? Is that ordered properly?

As per my prior email the caller should have already updated the DTE
because it attached some non-gcr3 needing thing. Once the new DTE is
in place then free_gcr3_table() should simply just free the allocated
memory.

Commingling DTE manipulation inside the gcr3 layer is not good layering.

You should be moving to a direction where the ops->attach_dev does
exactly one update to the DTE. It loads the new correct value of the
DTE that attach_dev is asking to create. All this repeated touching of
the DTE during the attach_dev flow is sort of a functional bug, or at
least a sub-optimal implementation of the API.

> -/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
> -static int setup_gcr3_table(struct protection_domain *domain, int pasids)
> +static int setup_gcr3_table(struct iommu_dev_data *dev_data, int pasids)
>  {
> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
>  	int levels = get_gcr3_levels(pasids);
>  
>  	if (levels > amd_iommu_max_glx_val)
>  		return -EINVAL;
>  
> -	domain->gcr3_tbl = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
> -	if (domain->gcr3_tbl == NULL)
> +	if (gcr3_info->gcr3_tbl)
> +		return -EBUSY;
> +
> +	gcr3_info->gcr3_tbl = alloc_pgtable_page(dev_to_node(dev_data->dev),
> +						 GFP_ATOMIC);
> +	if (gcr3_info->gcr3_tbl == NULL)
>  		return -ENOMEM;

Why is this in an atomic context? I can understand that the domain was
because it used a spinlock, but this should now be locked by the group
mutex which is not atomic.

Jason
